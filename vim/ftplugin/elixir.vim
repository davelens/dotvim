let $MIX_ENV='test' " Fixes conflicts with the phoenix code reloader
" More info here: https://github.com/phoenixframework/phoenix/issues/1165

if(empty(glob('~/.config/coc/extensions/node_modules/coc-elixir/package.json')))
  silent CocInstall coc-elixir
endif

nnoremap <leader>a :call navigation#alt(expand('%'), ':e')<CR>
