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
--vim.api.nvim_create_autocmd('FileType', {
  --group = vim.api.nvim_create_augroup('close-toggler', { clear = true }),
  --pattern = {
    --'checkhealth',
    --'fugitive',
    --'git',
    --'gitsigns-blame',
    --'help',
    --'lspinfo',
    --'neotest-output',
    --'neotest-output-panel',
    --'neotest-summary',
    --'notify',
    --'PlenaryTestPopup',
    --'qf',
  --},
  --callback = function(event)
    --vim.bo[event.buf].buflisted = false
    --vim.schedule(function()
      --vim.keymap.set('n', 'q', function()
        --vim.cmd('close')
        --pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
      --end, {
        --buffer = event.buf,
        --silent = true,
        --desc = '[Q]uit buffer',
      --})
    --end)
  --end,
--})

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
  'PlenaryTestPopup',
  'qf',
}

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('close-toggler', { clear = true }),
  pattern = special_filetypes,
  callback = function()
    vim.keymap.set("n", "q", function()
      for _, win in ipairs(vim.api.nvim_list_wins()) do
        local buf = vim.api.nvim_win_get_buf(win)
        local ft = vim.api.nvim_buf_get_option(buf, "filetype")
        if vim.tbl_contains(special_filetypes, ft) then
          vim.api.nvim_win_close(win, true)
          pcall(vim.api.nvim_buf_delete, buf, { force = true })
        end
      end

      -- Restore the default behavior (ie. recording macros)
      vim.keymap.del("n", "q")
    end, { desc = "Close special windows" })
  end
})
