-- So lazy.nvim is configured to load all lua/plugins/*.lua files. This means
-- that every file within this directory should return a list pointing to the
-- repo of the plugin, its dependencies, and a config function that will be
-- also be picked up by lazy.nvim.
--
-- This init file could then be used to "quickload" plugins that require
-- minimal or no configuration at all.
return {
  'preservim/nerdcommenter',
  'tpope/vim-surround',
  'tpope/vim-endwise',
  {
    "tpope/vim-fugitive", 
    keys = { { "<leader>g", "<cmd>G<cr>" } },
  },
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  }
}
