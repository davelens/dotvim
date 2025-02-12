if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "cb copy",
      ["*"] = "cb copy",
    },
    paste = {
      ["+"] = 'cb paste',
      ["*"] = 'cb paste',
    },
    cache_enabled = 0,
  }
end
