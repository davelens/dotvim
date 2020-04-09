" Indentation and whitespace defaults
" See this screencast to learn how these interoperate:
" http://vimcasts.org/episodes/tabs-and-spaces/
setlocal smartindent " Smart(ish) autoindenting when starting a new line
setlocal cindent " Automatic C-style indenting for non-C files
setlocal autoindent " Copy indents from current line when moving to a new line
setlocal tabstop=2 " The width of a tab character
setlocal expandtab " Forces spaces instead of tab characters
setlocal shiftwidth=2 " Use 2 spaces as default indent width when using << >>
setlocal softtabstop=2 " Determines how much whitespace is used while indenting
" Inserts/Deletes whitespace in front of lines according to the above settings
setlocal smarttab

nnoremap <buffer> <leader>a :A<CR>
nnoremap <buffer> <leader>r :R<CR>

" Method definition lookup. Same as <leader>l, but prefixes search string with "def "
nnoremap <expr> <leader>d ':execute rg#run("Rg -t ruby", "def '. expand('<cword>') .'")<CR>'
vnoremap <leader>d "ky:execute rg#run('Rg -t ruby ', "def ". @k)<CR>

" Convert "test = 3" to "let(:test) { 3 }"
nnoremap <leader>p :call refactor#rspec_promote_to_let()<CR>
