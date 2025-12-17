-- Smart brackets, parens, quotes,...
-- Binds <CR> to position between the pairs + auto-indent as well.
--
-- NOTE: nvim-ts-autotag is the one that autocloses HTML/XML tags, but the
-- auto-indent logic comes from this
return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',
  opts = {
    disable_filetype = { 'snacks_picker_input' },
  },
}
