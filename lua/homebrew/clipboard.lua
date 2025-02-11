if vim.fn.has("wsl") == 1 then
  vim.g.clipboard = {
    name = "WslClipboard",
    copy = {
      ["+"] = "cb",
      ["*"] = "cb",
    },
    paste = {
      ["+"] = 'cb',
      ["*"] = 'cb',
    },
    cache_enabled = 0,
  }
end
