local M = {}

local plugin_map = require('invero.lib.plugin_map')

function M.get_enabled(options)
  local installed_plugins = {}

  if pcall(require, 'lazy') then
    vim.list_extend(installed_plugins, vim.tbl_keys(require('lazy.core.config').plugins))
  end
  local enabled_integrations = {}
  for integration, enabled in pairs(options.integrations) do
    local plugin = plugin_map[integration]
    if enabled and vim.tbl_contains(installed_plugins, plugin) then
      table.insert(enabled_integrations, integration)
    end
  end

  return enabled_integrations
end

return M
