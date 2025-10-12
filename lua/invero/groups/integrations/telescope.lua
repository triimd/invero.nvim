local M = {}

function M.get(C)
	return {
		TelescopeMatching = { fg = C.yellow, bg = C.none, bold = true },
	}
end

return M
