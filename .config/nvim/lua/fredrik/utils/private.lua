M = {}

local function is_copilot_available()
  if vim.fn.executable("node") == 1 then
    return true
  else
    vim.notify("Node is not available, but required for Copilot.", vim.log.levels.WARN)
    return false
  end
end

-- export functions for use by e.g. plugins
M.is_copilot_availble = is_copilot_available

return M
