local M = {}

function M.get(C)
  return {
    NvimTreeIndentMarker = { fg = C.accent },
    NvimTreeFolderIcon = { fg = C.accent },
    NvimTreeEmptyFolderName = { fg = C.accent, bold = true },
    NvimTreeFileIcon = { fg = C.outline },
    NvimTreeCopiedHL = { undercurl = true },
  }
end

return M
