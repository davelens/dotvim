set nocompatible " No one fully knows the dark magic made by this setting.

" Automatic install of vim-plug
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/bundle')
" Structured and colored vim status bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" These provide the `r` block motion in Ruby files.
Plug 'adelarsq/vim-matchit' " extended matching for %
Plug 'kana/vim-textobj-user' " allows for custom text object definitions
Plug 'nelstrom/vim-textobj-rubyblock'

" Snippets.
Plug 'SirVer/ultisnips' " Snippet management
Plug 'honza/vim-snippets' " Snippet library for most filetypes

Plug 'sjl/vitality.vim' " FocusLost and FocusGained support
Plug 'altercation/vim-colors-solarized' " Pretty colors
"Plug 'dense-analysis/ale' " Syntax checking, linting, refactoring through LSP
Plug 'preservim/nerdcommenter' " Comment toggles
Plug 'jiangmiao/auto-pairs' " Smart brackets, parens and quotes
Plug 'tpope/vim-surround' " Maps to manipulate brackets, parens, quotes,..
Plug 'tpope/vim-repeat' " Extended repeat functionality through `.`
Plug 'tpope/vim-endwise' " Smart end structures for blocks
Plug 'tpope/vim-rails' " Pandora's box with Rails workflow features
Plug 'tpope/vim-fugitive', { 'tag': 'v3.3' } " Git wrapper for vim
Plug 'tpope/vim-dispatch' " Async testing toolkit
Plug 'tpope/vim-bundler' " Maps to help browse gem source code
Plug 'tpope/vim-abolish' " Case coercions and language corrections
Plug 'tpope/vim-unimpaired' " Complementary maps for quickfix, lists, options
Plug 'elixir-editors/vim-elixir' " Pandora's box with Elixir workflow features
Plug 'alvan/vim-closetag' " vim-endwise for HTML
Plug 'junegunn/fzf.vim' " Command-line fuzzy finder
Plug 'vim-test/vim-test' " Generic, configurable test-wrapper
Plug 'airblade/vim-localorie' " Maps and functions for Rails I18n interaction
Plug 'shime/vim-livedown' " Live markdown previews
" TODO: Find out which one of these have a conflicting <leader>t map.
"Plug 'dhruvasagar/vim-table-mode' " Table mode for human readable tables.
"Plug 'junegunn/vim-easy-align' " Table mode for human readable tables.
Plug 'github/copilot.vim' " AI pair programmer 😂

if has('nvim')
  Plug 'neoclide/coc.nvim', {'branch': 'release'} " Intellisense autocompletion
else
  Plug 'Valloric/YouCompleteMe' " Buffer autocompletion
endif

" This caters to Apple silicon. You need to point to /usr/local/opt/fzf for
" Intel macs.
if has('mac')
  Plug '/opt/homebrew/opt/fzf'
elseif has('unix')
  Plug '/home/linuxbrew/.linuxbrew/opt/fzf'
endif
call plug#end()

set hidden " Keeps buffers in the background when left behind
set autowrite " Write file contents for writable buffers
set autoread " Load in changes made from *outside* vim
set encoding=utf-8
set fileformat=unix " Use <NL> as EOL
set linespace=0 " Number of pixel lines between characters
set visualbell " NO BEEPING
set nocursorcolumn " Adds a coloured vertical (distracting) cursor column
set cursorline " Adds a coloured horizontal (convenient) cursor row
set colorcolumn=80 " Mark a (convenient) vertical line at the 80 char mark
set ignorecase " Ignore casing in pattern matching
set smartcase  " Ignores casing when all pattern characters are lowercase
set incsearch " Highlight search matches as you type
set laststatus=2 " Always show a statusline
set foldclose=all " When inactive folds get closed when foldmethod is toggled
set foldmethod=marker " Only fold by means of inline marker comments
set directory=~/.vim/swp " The swapfile directory
set whichwrap+=<,>,[,] " Allows word wrapping only when cursor keys are used
set completeopt=menu,longest " Autocompletion menu with the longest common match
" Allow backspacing over autoindent, line breaks and insert mode start
set backspace=indent,eol,start

" Indentation and whitespace default
" See this screencast to learn how these interoperate:
" http://vimcasts.org/episodes/tabs-and-spaces/
set smartindent " Smart(ish) autoindenting when starting a new line
set autoindent " Copy indents from current line when mooving to a new line
set tabstop=2 " The width of a tab character
set expandtab " Forces spaces instead of tab characters
set shiftwidth=2 " Use 2 spaces as default indent width when using << >>
set softtabstop=2 " Determines how much whitespace is used while indenting
" Inserts/Deletes whitespace in front of lines according to the above settings
setlocal smarttab

" wildmode determines how command-line completion behaves. It's considered the
" "enhanced" mode of completion because you can choose what it does for each
" subsequent use of the wildchar (<TAB>). If a condition fails, it moves to the
" next provided completion mode.
" 1st: longest. Complete until the longest matching string.
" 2nd: list. Lists all matches with n+1 match.
" 3d.: full. Completes the next full match.
set wildmenu
set wildmode=longest,list,full

if has('nvim')
  set icm=split " Enables real-time substitute previews. Nvim only.
endif

" The number of chars before syntax coloring fucks off.
" Setting this too high slows down files with a single, long line of code.
" (compiled js files, xml files,...)
set synmaxcol=512

" statusline: active file, line+col position, file format+encoding+filetype
" I'm using vim-airline, this is here as a fallback if for whatever reason I
" can't use plugins.
set statusline=%-25.25(%<%t\ %m%r\%)line\ %l\ of\ %L\ col\ %c%V\ %=%{&ff},%{strlen(&fenc)?&fenc:''}%Y
set t_vb= " Disable the bloody visual bell
set t_Co=256 " Set vim in 256 color-mode

" solarized options
let g:solarized_termtrans = 1
colorscheme solarized
set background=dark

" My thumbs never leave <Space> when typing, so it seems like the best choice.
let mapleader = ' '
