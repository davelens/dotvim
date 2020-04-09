" Indentation and whitespace defaults
" See this screencast to learn how these interoperate:
" http://vimcasts.org/episodes/tabs-and-spaces/
setlocal tabstop=2 " The width of a tab character
setlocal expandtab " Forces spaces instead of tab characters
setlocal shiftwidth=2 " Use 2 spaces as default indent width when using << >>
setlocal softtabstop=2 " Determines how much whitespace is used while indenting
" Inserts/Deletes whitespace in front of lines according to the above settings
setlocal smarttab
