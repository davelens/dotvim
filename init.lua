require('homebrew.globals')
require('homebrew.options')
require('homebrew.functions')
require('homebrew.autocommands')
require('homebrew.maps')
require("homebrew.lazy").load({
  keymap = "<leader>L",
  spec = {
    { import = 'plugins.basic' },
    { import = 'plugins.autoload' },
  }
})
