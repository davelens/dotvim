return {
  -- NOTE: I couldn't get the specific shim to load in due to it not being
  -- executable. Which doesn't make sense, since that's the same on in my path
  -- that nvim is clever enough to pick up. TBC.
  cmd = { 'lua-language-server' },
  filetypes = { 'lua' },
  root_markers = { '.luarc.json', '.luarc.jsonc' },
  -- The schema for lua-language-server can be found here:
  -- https://raw.githubusercontent.com/LuaLS/vscode-lua/master/setting/schema.json
  settings = {
    Lua = {
      runtime = {
        -- TODO: Change version depending on context. Neovim uses 5.1 and that's
        -- my main usecase, so default to 5.1 for now.
        version = 'Lua 5.1',
      }
    }
  }
}
