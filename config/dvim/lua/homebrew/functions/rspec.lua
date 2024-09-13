-- Converts "foo = create(:bar) to foo { create(:bar) }"
function refactor_rspec_promote_to_let()
  -- Delete the current line
  vim.cmd('normal! dd')

  -- Paste the deleted line above the nearest 'it' block
  vim.cmd('normal! ?^%s*it\\>')  -- Search for the next 'it' block
  vim.cmd('normal! P')            -- Paste the deleted line

  -- Substitute the variable assignment with an RSpec let statement
  vim.cmd([[.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/]])

  -- Indent the line properly
  vim.cmd('normal ==')
end
