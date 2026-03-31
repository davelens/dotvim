local M = {}

-- Returns the hex colour value for a given attribute of a highlight group.
-- Follows linked groups until it finds a concrete value.
local function resolve_hl_attr(name, attr)
  local hl = vim.api.nvim_get_hl(0, { name = name, link = false })

  if hl[attr] then
    return string.format('#%06x', hl[attr])
  end

  return nil
end

-- Follows the highlight link chain from a group name to its final target.
-- e.g. @variable.member -> Identifier -> SomeGroup -> ...
local function resolve_hl_link(name)
  local seen = {}

  while name and not seen[name] do
    seen[name] = true
    local hl = vim.api.nvim_get_hl(0, { name = name })

    if hl.link then
      name = hl.link
    else
      return name
    end
  end

  return name
end

-- Inspects treesitter captures at the cursor position.
-- Returns the capture name and resolved highlight group, or nil.
local function treesitter_info()
  local ok, captures = pcall(vim.treesitter.get_captures_at_cursor, 0)

  if not ok or #captures == 0 then
    return nil
  end

  -- The last capture is typically the most specific one.
  local capture = captures[#captures]
  local hl_group = '@' .. capture

  return hl_group
end

-- Inspects legacy vim syntax groups at the cursor position.
-- Returns the syntax group name, or nil.
local function syntax_info()
  local pos = vim.api.nvim_win_get_cursor(0)
  local line = pos[1]
  local col = pos[2] + 1 -- synID is 1-indexed for columns

  local syn_id = vim.fn.synID(line, col, true)

  if syn_id == 0 then
    return nil
  end

  local trans_id = vim.fn.synIDtrans(syn_id)
  local hl_group = vim.fn.synIDattr(syn_id, 'name')
  local linked_group = vim.fn.synIDattr(trans_id, 'name')

  if hl_group ~= linked_group then
    return hl_group .. ' -> ' .. linked_group
  end

  return hl_group
end

-- Prints the highlight group and resolved fg/bg colours under the cursor.
function M.inspect_under_cursor()
  local ts = treesitter_info()
  local syn = syntax_info()
  local source = ts or syn

  if not source then
    dvim.utils.print_redraw('No highlight group under cursor')
    return
  end

  -- Resolve colours from the effective highlight group.
  -- For treesitter captures, strip the leading '@' prefix variants to find
  -- the actual hl group neovim resolves to.
  local resolve_name = source:match('^@?(.+)$')
  local fg = resolve_hl_attr(source, 'fg') or resolve_hl_attr(resolve_name, 'fg')
  local bg = resolve_hl_attr(source, 'bg') or resolve_hl_attr(resolve_name, 'bg')

  -- Follow the link chain to find the concrete highlight group name.
  local resolved_group = resolve_hl_link(source)

  local parts = {}
  table.insert(parts, source)

  if resolved_group and resolved_group ~= source then
    table.insert(parts, resolved_group)
  end

  if syn and ts and syn ~= ts then
    table.insert(parts, '(syn: ' .. syn .. ')')
  end

  if fg then
    table.insert(parts, 'fg:' .. fg)
  end

  if bg then
    table.insert(parts, 'bg:' .. bg)
  end

  if not fg and not bg then
    table.insert(parts, '(no colours resolved)')
  end

  dvim.utils.print_redraw(table.concat(parts, ' | '))
end

return M
