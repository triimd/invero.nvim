local S = require('invero.lib.setup')

local M = {
  defaults = {
    variant = 'auto',
    background = {
      light = 'day',
      dark = 'night',
    },
    integrations = {
      nvim_tree = true,
      telescope = true,
      treesitter = true,
    },
  },
  theme_name = 'invero',
  cache_dir = vim.fn.stdpath('cache') .. '/invero',
  variants = { day = 1, night = 2 },
}

function M.setup(options)
  M.options = S.setup(M, options)
end

function M.load(options)
  M.options = S.setup_extend(M, options)
  M.variant = S.get_style_variant(M, M.options.variant)
  M.cache_path = S.get_cache_path(M)

  S.reset_theme(M)

  local highlights = S.read_from_cache(M)
  S.apply_highlights(highlights)
end

function M.rebuild()
  require('invero.lib.cache').rebuild_cache(M)
end

return M
