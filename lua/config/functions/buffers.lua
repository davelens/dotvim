local buffers = {}

-- For programming languages using a semi colon at the end of statement.
-- If there isn't one, append a semi colon to the end of the current line.
-- Thanks to @dubgeiser for the original Vimscript!
function buffers.append_semicolon()
  local line = vim.api.nvim_get_current_line()
  local cursor_pos = vim.api.nvim_win_get_cursor(0)

  if not line:match(';$') then
    vim.api.nvim_set_current_line(line .. ';')
  end

  vim.api.nvim_win_set_cursor(0, cursor_pos)
end

-- Clean up and wipeout all hidden buffers.
function buffers.delete_hidden()
  local tpbl = {}

  -- Iterate through each tab and collect the visible buffers
  for tab = 1, vim.fn.tabpagenr('$') do
    local tab_buffers = vim.fn.tabpagebuflist(tab)
    vim.list_extend(tpbl, tab_buffers)
  end

  -- Iterate through all buffers and delete the hidden ones
  for buf = 1, vim.fn.bufnr('$') do
    if vim.fn.bufexists(buf) == 1 and vim.fn.index(tpbl, buf) == -1 then
      if Snacks then
        Snacks.bufdelete(buf) -- Preserves window layout.
      else
        vim.cmd('silent bwipeout ' .. buf)
      end
    end
  end
end

-- Rename the current file in your buffer.
function buffers.rename_file(old_name, new_name)
  old_name = old_name or vim.fn.expand('%:t')
  local input_ok = true

  if new_name == nil or new_name == '' then
    input_ok, new_name =
      pcall(vim.fn.input, string.format('Rename "%s" to: ', old_name))
  end

  if
    not input_ok
    or new_name == nil
    or new_name == ''
    or new_name == old_name
  then
    return dvim.utils.print_redraw('Rename cancelled')
  end

  -- GRename is a vim-fugitive command.
  if vim.fn.exists(':GRename') == 2 then
    -- Check if the file is tracked by git
    vim.fn.systemlist('git ls-files --error-unmatch ' .. vim.fn.expand('%:p'))

    if vim.v.shell_error == 0 then -- 0 = File is tracked by git
      vim.cmd('GRename ' .. new_name)
      return dvim.utils.print_redraw(
        'Renamed ' .. old_name .. ' to ' .. new_name
      )
    end
  end

  local old_path = vim.fn.expand('%:p')
  local new_path = vim.fn.fnamemodify(old_path, ':h') .. '/' .. new_name

  local rename_ok, err = os.rename(old_path, new_path)
  if not rename_ok then
    return dvim.utils.print_redraw('Error renaming file: ' .. err)
  end

  vim.cmd('e ' .. new_path) -- Update buffer to the new file
  dvim.utils.print_redraw('Renamed ' .. old_name .. ' to ' .. new_name)
end

-- Check if any buffer for the given type is currently open.
function buffers.is_open(buf_type)
  for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(bufnr) then
      local bufname = vim.api.nvim_buf_get_name(bufnr)
      if bufname:match(buf_type) then
        return true
      end
    end
  end
  return false
end

-- Copy the current buffer's file path to the clipboard.
-- @param opts table Options table with the following keys:
--   - absolute: boolean (default: false) If true, use absolute path. If false, use path relative to cwd.
function buffers.copy_filepath(opts)
  opts = opts or { absolute = false }
  local filepath = vim.fn.expand('%:.')

  if opts.absolute then
    filepath = vim.fn.expand('%:p')
  end

  local copy_cmd = 'xclip -selection clipboard'

  if vim.fn.has('mac') == 1 then
    copy_cmd = 'pbcopy'
  elseif vim.fn.has('wsl') == 1 then
    copy_cmd = 'clip.exe'
  elseif os.getenv('WAYLAND_DISPLAY') then
    copy_cmd = 'wl-copy'
  end

  vim.fn.system('echo -n ' .. vim.fn.shellescape(filepath) .. ' | ' .. copy_cmd)
end

-- Shifts the width of the buffer into a given direction.
-- `direction` = either 'left', 'right', 'up', or 'down'
function buffers.shift_width(direction)
  local d = direction and direction or 'left'

  local lr = d == 'left' or d == 'right'
  -- 5 columns left/right, 3 rows for up/down
  local amt = lr and 5 or 3

  local pos = vim.api.nvim_win_get_position(0)
  local w = vim.api.nvim_win_get_width(0)
  local h = vim.api.nvim_win_get_height(0)

  if lr then
    amt = pos[2] == 0 and -amt or amt
  else
    amt = pos[1] == 0 and -amt or amt
  end

  w = (d == 'left') and (w + amt) or (w - amt)
  h = (d == 'up') and (h + amt) or (h - amt)

  if lr then
    vim.api.nvim_win_set_width(0, w)
  else
    vim.api.nvim_win_set_height(0, h)
  end
end

return buffers
