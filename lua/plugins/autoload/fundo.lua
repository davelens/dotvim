-- f(orever) undo makes (neo)vim's undofile persistent, even for changes
-- outside of vim. This eats up to 512 MB disk space as a soft limit by default
-- though, so use caution.
--
-- Stores its data in vim.fn.stdpath('data')/fundo/archives
return {
  'kevinhwang91/nvim-fundo',
  dependencies = { 'kevinhwang91/promise-async' },
  config = function()
    -- Actually required since the plugin itself only calls on init(), and it
    -- depends on vim.o.undofile to be set first. I already do that in my 
    -- options.lua file, so all that's left here is calling setup.
    require('fundo').setup()
  end
}
