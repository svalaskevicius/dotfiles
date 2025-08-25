return {
  {
    'svalaskevicius/nvim-terminal.lua',
    lazy = true,
    ft = "terminal",
    config = function(_, opts)
      require("terminal").setup()
    end,
  }
}
