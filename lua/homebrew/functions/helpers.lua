-- Clears stale command-line content
function print_redraw(string)
  vim.cmd('redraw') 
  print(string)
end

-- Useful to paste selected strings into other functionality.
--
-- It's a somewhat older function I specifically searched for, and found here:
-- https://neovim.discourse.group/t/function-that-return-visually-selected-text/1601
function get_visual_selection()
  local s_start = vim.fn.getpos("'<")
  local s_end = vim.fn.getpos("'>")
  local n_lines = math.abs(s_end[2] - s_start[2]) + 1
  local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
  lines[1] = string.sub(lines[1], s_start[3], -1)
  if n_lines == 1 then
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
  else
    lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
  end
  return table.concat(lines, '\n')
end

-- Useful to use this on keymaps to quickly run external scripts.
-- Mostly done to have a single point where these kind of arguments get 
-- sanitized.
function run_script_on_visual_selection(script_path)
  local visual_selection = get_visual_selection()
  visual_selection = visual_selection:gsub("'", "'\\''")

  -- Run the cmd, grab the output as a systemlist
  local output = vim.fn.systemlist(script_path .. " " .. visual_selection)

    -- Check for any errors in command execution (non-zero exit status)
  if vim.v.shell_error ~= 0 then
    print("Error running " .. script_path)
    return
  end

  vim.fn.setqflist({}, 'r', { title = script_path, lines = output })
  vim.cmd('copen')
end

-- Display everything contained in a LUA table; useful for debugging.
function print_table(tbl, indent)
  indent = indent or 0
  local formatting = string.rep("  ", indent)

  if type(tbl) ~= "table" then
    print(formatting .. tostring(tbl))
    return
  end

  for k, v in pairs(tbl) do
    local key = tostring(k)
    if type(v) == "table" then
      print(formatting .. key .. ":")
      print_table(v, indent + 1)
    else
      print(formatting .. key .. ": " .. tostring(v))
    end
  end
end

-- Runs a check to see if a keymap exists before deleting it.
-- I "sometimes" run into autocmd errors and this should prevent those.
function nvim_buf_safe_del_keymap(bufnr, mode, lhs)
  local keymaps = vim.api.nvim_buf_get_keymap(bufnr, mode)

  for _, keymap in ipairs(keymaps) do
    if keymap.lhs == lhs then
      vim.api.nvim_buf_del_keymap(bufnr, mode, lhs)
      return true
    end
  end

  -- No matching keymap = exit quietly
  return false
end
