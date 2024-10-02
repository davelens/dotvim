-- Indentation and whitespace default
-- See this screencast to learn how these interoperate:
-- http://vimcasts.org/episodes/tabs-and-spaces/
vim.opt.autoindent = true -- Copy indents from current line when mooving to a new line
vim.opt.expandtab = true -- Forces spaces instead of tab characters
vim.opt.shiftwidth = 2 -- Use 2 spaces as default indent width when using << >>
vim.opt.smartindent = true -- Smart(ish) autoindenting when starting a new line
vim.opt.softtabstop = 2 -- Determines how much whitespace is used while indenting
vim.opt.tabstop = 2 -- The width of a tab character
-- Inserts/Deletes whitespace in front of lines according to the above settings
vim.opt_local.smarttab = true

-- Behavioural settings
vim.opt.autoread = true -- Load in changes made from *outside* vim
vim.opt.autowrite = true -- Write file contents for writable buffers
-- Allow backspacing over autoindent, line breaks and insert mode start
vim.opt.backspace = 'indent,eol,start'
vim.opt.colorcolumn = '80' -- Mark a (convenient) vertical line at the 80 char mark
vim.opt.completeopt = 'menu,longest' -- Autocompletion menu with the longest common match
vim.opt.cursorline = true -- Adds a coloured horizontal (convenient) cursor row
-- TODO: See about using vim.opt.undofile + simnalamburt/vim-mundo instead.
vim.opt.directory = vim.fn.expand("~") .. "/.local/share/dvim/swap" --The swapfile directory
vim.opt.encoding = 'utf-8'
--vim.opt.fileformat = unix -- Use <NL> as EOL
vim.opt.foldclose = 'all' -- When inactive folds get closed when foldmethod is toggled
vim.opt.foldmethod = 'marker' -- Only fold by means of inline marker comments
vim.opt.hidden = true -- Keeps buffers in the background when left behind
vim.opt.ignorecase = true -- Ignore casing in pattern matching
vim.opt.incsearch = true -- Highlight search matches as you type
vim.opt.laststatus = 2 -- Always show a statusline
vim.opt.linespace = 0 -- Number of pixel lines between characters
vim.opt.cursorcolumn = false -- Adds a coloured vertical (distracting) cursor column
vim.opt.smartcase = true -- Ignores casing when all pattern characters are lowercase
vim.opt.visualbell = true -- NO BEEPING
vim.opt.whichwrap:append('<,>,[,]') -- Allows word wrapping only when cursor keys are used
vim.opt.clipboard = 'unnamedplus' -- Use the system clipboard
vim.colorscheme = 'onenord' -- Set the colorscheme
