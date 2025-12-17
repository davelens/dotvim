-- Treesitter abstraction layer for Neovim.
-- Provides advanced / context-aware syntax highlighting.
--
-- NOTE: This config now uses the nvim-treesitter 1.0 API (main branch).
-- The old API using require('nvim-treesitter.configs').setup() is deprecated.
return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    lazy = false,
    config = function()
      ts = require('nvim-treesitter')

      -- Setup the install directory for treesitter parsers.
      -- I don't understand why this is named `site` in nvim-treesitter's
      -- README.md, but I'll just leave it as-is for now.
      ts.setup({
        install_dir = vim.fn.stdpath('data') .. '/site',
      })

      -- Install parsers
      ts.install({
        'bash',
        'c',
        'cpp',
        'css',
        'dockerfile',
        'eex',
        'elixir',
        'embedded_template',
        'go',
        'heex',
        'html',
        'javascript',
        'json',
        'latex',
        'lua',
        'markdown',
        'norg',
        'puppet',
        'python',
        'regex',
        'ruby',
        'rust',
        'scss',
        'svelte',
        'tsx',
        'typescript',
        'typst',
        'vim',
        'vimdoc',
        'vue',
        'yaml',
      })

      -- Filetypes that should use additional vim regex highlighting
      local regex_highlight_filetypes = {
        ruby = true,
        embedded_template = true,
        elixir = true,
        eex = true,
        heex = true,
        eruby = true,
      }

      -- Filetypes where treesitter indent should be disabled
      local disable_indent_filetypes = {
        ruby = true,
        embedded_template = true,
        eruby = true,
      }

      -- Enable treesitter highlighting dynamically
      vim.api.nvim_create_autocmd('FileType', {
        callback = function(args)
          local ft = vim.bo[args.buf].filetype
          -- Start treesitter highlighting
          local start_ok = pcall(vim.treesitter.start, args.buf)
          if not start_ok then
            return
          end

          -- Enable additional vim regex highlighting for certain filetypes
          if regex_highlight_filetypes[ft] then
            vim.bo[args.buf].syntax = 'ON'
          end

          -- Set treesitter-based indentation (except for disabled filetypes)
          if not disable_indent_filetypes[ft] then
            vim.bo[args.buf].indentexpr =
              "v:lua.require'nvim-treesitter'.indentexpr()"
          end
        end,
      })

      -- Because treesitter has made these changes, I'm required to load these
      -- in at this point. Both won't work without calling them here first.
      require('nvim-treesitter-textobjects')
      require('nvim-treesitter-endwise')
    end,
  },
}
