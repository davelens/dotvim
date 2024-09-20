-- Configurable notification manager
return {
  'rcarriga/nvim-notify',
  config = function()
    local notify = require('notify')

    notify.setup({
      stages = 'fade'
    })

    vim.notify = notify
  end
}
