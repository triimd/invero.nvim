local M = {}

function M.get_palette(c)
  return {
    -- Base colors
    black = c(238),
    red = c(196),
    green = c(35),
    yellow = c(221),
    blue = c(27),
    magenta = c(125),
    cyan = c(30),
    white = c(255),

    -- Extended
    gray_dark = c(245),
    gray = c(247),
    gray_light = c(253),
    orange = c(166),
    orange_light = c(180),
    yellow_light = c(180),
    blue_light = c(153),
    slate_indigo = c(60),

    none = c('NONE'),
  }
end

function M.get_colors(P)
  return {
    base = P.white,
    surface = P.gray_light,
    outline = P.gray_dark,
    text = P.black,
    muted = P.gray,
    accent = P.blue,
    accent_light = P.blue_light,
    syntax = P.slate_indigo,
  }
end

return M
