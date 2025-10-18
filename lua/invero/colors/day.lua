local M = {}

function M.get_palette(c)
  return {
    red = c(196),
    green = c(35),
    yellow = c(166),
    blue = c(27),
    magenta = c(60),
    cyan = c(153),
    black = c(238),
    gray0 = c(245),
    gray1 = c(247),
    gray2 = c(249),
    gray3 = c(253),
    white = c(255),
    none = c('NONE'),
  }
end

function M.get_colors(p)
  return {
    base = p.white,
    text = p.black,

    accent = p.blue,
    accent_light = p.cyan,
    syntax = p.magenta,

    outline = p.gray0,
    outline_light = p.gray2,
    muted = p.gray1,
    surface = p.gray3,
  }
end

return M
