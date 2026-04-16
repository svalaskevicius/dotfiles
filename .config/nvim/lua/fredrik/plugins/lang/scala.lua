return {
  {
    "scalameta/nvim-metals",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
      vim.g["metals_server_version"] = "1.6.6"
    end,
    opts = function()
      local metals_config = require("metals").bare_config()
      -- metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
      -- metals_config.capabilities.textDocument.foldingRange = {
      --   dynamicRegistration = false,
      --   lineFoldingOnly = true
      -- }
      metals_config.on_attach = function(client, bufnr)
        require("metals").setup_dap()
        local dap = require("dap")
        dap.configurations.scala = {
          {
            type = "scala",
            request = "launch",
            name = "Run or Test Target",
            metals = {
              runType = "runOrTestFile",
              -- jvmOptions = { "-Dpropert=123" },
            },
          },
          {
            type = "scala",
            request = "launch",
            name = "Test Target",
            metals = {
              runType = "testTarget",
              -- jvmOptions = { "-Dpropert=123" },
            },
          },
          {
            type = "scala",
            request = "attach",
            name = "Attach to Localhost",
            hostName = "localhost",
            port = 5005,
            buildTarget = "root",
          }
        }
        -- vim.keymap.set("n", "K", vim.lsp.buf.hover)
      end
      metals_config.settings = {
        showImplicitArguments = true,
        -- defaultBspToBuildTool = true,
        serverProperties = {
          "-Xmx16g",
        },
        startMcpServer = true,
        -- testUserInterface = "Test Explorer",
        -- serverVersion = "latest.snapshot",
      }
      metals_config.tvp = {
        panel_width = 40,
        panel_alignment = "left",
        toggle_node_mapping = "<CR>",
        node_command_mapping = "r",
        collapsed_sign = "▸",
        expanded_sign = "▾",
        icons = {
          enabled = true,
          symbols = {
            object = "",
            trait = "𝕋",
            class = "ℂ",
            interface = "𝕀",
            val = "",
            var = "",
            method = "ﬦ",
            enum = "",
            field = "ͻ",
            package = "",
          },
        },
      }
      return metals_config
    end,
    ft = { "scala", "sbt", "java" },
    config = function(metals, metals_config)
      local nvim_metals_group = vim.api.nvim_create_augroup("nvim-metals", { clear = true })
      vim.api.nvim_create_autocmd("FileType", {
        pattern = metals.ft,
        callback = function()
          require("metals").initialize_or_attach(metals_config)
          vim.keymap.set("n", "<leader>ct", ":lua require(\"metals.tvp\").reveal_in_tree()<CR>", { buffer = true })
          vim.keymap.set("n", "<leader>cT", ":lua require(\"metals.tvp\").toggle_tree_view()<CR>", { buffer = true })
        end,
        group = nvim_metals_group,
      })
    end,
  },
}
