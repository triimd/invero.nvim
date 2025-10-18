local util = require('invero.lib.utils')

local M = {}

function M.generate(colors)
  return util.template(
    [[
palette = 0={black}
palette = 1={red}
palette = 2={green}
palette = 3={yellow}
palette = 4={blue}
palette = 5={magenta}
palette = 6={cyan}
palette = 7={white}
palette = 8={black}
palette = 9={red}
palette = 10={green}
palette = 11={yellow}
palette = 12={blue}
palette = 13={magenta}
palette = 14={cyan}
palette = 15={white}

background = {base}
foreground = {text}
cursor-color = {accent}
selection-background = {surface}
selection-foreground = {text}
]],
    colors
  )
end

return M
