--- Register parsers from opts.ensure_installed
local function register(ensure_installed)
  for filetype, parser in pairs(ensure_installed) do
    local filetypes = vim.treesitter.language.get_filetypes(parser)
    if not vim.tbl_contains(filetypes, filetype) then
      table.insert(filetypes, filetype)
    end

    -- register and start parsers for filetypes
    vim.treesitter.language.register(parser, filetypes)
  end
end

return {
  {
    "svalaskevicius/nvim-treesitter",
    lazy = true,
    event = "BufRead",
    build = ":TSUpdate",
    ---@class TSConfig
    opts = {
      -- Other plugins can pass in desired filetype/parser combos.
      -- ensure_installed = { filetype = "parser1", filetype2 = "parser2" },
      ensure_installed = {},
    },
    config = function(_, opts)
      -- Set up folding via tree-sitter (will be overridden by LSP settings, when LSP supports folding).
      require("fredrik.config.options").treesitter_foldexpr()

      -- Register parsers from opts.ensure_installed
      register(opts.ensure_installed)

      -- debugging
      -- vim.notify(vim.inspect(opts.ensure_installed))
      -- local already_installed = require("nvim-treesitter.config").installed_parsers()
      -- vim.notify(vim.inspect(already_installed))
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufRead",
    dependencies = {
      "svalaskevicius/nvim-treesitter",
      event = "BufRead",
    },
    opts = {
      multiwindow = true,
      max_lines = 7,
      min_window_height = 50,
    },
  },
}
