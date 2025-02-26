_G.dvim = {
  -- Load a submodule and stores it in the global dvim object
  load = function(name, module)
    _G.dvim[name] = _G.dvim[name] or require(module)
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
