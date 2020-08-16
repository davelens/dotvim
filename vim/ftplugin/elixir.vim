if(empty(glob('~/.config/coc/extensions/node_modules/coc-elixir/package.json')))
  silent CocInstall coc-elixir
endif

nnoremap <leader>a :call navigation#alt(expand('%'), ':e')<CR>
