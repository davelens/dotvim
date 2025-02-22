require('config.globals')
require('config.options')
require('config.functions')
require('config.autocommands')
require('config.maps')
require('config.lazy').load({
  keymap = '<leader>L',
  spec = {
    { import = 'plugins.basic' },
    { import = 'plugins.autoload' },
  }
})
