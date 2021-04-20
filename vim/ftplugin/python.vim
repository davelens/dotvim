set wildignore+=*.pyc

" Use pydoc for keywordprg.
" Unix users preferentially get pydoc3, then pydoc2.
" Windows doesn't have a standalone pydoc executable in $PATH by default, nor
" does it have separate python2/3 executables, so Windows users just get
" whichever version corresponds to their installed Python version.
if executable('python3')
  setlocal keywordprg=python3\ -m\ pydoc
elseif executable('python')
  setlocal keywordprg=python\ -m\ pydoc
endif

" Not a fan of tabs for indentation, but adhering to the PEP8 community
" standard.
if !exists("g:python_recommended_style") || g:python_recommended_style != 0
  setlocal expandtab tabstop=4 softtabstop=4 shiftwidth=4
endif

" Method definition lookup. Same as <leader>l, but prefixes search string with "def "
nnoremap <expr> <leader>d ':execute rg#run("Rg -t python", "def '. expand('<cword>') .'")<CR>'
vnoremap <leader>d "ky:execute rg#run('Rg -t python ', "def ". @k)<CR>
