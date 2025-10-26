local M = {}

local plugin_map = require('invero.lib.plugin_map')

local function collect_installed_plugins()
  local installed = {}

  -- 1. lazy.nvim
  local ok_lazy, lazy = pcall(require, 'lazy')
  if ok_lazy and lazy.core and lazy.core.config then
    vim.list_extend(installed, vim.tbl_keys(lazy.core.config.plugins))
  end

  -- 2. native packages: pack/*/start/*
  local paths = vim.fn.globpath(vim.o.packpath, 'pack/*/start/*', true, true)
  for _, path in ipairs(paths) do
    local name = vim.fn.fnamemodify(path, ':t')
    table.insert(installed, name)
  end

  -- 3. paq.nvim
  local ok_paq, paq = pcall(require, 'paq')
  if ok_paq and type(paq.list) == 'table' then
    for _, spec in pairs(paq.list) do
      if type(spec) == 'table' and spec.as then
        table.insert(installed, spec.as)
      elseif type(spec) == 'string' then
        table.insert(installed, spec:match('[^/]+$'))
      end
    end
  end

  -- deduplicate
  installed = vim.fn.uniq(vim.fn.sort(installed))
  return installed
end

function M.get_enabled(options)
  local installed_plugins = collect_installed_plugins()
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
