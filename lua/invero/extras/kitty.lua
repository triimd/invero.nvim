local util = require('invero.lib.utils')

local M = {}

function M.generate(colors)
  return util.template(
    [[
# vim:ft=kitty

background ${base}
foreground ${text}
cursor ${accent}
cursor_text_color ${base}
selection_background ${surface}
selection_foreground ${text}
url_color ${blue}

# Tabs
active_tab_background ${blue}
active_tab_foreground ${base}
inactive_tab_background ${surface}
inactive_tab_foreground ${muted}

# normal
color0 ${black}
color1 ${red}
color2 ${green}
color3 ${yellow}
color4 ${blue}
color5 ${magenta}
color6 ${cyan}
color7 ${white}

# bright
color8  ${black}
color9  ${red}
color10 ${green}
color11 ${yellow}
color12 ${blue}
color13 ${magenta}
color14 ${cyan}
color15 ${white}
]],
    colors
  )
end

return M
