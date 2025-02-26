local rspec = {}

-- Converts "foo = create(:bar) to foo { create(:bar) }"
--
-- I haven't found this to be easier in pure Lua.
-- You could probably do it in a oneliner with regex, but
function rspec.refactor_assignment_to_let()
  vim.cmd('normal! dd') -- Delete the current line
  vim.cmd('normal! ?^%s*it\\>') -- Search for the next 'it' block
  vim.cmd('normal! P') -- Paste the deleted line above it
  vim.cmd([[.s/\(\w\+\) = \(.*\)$/let(:\1) { \2 }/]]) -- Do the substitution
  vim.cmd('normal ==') -- Fix indentation
end

-- Load the autocommands for the RSpec filetype buffers.
-- NOTE: This is an experiment to see if I can keep my ftplugin files as
-- readable as possible.
function rspec.load_autocommands(callback)
  rspec = augroup('rspec')

  autocmd('BufEnter', {
    group = rspec,
    pattern = '*_spec.rb',
    callback = function(_)
      dvim.load('rspec', 'config.functions.rspec')
      callback(dvim.rspec)
    end
  })

  autocmd('BufLeave', {
    group = rspec,
    pattern = '*_spec.rb',
    callback = function(_)
      dvim.unload('rspec')
    end
  })
end

return rspec
