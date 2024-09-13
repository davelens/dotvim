-- Useful to paste selected strings into other functionality.
-- Currently used in my Telescope configuration to grep_string the visual 
-- selection.
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
