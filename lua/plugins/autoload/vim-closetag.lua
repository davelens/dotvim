-- Auto-close HTML/XML tags. I had nvim-ts-autotag installed, but that
-- functionality does not include the convenient formatting with indentation.
-- I'll stick to vim-closetag for now.
--
-- NOTE: copilot sometimes messes with the indentation, so another use case
-- where a toggle for copilot is pretty much required.
return {
  'alvan/vim-closetag',
  init = function()
    -- using init() here because closetag requires vim.g modifications.
    vim.g.closetag_filetypes = 'html,eruby,eelixir,heex'
  end
  -- no opts needed here since this is a pure vim plugin.
}
