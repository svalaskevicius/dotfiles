local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local cmd = vim.cmd
local g = vim.g

local function opt(scope, key, value)
  local scopes = { o = vim.o, b = vim.bo, w = vim.wo }
  scopes[scope][key] = value
  if scope ~= 'o' then
    scopes['o'][key] = value
  end
end

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

g.mapleader = " "
----------------------------------
-- PLUGINS -----------------------
----------------------------------
require('lazy').setup({
  { 'svalaskevicius/nerdcommenter' },
  -- General fuzzy search capability
  -- 'junegunn/fzf', { 'dir': '~/.local/bin/fzf', 'do': './install --all' }

  -- Some surrounding characters trickery (not sure if should keep it)
  --Plug 'tpope/vim-surround'

  -- Aligning - TODO - Check if it's doing any usefull stuff
  -- Plug 'godlygeek/tabular'

  -- " Ctrlp - quickly find files, tags and buffers using fuzzy search
  -- Plug 'kien/ctrlp.vim'

  -- " Nerdtree file browser
  -- " Plug 'preservim/nerdtree'

  -- " Easily comment - <Leader>cc
  -- Plug 'preservim/nerdcommenter'

  -- " Git support
  -- " Plug 'tpope/vim-fugitive'

  -- " Apply a command on every file in the quickfix list :Qdo %s/Foobar/Barfoo
  -- Plug 'henrik/vim-qargs'

  'tmux-plugins/vim-tmux-focus-events',
  'christoomey/vim-tmux-navigator',

  -- 'derekwyatt/vim-scala'

  -- 'neovimhaskell/haskell-vim'
  -- " Plug 'alx741/vim-hindent'
  -- Plug 'mpickering/hlint-refactor-vim'

  -- Plug 'gruvbox-community/gruvbox'
  -- Plug 'sonph/onehalf', {'rtp': 'vim/'}
  -- Plug 'jacoborus/tender.vim'

  --  'ryanoasis/vim-devicons'

  -- Plug 'neomake/neomake'
  --
  -- Plug 'majutsushi/tagbar'
  --
  -- Plug 'chrisbra/Colorizer'
  --
  -- Plug 'luochen1990/rainbow'
  --
  -- " Plug 'YorickPeterse/happy_hacking.vim'
  --
  -- " Plug 'ntk148v/vim-horizon'
  --
  -- " Plug 'srcery-colors/srcery-vim'
  -- Plug 'tomasiser/vim-code-dark'
  -- Plug 'habamax/vim-gruvbit'

  -- Plug 'mileszs/ack.vim'
  -- Plug 'jremmen/vim-ripgrep'
  -- Plug 'stefandtw/quickfix-reflector.vim'

  -- Plug 'svalaskevicius/vim-leader-guide'
  -- " Plug 'liuchengxu/vim-which-key'
  -- " Plug 'kana/vim-arpeggio'

  'vim-scripts/CycleColor',

  'will133/vim-dirdiff',

  -- Plug 'rktjmp/lush.nvim'
  -- Plug 'alaric/nortia.nvim'
  --
  -- " Plug 'sotte/presenting.vim'
  -- Plug '/home/sarunas/src/presenting.vim'
  -- Plug 'junegunn/goyo.vim'
  --
  -- " Plug 'jaxbot/semantic-highlight.vim'
  -- "
  --
  -- Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
  --
  -- 'hrsh7th/nvim-compe', dependencies = {'hrsh7th/vim-vsnip'},


  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      { "hrsh7th/vim-vsnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/cmp-buffer" },
    },
  },

  -- use({ "liuchengxu/vista.vim" })
  { 'scalameta/nvim-metals',       dependencies = { "nvim-lua/plenary.nvim" } },

  'neovim/nvim-lspconfig',
  'onsails/lspkind-nvim',
  'RRethy/vim-illuminate',
  {
    'lewis6991/gitsigns.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim'
    }
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  'nvim-telescope/telescope-ui-select.nvim',
  { 'nvim-treesitter/nvim-treesitter' }, -- , init = function() vim.cmd('TSUpdate') end },
  { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },


  'rafi/awesome-vim-colorschemes',
  'EdenEast/nightfox.nvim',
  { 'rebelot/kanagawa.nvim',    lazy = false },
  { 'akinsho/bufferline.nvim',  dependencies = 'nvim-tree/nvim-web-devicons',    lazy = false },
  { 'hoob3rt/lualine.nvim',     dependencies = { 'nvim-tree/nvim-web-devicons' } },


  { 'kyazdani42/nvim-tree.lua', dependencies = { 'nvim-tree/nvim-web-devicons' } },
  -- use {
  --   -- Optional but recommended
  --   -- 'nvim-treesitter/nvim-treesitter',
  --   'lewis6991/spellsitter.nvim',
  --   config = function()
  --     require('spellsitter').setup({
  --       hl = 'SpellBad',
  --       captures = {'comment'},  -- set to {} to spellcheck everything
  --     })
  --   end
  -- }
  'folke/which-key.nvim',
  'sindrets/winshift.nvim',

  'sheerun/vim-polyglot',
  -- use 'ggandor/leap.nvim'
  -- use 'vim-scripts/AnsiEsc.vim'
  'powerman/vim-plugin-AnsiEsc',
  -- { 'm00qek/baleia.nvim',          tag = 'v1.4.0' },

  {
    'MrcJkb/haskell-tools.nvim',
    dependencies = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim', -- optional
      {
        'm-demare/hlargs.nvim',
        dependencies = { 'nvim-treesitter/nvim-treesitter' }
      }
    }
  },
  { 'svalaskevicius/ltex-ls.nvim', dependencies = 'neovim/nvim-lspconfig',         branch = 'fixes' },
  -- {
  --   "folke/trouble.nvim",
  --   opts = {},
  --   cmd = "Trouble",
  --   keys = {
  --     {
  --       "<leader>a",
  --       "<cmd>Trouble diagnostics toggle<cr>",
  --       desc = "Diagnostics (Trouble)",
  --     },
  --     {
  --       "<leader>d",
  --       "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
  --       desc = "Buffer Diagnostics (Trouble)",
  --     },
  --     {
  --       "<leader>cs",
  --       "<cmd>Trouble symbols toggle focus=false<cr>",
  --       desc = "Symbols (Trouble)",
  --     },
  --     {
  --       "<leader>cl",
  --       "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
  --       desc = "LSP Definitions / references / ... (Trouble)",
  --     },
  --     {
  --       "<leader>xL",
  --       "<cmd>Trouble loclist toggle<cr>",
  --       desc = "Location List (Trouble)",
  --     },
  --     {
  --       "<leader>xQ",
  --       "<cmd>Trouble qflist toggle<cr>",
  --       desc = "Quickfix List (Trouble)",
  --     },
  --   },
  -- },
  {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    opts = {
      -- you can configure Hop the way you like here; see :h hop-config
      keys = 'etovxqpdygfblzhckisuran'
    }
  },

  'simrat39/rust-tools.nvim',
  'williamboman/mason.nvim',
  { 'mfussenegger/nvim-dap',       dependencies = { "nvim-neotest/nvim-nio" } },
  { "rcarriga/nvim-dap-ui",        dependencies = { "mfussenegger/nvim-dap" } },
  { "jonboh/nvim-dap-rr",          dependencies = { "nvim-dap", "telescope.nvim" } },
  'LunarVim/bigfile.nvim',

  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
      "hrsh7th/nvim-cmp",                                                                    -- Optional: For using slash commands and variables in the chat buffer
      "nvim-telescope/telescope.nvim",                                                       -- Optional: For using slash commands
      { "MeanderingProgrammer/render-markdown.nvim", ft = { "markdown", "codecompanion" } }, -- Optional: For prettier markdown rendering
      { "stevearc/dressing.nvim",                    opts = {} },                            -- Optional: Improves `vim.ui.select`
    },
    config = true
  },
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        backdrop = 0.95, -- shade the backdrop of the Zen window. Set to 1 to keep the same as Normal
        -- height and width can be:
        -- * an absolute number of cells when > 1
        -- * a percentage of the width / height of the editor when <= 1
        -- * a function that returns the width or the height
        width = 120, -- width of the Zen window
        height = 1,  -- height of the Zen window
        -- by default, no options are changed for the Zen window
        -- uncomment any of the options below, or add other vim.wo options you want to apply
        options = {
          signcolumn = "no",      -- disable signcolumn
          number = false,         -- disable number column
          relativenumber = false, -- disable relative numbers
          cursorline = false,     -- disable cursorline
          cursorcolumn = false,   -- disable cursor column
          foldcolumn = "0",       -- disable fold column
          list = false,           -- disable whitespace characters
        },
      },
      plugins = {
        -- disable some global vim options (vim.o...)
        -- comment the lines to not apply the options
        options = {
          enabled = true,
          ruler = false,   -- disables the ruler text in the cmd line area
          showcmd = false, -- disables the command in the last line of the screen
          -- you may turn on/off statusline in zen mode by setting 'laststatus'
          -- statusline will be shown only if 'laststatus' == 3
          laststatus = 0,               -- turn off the statusline in zen mode
        },
        twilight = { enabled = true },  -- enable to start Twilight when zen mode opens
        gitsigns = { enabled = false }, -- disables git signs
        tmux = { enabled = false },     -- disables the tmux statusline
        todo = { enabled = false },     -- if set to "true", todo-comments.nvim highlights will be disabled
        -- this will change the font size on kitty when in zen mode
        -- to make this work, you need to set the following kitty options:
        -- - allow_remote_control socket-only
        -- - listen_on unix:/tmp/kitty
        kitty = {
          enabled = false,
          font = "+4", -- font size increment
        },
        -- this will change the font size on alacritty when in zen mode
        -- requires  Alacritty Version 0.10.0 or higher
        -- uses `alacritty msg` subcommand to change font size
        alacritty = {
          enabled = false,
          font = "14", -- font size
        },
        -- this will change the font size on wezterm when in zen mode
        -- See alse also the Plugins/Wezterm section in this projects README
        wezterm = {
          enabled = false,
          -- can be either an absolute font size or the number of incremental steps
          font = "+4", -- (10% increase per step)
        },
        -- this will change the scale factor in Neovide when in zen mode
        -- See alse also the Plugins/Wezterm section in this projects README
        neovide = {
          enabled = false,
          -- Will multiply the current scale factor by this number
          scale = 1.2,
          -- disable the Neovide animations while in Zen mode
          disable_animations = {
            neovide_animation_length = 0,
            neovide_cursor_animate_command_line = false,
            neovide_scroll_animation_length = 0,
            neovide_position_animation_length = 0,
            neovide_cursor_animation_length = 0,
            neovide_cursor_vfx_mode = "",
          }
        },
      },
      -- callback where you can add custom code when the Zen window opens
      on_open = function(win)
      end,
      -- callback where you can add custom code when the Zen window closes
      on_close = function()
      end,
    }
  },

  -- {
  --   "David-Kunz/gen.nvim",
  --   opts = {
  --     model = "qwen2.5-coder:32b", -- The default model to use.
  --     quit_map = "q",              -- set keymap to close the response window
  --     retry_map = "<c-r>",         -- set keymap to re-send the current prompt
  --     accept_map = "<c-cr>",       -- set keymap to replace the previous selection with the last result
  --     host = "localhost",          -- The host running the Ollama service.
  --     port = "11434",              -- The port on which the Ollama service is listening.
  --     display_mode = "split",      -- The display mode. Can be "float" or "split" or "horizontal-split".
  --     show_prompt = true,          -- Shows the prompt submitted to Ollama. Can be true (3 lines) or "full".
  --     show_model = true,           -- Displays which model you are using at the beginning of your chat session.
  --     no_auto_close = true,        -- Never closes the window automatically.
  --     file = false,                -- Write the payload to a temporary file to keep the command short.
  --     hidden = false,              -- Hide the generation window (if true, will implicitly set `prompt.replace = true`), requires Neovim >= 0.10
  --     init = function(options) pcall(io.popen, "ollama serve > /dev/null 2>&1 &") end,
  --     -- Function to initialize Ollama
  --     command = function(options)
  --       local body = { model = options.model, stream = true }
  --       return "curl --silent --no-buffer -X POST http://" .. options.host .. ":" .. options.port .. "/api/chat -d $body"
  --     end,
  --     -- The command for the Ollama service. You can use placeholders $prompt, $model and $body (shellescaped).
  --     -- This can also be a command string.
  --     -- The executed command must return a JSON object with { response, context }
  --     -- (context property is optional).
  --     -- list_models = '<omitted lua function>', -- Retrieves a list of model names
  --     result_filetype = "markdown", -- Configure filetype of the result buffer
  --     debug = false                 -- Prints errors and the command which is run.
  --   }
  -- },
  -- {
  --   "j-hui/fidget.nvim",
  --   -- tag = "v1.0.0", -- Make sure to update this to something recent!
  --   opts = {
  --     -- Options related to LSP progress subsystem
  --     progress = {
  --       poll_rate = 0,            -- How and when to poll for progress messages
  --       suppress_on_insert = false, -- Suppress new messages while in insert mode
  --       ignore_done_already = false, -- Ignore new tasks that are already complete
  --       ignore_empty_message = false, -- Ignore new tasks that don't contain a message
  --       clear_on_detach =         -- Clear notification group when LSP server detaches
  --           function(client_id)
  --             local client = vim.lsp.get_client_by_id(client_id)
  --             return client and client.name or nil
  --           end,
  --       notification_group = -- How to get a progress message's notification group key
  --           function(msg) return msg.lsp_client.name end,
  --       ignore = {},     -- List of LSP servers to ignore
  --
  --       -- -- Options related to how LSP progress messages are displayed as notifications
  --       display = {
  --         render_limit = 16, -- How many LSP messages to show at once
  --         done_ttl = 3, -- How long a message should persist after completion
  --         done_icon = "✔", -- Icon shown when all LSP progress tasks are complete
  --         done_style = "Constant", -- Highlight group for completed LSP tasks
  --         progress_ttl = math.huge, -- How long a message should persist when in progress
  --         progress_icon = -- Icon shown when LSP progress tasks are in progress
  --         { "dots" },
  --         progress_style = -- Highlight group for in-progress LSP tasks
  --         "WarningMsg",
  --         group_style = "Title", -- Highlight group for group name (LSP server name)
  --         icon_style = "Question", -- Highlight group for group icons
  --         priority = 30, -- Ordering priority for LSP notification group
  --         skip_history = true, -- Whether progress notifications should be omitted from history
  --         -- format_message = -- How to format a progress message
  --         --     require("fidget.progress.display").default_format_message,
  --         format_annote = -- How to format a progress annotation
  --             function(msg) return msg.title end,
  --         format_group_name = -- How to format a progress notification group's name
  --             function(group) return tostring(group) end,
  --         overrides = { -- Override options from the default notification config
  --           rust_analyzer = { name = "rust-analyzer" },
  --         },
  --       },
  --
  --       -- Options related to Neovim's built-in LSP client
  --       lsp = {
  --         progress_ringbuf_size = 0, -- Configure the nvim's LSP progress ring buffer size
  --         log_handler = false,   -- Log `$/progress` handler invocations (for debugging)
  --       },
  --     },
  --
  --     -- Options related to notification subsystem
  --     notification = {
  --       poll_rate = 10,           -- How frequently to update and render notifications
  --       filter = vim.log.levels.INFO, -- Minimum notifications level
  --       history_size = 128,       -- Number of removed messages to retain in history
  --       override_vim_notify = false, -- Automatically override vim.notify() with Fidget
  --       -- configs =                 -- How to configure notification groups when instantiated
  --       -- { default = require("fidget.notification").default_config },
  --       -- redirect =                -- Conditionally redirect notifications to another backend
  --       --     function(msg, level, opts)
  --       --       if opts and opts.on_open then
  --       --         return require("fidget.integration.nvim-notify").delegate(msg, level, opts)
  --       --       end
  --       --     end,
  --
  --       -- Options related to how notifications are rendered as text
  --       view = {
  --         stack_upwards = true, -- Display notification items from bottom to top
  --         icon_separator = " ", -- Separator between group name and icon
  --         group_separator = "---", -- Separator between notification groups
  --         group_separator_hl = -- Highlight group used for group separator
  --         "Comment",
  --         render_message =     -- How to render notification messages
  --             function(msg, cnt)
  --               return cnt == 1 and msg or string.format("(%dx) %s", cnt, msg)
  --             end,
  --       },
  --
  --       -- Options related to the notification window and buffer
  --       window = {
  --         normal_hl = "Comment", -- Base highlight group in the notification window
  --         winblend = 100,    -- Background color opacity in the notification window
  --         border = "none",   -- Border around the notification window
  --         zindex = 45,       -- Stacking priority of the notification window
  --         max_width = 0,     -- Maximum width of the notification window
  --         max_height = 0,    -- Maximum height of the notification window
  --         x_padding = 1,     -- Padding from right edge of window boundary
  --         y_padding = 0,     -- Padding from bottom edge of window boundary
  --         align = "bottom",  -- How to align the notification window
  --         relative = "editor", -- What the notification window position is relative to
  --       },
  --     },
  --
  --     -- Options related to integrating with other plugins
  --     integration = {
  --       ["nvim-tree"] = {
  --         enable = true, -- Integrate with nvim-tree/nvim-tree.lua (if installed)
  --       },
  --       ["xcodebuild-nvim"] = {
  --         enable = true, -- Integrate with wojciech-kulik/xcodebuild.nvim (if installed)
  --       },
  --     },
  --
  --     -- Options related to logging
  --     logger = {
  --       level = vim.log.levels.WARN, -- Minimum logging level
  --       max_size = 10000,        -- Maximum log file size, in KB
  --       float_precision = 0.01,  -- Limit the number of decimals displayed for floats
  --       path =                   -- Where Fidget writes its logs to
  --           string.format("%s/fidget.nvim.log", vim.fn.stdpath("cache")),
  --     },
  --   }
  -- },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      cmdline = {
        enabled = true,         -- enables the Noice cmdline UI
        view = "cmdline_popup", -- view for rendering the cmdline. Change to `cmdline` to get a classic cmdline at the bottom
        opts = {
          position = "100%",
          size = {
            width = "100%",
            height = 1,
          },
          border = {
            padding = {
              top = 0,
              bottom = 0,
              left = 0,
              right = 0,
            },
            style = "none",
            text = {
              top = "",
              top_align = "center",
              bottom = "",
              bottom_align = "left",
            },
          },
        }, -- global options for the cmdline. See section on views
        ---@type table<string, CmdlineFormat>
        format = {
          -- conceal: (default=true) This will hide the text in the cmdline that matches the pattern.
          -- view: (default is cmdline view)
          -- opts: any options passed to the view
          -- icon_hl_group: optional hl_group for the icon
          -- title: set to anything or empty string to hide
          cmdline = { pattern = "^:", icon = "", lang = "vim" },
          search_down = { kind = "search", pattern = "^/", icon = " ", lang = "regex" },
          search_up = { kind = "search", pattern = "^%?", icon = " ", lang = "regex" },
          filter = { pattern = "^:%s*!", icon = "$", lang = "bash" },
          lua = { pattern = { "^:%s*lua%s+", "^:%s*lua%s*=%s*", "^:%s*=%s*" }, icon = "", lang = "lua" },
          help = { pattern = "^:%s*he?l?p?%s+", icon = "" },
          input = { view = "cmdline_input", icon = "󰥻 " }, -- Used by input()
          -- lua = false, -- to disable a format, set to `false`
        },
      },
      messages = {
        -- NOTE: If you enable messages, then the cmdline is enabled automatically.
        -- This is a current Neovim limitation.
        enabled = true,              -- enables the Noice messages UI
        view = "notify",             -- default view for messages
        view_error = "notify",       -- view for errors
        view_warn = "notify",        -- view for warnings
        view_history = "messages",   -- view for :messages
        view_search = "virtualtext", -- view for search count messages. Set to `false` to disable
      },
      popupmenu = {
        enabled = true,  -- enables the Noice popupmenu UI
        ---@type 'nui'|'cmp'
        backend = "nui", -- backend to use to show regular cmdline completions
        ---@type NoicePopupmenuItemKind|false
        -- Icons for completion item kinds (see defaults at noice.config.icons.kinds)
        kind_icons = {}, -- set to `false` to disable icons
      },
      -- default options for require('noice').redirect
      -- see the section on Command Redirection
      ---@type NoiceRouteConfig
      redirect = {
        view = "popup",
        filter = { event = "msg_show" },
      },
      -- You can add any custom commands below that will be available with `:Noice command`
      ---@type table<string, NoiceCommand>
      commands = {
        history = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {
            any = {
              { event = "notify" },
              { error = true },
              { warning = true },
              { event = "msg_show", kind = { "" } },
              { event = "lsp",      kind = "message" },
            },
          },
        },
        -- :Noice last
        last = {
          view = "popup",
          opts = { enter = true, format = "details" },
          filter = {
            any = {
              { event = "notify" },
              { error = true },
              { warning = true },
              { event = "msg_show", kind = { "" } },
              { event = "lsp",      kind = "message" },
            },
          },
          filter_opts = { count = 1 },
        },
        -- :Noice errors
        errors = {
          -- options for the message history that you get with `:Noice`
          view = "popup",
          opts = { enter = true, format = "details" },
          filter = { error = true },
          filter_opts = { reverse = true },
        },
        all = {
          -- options for the message history that you get with `:Noice`
          view = "split",
          opts = { enter = true, format = "details" },
          filter = {},
        },
      },
      notify = {
        -- Noice can be used as `vim.notify` so you can route any notification like other messages
        -- Notification messages have their level and other properties set.
        -- event is always "notify" and kind can be any log level as a string
        -- The default routes will forward notifications to nvim-notify
        -- Benefit of using Noice for this is the routing and consistent history view
        enabled = true,
        view = "notify",
      },
      lsp = {
        progress = {
          enabled = true,
          -- Lsp Progress is formatted using the builtins for lsp_progress. See config.format.builtin
          -- See the section on formatting for more details on how to customize.
          --- @type NoiceFormat|string
          format = "lsp_progress",
          --- @type NoiceFormat|string
          format_done = "lsp_progress_done",
          throttle = 1000 / 30, -- frequency to update lsp progress message
          view = "mini",
        },
        override = {
          -- override the default lsp markdown formatter with Noice
          ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
          -- override the lsp markdown formatter with Noice
          ["vim.lsp.util.stylize_markdown"] = false,
          -- override cmp documentation with Noice (needs the other options to work)
          ["cmp.entry.get_documentation"] = false,
        },
        hover = {
          enabled = false,
          silent = false, -- set to true to not show a message if hover is not available
          view = nil,     -- when nil, use defaults from documentation
          ---@type NoiceViewOptions
          opts = {},      -- merged with defaults from documentation
        },
        signature = {
          enabled = false,
          auto_open = {
            enabled = true,
            trigger = true, -- Automatically show signature help when typing a trigger character from the LSP
            luasnip = true, -- Will open signature help when jumping to Luasnip insert nodes
            throttle = 50,  -- Debounce lsp signature help request by 50ms
          },
          view = nil,       -- when nil, use defaults from documentation
          ---@type NoiceViewOptions
          opts = {},        -- merged with defaults from documentation
        },
        message = {
          -- Messages shown by lsp servers
          enabled = true,
          view = "notify",
          opts = {},
        },
        -- defaults for hover and signature help
        documentation = {
          view = "hover",
          ---@type NoiceViewOptions
          opts = {
            lang = "markdown",
            replace = true,
            render = "plain",
            format = { "{message}" },
            win_options = { concealcursor = "n", conceallevel = 3 },
          },
        },
      },
      markdown = {
        hover = {
          ["|(%S-)|"] = vim.cmd.help, -- vim help links
          -- ["%[.-%]%((%S-)%)"] = require("noice.util").open,     -- markdown links
        },
        highlights = {
          ["|%S-|"] = "@text.reference",
          ["@%S+"] = "@parameter",
          ["^%s*(Parameters:)"] = "@text.title",
          ["^%s*(Return:)"] = "@text.title",
          ["^%s*(See also:)"] = "@text.title",
          ["{%S-}"] = "@parameter",
        },
      },
      health = {
        checker = true, -- Disable if you don't want health checks to run
      },
      ---@type NoicePresets
      presets = {
        -- you can enable a preset by setting it to true, or a table that will override the preset config
        -- you can also add custom presets that you can enable/disable with enabled=true
        bottom_search = true,          -- use a classic bottom cmdline for search
        command_palette = false,       -- position the cmdline and popupmenu together
        long_message_to_split = false, -- long messages will be sent to a split
        inc_rename = false,            -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true,         -- add a border to hover docs and signature help
      },
      throttle = 1000 / 30,            -- how frequently does Noice need to check for ui updates? This has no effect when in blocking mode.
      ---@type NoiceConfigViews
      views = {}, ---@see section on views
      ---@type NoiceRouteConfig[]
      routes = {}, --- @see section on routes
      ---@type table<string, NoiceFilter>
      status = {}, --- @see section on statusline components
      ---@type NoiceFormatOptions
      format = {}, --- @see section on formatting
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    }
  },
  "github/copilot.vim"
})

