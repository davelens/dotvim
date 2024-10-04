-- Auto-close HTML/XML tags. I had nvim-ts-autotag installed, but that
-- functionality does not include the convenient formatting with indentation.
-- I'll stick to vim-closetag for now.
return {
  'alvan/vim-closetag',
  init = function()
    vim.g.closetag_filetypes = 'html,eruby,eelixir'
  end
}
