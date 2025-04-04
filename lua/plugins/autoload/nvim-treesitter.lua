-- Treesitter abstraction layer for Neovim.
-- Provides advanced / context-aware syntax highlighting.
--
-- NOTE: Because my 'endwise'-solution is a treesitter plugin, I opted to
-- include every plugin related to auto-pairs and auto-tags in this file.
-- The biggest chunk is nvim-treesitter itself, so it seems overkill to split
-- them up in multiple files.
return {
  -- Autoformats log files on common patterns for more default readability.
  { 'fei6409/log-highlight.nvim', event = 'BufRead *.log', opts = {} },

  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      -- Probably good to read up on text objects and how to add custom ones:
      -- https://ofirgall.github.io/learn-nvim/chapters/05-text-objects.html
      'nvim-treesitter/nvim-treesitter-textobjects',

      -- nvim-treesitter extension to autoclose Ruby/Elixir/Lua/... blocks
      'RRethy/nvim-treesitter-endwise',
    },

    build = ':TSUpdate',
    main = 'nvim-treesitter.configs',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {
      -- Auto-indentation on all supported filetypes.
      indent = { enable = true },
      ensure_installed = {
        'c',
        'cpp',
        'go',
        'lua',
        'python',
        'rust',
        'tsx',
        'javascript',
        'typescript',
        'vimdoc',
        'vim',
        'bash',
        'elixir',
        'eex',
        'heex',
        'ruby',
        'puppet',
        'html',
        'css',
        'scss',
        'json',
        'yaml',
        'dockerfile',
        'embedded_template',
      },

      highlight = {
        enable = true,
        additional_vim_regex_highlighting = {
          'ruby',
          'embedded_template',
          'elixir',
          'eex',
          'heex',
          'eruby',
        },
      },

      -- nvim - treesitter / nvim - treesitter - textobjects
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ['af'] = '@function.outer',
            ['if'] = '@function.inner',
            ['ac'] = '@class.outer',
            ['ic'] = '@class.inner',
            ['ab'] = '@block.outer',
            ['ib'] = '@block.inner',
          },
        },
      },

      -- RRethy / nvim - treesitter - endwise
      endwise = {
        enable = true,
      },
    },
  },

  {
    -- Smart brackets, parens, quotes,...
    -- Binds <CR> to position between the pairs + auto-indent as well.
    -- NOTE: nvim-ts-autotag is the one that autocloses HTML/XML tags, but the
    -- auto-indent logic comes from this
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    opts = {
      disable_filetype = { 'snacks_picker_input' },
    },
  },

  {
    -- Auto rename of HTML/XML tags on change motions.
    -- NOTE: The author has deprecated 'setup({}) through opts = {}', because
    -- nvim-treesitter will supposedly do the same in their 1.0 release.
    -- That's why this uses a config function.
    -- https://github.com/windwp/nvim-ts-autotag?tab=readme-ov-file#setup
    'windwp/nvim-ts-autotag',
    config = function()
      require('nvim-ts-autotag').setup({
        opts = {
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = false, -- Don't auto close on trailing </
        },
      })
    end,
  },
}
