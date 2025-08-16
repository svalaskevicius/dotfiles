return {
  {
    "github/copilot.vim",
    lazy = true,
    event = "InsertEnter",
    enabled = true,
    cmd = "Copilot",
    build = ":Copilot auth",
    keys = require("fredrik.config.keymaps").setup_copilot_keymaps(),
  },
}
