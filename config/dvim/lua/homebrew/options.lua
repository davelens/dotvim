-- Indentation and whitespace default
-- See this screencast to learn how these interoperate:
-- http://vimcasts.org/episodes/tabs-and-spaces/
vim.opt.autoindent = true -- Copy indents from current line when mooving to a new line
vim.opt.expandtab = true -- Forces spaces instead of tab characters
vim.opt.shiftwidth = 2 -- Use 2 spaces as default indent width when using << >>
vim.opt.smartindent = true -- Smart(ish) autoindenting when starting a new line
vim.opt.softtabstop = 2 -- Determines how much whitespace is used while indenting
vim.opt.tabstop = 2 -- The width of a tab character
vim.opt_local.smarttab = true -- Inserts/Deletes whitespace in front of lines according to the above settings

-- Behavioural settings
vim.colorscheme = 'onenord' -- Set the colorscheme
vim.opt.autoread = true -- Load in changes made from *outside* vim
vim.opt.autowrite = true -- Write file contents for writable buffers
vim.opt.backspace = 'indent,eol,start' -- Allow backspacing over autoindent, line breaks and insert mode start
vim.opt.breakindent = true -- Indent wrapped lines to match the start of the line above
vim.opt.clipboard = 'unnamedplus' -- Use the system clipboard
vim.opt.colorcolumn = '80' -- Mark a (convenient) vertical line at the 80 char mark
vim.opt.completeopt = 'menu,longest' -- Autocompletion menu with the longest common match
vim.opt.cursorcolumn = false -- Adds a coloured vertical (distracting) cursor column
vim.opt.cursorline = true -- Adds a coloured horizontal (convenient) cursor row
vim.opt.encoding = 'utf-8'
vim.opt.foldclose = 'all' -- When inactive folds get closed when foldmethod is toggled
vim.opt.foldmethod = 'marker' -- Only fold by means of inline marker comments
vim.opt.hidden = true -- Keeps buffers in the background when left behind
vim.opt.ignorecase = true -- Ignore casing in pattern matching
vim.opt.incsearch = true -- Highlight search matches as you type
vim.opt.laststatus = 2 -- Always show a statusline
vim.opt.linespace = 0 -- Number of pixel lines between characters
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }
vim.opt.scrolloff = 10 -- Keep 10 lines above and below the cursor when scrolling
vim.opt.showmode = false -- Do not show the current mode (it's already in the statusline)
vim.opt.signcolumn = 'yes' -- Always show the sign column
vim.opt.smartcase = true -- Ignores casing when all pattern characters are lowercase
vim.opt.undofile = true -- Enable persistent undo
vim.opt.updatetime = 250 -- Lower-than-default wait time (in ms) before writing swap file
vim.opt.visualbell = true -- NO BEEPING
vim.opt.whichwrap:append('<,>,[,]') -- Allows word wrapping only when cursor keys are used

-- TODO: See about using vim.opt.undofile + simnalamburt/vim-mundo instead.
vim.opt.directory = vim.fn.expand("~") .. "/.local/share/dvim/swap" --The swapfile directory
