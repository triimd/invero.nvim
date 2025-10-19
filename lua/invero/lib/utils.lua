local M = {}

function M.merge(...)
  local t = {}
  local args = { ... }
  for i = 1, #args do
    t = vim.tbl_deep_extend('force', t, args[i] or {})
  end
  return t
end

function M.normalize_colors(colors, to)
  to = to or 'gui' -- or 'cterm'
  local normalized = {}
  for name, color in pairs(colors) do
    normalized[name] = color[to]
  end
  return normalized
end

function M.template(str, tbl)
  return (
    str:gsub('($%b{})', function(w)
      return vim.tbl_get(tbl, unpack(vim.split(w:sub(3, -2), '.', { plain = true }))) or w
    end)
  )
end

function M.write_file(path, content)
  -- Ensure directory exists
  vim.fn.mkdir(vim.fs.dirname(path), 'p')

  local file = assert(io.open(path, 'w'))
  file:write(content)
  file:close()
end

-- function M.reload_theme()
--   M.reload_namespace('invero')
-- end
--
-- function M.reload_namespace(ns)
--   for name, _ in pairs(package.loaded) do
--     if name:match('^' .. ns) then
--       package.loaded[name] = nil
--     end
--   end
-- end

return M
