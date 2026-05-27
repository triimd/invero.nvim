local S = require('invero.lib.setup')
local U = require('invero.lib.utils')

local M = {
  defaults = {
    variant = 'auto',
    background = {
      light = 'day',
      dark = 'night',
    },
    transparent = false,
    integrations = {
      nvim_tree = true,
      telescope = true,
      treesitter = true,
      gitsigns = true,
    },
  },
  theme_name = 'invero',
  cache_dir = vim.fs.joinpath(vim.fn.stdpath('cache'), '/invero'),
  variants = { day = 1, night = 2 },
}

local function create_commands()
  vim.api.nvim_create_user_command('InveroReload', function(command)
    local reload_options = {}
    if command.args ~= '' then
      reload_options.variant = command.args
    end
    require('invero').reload(reload_options)
  end, {
    force = true,
    nargs = '?',
    complete = function()
      return vim.tbl_keys(M.variants)
    end,
  })
end

function M.setup(options)
  M.options = S.setup(M, options)
  create_commands()
end

function M.load(options)
  M.options = S.setup_extend(M, options)
  M.variant = S.get_style_variant(M, M.options.variant)
  M.cache_path = S.get_cache_path(M)

  S.apply_highlights(M)
end

function M.invalidate_cache()
  for variant, _ in pairs(M.variants) do
    os.remove(vim.fs.joinpath(M.cache_dir, variant))
  end
end

function M.unload()
  for module in pairs(package.loaded) do
    if module == 'invero' or module:match('^invero%.') then
      package.loaded[module] = nil
    end
  end
end

function M.reload(options)
  local current_options = vim.deepcopy(M.options or M.defaults)
  local reload_options = U.merge(current_options, options)
  local variant = reload_options.variant or M.variant

  M.invalidate_cache()
  M.unload()

  local invero = require('invero')
  invero.setup(reload_options)
  invero.load({ variant = variant })
end

function M.get_colors(options)
  M.options = S.setup_extend(M, options)
  M.variant = S.get_style_variant(M, M.options.variant)

  return require('invero.lib.highlights').get_variant_colors(M)
end

create_commands()

return M