-- require('leap').set_default_keymaps()

require('hlargs').setup()

-- require("noice").setup({
-- })
--
-- require("fidget").setup({
-- })

-- require'lspconfig'.jdtls.setup{
--   cmd = { 'sh', '-c', 'exec jdt-language-server -data ~/.jdt.workspace/$(pwd | md5sum | cut -d" " -f1)' }
-- }

require('lspconfig').clangd.setup {
  -- on_attach = keybinds.on_attach,
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    -- "--compile-commands-dir=/home/localuser/test/build",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
}

require 'lspconfig'.lua_ls.setup {
  on_init = function(client)
    local path = client.workspace_folders[1].name
    if vim.loop.fs_stat(path .. '/.luarc.json') or vim.loop.fs_stat(path .. '/.luarc.jsonc') then
      return
    end

    client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
      runtime = {
        -- Tell the language server which version of Lua you're using
        -- (most likely LuaJIT in the case of Neovim)
        version = 'LuaJIT'
      },
      -- Make the server aware of Neovim runtime files
      workspace = {
        checkThirdParty = false,
        -- library = {
        --   vim.env.VIMRUNTIME
        --   -- Depending on the usage, you might want to add additional paths here.
        --   -- "${3rd}/luv/library"
        --   -- "${3rd}/busted/library",
        -- },
        -- or pull in all of 'runtimepath'. NOTE: this is a lot slower
        library = vim.api.nvim_get_runtime_file("", true)
      }
    })
  end,
  settings = {
    Lua = {}
  }
}

