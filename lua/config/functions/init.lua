_G.dvim = {
  -- Load a submodule and stores it in the global dvim object
  load = function(opts)
    local src
    opts = vim.tbl_extend('force', {
      name = nil,
      module = nil,
      pattern = nil,
      autocommands = nil,
    }, opts) or {}

    opts.name = opts.name or opts.module:match('([^.]+)$')
    src = _G.dvim[opts.name] or require(opts.module)

    group = augroup(opts.name)

    if opts.autocommands then
      autocmd('BufEnter', {
        group = group,
        pattern = opts.pattern,
        callback = function(_)
          opts.autocommands(src)
        end
      })

      autocmd({ 'BufLeave', 'BufDelete', 'FocusLost' }, {
        group = group,
        pattern = opts.pattern,
        callback = function(_)
          dvim.unload('rspec')
        end
      })
    end

    _G.dvim[opts.name] = src
    return src
  end,

  -- Unloads a submodule from the global dvim object
  unload = function(name)
    _G.dvim[name] = nil
  end,

  dump = function(var)
    print(vim.inspect(var))
  end,

  buffers = require('config.functions.buffers'),
  cursor = require('config.functions.cursor'),
  utils = require('config.functions.utils'),
}

-- Alias for quick debugging
dd = _G.dvim.dump
