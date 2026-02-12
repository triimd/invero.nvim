local H = require('invero.lib.highlights')
local M = {}
local uv = vim.uv or vim.loop

local function get_plugin_root()
  local source = debug.getinfo(1, 'S').source:sub(2)
  return vim.fn.fnamemodify(source, ':h:h:h:h')
end

local function get_mtime(path)
  local stat = uv.fs_stat(path)
  if not stat or not stat.mtime then
    return 0
  end

  if type(stat.mtime) == 'number' then
    return stat.mtime
  end

  return stat.mtime.sec or 0
end

local function sorted_keys(tbl)
  local keys = {}
  for k in pairs(tbl) do
    table.insert(keys, k)
  end
  table.sort(keys)
  return keys
end

function M.is_cache_stale(G)
  local cache_mtime = get_mtime(G.cache_path)
  if cache_mtime == 0 then
    return true
  end

  local root = get_plugin_root()
  local source_files = {}
  vim.list_extend(source_files, vim.fn.globpath(vim.fs.joinpath(root, 'lua', 'invero'), '**/*.lua', false, true))
  vim.list_extend(source_files, vim.fn.globpath(vim.fs.joinpath(root, 'colors'), '**/*.lua', false, true))

  for _, file in ipairs(source_files) do
    if get_mtime(file) > cache_mtime then
      return true
    end
  end

  return false
end

function M.serialize(highlights)
  local buffer = { 'return {\n' }

  for _, group in ipairs(sorted_keys(highlights)) do
    local options = highlights[group]
    table.insert(buffer, string.format('  [%q] = {', group))

    for _, k_opt in ipairs(sorted_keys(options)) do
      local v_opt = options[k_opt]
      if type(v_opt) == 'string' then
        table.insert(buffer, string.format(' %s=%q,', k_opt, v_opt))
      elseif type(v_opt) == 'number' then
        table.insert(buffer, string.format(' %s=%s,', k_opt, v_opt))
      elseif type(v_opt) == 'boolean' then
        table.insert(buffer, string.format(' %s=%s,', k_opt, v_opt))
      end
    end

    table.insert(buffer, ' },\n')
  end

  table.insert(buffer, '}\n')
  return table.concat(buffer)
end

function M.write_to_cache(G, highlights)
  vim.fn.mkdir(vim.fs.dirname(G.cache_path), 'p')
  local serialized = M.serialize(highlights)

  local cache_file = io.open(G.cache_path, 'r')
  if cache_file then
    local existing = cache_file:read('*a')
    cache_file:close()
    if existing == serialized then
      return
    end
  end

  local tmp_path = G.cache_path .. '.tmp'
  local file = assert(io.open(tmp_path, 'w'))
  file:write(serialized)
  file:close()
  local ok, err = os.rename(tmp_path, G.cache_path)
  if not ok then
    os.remove(tmp_path)
    error(err)
  end
end

function M.build_cache(G)
  local highlights = H.generate_highlights(G)
  local success, err = pcall(M.write_to_cache, G, highlights)
  if not success then
    vim.notify('invero: failed to write cache: ' .. err, vim.log.levels.WARN)
    os.remove(G.cache_path)
  end
  return highlights
end

function M.rebuild_cache(G)
  os.remove(G.cache_path)
  return M.build_cache(G)
end

return M