require 'lspconfig'.pylsp.setup {
  settings = {
    pylsp = {
      plugins = {
        pycodestyle = {
          -- ignore = { 'W391' },
          maxLineLength = 160
        }
      }
    }
  }
}

require 'nvim-web-devicons'.setup {
  -- your personnal icons can go here (to override)
  -- DevIcon will be appended to `name`
  -- override = {
  --   zsh = {
  --     icon = "",
  --     color = "#428850",
  --     name = "Zsh"
  --   }
  -- };
  -- globally enable default icons (default to false)
  -- will get overriden by `get_icons` option
  default = true,
}

g['nvim_web_devicons'] = 1 -- temporary until nvim-tree removes check?

require('illuminate').configure({
  -- providers: provider used to get references in the buffer, ordered by priority
  providers = {
    'lsp',
    -- 'treesitter',
    -- 'regex',
  },
  -- delay: delay in milliseconds
  delay = 100,
  -- filetype_overrides: filetype specific overrides.
  -- The keys are strings to represent the filetype while the values are tables that
  -- supports the same keys passed to .configure except for filetypes_denylist and filetypes_allowlist
  filetype_overrides = {},
  -- filetypes_denylist: filetypes to not illuminate, this overrides filetypes_allowlist
  filetypes_denylist = {
    'dirbuf',
    'dirvish',
    'fugitive',
  },
  -- filetypes_allowlist: filetypes to illuminate, this is overridden by filetypes_denylist
  -- You must set filetypes_denylist = {} to override the defaults to allow filetypes_allowlist to take effect
  filetypes_allowlist = {},
  -- modes_denylist: modes to not illuminate, this overrides modes_allowlist
  -- See `:help mode()` for possible values
  modes_denylist = {},
  -- modes_allowlist: modes to illuminate, this is overridden by modes_denylist
  -- See `:help mode()` for possible values
  modes_allowlist = {},
  -- providers_regex_syntax_denylist: syntax to not illuminate, this overrides providers_regex_syntax_allowlist
  -- Only applies to the 'regex' provider
  -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
  providers_regex_syntax_denylist = {},
  -- providers_regex_syntax_allowlist: syntax to illuminate, this is overridden by providers_regex_syntax_denylist
  -- Only applies to the 'regex' provider
  -- Use :echom synIDattr(synIDtrans(synID(line('.'), col('.'), 1)), 'name')
  providers_regex_syntax_allowlist = {},
  -- under_cursor: whether or not to illuminate under the cursor
  under_cursor = true,
  -- large_file_cutoff: number of lines at which to use large_file_config
  -- The `under_cursor` option is disabled when this cutoff is hit
  large_file_cutoff = 10000,
  -- large_file_config: config to use for large files (based on large_file_cutoff).
  -- Supports the same keys passed to .configure
  -- If nil, vim-illuminate will be disabled for large files.
  large_file_overrides = nil,
  -- min_count_to_highlight: minimum number of matches required to perform highlighting
  min_count_to_highlight = 1,
  -- should_enable: a callback that overrides all other settings to
  -- enable/disable illumination. This will be called a lot so don't do
  -- anything expensive in it.
  should_enable = function(bufnr) return true end,
  -- case_insensitive_regex: sets regex case sensitivity
  case_insensitive_regex = false,
  -- disable_keymaps: disable default keymaps
  disable_keymaps = false,
})
----------------------------------
-- VARIABLES ---------------------
----------------------------------
-- nvim-metals
g['metals_server_version'] = '1.6.0'

