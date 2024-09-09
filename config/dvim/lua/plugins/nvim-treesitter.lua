-- tree-sitter implementation for Neovim. Parsing system for advanced syntax 
-- highlighting and more crazy shenanigans.
return {
  "nvim-treesitter/nvim-treesitter",

  dependencies = {
    -- Probably good to read up on text objects and how to add custom ones:
    -- https://ofirgall.github.io/learn-nvim/chapters/05-text-objects.html
    "nvim-treesitter/nvim-treesitter-textobjects",

    -- nvim-treesitter extension to autoclose/autorename tags.
    -- Mainly targetted for HTML, JS, Typescript, XML, Vue, etc....
    "windwp/nvim-ts-autotag",
  },
  build = ":TSUpdate",
  config = function () 
    local configs = require("nvim-treesitter.configs")

    configs.setup({
      ensure_installed = { 
        'c', 'cpp', 'go', 'lua', 'python', 'rust', 'tsx', 'javascript', 
        'typescript', 'vimdoc', 'vim', 'bash', 'elixir', 'eex', 'ruby', 
        'puppet', 'html', 'css', 'json', 'yaml', 'dockerfile'
      },
      sync_install = false,
      highlight = { enable = true },
      indent = { enable = true },  
    })

    require("nvim-ts-autotag").setup {
      opts = {
        -- These are default, but leave them here for good measure.
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false -- Auto close on trailing </
      },
      -- Also override individual filetype configs, these take priority.
      -- Empty by default, useful if one of the "opts" global settings
      -- doesn't work well in a specific filetype
      --per_filetype = {
        --["html"] = { enable_close = false }
      --}
    }
  end,
}
