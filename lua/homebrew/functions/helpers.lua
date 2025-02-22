-- Clears stale command-line characters.
function print_redraw(string)
  vim.cmd('redraw')
  print(string)
end

-- A little alias to dump output of vars to the console. Works on Lua tables.
function dump(var)
  print(vim.inspect(var))
end

-- A little helper to assign and cache a module to a global variable.
function assign(name, module)
  _G.dvim[name] = _G.dvim[name] or require(module)
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
  vim.cmd("normal! \"vy")   -- Yank the selection into the unnamed register
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
