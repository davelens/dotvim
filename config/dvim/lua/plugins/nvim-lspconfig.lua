return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true }, -- LSP server installation manager
    'williamboman/mason-lspconfig.nvim', -- LSP-related heavy lifting for Mason
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls', 'elixirls', 'tailwindcss' }
    })

    local lspconfig = require('lspconfig')

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
            disable = {'lowercase-global', 'trailing-space'}
          }
        }
      }
    })

    lspconfig.elixirls.setup({})
    lspconfig.tailwindcss.setup({})
  end
}
