local M = {}

-- Dumps contents of var to the console using vim.inspect
function M.dump(var)
  print(vim.inspect(var))
end

-- Clears stale command-line characters.
function M.print_redraw(string)
  vim.cmd('redraw')
  print(string)
end

-- Returns the word under the cursor, but saves its value for later reuse.
function M.save_and_expand_cword()
  -- In cases like our quickfix search/replace, we need to jump back to the
  -- original position when we started looking for matches to replace.
  dvim.cursor.remember_position()
  local cword = vim.fn.expand('<cword>')
  vim.g.last_word_selection = cword
  return cword
end

-- Returns the visual selection, like an expand('<cword>') for selections.
--
-- This is a trick. Normally you'd want to grab the start and end position
-- of your selection, than extract the string inbetween.
-- It's infinitely easier to just yank the visual selection into a register,
-- and then return it.
--
function M.get_visual_selection()
  -- Assuming visual mode here, so no explicit checks for it.
  vim.cmd('normal! "vy')               -- Yank the selection into the unnamed register
  local selection = vim.fn.getreg('v') -- Grab and return yanked text
  vim.g.last_word_selection = selection
  return selection
end

-- Recall the last word selection stored with either M.get_visual_selection org
-- M.save_and_expand_cword.
function M.last_word_selection()
  return vim.g.last_word_selection
end

-- Useful to use this on keymaps to quickly run external scripts.
-- Mostly done to have a single point where these kind of arguments get
-- sanitized.
function M.run_script_on_visual_selection(script_path)
  local visual_selection = M.get_visual_selection()
  visual_selection = visual_selection:gsub("'", "'\\''")

  -- Run the cmd, grab the output as a systemlist
  local output = vim.fn.systemlist(script_path .. ' ' .. visual_selection)

  -- Check for any errors in command execution (non-zero exit status)
  if vim.v.shell_error ~= 0 then
    print('Error running ' .. script_path)
    return
  end

  vim.fn.setqflist({}, 'r', { title = script_path, lines = output })
  vim.cmd('copen')
end

-- Runs a check to see if a keymap exists before deleting it.
-- I "sometimes" run into autocmd errors and this should prevent those.
function M.nvim_buf_safe_del_keymap(bufnr, mode, lhs)
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

return M
