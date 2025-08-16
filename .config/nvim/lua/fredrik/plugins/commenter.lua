return { 
  {
    'svalaskevicius/nerdcommenter',
    lazy = true,
    init = function()
      vim.g.NERDCreateDefaultMappings = 0
    end,
    keys = function() return require("fredrik.config.keymaps").setup_commenter_keymaps() end,
  }
}
