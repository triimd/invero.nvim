local M = {}

function M.get(C)
  return {
    GitSignsAdd = { fg = C.green },
    GitSignsChange = { fg = C.yellow },
    GitSignsDelete = { fg = C.red },

    GitSignsAddNr = { fg = C.green },
    GitSignsChangeNr = { fg = C.yellow },
    GitSignsDeleteNr = { fg = C.red },

    GitSignsAddLn = { bg = C.surface },
    GitSignsChangeLn = { bg = C.surface },
    GitSignsDeleteLn = { bg = C.surface },

    GitSignsCurrentLineBlame = { fg = C.muted, italic = true },
  }
end

return M
