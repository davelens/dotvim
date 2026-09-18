-- Run with: nvim --headless -u NONE -l tests/plugin-prerequisites.lua
local executable = vim.fn.executable

for _, deno in ipairs({ 0, 1 }) do
  for _, make in ipairs({ 0, 1 }) do
    vim.fn.executable = function(command)
      return ({ deno = deno, make = make })[command] or 0
    end

    local peek = dofile('lua/plugins/autoload/peek.lua')
    local luasnip = dofile('lua/plugins/autoload/luasnip.lua')

    assert(peek.cond == (deno == 1), 'Peek must be skipped without Deno')
    assert(
      luasnip.build == (make == 1 and 'make install_jsregexp' or false),
      'LuaSnip must skip its native build without make'
    )
    assert(
      luasnip.enabled ~= false and luasnip.cond ~= false,
      'Keep LuaSnip enabled'
    )
  end
end

vim.fn.executable = executable
print('Plugin prerequisite checks passed')
