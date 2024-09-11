local function get_translation(text)
  -- Replace this with your actual function to get translations
  return "Translation for: " .. text
end

local function toggle_floating_windows()
  local buf = vim.api.nvim_get_current_buf()
  local line_num = vim.api.nvim_win_get_cursor(0)[1] - 1
  local current_line = vim.api.nvim_buf_get_lines(buf, line_num, line_num + 1, false)[1]

  -- Define the pattern to match
  local pattern = "t%(['\"][%w%.]+['\"]%)" -- Updated regex pattern

  -- Function to check if a window is a floating window
  local function is_floating_win(win_id)
    local win_info = vim.api.nvim_win_get_config(win_id)
    return win_info.relative and win_info.relative ~= ""
  end

  -- Close all floating windows
  local function close_all_floating_windows()
    for _, win_id in ipairs(vim.api.nvim_list_wins()) do
      if is_floating_win(win_id) then
        vim.api.nvim_win_close(win_id, true)
      end
    end
  end

  -- Get the IDs of existing floating windows
  local floating_windows = {}
  for _, win_id in ipairs(vim.api.nvim_list_wins()) do
    if is_floating_win(win_id) then
      table.insert(floating_windows, win_id)
    end
  end

  if #floating_windows > 0 then
    -- If floating windows are open, close them
    close_all_floating_windows()
  else
    -- Define dimensions for floating windows
    local width = 30
    local height = 1
    local row_offset = 1 -- Vertical offset from the match

    -- Create floating windows for each match
    local match_start = 1
    while match_start do
      match_start, match_end = current_line:find(pattern, match_start)
      if match_start then
        local match_text = current_line:sub(match_start, match_end)

        -- Calculate the position for the floating window
        local row = line_num - row_offset
        local col = match_start - 1

        -- Create a new buffer for the floating window
        local float_buf = vim.api.nvim_create_buf(false, true)

        -- Fetch the translation and set it in the buffer
        local translation = get_translation(match_text)
        vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, { translation })

        -- Open the floating window
        local win_opts = {
          relative = 'win',
          row = row,
          col = col,
          width = width,
          height = height,
          style = 'minimal',
          border = 'single'
        }
        local win_id = vim.api.nvim_open_win(float_buf, true, win_opts)
        table.insert(floating_windows, win_id)

        -- Move to the next match
        match_start = match_end + 1
      end
    end
  end
end

-- Bind the function to a command or keybinding
vim.api.nvim_create_user_command('ToggleFloatingWindows', toggle_floating_windows, {})

--vim.keymap.set('n', '<leader>m', '<cmd>ToggleFloatingWindows<CR>')

