local M = {}

function M.get(c, opts)
  local bg = opts.transparent and c.none or c.base
  return {
    -- Core editor
    Normal = { fg = c.text, bg = bg },
    NormalNC = { fg = c.text, bg = bg },
    EndOfBuffer = { fg = c.base }, -- Filler lines (~)
    ColorColumn = { bg = c.surface },
    CursorLine = { bg = c.surface },
    CursorLineNr = { fg = c.accent, bold = true },
    LineNr = { fg = c.muted },
    Visual = { bg = c.accent_light },
    MatchParen = { fg = c.accent, bg = c.accent_light, bold = true },

    -- Search
    Search = { fg = c.yellow },
    IncSearch = { fg = c.yellow, bg = c.none, bold = true },
    CurSearch = { fg = c.yellow, bg = c.none, bold = true },

    -- Floating windows
    NormalFloat = { fg = c.text, bg = bg },
    FloatBorder = { fg = c.outline, bg = bg },
    FloatTitle = { fg = c.text, bold = true },
    FloatShadow = { bg = c.none, blend = 0 },
    FloatShadowThrough = { bg = c.none, blend = 0 },

    -- UI sections
    Directory = { fg = c.accent },
    Question = { fg = c.text },
    Conceal = { fg = c.muted, italic = true },

    -- StatusLine = { fg = c.outline, bg = bg },
    WinSeparator = { fg = c.outline, bg = c.outline },
    StatusLine = { fg = c.base, bg = c.outline, bold = true },
    StatusLineNC = { fg = c.surface, bg = c.outline },
    MsgArea = { fg = c.text, bg = bg },
    MsgSeparator = { fg = c.text, bg = c.outline_light },

    TabLine = { fg = c.muted, bg = c.black },
    TabLineSel = { fg = c.base, bg = c.black, bold = true },
    TabLineFill = { bg = c.black },

    -- Popups / menus
    Pmenu = { fg = c.text, bg = bg },
    PmenuSel = { fg = c.text, bg = c.accent_light },
    PmenuSbar = { bg = c.surface },
    PmenuThumb = { bg = c.outline },
  }
end

return M
