return {
  'folke/noice.nvim',
  event = 'VeryLazy',
  opts = {
    lsp = {
      -- Override markdown rendering so that completion plugins use Treesitter.
      override = {
        ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
        ['vim.lsp.util.stylize_markdown'] = true,
      },
    },
  },
  dependencies = {
    -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
    'MunifTanjim/nui.nvim',
  },
}
