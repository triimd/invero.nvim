local util = require('invero.lib.utils')

local M = {}

function M.generate(colors, context)
  local is_day = context.variant == 'day'
  local values = vim.tbl_extend('force', colors, {
    herdr_surface1 = util.blend(colors.surface, colors.text, is_day and 0.08 or 0.12),
    herdr_surface_dim = util.blend(colors.base, colors.text, is_day and 0.05 or 0.08),
  })

  return util.template(
    [[
[theme]
name = "terminal"
auto_switch = false

[theme.custom]
accent = "${accent}"
panel_bg = "${base}"
surface0 = "${surface}"
surface1 = "${herdr_surface1}"
surface_dim = "${herdr_surface_dim}"
overlay0 = "${outline}"
overlay1 = "${outline_light}"
text = "${text}"
subtext0 = "${muted}"
mauve = "${syntax}"
green = "${green}"
yellow = "${yellow}"
red = "${red}"
blue = "${blue}"
teal = "${cyan}"
peach = "${yellow}"
]],
    values
  )
end

return M