----------------------------------
-- OPTIONS -----------------------
----------------------------------
-- global
opt('o', 'completeopt', 'menuone,noinsert,noselect')
vim.o.shortmess                   = string.gsub(vim.o.shortmess, 'F', '') .. 'c'

-- nvim tree

g['nvim_tree_auto_ignore_ft']     = {} -- [ 'startify', 'dashboard' ] -- empty by default, don't auto open tree on specific filetypes.
g['nvim_tree_width_allow_resize'] = 1  -- 0 by default, will not resize the tree when opening a file
-- g['nvim_tree_add_trailing'] = 1 -- 0 by default, append a trailing slash to folder names
-- g['nvim_tree_group_empty'] = 1 --  0 by default, compact folders that only contain a single folder into one node in the file tree
-- g['nvim_tree_special_files'] = { 'README.md', 'Makefile', 'MAKEFILE' } --  List of filenames that gets highlighted with NvimTreeSpecialFile
-- g['nvim_tree_show_icons'] = { git = 1, folders = 1, files = 1 }

map('n', '<leader>tt', '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>tr', '<cmd>NvimTreeRefresh<CR>')
map('n', '<leader>tf', '<cmd>NvimTreeFindFile | NvimTreeFocus <CR>')


require 'nvim-tree'.setup({
  actions             = {
    open_file = {
      window_picker = {
        enable = true
      },
      quit_on_open = false
    }
  },
  -- disables netrw completely
  disable_netrw       = true,
  -- hijack netrw window on startup
  hijack_netrw        = true,
  -- opens the tree when changing/opening a new tab if the tree wasn't previously opened
  open_on_tab         = false,
  -- hijacks new directory buffers when they are opened.
  -- update_to_buf_dir   = {
  --   enable = true,
  --   auto_open = true,
  -- },
  -- hijack the cursor in the tree to put it at the start of the filename
  hijack_cursor       = false,
  -- updates the root directory of the tree on `DirChanged` (when your run `:cd` usually)
  update_cwd          = true,
  -- show lsp diagnostics in the signcolumn
  diagnostics         = {
    enable = true,
  },
  -- update the focused file on `BufEnter`, un-collapses the folders recursively until it finds the file
  update_focused_file = {
    -- enables the feature
    enable      = false,
    -- update the root directory of the tree to the one of the folder containing the file if the file is not under the current root directory
    -- only relevant when `update_focused_file.enable` is true
    update_cwd  = true,
    -- list of buffer names / filetypes that will not update the cwd if the file isn't found under the current root directory
    -- only relevant when `update_focused_file.update_cwd` is true and `update_focused_file.enable` is true
    ignore_list = {}
  },
  -- configuration options for the system open command (`s` in the tree by default)
  system_open         = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
  },

  view                = {
    -- width of the window, can be either a number (columns) or a string in `%`
    width = 40,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'right',
    -- if true the tree will resize itself after opening a file
    -- auto_resize = false,
  },
  filters             = {
    custom = { '^\\.git$', '^node_modules$', '^\\.cache$', '^target$', '^\\.tmp$', '^\\.gitignore$' },
    dotfiles = false
  },
  git                 = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  renderer            = {
    indent_markers = {
      enable = true
    },
    highlight_git = true,
    highlight_opened_files = "icon",
    group_empty = true
  }
})

-- LSP
map('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>')
map('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>')
map('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>')
map('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>')
map('n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>')
map('n', 'gs', '<cmd>lua vim.lsp.buf.document_symbol()<CR>')
map('n', 'gws', '<cmd>lua vim.lsp.buf.workspace_symbol()<CR>')
map('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
map('n', '<leader>f', '<cmd>lua vim.lsp.buf.format()<CR>')
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('v', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
-- map('n', '<leader>a', '<cmd>TroubleToggle workspace_diagnostics<CR>')
-- map('n', '<leader>d', '<cmd>TroubleToggle document_diagnostics<CR>')
-- map('n', '<leader>a', '<cmd>lua vim.diagnostic.setqflist()<CR>')
-- map('n', '<leader>d', '<cmd>lua vim.diagnostic.setloclist()<CR>') -- buffer diagnostics only
map('n', '[e', '<cmd>lua vim.diagnostic.goto_prev { wrap = false, severity = vim.diagnostic.severity.ERROR }<CR>')
map('n', ']e', '<cmd>lua vim.diagnostic.goto_next { wrap = false, severity = vim.diagnostic.severity.ERROR }<CR>')
map('n', '[c', '<cmd>lua vim.diagnostic.goto_prev { wrap = false }<CR>')
map('n', ']c', '<cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>')
-- map('n', '<leader>cv', '<cmd>Vista nvim_lsp<CR>')
-- map('n', '<leader>cc', '<cmd>Vista finder nvim_lsp<CR>')



local cmp = require("cmp")
cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "vsnip" },
  },
  snippet = {
    expand = function(args)
      -- Comes from vsnip
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    -- None of this made sense to me when first looking into this since there
    -- is no vim docs, but you can't have select = true here _unless_ you are
    -- also using the snippet stuff. So keep in mind that if you remove
    -- snippets you need to remove this select
    -- ["<CR>"] = cmp.mapping.confirm({ select = true }),
    -- I use tabs... some say you should stick to ins-completion
    -- ["<Tab>"] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_next_item()
    --   else
    --     fallback()
    --   end
    -- end,
    -- ["<S-Tab>"] = function(fallback)
    --   if cmp.visible() then
    --     cmp.select_prev_item()
    --   else
    --     fallback()
    --   end
    -- end,
    ['<C-n>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<C-p>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
    ['<Down>'] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
    ['<Up>'] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    })
  },
})


