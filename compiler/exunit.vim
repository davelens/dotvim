" Vim compiler file
" Language:     Elixir ExUnit
" Maintainer:   Dave Lens
" Last Change:  2024

if exists("current_compiler")
  finish
endif
let current_compiler = "exunit"

let s:cpo_save = &cpo
set cpo-=C

" Note: --color is NOT included here to keep quickfix clean.
" Colors are added via vim-test's g:test#elixir#exunit#options for terminal output.
CompilerSet makeprg=mix\ test

" ExUnit error format:
"   1) test description (Module.Test)
"      test/path/to_test.exs:123
"      ** (RuntimeError) error message
"      code: assert something
"      left: actual
"      right: expected
CompilerSet errorformat=
    \%E\ \ \ \ \ %n)\ %m,
    \%C\ \ \ \ \ \ \ \ \ %f:%l,
    \%C\ \ \ \ \ \ \ \ \ **\ %m,
    \%C\ \ \ \ \ \ \ \ \ code:\ %m,
    \%Z\ \ \ \ \ \ \ \ \ %m,
    \%W%f:%l:\ warning:\ %m,
    \%E%f:%l:\ %m,
    \%-G%.%#

let &cpo = s:cpo_save
unlet s:cpo_save

" vim: nowrap sw=2 sts=2 ts=8:
