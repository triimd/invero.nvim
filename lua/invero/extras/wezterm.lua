local util = require('invero.lib.utils')

local M = {}

function M.generate(colors)
  return util.template(
    [[
[colors]
background = "${base}"
foreground = "${text}"
cursor_bg = "${accent}"
cursor_border = "${muted}"
cursor_fg = "${base}"
selection_bg = "${surface}"
selection_fg = "${text}"
split = "${blue}"
compose_cursor = "${yellow}"
scrollbar_thumb = "${muted}"

copy_mode_active_highlight_bg = { Color = "${surface}" }
copy_mode_active_highlight_fg = { Color = "${yellow}" }
copy_mode_inactive_highlight_bg = { Color = "${base}" }
copy_mode_inactive_highlight_fg = { Color = "${yellow}" }

ansi = ["${black}", "${red}", "${green}", "${yellow}", "${blue}", "${magenta}", "${cyan}", "${white}"]
brights = ["${black}", "${red}", "${green}", "${yellow}", "${blue}", "${magenta}", "${cyan}", "${white}"]

[colors.tab_bar]
inactive_tab_edge = "${red}"
background = "${black}"

[colors.tab_bar.active_tab]
fg_color = "${white}"
bg_color = "${black}"
intensity = "Bold"

[colors.tab_bar.inactive_tab]
fg_color = "${muted}"
bg_color = "${black}"

[colors.tab_bar.inactive_tab_hover]
fg_color = "${surface}"
bg_color = "${black}"
]],
    colors
  )
end

return M