-- completion
-- This is just copied from the docs, edit to your liking
-- require'compe'.setup {
--   enabled = true;
--   autocomplete = true;
--   debug = false;
--   min_length = 1;
--   preselect = 'enable';
--   throttle_time = 80;
--   source_timeout = 200;
--   incomplete_delay = 400;
--   allow_prefix_unmatch = false;
--
--   source = {
--     path = true;
--     buffer = true;
--     calc = true;
--     vsnip = true;
--     nvim_lsp = true;
--     nvim_lua = true;
--     spell = true;
--     tags = true;
--     snippets_nvim = true;
--   };
-- }
--
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', { expr = true })
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', { expr = true })
-- map('i', '<CR>', 'compe#confirm("\\<CR>")', {expr = true})
-- map('i', '<C-Space>', 'compe#complete()', {expr = true})

function FilterQuickfixByCWD()
  local cwd = vim.fn.getcwd()
  local new_qf = {}
  local qf_list = vim.fn.getqflist()

  -- print("CWD", cwd)
  for _, item in ipairs(qf_list) do
    local full_path = vim.fn.fnamemodify(vim.fn.bufname(item.bufnr), ":p")
    -- print("Buffer Number:", item.bufnr)
    -- print("Buffer Name:", bufname)
    -- print("Full Path:", full_path)
    if string.sub(full_path, 1, #cwd) == cwd then
      table.insert(new_qf, item)
    end
  end

  vim.fn.setqflist(new_qf)
end

----------------------------------
-- COMMANDS ----------------------
----------------------------------
-- LSP
vim.cmd [[augroup scalalsp]]
vim.cmd [[autocmd!]]
vim.cmd [[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]]
vim.cmd [[autocmd FileType scala,sbt,java,sc lua require("metals").initialize_or_attach(metals_config)]]
vim.cmd [[autocmd FileType scala nnoremap <leader>cs  <cmd>lua require"metals".hover_worksheet()<CR>]]
vim.cmd [[autocmd FileType scala nnoremap <leader>tm   <cmd>lua require("metals.tvp").toggle_tree_view()<CR>]]
vim.cmd [[autocmd FileType scala nnoremap <leader>tg   <cmd>lua require("metals.tvp").reveal_in_tree()<CR>]]
vim.cmd [[augroup end]]

vim.cmd [[nnoremap <leader>cl  <cmd>lua vim.lsp.codelens.run()<CR>]]
vim.cmd [[nnoremap <leader>sh  <cmd>lua vim.lsp.buf.signature_help()<CR>]]
vim.cmd [[nnoremap <leader>ae  <cmd>lua vim.diagnostic.setqflist({severity = "E"})<CR>]]
vim.cmd [[nnoremap <leader>aa  <cmd>lua vim.diagnostic.setqflist()<CR>]]
vim.cmd [[nnoremap <leader>aw  <cmd>lua vim.diagnostic.setqflist({severity = "W"})<CR>]]
vim.cmd [[nnoremap <leader>ad  <cmd>lua vim.diagnostic.setloclist()<CR>]]
vim.cmd [[nnoremap <leader>af  <cmd>lua FilterQuickfixByCWD()<CR>]]

-- Need for symbol highlights to work correctly
vim.cmd [[hi! link LspReferenceText CursorColumn]]
vim.cmd [[hi! link LspReferenceRead CursorColumn]]
vim.cmd [[hi! link LspReferenceWrite CursorColumn]]
----------------------------------
-- LSP Setup ---------------------
----------------------------------



-- metals_config = require'metals'.bare_config
-- -- Example of settings
-- metals_config.settings = {
--   showImplicitArguments = true,
--   excludedPackages = {'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl'}
-- }
-- -- Example of how to ovewrite a handler
-- metals_config.handlers['textDocument/publishDiagnostics'] =
--     vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {virtual_text = {prefix = ''}})
-- -- Example if you are including snippets
-- -- local capabilities = vim.lsp.protocol.make_client_capabilities()
-- local capabilities = lsp_status.capabilities
-- capabilities.textDocument.completion.completionItem.snippetSupport = true
-- metals_config.capabilities = capabilities
-- metals_config.on_attach = lsp_status.on_attach


metals_config = require("metals").bare_config()
metals_config.settings = {
  showImplicitArguments = true,
  bloopSbtAlreadyInstalled = true,
  showInferredType = true,
  superMethodLensesEnabled = false,
  -- bloopVersion = "2.0.0",
  serverProperties = {
    "-XX:+UseG1GC", "-Xmx8g",
  }
}
metals_config.scala_file_types = { "sbt", "scala", "java", "sc" }


