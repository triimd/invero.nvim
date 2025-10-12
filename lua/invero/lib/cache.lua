local H = require('invero.lib.highlights')
local M = {}

function M.serialize(highlights)
  local buffer = { 'return {\n' }
  for group, options in pairs(highlights) do
    table.insert(buffer, string.format('  [%q] = {', group))
    for k_opt, v_opt in pairs(options) do
      if type(v_opt) == 'string' then
        table.insert(buffer, string.format(' %s=%q,', k_opt, v_opt))
      elseif type(v_opt) == 'number' then
        table.insert(buffer, string.format(' %s=%d,', k_opt, v_opt))
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
  local file = assert(io.open(G.cache_path, 'w'))
  file:write(M.serialize(highlights))
  file:close()
  vim.notify('invero: cache written to ' .. G.cache_path, vim.log.levels.INFO)
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
