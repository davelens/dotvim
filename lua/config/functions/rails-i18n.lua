local M = {}

function M.get_yaml_files()
  return vim.fn.globpath('config/locales', '*.yml', false, true)
end

local function flatten_table(t, prefix, out)
  out = out or {}
  prefix = prefix or ''
  for k, v in pairs(t) do
    local key = prefix ~= '' and (prefix .. '.' .. k) or k
    if type(v) == 'table' then
      flatten_table(v, key, out)
    else
      out[key] = v
    end
  end
  return out
end

function M.parse_and_flatten_yaml_files()
  local files = M.get_yaml_files()
  local flat = {}

  for _, file in ipairs(files) do
    local json = vim.fn.system({ 'yq', '-o=json', file })
    local ok, tbl = pcall(vim.fn.json_decode, json)
    if ok and type(tbl) == 'table' then
      flatten_table(tbl, '', flat)
    end
  end

  return flat
end

function M.translations_quickfix_for(key)
  local files = M.get_yaml_files()
  local items = {}

  for _, file in ipairs(files) do
    local json = vim.fn.system({ 'yq', '-o=json', file })
    local ok, tbl = pcall(vim.fn.json_decode, json)
    if ok and type(tbl) == 'table' then
      local flat = {}
      flatten_table(tbl, '', flat)
      for k, v in pairs(flat) do
        local match = (k == key) or (k:sub(-(#key + 1)) == '.' .. key)
        if match then
          -- Find line number in file
          local lines = vim.fn.readfile(file)
          local last = k:match('([^.]+)$')
          local pattern = '^%s*' .. vim.pesc(last) .. ':'
          for i, line in ipairs(lines) do
            if line:match(pattern) then
              table.insert(items, {
                filename = file,
                lnum = i,
                col = 1,
                text = k .. ': ' .. tostring(v),
              })
              break
            end
          end
        end
      end
    end
  end

  return #items > 0 and items or nil
end

function M.translations_for(key)
  local flat = M.parse_and_flatten_yaml_files()
  local results = {}

  for k, v in pairs(flat) do
    -- Direct match OR if `k` ends with a dot followed by our `key`.
    if k == key or (k:sub(-#key + 1)) == '.' .. key then
      results[k] = v
    end
  end

  return next(results) and results or nil
end

function M.expand_yaml_key_under_cursor()
  local bufnr = vim.api.nvim_get_current_buf()
  local cursor = vim.api.nvim_win_get_cursor(0)
  local cur_line_num = cursor[1]
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, cur_line_num, false)

  -- Helper to extract key and indent from a YAML line
  local function parse_yaml_key(line)
    local indent, key = line:match('^(%s*)([%w_%-]+):')
    if key then
      return #indent, key
    end
    return nil, nil
  end

  local key_path = {}
  local cur_indent, cur_key = parse_yaml_key(lines[#lines])
  if not cur_key then
    return nil -- Not on a YAML key line
  end
  table.insert(key_path, 1, cur_key)

  -- Walk upwards to collect parent keys
  for i = #lines - 1, 1, -1 do
    local indent, key = parse_yaml_key(lines[i])
    if key and indent < cur_indent then
      table.insert(key_path, 1, key)
      cur_indent = indent
    end
  end

  -- Remove the root locale (first key)
  table.remove(key_path, 1)
  return table.concat(key_path, '.')
end

return M
