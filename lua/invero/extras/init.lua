local utils = require('invero.lib.utils')

local M = {}

M.extras = {
  wezterm = { ext = 'toml' },
  kitty = { ext = 'conf' },
  ghostty = {},
}

local function extra_filename(theme_name, metadata, variant)
  return theme_name
    .. (variant and '_' .. variant or '')
    .. (metadata.ext and '.' .. metadata.ext or '')
end

function M.setup()
  local invero = require('invero')

  for extra, metadata in pairs(M.extras) do
    local extra_path = vim.fs.joinpath(vim.fn.getcwd(), 'extras', extra)
    local port = require('invero.extras.' .. extra)
    for variant, _ in pairs(invero.variants) do
      local filename = extra_filename(invero.theme_name, metadata, variant)
      local file_path = vim.fs.joinpath(extra_path, filename)
      local colors = invero.get_colors({ variant = variant })
      colors = utils.normalize_colors(colors, 'gui')
      local content = port.generate(colors)

      utils.write_file(file_path, content)
    end
  end
end

return M
