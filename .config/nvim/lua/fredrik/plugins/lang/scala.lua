return {
  {
    "scalameta/nvim-metals",
    lazy = true,
    dependencies = { "nvim-lua/plenary.nvim" },
    init = function()
      vim.g["metals_server_version"] = "1.6.4"
    end,
    opts = function()
      local metals_config = require("metals").bare_config()
      --metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
      --metals_config.on_attach = function(client, bufnr)
      --vim.keymap.set("n", "K", vim.lsp.buf.hover)
      --end

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
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "scala", "sbt", "java" },
        callback = function()
          require("metals").initialize_or_attach(metals_config)
          vim.keymap.set("n", "<leader>ct", ":lua require(\"metals.tvp\").reveal_in_tree()<CR>", { buffer = true })
          vim.keymap.set("n", "<leader>cT", ":lua require(\"metals.tvp\").toggle_tree_view()<CR>", { buffer = true })
        end,
      })
    end,
  },
}
