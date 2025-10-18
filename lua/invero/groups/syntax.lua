local M = {}

function M.get(C)
  return {
    Comment = { fg = C.muted, italic = true },
    String = { fg = C.green },
    Boolean = { fg = C.accent, bold = true, italic = true },
    Number = { fg = C.accent },

    Constant = { fg = C.syntax },
    Function = { fg = C.syntax },
    Type = { fg = C.syntax },
    Statement = { fg = C.syntax },
    Identifier = { fg = C.syntax },
    Operator = { fg = C.syntax },
    PreProc = { fg = C.syntax },
    Delimiter = { fg = C.syntax },
    Special = { fg = C.syntax, bold = true, italic = true },
    Todo = { fg = C.syntax },
    Title = { fg = C.syntax },
    Underlined = { fg = C.syntax },

    -- Diffs
    Added = { fg = C.green },
    Changed = { fg = C.yellow },
    Removed = { fg = C.red },

    -- Diagnostics
    DiagnosticInfo = { fg = C.blue },
    DiagnosticWarn = { fg = C.yellow },
    DiagnosticError = { fg = C.red },
    DiagnosticDeprecated = { fg = C.muted },
    DiagnosticUnderlineError = { underline = true },
  }
end

return M
