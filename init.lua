require('config.globals')
require('config.options')
require('config.functions')
require('config.autocommands')
require('config.keymaps')
require('config.lazy').load({
  keymap = ';p',
  spec = {
    { import = 'plugins.basic' },
    { import = 'plugins.autoload' },
  },
})