-- require'lspconfig'.rust_analyzer.setup({
--   on_attach = lsp_status.on_attach,
--   capabilities = lsp_status.capabilities,
-- })
local rt = require("rust-tools")
rt.setup({
  tools = { -- rust-tools options

    -- automatically call RustReloadWorkspace when writing to a Cargo.toml file.
    reload_workspace_from_cargo_toml = true,

    -- These apply to the default RustSetInlayHints command
    inlay_hints = {
      -- automatically set inlay hints (type hints)
      -- default: true
      auto = true,
      -- Only show inlay hints for the current line
      only_current_line = false,
      -- whether to show parameter hints with the inlay hints or not
      -- default: true
      show_parameter_hints = true,
      -- prefix for parameter hints
      -- default: "<-"
      parameter_hints_prefix = "<- ",
      -- prefix for all the other hints (type, chaining)
      -- default: "=>"
      other_hints_prefix = "=> ",
      -- whether to align to the length of the longest line in the file
      max_len_align = false,
      -- padding from the left if max_len_align is true
      max_len_align_padding = 1,
      -- whether to align to the extreme right or not
      right_align = false,
      -- padding from the right if right_align is true
      right_align_padding = 7,
      -- The color of the hints
      highlight = "Comment",
    },

    -- options same as lsp hover / vim.lsp.util.open_floating_preview()
    hover_actions = {
      -- the border that is used for the hover window
      -- see vim.api.nvim_open_win()
      border = {
        { "╭", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╮", "FloatBorder" },
        { "│", "FloatBorder" },
        { "╯", "FloatBorder" },
        { "─", "FloatBorder" },
        { "╰", "FloatBorder" },
        { "│", "FloatBorder" },
      },

      -- Maximal width of the hover window. Nil means no max.
      max_width = nil,
      -- Maximal height of the hover window. Nil means no max.
      max_height = nil,
      -- whether the hover action window gets automatically focused
      -- default: false
      auto_focus = true,
    },

    -- settings for showing the crate graph based on graphviz and the dot
    -- command
    crate_graph = {
      -- Backend used for displaying the graph
      -- see: https://graphviz.org/docs/outputs/
      -- default: x11
      backend = "gtk",
      -- where to store the output, nil for no output stored (relative
      -- path from pwd)
      -- default: nil
      output = nil,
      -- true for all crates.io and external crates, false only the local
      -- crates
      -- default: true
      full = true,

      -- List of backends found on: https://graphviz.org/docs/outputs/
      -- Is used for input validation and autocompletion
      -- Last updated: 2021-08-26
      enabled_graphviz_backends = {
        "bmp", "cgimage", "canon", "dot", "gv", "xdot", "xdot1.2", "xdot1.4", "eps", "exr", "fig", "gd", "gd2",
        "gif", "gtk", "ico", "cmap", "ismap", "imap", "cmapx", "imap_np", "cmapx_np", "jpg", "jpeg", "jpe", "jp2",
        "json", "json0", "dot_json", "xdot_json", "pdf", "pic", "pct", "pict", "plain", "plain-ext", "png", "pov",
        "ps", "ps2", "psd", "sgi", "svg", "svgz", "tga", "tiff", "tif", "tk", "vml", "vmlz", "wbmp", "webp", "xlib",
        "x11",
      },
    },
  },


  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#rust_analyzer
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      -- vim.keymap.set("n", "<Leader>ca", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
    -- standalone file support
    -- setting it to false may improve startup time
    standalone = true,
  }, -- rust-analyzer options

  -- debugging stuff
  -- dap = {
  --   adapter = {
  --     type = "executable",
  --     command = "lldb-vscode",
  --     name = "rt_lldb",
  --   },
  -- },
})

require("mason").setup()


-- require'lspconfig'.jdtls.setup({
--   on_attach = lsp_status.on_attach,
--   capabilities = lsp_status.capabilities,
-- })

require('lspkind').init()

require('gitsigns').setup()

local custom_lualine_theme = require 'lualine.themes.ayu_dark'
custom_lualine_theme.normal.c.bg = '#101314'

local add_codecompanion_to_lualine = function()
  local M = require("lualine.component"):extend()

  M.processing = false
  M.spinner_index = 1

  local spinner_symbols = {
    "⠋",
    "⠙",
    "⠹",
    "⠸",
    "⠼",
    "⠴",
    "⠦",
    "⠧",
    "⠇",
    "⠏",
  }
  local spinner_symbols_len = 10

  -- Initializer
  function M:init(options)
    M.super.init(self, options)

    local group = vim.api.nvim_create_augroup("CodeCompanionHooks", {})

    vim.api.nvim_create_autocmd({ "User" }, {
      pattern = "CodeCompanionRequest*",
      group = group,
      callback = function(request)
        if request.match == "CodeCompanionRequestStarted" then
          self.processing = true
        elseif request.match == "CodeCompanionRequestFinished" then
          self.processing = false
        end
      end,
    })
  end

  -- Function that runs every time statusline is updated
  function M:update_status()
    if self.processing then
      self.spinner_index = (self.spinner_index % spinner_symbols_len) + 1
      return spinner_symbols[self.spinner_index]
    else
      return nil
    end
  end

  return M
end





local function macro_recording()
  local reg = vim.fn.reg_recording()
  if reg == "" then
    return ""
  else
    return "Recording @" .. reg
  end
end


require 'lualine'.setup {
  extensions = { 'quickfix', 'nvim-tree', 'fzf' },
  sections = {
    lualine_b = {
      'branch',
      'diff',
      {
        'diagnostics',

        -- Table of diagnostic sources, available sources are:
        --   'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic', 'coc', 'ale', 'vim_lsp'.
        -- or a function that returns a table as such:
        --   { error=error_cnt, warn=warn_cnt, info=info_cnt, hint=hint_cnt }
        sources = { 'nvim_lsp', 'nvim_diagnostic', 'nvim_workspace_diagnostic' },

        -- Displays diagnostics for the defined severity types
        sections = { 'error', 'warn', 'info', 'hint' },

        diagnostics_color = {
          -- Same values as the general color option can be used here.
          error = 'DiagnosticError', -- Changes diagnostics' error color.
          warn  = 'DiagnosticWarn',  -- Changes diagnostics' warn color.
          info  = 'DiagnosticInfo',  -- Changes diagnostics' info color.
          hint  = 'DiagnosticHint',  -- Changes diagnostics' hint color.
        },
        symbols = { error = 'E', warn = 'W', info = 'I', hint = 'H' },
        colored = true,           -- Displays diagnostics status in color if set to true.
        update_in_insert = false, -- Update diagnostics in insert mode.
        always_visible = false,   -- Show diagnostics even if there are none.
      }
    },
    lualine_c = {
      -- lsp_status.status,
      -- lsp_status.progress,
      add_codecompanion_to_lualine(),
      -- {
      --   require("noice").api.statusline.mode.get,
      --   cond = require("noice").api.statusline.mode.has,
      --   color = { fg = "#ff9e64" },
      -- }
    },
    lualine_x = {
      macro_recording, "encoding", "fileformat", "filetype"
    }
  },
  options = {
    theme = custom_lualine_theme,
    disabled_filetypes = { 'presenting_markdown' }
  },
}


require 'bufferline'.setup {
  options = {
    view = "default",
    numbers = "ordinal",
    max_name_length = 18,
    max_prefix_length = 15, -- prefix used when a buffer is de-duplicated
    tab_size = 18,
    diagnostics = "nvim_lsp",
    diagnostics_indicator = function(count, level, diagnostics_dict)
      return "(" .. count .. ")"
    end,
    -- NOTE: this will be called a lot so don't do any heavy processing here
    custom_filter = function(buf_number)
      -- filter out filetypes you don't want to see
      if vim.bo[buf_number].filetype ~= "qf" then
        return true
      end
      -- -- filter out by buffer name
      -- if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
      --   return true
      -- end
      -- -- filter out based on arbitrary rules
      -- -- e.g. filter out vim wiki buffer from tabline in your work repo
      -- if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
      --   return true
      -- end
    end,
    offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "left" } },
    show_buffer_icons = true, -- disable filetype icons for buffers
    show_buffer_close_icons = false,
    show_close_icon = false,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "slant",
    enforce_regular_tabs = false,
    always_show_bufferline = false,
    -- sort_by = 'extension' | 'relative_directory' | 'directory' | function(buffer_a, buffer_b)
    --   -- add custom logic
    --   return buffer_a.modified > buffer_b.modified
    -- end
  }
}


-- map('n', '<C-1>', '<cmd>lua require"bufferline".go_to(1)<CR>')
-- map('n', '<C-2>', '<cmd>lua require"bufferline".go_to(2)<CR>')

-- telescope

-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes

local previewers = require('telescope.previewers')

local new_maker = function(filepath, bufnr, opts)
  opts = opts or {}

  filepath = vim.fn.expand(filepath)
  vim.loop.fs_stat(filepath, function(_, stat)
    if not stat then return end
    if stat.size > 500000 then
      return
    else
      previewers.buffer_previewer_maker(filepath, bufnr, opts)
    end
  end)
end

require('telescope').setup {
  defaults = {
    -- vimgrep_arguments = {
    --     "rg",
    --     "--color=never",
    --     "--no-heading",
    --     "--with-filename",
    --     "--line-number",
    --     "--column",
    --     "--smart-case",
    --     "--max-results=500" -- Set max results
    -- },
    -- prompt_prefix = "🔍 ",
    -- selection_caret = " ",
    -- entry_prefix = "  ",
    -- layout_strategy = "horizontal",
    -- layout_config = {
    --   preview_width = 0.5,
    -- },
    file_ignore_patterns = { "node_modules", ".git/" },
    mappings = {
      i = {
        -- map actions.which_key to <C-h> (default: <C-/>)
        -- actions.which_key shows the mappings for your picker,
        -- e.g. git_{create, delete, ...}_branch for the git_branches picker
        ["<C-l>"] = function(prompt_bufnr)
          local state = require "telescope.state"
          local status = state.get_status(prompt_bufnr)
          vim.api.nvim_win_call(status.results_win, function()
            vim.cmd([[normal! 5zl]])
          end)
        end,
        ["<C-h>"] = function(prompt_bufnr)
          local state = require "telescope.state"
          local status = state.get_status(prompt_bufnr)
          vim.api.nvim_win_call(status.results_win, function()
            vim.cmd([[normal! 5zh]])
          end)
        end
      }
    },
    buffer_previewer_maker = new_maker,
  },
  -- pickers = {
  --   live_grep = {
  --     only_sort_text = true,
  --     theme = "dropdown",
  --     max_results = 500, -- Limit results
  --   }
  -- },
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    },
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
}

require("telescope").load_extension("ui-select")
require('telescope').load_extension('fzf')

-- treesitter

require 'nvim-treesitter.configs'.setup {
  ensure_installed = require 'nvim-treesitter.parsers'.available_parsers(),
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true,     -- false will disable the whole extension
    disable = {},      -- list of language that will be disabled
  },
  indent = {
    enable = true
  }
}




