local M = {}

function M.get(C)
  return {
    terminal_color_0 = { fg = C.black },
    terminal_color_8 = { fg = C.black },

    terminal_color_1 = { fg = C.red },
    terminal_color_9 = { fg = C.red },

    terminal_color_2 = { fg = C.green },
    terminal_color_10 = { fg = C.green },

    terminal_color_3 = { fg = C.orange },
    terminal_color_11 = { fg = C.orange },

    terminal_color_4 = { fg = C.blue },
    terminal_color_12 = { fg = C.blue },

    terminal_color_5 = { fg = C.magenta },
    terminal_color_13 = { fg = C.magenta },

    terminal_color_6 = { fg = C.cyan },
    terminal_color_14 = { fg = C.cyan },

    terminal_color_7 = { fg = C.white },
    terminal_color_15 = { fg = C.white },
  }
end

return M
