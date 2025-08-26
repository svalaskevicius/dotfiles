return {

  {
    "LunarVim/bigfile.nvim",
    lazy = false,
    priority = 1000,
    event = "BufReadPre",
    opts = {
      -- pattern = { "*" }, -- apply to all files
      filesize = 1, -- size of the file in MiB, the plugin round file sizes to the closest MiB
      features = { "syntax", "treesitter", "lsp", "illuminate" }
    },
  },
}
