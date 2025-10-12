local M = {}

function M.get(C)
  return {
    TelescopeMatching = { fg = C.orange, bg = C.none, bold = true },
  }
end

return M
