return {
  'L3MON4D3/LuaSnip',
  version = 'v2.*',
  build = vim.fn.executable('make') == 1 and 'make install_jsregexp' or false,
  event = 'VeryLazy',
  dependencies = {
    {
      'rafamadriz/friendly-snippets',
      config = function()
        -- Loads vscode-like snippets (here: rafamadriz/friendly-snippets).
        require('luasnip.loaders.from_vscode').lazy_load()

        -- Loads in my Homebrew snippets.
        require('luasnip.loaders.from_vscode').lazy_load({
          paths = { vim.fn.stdpath('config') .. '/snippets' }, -- Homebrew
        })
      end,
    },
  },
  opts = {
    history = true,
    -- Prevents lingering snippet sessions.
    delete_check_events = 'TextChanged',
    region_check_events = 'CursorMoved',
  },
}
