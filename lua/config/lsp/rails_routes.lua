--- @module 'blink.cmp'
--- @class blink.cmp.Source
local source = {}
local rails = require('config.functions.rails')

function source.new(_) -- No opts required, I just want a routes dump.
  local self = setmetatable({ routes = {} }, { __index = source })
  self.routes = rails.load_routes()

  -- TODO: Add an auto-reload here when saving the routes
  -- file. Probably do a file check, too. You can do:
  --
  --   Rails.application.reload_routes!
  --
  -- vim.api.nvim_create_autocmd('BufWritePost', {
  --   pattern = 'config/routes.rb',
  --   callback = function()
  --     return self.routes
  --   end,
  -- })

  return self
end

function source:enabled()
  if not vim.tbl_contains({ 'ruby', 'eruby' }, vim.bo.filetype) then
    return false
  end

  return rails.present()
end

function source:get_completions(_, callback)
  local items = {}
  for _, line in ipairs(self.routes) do
    local route, desc, controller, action =
      line:match('^(.-)%|%|(.-)%|%|(.-)%|%|(.+)$')

    table.insert(items, {
      label = route,
      detail = desc,
      kind = require('blink.cmp.types').CompletionItemKind.Text,
      documentation = {
        kind = 'markdown',
        value = tostring(controller) .. ' => ' .. tostring(action),
      },
    })
  end

  callback({
    items = items,
    is_incomplete_backward = false, -- Trigger on char removal
    is_incomplete_forward = false, -- Trigger on char addition
  })

  return function() end -- To avoid memleaks when the completion fails.
end

return source
