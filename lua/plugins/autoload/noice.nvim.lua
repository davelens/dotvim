return {
  'folke/noice.nvim',
  dependencies = { 'MunifTanjim/nui.nvim' },
  event = 'VeryLazy',
  opts = {
    lsp = {
      -- Override markdown rendering so that completion plugins use Treesitter.
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
    },
    views = {
      cmdline_popup = {
        position = { row = 5 },
        border = { style = 'single' },
      },
    },
  },
}
