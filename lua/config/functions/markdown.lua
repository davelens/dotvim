local M = {}

-- Extract the link target under the cursor, if any.
-- Supports: [text](target), [[target]], and bare URLs.
local function link_target_at_cursor()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2] + 1 -- 1-indexed

  -- [text](target) — match if cursor is anywhere inside the brackets or parens
  for start_pos, target, end_pos in line:gmatch('()%[.-%]%((.-)%)()') do
    if col >= start_pos and col < end_pos then
      return target
    end
  end

  -- [[target]] — match if cursor is anywhere inside the double brackets
  for start_pos, target, end_pos in line:gmatch('()%[%[(.-)%]%]()') do
    if col >= start_pos and col < end_pos then
      return target
    end
  end

  -- Bare URLs (http:// or https://)
  for start_pos, target, end_pos in
    line:gmatch("()(https?://[%w%-%._~:/?#%[%]@!$&'*+,;%%=]+)()")
  do
    if col >= start_pos and col < end_pos then
      return target
    end
  end

  return nil
end

local function jump_to_anchor(anchor)
  for row, line in ipairs(vim.api.nvim_buf_get_lines(0, 0, -1, false)) do
    local hashes, heading = line:match('^%s*(#+)%s+(.+)$')

    if hashes and #hashes <= 6 then
      heading = heading:gsub('%s+#+%s*$', '')
      local slug = heading:lower():gsub('%s+', '-'):gsub('[^%w%-]', '')

      if slug == anchor:lower() then
        vim.api.nvim_win_set_cursor(0, { row, 0 })
        return true
      end
    end
  end

  return false
end

-- Follow a markdown link target: open URLs in the browser, files in Neovim.
local function follow(target)
  -- URLs open in the default browser
  if target:match('^https?://') then
    vim.ui.open(target)
    return
  end

  local path, anchor = target:match('^(.-)#(.+)$')
  if path then
    target = path
  end

  if target ~= '' then
    -- Resolve wiki-style links to .md files in the same directory
    if not target:match('%.[%w]+$') then
      target = target .. '.md'
    end

    -- Resolve relative paths from the current file's directory
    if not target:match('^/') then
      local current_dir = vim.fn.expand('%:p:h')
      target = current_dir .. '/' .. target
    end

    target = vim.fn.resolve(target)

    if vim.fn.filereadable(target) == 1 then
      vim.cmd.edit(target)
    else
      vim.notify('File not found: ' .. target, vim.log.levels.WARN)
      return
    end
  end

  if anchor and not jump_to_anchor(anchor) then
    vim.notify('Heading not found: #' .. anchor, vim.log.levels.WARN)
  end
end

-- Context-aware Enter handler for markdown buffers.
-- Follows links when the cursor is on one, otherwise toggles checkboxes.
function M.enter()
  local target = link_target_at_cursor()

  if target then
    follow(target)
  else
    require('config.functions.todo').toggle_state()
  end
end

return M
