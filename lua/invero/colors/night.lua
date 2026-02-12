local M = {}

function M.get_palette(c)
  return {
    red = c(203),
    green = c(114),
    yellow = c(222),
    blue = c(75),
    magenta = c(183),
    cyan = c(116),
    black = c(234),
    gray0 = c(240),
    gray1 = c(238),
    gray2 = c(236),
    gray3 = c(235),
    white = c(252),
    none = c('NONE'),
  }
end

function M.get_colors(p)
  return {
    base = p.black,
    text = p.white,

    accent = p.blue,
    accent_light = p.gray2,
    syntax = p.magenta,

    outline = p.gray0,
    outline_light = p.gray1,
    muted = p.gray0,
    surface = p.gray3,
  }
end

return M
