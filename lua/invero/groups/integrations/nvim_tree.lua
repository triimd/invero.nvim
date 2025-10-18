local M = {}

function M.get(c)
  return {
    NvimTreeRootFolder = { fg = c.base, bg = c.outline, bold = true },
    NvimTreeIndentMarker = { fg = c.outline_light },
    NvimTreeFolderIcon = { fg = c.accent },
    NvimTreeEmptyFolderName = { fg = c.accent, bold = true },
    NvimTreeFileIcon = { fg = c.outline },
    NvimTreeCopiedHL = { undercurl = true },
  }
end

return M
