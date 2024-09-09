return {
  'neovim/nvim-lspconfig',
  config = function()
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = { "lua_ls", "lexical", "tailwindcss" }
    })

    local lspconfig = require("lspconfig")

    lspconfig.lua_ls.setup{
      settings = {
        Lua = {
          diagnostics = {
            globals = { "vim" },
            disable = {"lowercase-global","trailing-space"}
          }
        }
      }
    }

    lspconfig.lexical.setup {}
    lspconfig.tailwindcss.setup {}
  end
}
