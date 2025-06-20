--- @module 'blink.cmp'
--- @class blink.cmp.Source
local source = {}

function source.new(_) -- No opts required, I just want a routes dump.
  local self = setmetatable({ routes = {} }, { __index = source })
  self.routes = require('config.functions.rails').load_routes()

  vim.api.nvim_create_autocmd('BufWritePost', {
    pattern = 'config/routes.rb',
    callback = function()
      return self.routes
    end,
  })

  return self
end

function source:enabled()
  return vim.tbl_contains({ 'ruby', 'eruby' }, vim.bo.filetype)
end

function source:get_completions(_, callback)
  local items = {}
  for _, line in ipairs(self.routes) do
    local route, desc = line:match('^(.-)%|%|(.+)$')

    table.insert(items, {
      label = route,
      detail = desc,
      kind = require('blink.cmp.types').CompletionItemKind.Text,
      documentation = {
        kind = 'markdown',
        value = 'Van `config/routes.rb`. Zet er hier nog een controller bij oid',
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
