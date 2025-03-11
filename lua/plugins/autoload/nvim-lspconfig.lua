return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true }, -- LSP server installation manager
    'williamboman/mason-lspconfig.nvim', -- LSP-related heavy lifting for Mason
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls', 'elixirls', 'gopls', 'cssls', 'bashls' },
    })

    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim', 'Snacks' },
            disable = { 'lowercase-global', 'trailing-space', 'empty-block' },
          },
        },
      },
    })

    lspconfig.elixirls.setup({
      cmd = { 'elixir-ls' },
      capabilities = capabilities,
      settings = {
        elixirLS = {
          dialyzerEnabled = false,
          fetchDeps = false,
          plugins = {
            phoenix = {
              enabled = true,
              liveSocketEnabled = true,
            },
          },
        },
      },
    })

    lspconfig.gopls.setup({
      capabilities = capabilities,
    })

    lspconfig.cssls.setup({})
    lspconfig.bashls.setup({})
  end,
}
