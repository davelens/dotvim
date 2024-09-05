-- tree-sitter implementation for Neovim. Parsing system for advanced syntax 
-- highlighting and more crazy shenanigans.
return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function () 
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { 
        "ruby", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", 
        "html", "puppet"
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },  
    })
  end
}
