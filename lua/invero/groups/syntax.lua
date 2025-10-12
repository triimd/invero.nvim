local M = {}

function M.get(C)
  return {
    Comment = { fg = C.muted, italic = true },
    String = { fg = C.green },
    Boolean = { fg = C.accent, bold = true, italic = true },
    Number = { fg = C.accent },

    -- syntax color
    Constant = { fg = C.syntax },
    Function = { fg = C.syntax },
    Special = { fg = C.syntax, bold = true, italic = true },
    Type = { fg = C.syntax },
    Statement = { fg = C.syntax },
    Identifier = { fg = C.syntax },
    Operator = { fg = C.syntax },
    PreProc = { fg = C.syntax },
    Delimiter = { fg = C.syntax },
    Todo = { fg = C.syntax },
    Title = { fg = C.syntax },
    Underlined = { fg = C.syntax },

    -- diffs
    Added = { fg = C.green },
    Removed = { fg = C.red },
    Changed = { fg = C.orange },

    -- diagnostics
    DiagnosticInfo = { fg = C.blue },
    DiagnosticWarn = { fg = C.orange },
    DiagnosticError = { fg = C.red },
    DiagnosticDeprecated = { fg = C.magenta },
    DiagnosticUnderlineError = { fg = C.syntax, underline = true },
  }
end

return M
