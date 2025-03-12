return {
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'williamboman/mason.nvim',
      opts = {
        ensure_installed = {
          'bashls',
          'cssls',
          'elixirls',
          'lua_ls',
          'ruby_lsp'
        },
      },
    },
    { 'williamboman/mason-lspconfig.nvim' },
  },
  config = function()
    local lspconfig = require('lspconfig')
    local capabilities = require('cmp_nvim_lsp').default_capabilities()

    lspconfig.cssls.setup({ capabilities = capabilities, })
    lspconfig.bashls.setup({ capabilities = capabilities, })
    lspconfig.ruby_lsp.setup({ capabilities = capabilities })

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim', 'Snacks', 'dvim' },
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
  end,
}
