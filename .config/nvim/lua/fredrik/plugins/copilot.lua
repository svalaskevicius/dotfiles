return {
  {
    "github/copilot.vim",
    lazy = true,
    event = "InsertEnter",
    enabled = true,
    cmd = "Copilot",
    -- build = ":Copilot auth",
    keys = require("fredrik.config.keymaps").setup_copilot_keymaps(),
    init = function()
      vim.g.copilot_no_maps = true
    end,
    config = function()
      -- Block the normal Copilot suggestions
      -- provided by blink-copilot
      vim.api.nvim_create_augroup("github_copilot", { clear = true })
      vim.api.nvim_create_autocmd({ "FileType", "BufUnload" }, {
        group = "github_copilot",
        callback = function(args)
          vim.fn["copilot#On" .. args.event]()
        end,
      })
      vim.fn["copilot#OnFileType"]()
    end,
  },
}
