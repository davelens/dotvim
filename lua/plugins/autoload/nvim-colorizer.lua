-- Colorize hex codes, color names, etc
return { 
  'NvChad/nvim-colorizer.lua',
  config = function()
    require('colorizer').setup()
  end
}
