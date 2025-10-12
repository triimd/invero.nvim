local M = {}

function M.merge(...)
  local t = {}
  local args = { ... }
  for i = 1, #args do
    t = vim.tbl_deep_extend('force', t, args[i] or {})
  end
  return t
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
