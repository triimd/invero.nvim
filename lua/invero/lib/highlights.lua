local U = require('invero.lib.utils')
local M = {}

local function generate_256_palette()
  local palette = {}
  -- 0..15 left as nil (system colors)
  -- 16..231: 6x6x6 color cube using standard xterm levels
  local levels = { 0, 95, 135, 175, 215, 255 }
  local idx = 16
  for r = 1, 6 do
    for g = 1, 6 do
      for b = 1, 6 do
        palette[idx] = string.format('#%02x%02x%02x', levels[r], levels[g], levels[b])
        idx = idx + 1
      end
    end
  end
  -- 232..255: grayscale ramp (8,18,...,238)
  for i = 232, 255 do
    local v = 8 + (i - 232) * 10
    palette[i] = string.format('#%02x%02x%02x', v, v, v)
  end

  return palette
end

function M.gen_color_tool()
  local palette_256 = generate_256_palette()

  return function(index, hex)
    if index == 'NONE' or index == 'none' then
      return { cterm = 'NONE', gui = 'NONE' }
    end

    return {
      cterm = index,
      gui = hex or palette_256[index],
    }
  end
end

local function get_theme_modules(G)
  local modules = {
    require('invero.groups.editor'),
    require('invero.groups.syntax'),
    require('invero.groups.terminal'),
  }

  local available_integrations = require('invero.lib.integrations').get_enabled(G.options)
  _G._integrations = available_integrations
  for _, integration in ipairs(available_integrations) do
    local ok_mod, mod = pcall(require, 'invero.groups.integrations.' .. integration)
    if ok_mod then
      table.insert(modules, mod)
    end
  end

  return modules
end

function M.get_variant_colors(G)
  local color_set = require('invero.colors.' .. G.variant)
  local color_tool = M.gen_color_tool()
  local palette = color_set.get_palette(color_tool)
  local semantic_colors = color_set.get_colors(palette)

  return U.merge(palette, semantic_colors), color_tool
end

local function normalize_highlight_groups(groups)
  local result = {}
  for group, opts in pairs(groups) do
    local hl = {}
    if type(opts) == 'string' then
      hl.link = opts
    else
      for k, v in pairs(opts) do
        if k == 'fg' then
          hl.ctermfg, hl.fg = v.cterm, v.gui
        elseif k == 'bg' then
          hl.ctermbg, hl.bg = v.cterm, v.gui
        else
          hl[k] = v
        end
      end
    end
    result[group] = hl
  end
  return result
end

function M.generate_highlights(G)
  local highlights = {}

  local modules = get_theme_modules(G)
  local colors, color_tool = M.get_variant_colors(G)
  for _, module in ipairs(modules) do
    local groups = module.get(colors, G.options)
    highlights = U.merge(highlights, groups)
  end

  if G.options.highlights then
    local custom_highlights = G.options.highlights(colors, color_tool)
    highlights = U.merge(highlights, custom_highlights)
  end

  local hl = normalize_highlight_groups(highlights)

  return hl
end

return M
