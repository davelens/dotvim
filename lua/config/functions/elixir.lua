local elixir = {}

-- Wraps a string with gettext
--
function elixir.wrap_with_gettext()
  local line = vim.api.nvim_get_current_line()
  local str = dvim.utils.get_visual_selection()
  local search = '"' .. str .. '"'
  local replace = '{gettext("' .. str .. '")}'
  local start_pos = line:find(search, 1, true)

  if start_pos then
    local new_line = line:sub(1, start_pos - 1)
      .. replace
      .. line:sub(start_pos + #search)
    vim.api.nvim_set_current_line(new_line)
  end
end

return elixir
