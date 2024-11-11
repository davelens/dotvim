return {
  'neovim/nvim-lspconfig',
  dependencies = {
    { 'williamboman/mason.nvim', config = true }, -- LSP server installation manager
    'williamboman/mason-lspconfig.nvim', -- LSP-related heavy lifting for Mason
  },
  config = function()
    require('mason').setup()
    require('mason-lspconfig').setup({
      ensure_installed = { 'lua_ls', 'elixirls', 'tailwindcss', 'gopls' }
    })

    local lspconfig = require('lspconfig')
    local capabilities = require("cmp_nvim_lsp").default_capabilities()

    lspconfig.lua_ls.setup({
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
            disable = {'lowercase-global', 'trailing-space', 'undefined-global'}
          }
        }
      }
    })

    lspconfig.elixirls.setup({
      cmd = { "elixir-ls" },
      -- set default capabilities for nvim-cmp's completion source
      capabilities = capabilities,
    })

    lspconfig.tailwindcss.setup({
      init_options = {
        userLanguages = {
          elixir = "html-eex",
          eelixir = "html-eex",
          heex = "html-eex",
        },
      },
    })

    lspconfig.elixirls.setup({})
    lspconfig.tailwindcss.setup({})
    lspconfig.gopls.setup({})
  end
}
