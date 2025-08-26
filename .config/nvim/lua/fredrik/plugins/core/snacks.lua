return {
  {
    "folke/snacks.nvim",
    dependencies = {
      --  "folke/persistence.nvim",
      {
        "nvim-lualine/lualine.nvim",
        opts = {
          options = {
            disabled_filetypes = { "snacks_dashboard" },
          },
        },
        opts_extend = {
          "options.disabled_filetypes",
        },
      },
      { "folke/trouble.nvim" },
      { "folke/todo-comments.nvim" },
    },
    priority = 1000,
    lazy = false,

    ---@type snacks.Config
    opts = {
      styles = {
        notification_history = {
          relative = "editor",
          width = 0.98,
          height = 0.98,
        },
      },

      dashboard = {
        enabled = false,
        preset = {
          keys = {
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },

      image = { enabled = true },

      indent = {
        enabled = true,
        priority = 1,
        animate = {
          enabled = false,
          style = "out",
          easing = "linear",
          duration = {
            step = 20,   -- ms per step
            total = 500, -- maximum duration
          },
        },
      },

      lazygit = {
        enabled = true,
        -- automatically configure lazygit to use the current colorscheme
        -- and integrate edit with the current neovim instance
        configure = true,

        config = {
          os = { editPreset = "nvim-remote" },
          gui = {
            -- set to an empty string "" to disable icons
            nerdFontsVersion = "3",
          },
          git = {
            overrideGpg = true,
          },
        },
      },

      notifier = { enabled = true, timeout = 2000 },

      picker = {
        enabled = true,
        actions = require("trouble.sources.snacks").actions,
        sources = {
          files = {
            hidden = true,   -- NOTE: toggle with alt+h
            ignored = false, -- NOTE: toggle with alt+h
          },
        },
        win = {
          input = {
            border = "none",
            keys = {
              ["<c-t>"] = {
                "trouble_open",
                mode = { "n", "i" },
              },
              ["<c-l>"] = {
                "loclist",
                mode = { "n", "i" },
              },
            },
          },
        },
        layouts = {
          default = {
            layout = {
              box = "horizontal",
              width = 0.9,
              min_width = 120,
              height = 0.9,
              {
                box = "vertical",
                border = "none",
                title = "{title} {live} {flags}",
                { win = "input", height = 1,     border = "bottom" },
                { win = "list",  border = "none" },
              },
              { win = "preview", title = "{preview}", border = "left", width = 0.5 },
            },
          },
          vertical = {
            layout = {
              backdrop = false,
              -- width = 0.99,
              min_width = 80,
              -- height = 1,
              min_height = 30,
              box = "vertical",
              border = "none",
              title = "{title} {live} {flags}",
              title_pos = "center",
              { win = "input",   height = 1,          border = "bottom" },
              { win = "list",    border = "none" },
              { win = "preview", title = "{preview}", height = 0.4,     border = "top" },
            },
          }
        },
      },

      explorer = {
        enabled = false,
      },

      quickfile = { enabled = false }, -- breaks bigfile plugin

      statuscolumn = { enabled = true },

      terminal = { enabled = false },

      zen = {
        enabled = true,
        -- You can add any `Snacks.toggle` id here.
        -- Toggle state is restored when the window is closed.
        -- Toggle config options are NOT merged.
        ---@type table<string, boolean>
        toggles = {
          dim = false,
          git_signs = false,
          mini_diff_signs = false,
          diagnostics = true,
          -- inlay_hints = false,
        },
        win = {
          backdrop = {
            transparent = false,
          },
        },
      },
    },
    keys = function()
      ---@type table[table]
      local snacks_keymaps = require("fredrik.config.keymaps").setup_snacks_keymaps()
      ---@type table[table]
      -- local terminal_keymaps = require("fredrik.config.keymaps").setup_terminal_keymaps()

      local merged_keymaps = {}
      for _, keymap in ipairs(snacks_keymaps) do
        table.insert(merged_keymaps, keymap)
      end
      -- for _, keymap in ipairs(terminal_keymaps) do
      --   table.insert(merged_keymaps, keymap)
      -- end
      return merged_keymaps
    end,
    config = function(_, opts)
      local s = require("snacks")
      s.setup(opts)
      s.picker.highlight.winhl = function(prefix, links)
        links = links or {}
        local winhl = {
          -- Normal = "",
          NormalFloat = "",
          FloatBorder = "Border",
          FloatTitle = "Title",
          FloatFooter = "Footer",
          FloatCursorLine = "CursorLine",
        }
        local ret = {} ---@type string[]
        local groups = {} ---@type table<string, string>
        for k, v in pairs(winhl) do
          groups[v] = links[k] or (prefix == "SnacksPicker" and k or ("SnacksPicker" .. v))
          ret[#ret + 1] = ("%s:%s%s"):format(k, prefix, v)
        end
        s.util.set_hl(groups, { prefix = prefix, default = true })
        return table.concat(ret, ",")
      end
      -- ("SnacksPicker"),

      -- local hl = vim.api.nvim_set_hl
      --
      -- -- Backgrounds
      -- hl(0, "SnacksPicker", { bg = "#1e1e2e" })
      -- hl(0, "SnacksNormal", { bg = "#1e1e2e" })
      -- hl(0, "SnacksNormalNC", { bg = "#181825" })
      -- hl(0, "SnacksWinBar", { bg = "#313244", fg = "#c0caf5" })
      -- hl(0, "SnacksBackdrop", { bg = "#000000", blend = 50 })
      --
      -- -- Borders → hide them by matching bg
      -- hl(0, "SnacksBorder", { fg = "#1e1e2e", bg = "#1e1e2e" })
      -- hl(0, "SnacksBorderNC", { fg = "#181825", bg = "#181825" })
      --
      -- -- Notifications (optional, also no borders)
      -- hl(0, "SnacksNotifierBorder", { fg = "#1e1e2e", bg = "#1e1e2e" })
    end,
  },
}
