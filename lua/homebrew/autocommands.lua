-- This solves an issue with the padding around the neovim instance when the
-- terminal background is different from the one set in Neovim. 
--
-- https://old.reddit.com/r/neovim/comments/1ehidxy/you_can_remove_padding_around_neovim_instance/
--
 --This removes that padding:
vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
  callback = function()
    local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
    if not normal.bg then
      return
    end
    io.write(string.format("\027]11;#%06x\027\\", normal.bg))
  end,
})
vim.api.nvim_create_autocmd("UILeave", {
  callback = function()
    io.write("\027]111\027\\")
  end,
})

-- Momentarily highlight text upon yanking
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Define an augroup to manage the autocmds
vim.api.nvim_create_augroup('tests', { clear = true })

-- Reserve <CR> for running :TestFile in Ruby, Elixir, and JavaScript files
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'ruby', 'javascript' },
  group = 'tests',
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<CR>', ':TestFile<CR>', { noremap = true, silent = true })
  end
})

-- Unmap <CR> in Command-line mode, including for vim and terminal buffers
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'vim' },
  group = 'tests',
  callback = function()
    nvim_buf_safe_del_keymap(0, 'n', '<CR>')
  end
})

-- Map <leader>; to run buffers#append_semicolon() in JS files.
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', '<leader>;', ":lua require('homebrew.functions.buffers').append_semicolon()<CR>", { noremap = true, silent = true })
  end,
})

-- Generic buffer close toggler for qf, vim-fugitive, help, etc,...
-- Hard bound on `q`.
-- Idea taken from folke's nvim config, but altered so `q` works in any buffer.
local special_filetypes = {
  'checkhealth',
  'fugitive',
  'git',
  'gitsigns-blame',
  'help',
  'lspinfo',
  'neotest-output',
  'neotest-output-panel',
  'neotest-summary',
  'notify',
  'oil',
  'PlenaryTestPopup',
  'qf',
}

local function q_handler()
  if vim.fn.reg_recording() ~= "" then
    return "q"
  end

  local wins = vim.api.nvim_list_wins()
  local special_count = 0
  local gitcommit_found = false
  local special_wins = {}

  for _, win in ipairs(wins) do
    local buf = vim.api.nvim_win_get_buf(win)
    local ft = vim.api.nvim_buf_get_option(buf, "filetype")
    if ft == "gitcommit" then
      gitcommit_found = true
    end
    if vim.tbl_contains(special_filetypes, ft) then
      special_count = special_count + 1
      table.insert(special_wins, win)
    end
  end

  if gitcommit_found then
    return "q"
  end

  if special_count > 0 then
    if special_count == #wins then
      local cur_buf = vim.api.nvim_win_get_buf(vim.api.nvim_get_current_win())
      local cur_ft = vim.api.nvim_buf_get_option(cur_buf, "filetype")
      local msg = "Closing this buffer with `q` now would exit vim (filetype `%s` is special)."
      vim.schedule(function()
        vim.notify(string.format(msg, cur_ft), vim.log.levels.ERROR)
      end)
      return ""
    end

    vim.schedule(function()
      for _, win in ipairs(special_wins) do
        local buf = vim.api.nvim_win_get_buf(win)
        vim.api.nvim_win_close(win, true)
        pcall(vim.api.nvim_buf_delete, buf, { force = true })
      end
    end)
    return ""
  end

  return "q"
end

vim.keymap.set("n", "q", q_handler, { expr = true, desc = "Close special windows if present, else pass through" })
