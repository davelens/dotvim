--- @module 'blink.cmp'
--- @class blink.cmp.Source
local source = {
  -- Set a custom name that will show in the source_name column
  name = 'Rails Routes',
}
local rails = require('config.functions.rails')

function source.new(_)
  local self = setmetatable({}, { __index = source })

  -- Auto-reload cache when routes file changes
  local group =
    vim.api.nvim_create_augroup('RailsRoutesReload', { clear = true })
  vim.api.nvim_create_autocmd('BufWritePost', {
    group = group,
    pattern = '*/config/routes.rb',
    callback = function()
      rails.load_routes(function(routes)
        if #routes > 0 then
          require('snacks').notify(
            string.format('Refreshed %d routes in cache.', #routes),
            { level = 'info', title = 'Rails completion' }
          )
        end
      end, true) -- force reload
    end,
  })

  return self
end

function source:enabled()
  if not vim.tbl_contains({ 'ruby', 'eruby' }, vim.bo.filetype) then
    return false
  end

  return rails.present()
end

function source:get_completions(_, callback)
  rails.load_routes(function(routes)
    local items = {}
    for _, line in ipairs(routes) do
      local route, desc, controller, action =
        line:match('^(.-)%|%|(.-)%|%|(.-)%|%|(.+)$')

      if route then
        table.insert(items, {
          label = route,
          detail = desc,
          kind = require('blink.cmp.types').CompletionItemKind.Function,
          documentation = {
            kind = 'markdown',
            value = tostring(controller) .. ' => ' .. tostring(action),
          },
        })
      end
    end

    callback({
      items = items,
      is_incomplete_backward = false,
      is_incomplete_forward = false,
    })
  end)

  return function() end
end

return source
