local function set_dark()
  vim.o.background = "light" -- NOTE: tokyonight-moon uses light background
  vim.cmd.colorscheme("tokyonight-moon")
end

local function set_light()
  vim.o.background = "light"
  vim.cmd.colorscheme("dayfox")
  -- vim.cmd.colorscheme("rose-pine-dawn")
  -- vim.cmd.colorscheme("tokyonight-day")
end

return {
  -- color scheme managers
  'vim-scripts/CycleColor',
  {
    'RRethy/vim-illuminate',
    config = function(_, opts)
      require('illuminate').configure({
        providers = {
          'lsp',
          -- 'treesitter',
          'regex',
        },
      }
      )
    end
  },
  'rafi/awesome-vim-colorschemes',
  {
    'rebelot/kanagawa.nvim',
    enabled = false,
    config = function(_, opts)
      require("kanagawa").setup({
        compile = true,   -- enable terminal_color_piling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = {},
        keywordStyle = { italic = true },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,   -- do not set background color
        dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {             -- add/modify theme and palette colors
          palette = {},
          theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
          return {}
        end,
        theme = "dragon",  -- Load "wave" theme when 'background' option is not set
        background = {     -- map the value of 'background' option to a theme
          dark = "dragon", -- try "dragon" !
          light = "lotus"
        },
      })
    end,
  },
  {
    "uga-rosa/ccc.nvim",
    enabled = false, -- NOTE: enable when needed
    opts = {
      highlighter = {
        auto_enable = true,
        lsp = true,
      },
    },
    config = function(_, opts)
      local ccc = require("ccc")
      ccc.setup(opts)
    end,
  },
  {
    "folke/tokyonight.nvim",
    enabled = false,
    lazy = true,
    ---@class tokyonight.Config
    opts = {
      transparent = false, -- Enable transparency
      styles = {
        -- Background styles. Can be "dark", "transparent" or "normal"
        sidebars = "dark",
        floats = "dark",
      },
      dim_inactive = false, -- dims inactive windows
    },
  },
  {
    "EdenEast/nightfox.nvim",
    enabled = false,
    lazy = true,
    opts = {
      options = {
        styles = {
          comments = "italic",
        },
      },
    },
  },
  {
    "rose-pine/neovim",
    enabled = false,
    name = "rose-pine",
    lazy = true,
    opts = {
      enable = {
        legacy_highlights = false,
      },
      dim_inactive_windows = true,
    },
  },
}
