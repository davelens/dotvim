-- This function is local so it doesn't get exposed on _G.dvim.
local function setup_dvim_autocommands(opts, callback_opts)
  if not opts then
    return
  end

  local group = dvim.utils.augroup(opts.name)

  dvim.utils.autocmd(opts.event, {
    group = group,
    pattern = opts.pattern,
    callback = function(_)
      opts.autocommands(callback_opts)
    end,
  })

  if opts.event == 'BufEnter' then
    dvim.utils.autocmd({ 'BufLeave', 'BufDelete', 'FocusLost' }, {
      group = group,
      pattern = opts.pattern,
      callback = function(_)
        dvim.unload(opts.name)
      end,
    })
  end
end

_G.dvim = {
  -- Load a submodule and store it in the global dvim object
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

-- Global aliases for quick debugging
-- These should be used for quick dumping of vars.
-- For debugging in functions, just use Snacks.debug's DSL.
_G.dd = function(...)
  Snacks.debug.inspect(...)
end
_G.bt = function(...)
  Snacks.debug.backtrace(...)
end

-- Override Neovim's built-in print so `:=` also uses dd().
vim.print = _G.dd
