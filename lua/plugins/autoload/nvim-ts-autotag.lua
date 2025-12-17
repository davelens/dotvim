-- Auto rename of HTML/XML tags on change motions.
--
-- NOTE: The author has deprecated 'setup({}) through opts = {}', because
-- nvim-treesitter did the same in their 1.0 release (main branch).
--
-- Info: https://github.com/windwp/nvim-ts-autotag?tab=readme-ov-file#setup
return {
  'windwp/nvim-ts-autotag',
  event = { 'BufReadPost', 'BufWritePost', 'BufNewFile' },
  config = function()
    require('nvim-ts-autotag').setup({
      opts = {
        enable_close = true, -- Auto close tags
        enable_rename = true, -- Auto rename pairs of tags
        enable_close_on_slash = false, -- Don't auto close on trailing </
      },
    })
  end,
}
