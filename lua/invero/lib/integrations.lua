local M = {}

local plugin_map = require('invero.lib.plugin_map')

local function collect_active_plugins()
  return vim
    .iter(vim.pack.get(nil, { info = false }))
    :filter(function(plugin)
      return plugin.active
    end)
    :map(function(plugin)
      return plugin.spec.name
    end)
    :totable()
end

function M.get_enabled(options)
  local active_plugins = collect_active_plugins()
  local enabled_integrations = {}

  for integration, enabled in pairs(options.integrations) do
    local plugin = plugin_map[integration]
    if enabled and vim.tbl_contains(active_plugins, plugin) then
      table.insert(enabled_integrations, integration)
    end
  end

  return enabled_integrations
end

return M
