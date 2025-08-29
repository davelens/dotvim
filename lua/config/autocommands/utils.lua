local U = {}

function U.augroup(name)
  return vim.api.nvim_create_augroup('augroup_' .. name, { clear = true })
end

function U.autocmd(event, opts)
  return vim.api.nvim_create_autocmd(event, opts)
end

return U
