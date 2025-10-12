local M = {}

function M.get(C)
	return {
		["@constant.macro"] = { fg = C.syntax },
		["@function.method"] = { fg = C.syntax },
		["@type.qualifier"] = { fg = C.syntax },
		["@variable.parameter"] = { fg = C.syntax },
		["@variable"] = { fg = C.syntax },
		["@type.definition"] = { fg = C.syntax },
		["@markup.italic"] = { fg = C.syntax },
		["@markup.strong"] = { fg = C.syntax },
		["@markup.underline"] = { fg = C.syntax },
		["@markup.strikethrough"] = { fg = C.syntax },

		["@_jsx_attribute"] = { link = "Constant" },
		["@string.documentation.python"] = { link = "Comment" },
	}
end

return M
