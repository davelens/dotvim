-- set your leader and local leader key
-- make sure to set `mapleader` and `maplocalleader` before lazy so your mappings are correct
vim.g.mapleader = " " -- using space as leader key
vim.g.maplocalleader = "," -- using comma as local leader

require("lazy")

local vimrc = vim.fn.stdpath("config") .. "/vimrc.vim"
vim.cmd.source(vimrc)
