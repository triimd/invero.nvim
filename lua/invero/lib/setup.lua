local U = require('invero.lib.utils')
local M = {}

function M.setup(G, options)
  return U.merge(G.defaults, options)
end

function M.setup_extend(G, options)
  return U.merge(G.options or G.defaults, options)
end

function M.get_style_variant(G, variant)
  if variant == 'auto' then
    variant = nil
  end

  if variant and not G.variants[variant] then
    vim.notify(("Invero (error): Invalid variant '%s'"):format(variant), vim.log.levels.ERROR)
    variant = nil
  end

  if not variant then
    variant = G.options.background[vim.o.background]
  end

  return variant
end

function M.get_cache_path(G)
  return vim.fs.joinpath(G.cache_dir, G.variant)
end

function M.reset_theme(G)
  vim.cmd('highlight clear')
  if vim.fn.exists('syntax_on') == 1 then
    vim.cmd('syntax reset')
  end
  vim.g.colors_name = G.theme_name
end

function M.apply_highlights(G, highlights)
  M.reset_theme(G)

  if not highlights then
    highlights = M.read_from_cache(G)
  end

  for group, definition in pairs(highlights) do
    vim.api.nvim_set_hl(0, group, definition)
  end
end

function M.read_from_cache(G)
  local cache = require('invero.lib.cache')
  if cache.is_cache_stale(G) then
    return cache.rebuild_cache(G)
  end

  local ok, highlights = pcall(dofile, G.cache_path)
  if not ok or type(highlights) ~= 'table' then
    -- print('invero: cache not found or invalid, rebuilding…')
    highlights = cache.rebuild_cache(G)
  end

  return highlights
end

return M
