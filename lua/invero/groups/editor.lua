local M = {}

function M.get(C)
  return {
    Normal = { fg = C.text, bg = C.none },
    Directory = { fg = C.accent },
    Question = { fg = C.text },
    LineNr = { fg = C.muted },
    CursorLineNr = { fg = C.accent, bold = true },
    CursorLine = { bg = C.surface },
    Visual = { bg = C.accent_light },
    ColorColumn = { bg = C.surface },

    Search = { fg = C.yellow },
    CurSearch = { fg = C.yellow, bg = C.none, bold = true },
    IncSearch = { fg = C.yellow, bg = C.none, bold = true },

    MatchParen = { fg = C.accent, bg = C.accent_light, bold = true },
    EndOfBuffer = { fg = C.base }, -- End-of-buffer marker (~ lines)

    WinSeparator = { fg = C.outline },
    -- StatusLine = { fg = C.outline, bg = C.none }, -- Active statusline (where filename)
    StatusLine = { fg = C.base, bg = C.outline, bold = false }, -- Active statusline (where filename)
    StatusLineNC = { fg = C.base, bg = C.outline, bold = false }, -- Active statusline (where filename)
    MsgArea = { fg = C.text, bg = C.none }, -- Command-line / message area
    MsgSeparator = { fg = C.text, bg = C.surface }, -- Separator for messages
    ModeMsg = { fg = C.text },

    TabLine = { fg = C.muted }, -- Unselected tab
    TabLineSel = { fg = C.text, bold = true }, -- Selected tab
    TabLineFill = { bg = C.none }, -- Empty space in the tabline

    Conceal = { fg = C.muted, italic = true },
  }
end

return M
