local vim = vim

return {

  -- MCP server info:
  -- https://github.com/modelcontextprotocol/servers
  -- https://www.aimcp.info/en

  {
    "ravitemer/mcphub.nvim",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required for Job and HTTP requests
      {
        "nvim-lualine/lualine.nvim",
        event = "VeryLazy",
        opts = function(_, opts)
          opts.mcphub = {
            lualine_component = {
              function()
                -- Check if MCPHub is loaded
                if not vim.g.loaded_mcphub then
                  return "󰐻 -"
                end

                local count = vim.g.mcphub_servers_count or 0
                local status = vim.g.mcphub_status or "stopped"
                local executing = vim.g.mcphub_executing

                -- Show "-" when stopped
                if status == "stopped" then
                  return "󰐻 -"
                end

                -- Show spinner when executing, starting, or restarting
                if executing or status == "starting" or status == "restarting" then
                  local frames = { "⠋", "⠙", "⠹", "⠸", "⠼", "⠴", "⠦", "⠧", "⠇", "⠏" }
                  local frame = math.floor(vim.uv.now() / 100) % #frames + 1
                  return "󰐻 " .. frames[frame]
                end

                return "󰐻 " .. count
              end,
              color = function()
                if not vim.g.loaded_mcphub then
                  return { fg = "#6c7086" } -- Gray for not loaded
                end

                local status = vim.g.mcphub_status or "stopped"
                if status == "ready" or status == "restarted" then
                  return { fg = "#50fa7b" } -- Green for connected
                elseif status == "starting" or status == "restarting" then
                  return { fg = "#ffb86c" } -- Orange for connecting
                else
                  return { fg = "#ff5555" } -- Red for error/stopped
                end
              end,
            },
          }
        end,
      },
    },
    -- build = "npm install -g mcp-hub@latest", -- Installs required mcp-hub npm module
    build = 'bundled_build.lua',
    config = function()
      require("mcphub").setup({
        use_bundled_binary = true,
        workspace = {
          enabled = true,                      -- Default: true
          look_for = { ".mcphub/servers.json", ".metals/mcp.json", ".vscode/mcp.json", ".cursor/mcp.json" },
          reload_on_dir_changed = true,        -- Auto-switch on directory change
          port_range = { min = 40000, max = 64000 }, -- Port range for workspace hubs
          get_port = nil,                      -- Optional function for custom port assignment
        },
        log = {
          level = vim.log.levels.WARN,
          to_file = false,
          file_path = nil,
          prefix = "MCPHub",
        },
      })
    end,
    cmd = { "MCPHub" },
  },
}
