-- tree-sitter implementation for Neovim. Parsing system for advanced syntax 
-- highlighting and more crazy shenanigans.
return {
  "nvim-treesitter/nvim-treesitter",

  dependencies = {
    -- Probably good to read up on text objects and how to add custom ones:
    -- https://ofirgall.github.io/learn-nvim/chapters/05-text-objects.html
    "nvim-treesitter/nvim-treesitter-textobjects",

    -- nvim-treesitter extension to autoclose/autorename tags.
    "windwp/nvim-ts-autotag",

    -- nvim-treesitter extension to autoclose Ruby/Elixir/Lua/... blocks
    "RRethy/nvim-treesitter-endwise",
  },
  build = ":TSUpdate",
  config = function () 
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { 
        'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 
        'typescript', 'vimdoc', 'vim', 'bash', 'elixir', 'heex', 'ruby', 
        'puppet', 'html', 'css', 'scss', 'json', 'yaml', 'dockerfile', 
        'embedded_template'
      },
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { 'embedded_template' },
      },
      sync_install = false,
      indent = { enable = true },

      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            ["ab"] = "@block.outer",
            ["ib"] = "@block.inner",
          },
        },
      },

      endwise = {
        enable = true,
      },
    })

    require("nvim-ts-autotag").setup {
      opts = {
        -- These are default, but leave them here for good measure.
        enable_close = false, -- I'm using vim-closetag for auto closing tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false -- Auto close on trailing </
      },
    }
  end,
}
