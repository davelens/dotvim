-- Clears stale command-line content
function print_redraw(string)
  vim.cmd('redraw') 
  print(string)
end

-- Returns the visual selection, like an expand('<cword>') for selections.
--
-- This is a trick. Normally you'd want to grab the start and end position
-- of your selection, than extract the string inbetween.
-- It's infinitely easier to just yank the visual selection into a register,
-- and then return it.
--
function get_visual_selection()
  -- Assuming visual mode here, so no explicit checks for it.
  vim.cmd("normal! \"vy") -- Yank the selection into the unnamed register
  return vim.fn.getreg("v") -- Grab and return yanked text
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
