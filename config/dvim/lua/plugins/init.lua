-- So lazy.nvim is configured to load all lua/plugins/*.lua files. This means
-- that every file within this directory should return a list pointing to the
-- repo of the plugin, its dependencies, and a config function that will be
-- also be picked up by lazy.nvim.
--
-- This init file could then be used to "quickload" plugins that require
-- minimal or no configuration at all.
return {
  'preservim/nerdcommenter', -- Comment toggles with <leader>ci
  'tpope/vim-surround', -- Maps to manipulate brackets, parens, quotes,..
  'tpope/vim-endwise', -- Smart end structures for blocks
  'tpope/vim-repeat', -- Extended repeat functionality through `.`
  'tpope/vim-rails', -- Pandora's box with Rails workflow features
  {
    "tpope/vim-fugitive", -- Git wrapper for vim
    keys = { { "<leader>g", "<cmd>G<cr>" } },
  },
  {
    'windwp/nvim-autopairs', -- Smart brackets, parens, quotes,...
    event = "InsertEnter",
    config = true
    -- use opts = {} for passing setup options
    -- this is equivalent to setup({}) function
  }
}
