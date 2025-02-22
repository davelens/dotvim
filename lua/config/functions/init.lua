_G.dvim = {
  assign = function(name, module)
    _G.dvim = _G.dvim or { [name] = nil }
    _G.dvim[name] = _G.dvim[name] or require(module)
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
