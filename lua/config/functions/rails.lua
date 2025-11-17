local blink = require('blink.cmp')
local snacks = require('snacks')
local rails = {
  _routes_cache = nil,
  _loading = false,
}

function rails.present()
  return vim.fn.findfile('config.ru', '.;') ~= ''
end

-- Helper to shell out and collect *_{path,url} helpers.
-- Calls callback with routes table when done, or empty table on error
function rails.load_routes(callback, force_reload)
  if rails._routes_cache and not force_reload then
    callback(rails._routes_cache)
    return
  end

  -- If already loading we queue the callback.
  if rails._loading then
    vim.defer_fn(function()
      rails.load_routes(callback, false)
    end, 100)
    return
  end

  rails._loading = true

  local script_path = vim.fn.stdpath('config') .. '/scripts/rails_routes.rb'
  local routes = {}

  require('plenary.job')
    :new({
      command = 'bin/rails',
      args = { 'runner', script_path },
      on_stdout = function(_, line)
        if line and line ~= '' then
          table.insert(routes, line)
        end
      end,
      on_exit = function(_, return_code)
        rails._loading = false
        if return_code == 0 then
          rails._routes_cache = routes
          callback(routes)
        else
          snacks.notify(
            'Failed to load Rails routes (exit code: ' .. return_code .. ')',
            { level = 'warn', title = 'Rails completion' }
          )
          callback({})
        end
      end,
    })
    :start()
end

-- Trigger Rails routes completion manually
function rails.complete_routes()
  if not rails.present() then
    return
  end

  if not vim.tbl_contains({ 'ruby', 'eruby' }, vim.bo.filetype) then
    snacks.notify(
      'Rails routes only available in Ruby files',
      { level = 'warn', title = 'Rails completion' }
    )
    return
  end

  -- Helper to setup and show completion
  local show_completion = function()
    vim.schedule(function()
      -- Completion with just the rails_routes provider.
      blink.show({ providers = { 'rails_routes' } })
    end)
  end

  -- If routes are already cached, show immediately
  if rails._routes_cache then
    show_completion()
    return
  end

  -- Routes not cached; hide blink.
  blink.hide()

  -- Show loading notification directly to get the notification object.
  local loading = snacks.notify(
    'Caching Rails routes...',
    { level = 'info', title = 'Rails completion' }
  )

  -- Load routes in background with callback to trigger completion.
  rails.load_routes(function(routes)
    if loading and loading.close then
      loading:close()
    end

    snacks.notify(
      string.format('%d routes cached.', #routes),
      { level = 'info', title = 'Rails completion' }
    )

    show_completion()
  end, false) -- don't force reload
end

return rails
