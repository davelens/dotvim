local rspec = {}

-- Converts "foo = create(:bar) to foo { create(:bar) }"
--
-- I haven't found this to be easier in pure Lua.
-- You could probably do it in a oneliner with regex, but
function rspec.refactor_assignment_to_let()
  vim.cmd('normal! dd')                               -- Delete the current line
  vim.cmd('normal! ?^%s*it\\>')                       -- Search for the next 'it' block
  vim.cmd('normal! P')                                -- Paste the deleted line above it
  vim.cmd([[.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/]]) -- Do the substitution
  vim.cmd('normal ==')                                -- Fix indentation
end

return rspec
