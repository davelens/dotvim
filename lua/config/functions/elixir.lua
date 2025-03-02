local elixir = {}

-- Wraps a string with gettext
--
function elixir.wrap_with_gettext()
  local line = vim.api.nvim_get_current_line()
  local str = dvim.utils.get_visual_selection()
  local new_line = line:gsub('"' .. str .. '"', '{gettext("' .. str .. '")}', 1)
  vim.api.nvim_set_current_line(new_line)
end

return elixir
