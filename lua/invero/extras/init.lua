local comments = require('invero.extras.comments')
local utils = require('invero.lib.utils')

local M = {}

local function get_plugin_root()
  local source = debug.getinfo(1, 'S').source:sub(2)
  return vim.fn.fnamemodify(source, ':h:h:h:h')
end

local readable_day_colors = {
  black = '#303030',
  text = '#303030',
  outline = '#626262',
  muted = '#6c6c6c',
  outline_light = '#767676',
}

M.extras = {
  wezterm = { ext = 'toml' },
  kitty = { ext = 'conf' },
  ghostty = { filetype = 'conf' },
  herdr = { ext = 'toml', color_overrides = { day = readable_day_colors } },
  pi = { ext = 'json', color_overrides = { day = readable_day_colors } },
  zellij = { ext = 'kdl', color_overrides = { day = readable_day_colors } },
}

local function extra_filename(theme_name, metadata, variant)
  return theme_name
    .. (variant and '-' .. variant or '')
    .. (metadata.ext and '.' .. metadata.ext or '')
end

function M.setup()
  local invero = require('invero')

  for extra, metadata in pairs(M.extras) do
    local extra_path = vim.fs.joinpath(get_plugin_root(), 'extras', extra)
    local port = require('invero.extras.' .. extra)
    local generated = {}

    for variant, _ in pairs(invero.variants) do
      local filename = extra_filename(invero.theme_name, metadata, variant)
      local file_path = vim.fs.joinpath(extra_path, filename)
      generated[filename] = true
      local colors = invero.get_colors({ variant = variant })
      if colors.terminal then
        local terminal = colors.terminal
        colors.terminal = nil
        for k, v in pairs(terminal) do
          colors[k] = v
        end
      end
      colors = utils.normalize_colors(colors, 'gui')
      colors = vim.tbl_extend(
        'force',
        colors,
        metadata.color_overrides and metadata.color_overrides[variant] or {}
      )
      local context = {
        name = invero.theme_name .. '-' .. variant,
        theme_name = invero.theme_name,
        variant = variant,
      }
      local content = port.generate(colors, context)
      content = comments.add(content, metadata.filetype or metadata.ext)

      utils.write_file(file_path, content)
    end

    for filename, filetype in vim.fs.dir(extra_path) do
      if filetype == 'file' and not generated[filename] then
        os.remove(vim.fs.joinpath(extra_path, filename))
      end
    end
  end
end

return M
