local util = require('invero.lib.utils')

local M = {}

function M.generate(colors, context)
  local values = vim.tbl_extend('force', colors, {
    name = context.name,
  })

  return util.template(
    [[
themes {
  ${name} {
    fg "${text}"
    bg "${base}"
    black "${black}"
    red "${red}"
    green "${green}"
    yellow "${yellow}"
    blue "${blue}"
    magenta "${magenta}"
    cyan "${cyan}"
    white "${white}"
    orange "${yellow}"
  }
}
]],
    values
  )
end

return M