-- cmd [[hi NormalFloat guibg=#CCCCCC]]
-- cmd [[hi WhichKeyFloat guibg=#141414]]
-- cmd [[hi NvimTreeNormal guibg=#141414]]
-- cmd [[autocmd Colorscheme * highlight NvimTreeNormal guibg=#21252B guifg=#9da5b3]]
-- cmd [[autocmd ColorScheme * highlight NvimTreeBg guibg=#2B4252]]
-- cmd [[autocmd FileType NvimTree hi NvimTreeNormal guibg=#141414]]

require("which-key").setup {
  -- https://github.com/folke/which-key.nvim
  -- your configuration comes here
  -- or leave it empty to use the default settings
  -- refer to the configuration section below
}


require 'which-key'.add({
  { "<leader>0", hidden = true },
  { "<leader>1", hidden = true },
  { "<leader>2", hidden = true },
  { "<leader>3", hidden = true },
  { "<leader>4", hidden = true },
  { "<leader>5", hidden = true },
  { "<leader>6", hidden = true },
  { "<leader>7", hidden = true },
  { "<leader>8", hidden = true },
  { "<leader>9", hidden = true },
})


require("winshift").setup({
  highlight_moving_win = true, -- Highlight the window being moved
  focused_hl_group = "Visual", -- The highlight group used for the moving window
  moving_win_options = {
    -- These are local options applied to the moving window while it's
    -- being moved. They are unset when you leave Win-Move mode.
    wrap = false,
    cursorline = false,
    cursorcolumn = false,
    colorcolumn = "",
  },
  -- The window picker is used to select a window while swapping windows with
  -- ':WinShift swap'.
  -- A string of chars used as identifiers by the window picker.
  window_picker = function()
    return require("winshift.lib").pick_window({
      picker_chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
      filter_rules = {
        cur_win = true,
        floats = true,
        filetype = {
          "NvimTree",
        },
        buftype = {
          "terminal",
          "quickfix",
        },
        bufname = {
          [[.*foo/bar/baz\.qux]]
        },
      },
    })
  end,
})

-- Start Win-Move mode:
map('n', '<leader>ww', '<cmd>WinShift<CR>')
map('n', '<leader>wx', '<cmd>WinShift swap<CR>')
map('n', '<leader>w<left>', '<cmd>WinShift left<CR>')
map('n', '<leader>w<right>', '<cmd>WinShift right<CR>')
map('n', '<leader>w<up>', '<cmd>WinShift up<CR>')
map('n', '<leader>w<down>', '<cmd>WinShift down<CR>')
map('n', '<leader>w<C-left>', '<cmd>WinShift far_left<CR>')
map('n', '<leader>w<C-right>', '<cmd>WinShift far_right<CR>')
map('n', '<leader>w<C-up>', '<cmd>WinShift far_up<CR>')
map('n', '<leader>w<C-down>', '<cmd>WinShift far_down<CR>')


-- Debug settings if you're using nvim-dap
local dap = require("dap")

local cpptools_path = vim.fn.stdpath("data") .. "/mason/packages/cpptools/extension/debugAdapters/bin/OpenDebugAD7"
dap.adapters.cppdbg = {
  id = 'cppdbg',
  type = 'executable',
  command = cpptools_path,
}

dap.configurations.scala = {
  {
    type = "scala",
    request = "launch",
    name = "RunOrTest",
    metals = {
      runType = "runOrTestFile",
      --args = { "firstArg", "secondArg", "thirdArg" }, -- here just as an example
    },
  },
  {
    type = "scala",
    request = "launch",
    name = "Test Target",
    metals = {
      runType = "testTarget",
    },
  },
  {
    type = "scala",
    request = "attach",
    name = "Attach to Target",
    host = "localhost",
    port = 5005
  },
}

metals_config.on_attach = function(client, bufnr)
  require("metals").setup_dap()
end

vim.keymap.set("n", "<F1>", dap.terminate)
vim.keymap.set("n", "<F6>", dap.toggle_breakpoint)
vim.keymap.set("n", "<F7>", dap.continue)
vim.keymap.set("n", "<F8>", dap.step_over)
vim.keymap.set("n", "<F9>", dap.step_out)
vim.keymap.set("n", "<F10>", dap.step_into)
vim.keymap.set("n", "<F11>", dap.pause)
vim.keymap.set("n", "<F56>", dap.down) -- <A-F8>
vim.keymap.set("n", "<F57>", dap.up)   -- <A-F9>
-- map("n", "<leader>dr", [[<cmd>lua require"dap".repl.toggle()<CR>]])
-- map("n", "<leader>dK", [[<cmd>lua require"dap.ui.widgets".hover()<CR>]])
-- map("n", "<leader>dl", [[<cmd>lua require"dap".run_last()<CR>]])
-- map("n", "<leader>dx", [[<cmd>lua require"dap".run_to_cursor()<CR>]])
-- vim.keymap.set("n", "<leader>dz", function()
--   local widgets = require('dap.ui.widgets')
--   local my_sidebar = widgets.sidebar(widgets.frames)
--   my_sidebar.open()
-- end, {desc = 'debugger frames'})
-- vim.keymap.set("n", "<leader>dy", function()
--   local widgets = require('dap.ui.widgets')
--   local my_sidebar = widgets.sidebar(widgets.scopes)
--   my_sidebar.open()
-- end, {desc = 'debugger scopes'})

local rr_dap = require("nvim-dap-rr")
rr_dap.setup({
  mappings = {
    -- you will probably want to change these defaults to that they match
    -- your usual debugger mappings
    continue = "<F7>",
    step_over = "<F8>",
    step_out = "<F9>",
    step_into = "<F10>",
    reverse_continue = "<F19>",    -- <S-F7>
    reverse_step_over = "<F20>",   -- <S-F8>
    reverse_step_out = "<F21>",    -- <S-F9>
    reverse_step_into = "<F22>",   -- <S-F10>
    -- instruction level stepping
    step_over_i = "<F32>",         -- <C-F8>
    step_out_i = "<F33>",          -- <C-F8>
    step_into_i = "<F34>",         -- <C-F8>
    reverse_step_over_i = "<F44>", -- <SC-F8>
    reverse_step_out_i = "<F45>",  -- <SC-F9>
    reverse_step_into_i = "<F46>", -- <SC-F10>
  }
})
dap.configurations.rust = { rr_dap.get_rust_config() }
dap.configurations.cpp = { rr_dap.get_config() }
-- actions:
-- require("dapui").open()
-- require("dapui").close()
-- require("dapui").toggle()
local dapui = require("dapui")
dapui.setup()

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end




map("n", "<C-L>", [[10zl]])
map("n", "<C-H>", [[10zh]])



require 'ltex-ls'.setup {
  use_spellfile = false,    -- Uses the value of 'spellfile' as an external file when checking the document
  window_border = 'single', -- How the border should be rendered
  -- on_attach = on_attach,
  cmd = { "sh", "-c", "JAVA_OPTS=-Djdk.xml.totalEntitySizeLimit=1000000 ltex-ls" },
  filetypes = { "markdown", "text", "latex", "tex", "bib", "gitcommit" },
  flags = { debounce_text_changes = 300 },
  settings = {
    ltex = {
      enabled = { "latex", "tex", "bib", "markdown", "gitcommit" },
      language = "en-GB",
      configurationTarget = {
        dictionary = "workspaceFolderExternalFile",
        disabledRules = "workspaceFolder",
        hiddenFalsePositives = "workspaceFolder",
      },
      disabledRules = {
        ["en-GB"] = { "OXFORD_SPELLING_Z_NOT_S", "PASSIVE_VOICE" },
      },
      enableRules = {
        ["en-GB"] = { "OXFORD_SPELLING_ISE_VERBS" },
      },
      dictionary = (function()
        -- For dictionary, search for files in the runtime to have
        -- and include them as externals the format for them is
        -- dict/{LANG}.txt
        --
        -- Also add dict/default.txt to all of them
        local files = {}
        for _, file in ipairs(vim.api.nvim_get_runtime_file("dict/*", true)) do
          local lang = vim.fn.fnamemodify(file, ":t:r")
          local fullpath = vim.fs.normalize(file)
          files[lang] = { ":" .. fullpath }
        end

        if files.default then
          for lang, _ in pairs(files) do
            if lang ~= "default" then
              vim.list_extend(files[lang], files.default)
            end
          end
          files.default = nil
        end
        if files['en-GB'] then
          files['en-GB']:insert(1, ":" .. vim.fn.getcwd() .. "/.ltex.dictionary.txt")
        else
          files['en-GB'] = { ":" .. vim.fn.getcwd() .. "/.ltex.dictionary.txt" }
        end
        -- print(vim.inspect(files))
        return files
      end)(),
    }
  }
}


-- -- haskell
-- local ht = require('haskell-tools')
-- local def_opts = { noremap = true, silent = true, }
-- ht.setup {
--   hls = {
--     -- See nvim-lspconfig's  suggested configuration for keymaps, etc.
--     on_attach = function(client, bufnr)
--       local opts = vim.tbl_extend('keep', def_opts, { buffer = bufnr, })
--       -- haskell-language-server relies heavily on codeLenses,
--       -- so auto-refresh (see advanced configuration) is enabled by default
--       vim.keymap.set('n', '<space>ca', vim.lsp.codelens.run, opts)
--       vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
--       -- default_on_attach(client, bufnr)  -- if defined, see nvim-lspconfig
--     end,
--   },
-- }
-- -- Suggested keymaps that do not depend on haskell-language-server
-- -- Toggle a GHCi repl for the current package
-- vim.keymap.set('n', '<leader>rr', ht.repl.toggle, def_opts)
-- -- Toggle a GHCi repl for the current buffer
-- vim.keymap.set('n', '<leader>rf', function()
--   ht.repl.toggle(vim.api.nvim_buf_get_name(0))
-- end, def_opts)
-- vim.keymap.set('n', '<leader>rq', ht.repl.quit, def_opts)
--



local hop = require('hop')
hop.setup()
map('n', '<leader>ga', '<cmd>HopAnywhere<CR>')
map('n', '<leader>gw', '<cmd>HopWord<CR>')
map('n', '<C-x>', '<cmd>HopWord<CR>')
map('n', '<C-S-x>', '<cmd>HopAnywhere<CR>')
-- local directions = require('hop.hint').HintDirection
-- vim.keymap.set('', 'f', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true })
-- end, {remap=true})
-- vim.keymap.set('', 'F', function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true })
-- end, {remap=true})
-- vim.keymap.set('', 't', function()
--   hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
-- end, {remap=true})
-- vim.keymap.set('', 'T', function()
--   hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
-- end, {remap=true})

-- register autocommand for colorscheme change so when it's done in init.vim bufferline works ok



require('kanagawa').setup({
  compile = true,   -- enable compiling the colorscheme
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

-- cmd("KanagawaCompile")
-- cmd("colorscheme kanagawa-dragon") --  " focuspoint " afterglow " deus
cmd("colorscheme retrobox")


variable_colors = { "#9CD8F7", "#F5FA1D", "#F97C65", "#35D27F", "#EB75D6", "#E5D180", "#8997F5", "#D49DA5", "#7FEC35",
  "#F6B223", "#B4F1C3", "#99B730", "#F67C1B", "#3AC6BE", "#EAAFF1", "#DE9A4E", "#BBEA87", "#EEF06D", "#8FB272", "#EAA481",
  "#F58AAE", "#80B09B", "#5DE866", "#B5A5C5", "#88ADE6", "#4DAABD", "#EDD528", "#FA6BB2", "#47F2D4", "#F47F86", "#2ED8FF",
  "#B8E01C", "#C5A127", "#74BB46", "#D386F1", "#97DFD6", "#B1A96F", "#66BB75", "#97AA49", "#EF874A", "#48EDF0", "#C0AE50",
  "#89AAB6", "#D7D1EB", "#5EB894", "#57F0AC", "#B5AF1B", "#B7A5F0", "#8BE289", "#D38AC6", "#C8EE63", "#ED9C36", "#85BA5F",
  "#9DEA74", "#85C52D", "#40B7E5", "#EEA3C2", "#7CE9B6", "#8CEC58", "#D8A66C", "#51C03B", "#C4CE64", "#45E648", "#4DC15E",
  "#63A5F3", "#EA8C66", "#D2D43E", "#E5BCE8", "#E4B7CB", "#B092F4", "#44C58C", "#D1E998", "#76E4F2", "#E19392", "#A8E5A4",
  "#BF9FD6", "#E8C25B", "#58F596", "#6BAEAC", "#94C291", "#7EF1DB", "#E8D65C", "#A7EA38", "#D38AE0", "#ECF453", "#5CD8B8",
  "#B6BF6B", "#BEE1F1", "#B1D43E", "#EBE77B", "#84A5CD", "#CFEF7A", "#A3C557", "#E4BB34", "#ECB151", "#BDC9F2", "#5EB0E9",
  "#E09764", "#9BE3C8", "#B3ADDC", "#B2AC36", "#C8CD4F", "#C797AF", "#DCDB26", "#BCA85E", "#E495A5", "#F37DB8", "#70C0B1",
  "#5AED7D", "#E49482", "#8AA1F0", "#B3EDEE", "#DAEE34", "#EBD646", "#ECA2D2", "#A0A7E6", "#3EBFD3", "#C098BF", "#F1882E",
  "#77BFDF", "#7FBFC7", "#D4951F", "#A5C0D0", "#B892DE", "#F8CB31", "#75D0D9", "#A6A0B4", "#EA98E4", "#F38BE6", "#DC83A4" }
max_variable_colours = #(variable_colors)

for i = 0, max_variable_colours - 1
do
  vim.api.nvim_set_hl(0, '@variable.' .. i, { fg = variable_colors[i] })
end

local variable_counter = 0

local variable_hl = setmetatable({}, {
  __index = function(table, varname)
    local id = vim.api.nvim_get_hl_id_by_name('@variable.' .. variable_counter)
    variable_counter = variable_counter + 1
    if variable_counter >= max_variable_colours then
      variable_counter = 0
    end

    rawset(table, varname, id)
    return id
  end,
})


vim.api.nvim_create_autocmd('LspTokenUpdate', {
  callback = function(args)
    local token = args.data.token
    if (token.type == "variable") or (token.type == "parameter") then
      local text = vim.api.nvim_buf_get_text(args.buf, token.line, token.start_col, token.line, token.end_col, {})
      if text[1] ~= nil then
        -- print(vim.inspect(text[1]) .. " - " .. token.type)
        -- local text = api.nvim_buf_get_text(args.buf, token.line, token.start_col, token.line, token.end_col, {})
        local hl = variable_hl[text[1]]
        -- local hl = rawget(variable_hl, text[1])
        -- print(hl)
        -- print(vim.inspect(args))
        -- print("AAA " .. vim.inspect(text[1]))
        if hl ~= nil then
          vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, hl, { priority = 150 })
        end
      end
    end
  end
})




require("codecompanion").setup({
  opts = {
    log_level = "INFO", -- TRACE|DEBUG|ERROR|INFO
    system_prompt = function(opts)
      return
      [[/nothink Be brief and succinct. Minimize prose. Use Markdown formatting in your answers. Include the programming language name at the start of the Markdown code blocks. Avoid including line numbers in code blocks. Use actual line breaks instead of '\n' in your response to begin new lines. Use '\n' only when you want a literal backslash followed by a character 'n'.]]
    end,
  },
  adapters = {
    qwen = function()
      return require("codecompanion.adapters").extend("ollama", {
        name = "qwen",
        schema = {
          model = {
            -- default = "qwen3:30b",
            -- default = "qwen3:14b",
            -- default = "qwen3:32b",
            default = "hf.co/unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:UD-Q4_K_XL",
            -- default = "qwen2.5-coder:32b",
          },
          num_ctx = {
            default = 10240,
            -- default = 8192,
          },
          num_predict = {
            default = -1,
          },
        },
      })
    end,
  },
  strategies = {
    chat = {
      adapter = "copilot",
      -- adapter = "qwen",
    },
    -- inline = {
    --   adapter = "qwen",
    -- },
    inline = {
      adapter = "copilot",
    },
    agent = {
      -- adapter = "qwen",
      adapter = "copilot",
    },
  },
})

-- map('n', '<leader>cc', '<cmd>CodeCompanion<CR>')
-- map('v', '<leader>cc', "<cmd>execute \"normal! :'<,'>CodeCompanion<CR>\"<CR>")

vim.keymap.set({ "n", "v" }, "<C-c>", "<cmd>CodeCompanionActions<cr>", { noremap = true, silent = true })
vim.keymap.set({ "n", "v" }, "<Leader>cc", "<cmd>CodeCompanionChat Toggle<cr>", { noremap = true, silent = true })
vim.keymap.set("v", "ga", "<cmd>CodeCompanionChat Add<cr>", { noremap = true, silent = true })

-- Expand 'cc' into 'CodeCompanion' in the command line
vim.cmd([[cab cc CodeCompanion]])

-- nnoremap <silent> <C-c> :CodeCompanionChat<CR>
-- vnoremap <silent> <C-c> :<C-u>execute "normal! :\'\<lt>,\'>CodeCompanion\<lt>CR>"<CR>

-- require('gen').prompts['Fix_Code'] = {
--   prompt = "Fix the following code. Only output the result in format ```$filetype\n...\n```:\n```$filetype\n$text\n```",
--   replace = true,
--   extract = "```$filetype\n(.-)```"
-- }
-- vim.keymap.set({ 'n', 'v' }, '<leader>ff', ':Gen<CR>')
-- vim.keymap.set({ 'n', 'v' }, '<leader>fa', ':Gen Ask<CR>')
-- vim.keymap.set({ 'n', 'v' }, '<leader>fs', ':Gen Fix_Code<CR>')





vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(args)
    local win_id = vim.api.nvim_get_current_win()
    -- local winhl = vim.api.nvim_get_option_value("winhl", { win = win_id })
    local cfg = vim.api.nvim_win_get_config(win_id)

    if cfg.relative ~= "" then
      vim.api.nvim_set_option_value("winhl",
        "RenderMarkdownCode:MyPopupCode,LineNr:MyPopupLineNr,Normal:MyPopupNormal,WordUnderCursor:MyPopupWordUnderCursor,RenderMarkdownH1Bg:MyPopupRenderMarkdownH1Bg,RenderMarkdownH2Bg:MyPopupRenderMarkdownH2Bg,RenderMarkdownH3Bg:MyPopupRenderMarkdownH3Bg,RenderMarkdownH4Bg:MyPopupRenderMarkdownH4Bg,RenderMarkdownH5Bg:MyPopupRenderMarkdownH5Bg,RenderMarkdownH6Bg:MyPopupRenderMarkdownH6Bg",
        { win = win_id })
      -- vim.api.nvim_set_option_value("winhl", "RenderMarkdownCode:MyPopupCode,Normal:MyPopupNormal", { win = win_id })
    end
  end
})
vim.cmd("highlight MyPopupCode guibg=#205070")
vim.cmd("highlight MyPopupNormal guibg=#106060")
vim.cmd("highlight MyPopupLineNr guibg=#106060")
vim.cmd("highlight MyPopupWordUnderCursor guibg=#406060")
vim.cmd("highlight MyPopupRenderMarkdownH1Bg guibg=#103030")
vim.cmd("highlight MyPopupRenderMarkdownH2Bg guibg=#307050")
vim.cmd("highlight MyPopupRenderMarkdownH3Bg guibg=#305070")
vim.cmd("highlight MyPopupRenderMarkdownH4Bg guibg=#305070")
vim.cmd("highlight MyPopupRenderMarkdownH5Bg guibg=#305070")
vim.cmd("highlight MyPopupRenderMarkdownH6Bg guibg=#305070")
