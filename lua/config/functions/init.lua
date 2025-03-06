-- This function is local so it doesn't get exposed on _G.dvim.
local function setup_dvim_autocommands(opts, callback_opts)
  if not opts then
    return
  end

  local group = augroup(opts.name)

  autocmd(opts.event, {
    group = group,
    pattern = opts.pattern,
    callback = function(_)
      dd('Running autocommands for' .. opts.name)
      opts.autocommands(callback_opts)
    end
  })

  if opts.event == 'BufEnter' then
    autocmd({ 'BufLeave', 'BufDelete', 'FocusLost' }, {
      group = group,
      pattern = opts.pattern,
      callback = function(_)
        dvim.unload(opts.name)
      end
    })
  end
end

_G.dvim = {
  -- Load a submodule and stores it in the global dvim object
  load = function(opts)
    local src

    if not opts then
      error('dvim.load requires a module name or options table')
    end

    if type(opts) == 'string' then
      opts = { module = opts }
    end

    opts = vim.tbl_extend('force', {
      name = nil,
      module = nil,
      event = 'BufEnter',
      pattern = nil,
      autocommands = nil,
    }, opts) or {}

    opts.name = opts.name or opts.module:match('([^.]+)$')
    src = _G.dvim[opts.name] or require(opts.module)

    if opts.autocommands then
      setup_dvim_autocommands(opts, src)
    end

    _G.dvim[opts.name] = src
    return src
  end,

  -- Unloads a submodule from the global dvim object
  unload = function(name)
    _G.dvim[name] = nil
  end,
}

-- These are used everywhere, so we preload these on init.
_G.dvim.cursor = require('config.functions.cursor')
_G.dvim.buffers = require('config.functions.buffers')
_G.dvim.utils = require('config.functions.utils')

-- Global alias for quick debugging
dd = _G.dvim.utils.dump
