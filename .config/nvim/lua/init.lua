-------------------------------------------------------------------------------
-- These are example settings to use with nvim-metals and the nvim built in
-- LSP. Be sure to thoroughly read the the `:help nvim-metals` docs to get an
-- idea of what everything does.
--
-- The below configuration also makes use of the following plugins besides
-- nvim-metals, and therefore a bit opinionated:
--
-- - https://github.com/hrsh7th/nvim-compe
--    (needs hrsh7th/vim-vsnip) for snippet support
-- - https://github.com/wbthomason/packer.nvim for package management
-------------------------------------------------------------------------------
local cmd = vim.cmd
local g = vim.g

local function opt(scope, key, value)
  local scopes = {o = vim.o, b = vim.bo, w = vim.wo}
  scopes[scope][key] = value
  if scope ~= 'o' then
    scopes['o'][key] = value
  end
end

local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

----------------------------------
-- PLUGINS -----------------------
----------------------------------
cmd [[packadd packer.nvim]]
require('packer').startup(function(use)
  use {'wbthomason/packer.nvim'}

  -- use {'hrsh7th/nvim-compe', requires = {{'hrsh7th/vim-vsnip'}}}

  use({
    "hrsh7th/nvim-cmp",
    requires = {
      { "hrsh7th/vim-vsnip" },
      { "hrsh7th/cmp-nvim-lsp" },
      { "hrsh7th/cmp-vsnip" },
      { "hrsh7th/cmp-buffer" },
    },
  })

  -- use {'kevinhwang91/nvim-bqf'} -- buggy!

  use({ "liuchengxu/vista.vim" })
  use {'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" }}

  use { 'neovim/nvim-lspconfig' }
  use { 'onsails/lspkind-nvim' }
  use { 'RRethy/vim-illuminate' }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  use {
    'nvim-telescope/telescope.nvim',
    requires = { 'nvim-lua/plenary.nvim' }
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  use { 'akinsho/bufferline.nvim', tag = "*", requires = 'kyazdani42/nvim-web-devicons' }
  use { 'hoob3rt/lualine.nvim', requires = {'kyazdani42/nvim-web-devicons'} }
  use { 'kyazdani42/nvim-tree.lua', requires = {'kyazdani42/nvim-web-devicons'} }
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
  use 'nvim-lua/lsp-status.nvim'
  use 'folke/which-key.nvim'
  use 'sindrets/winshift.nvim'
  -- use 'mfussenegger/nvim-jdtls'

  use 'sheerun/vim-polyglot'
  -- use 'ggandor/leap.nvim'
  -- use 'vim-scripts/AnsiEsc.vim'
  use 'powerman/vim-plugin-AnsiEsc'

  use 'mfussenegger/nvim-dap'
  use {
    'MrcJkb/haskell-tools.nvim',
    requires = {
      'neovim/nvim-lspconfig',
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim', -- optional
    },
    -- tag = 'x.y.z' -- [^1]
    use {
      'm-demare/hlargs.nvim',
      requires = { 'nvim-treesitter/nvim-treesitter' }
    }
  }
  use { 'vigoux/ltex-ls.nvim', requires = 'neovim/nvim-lspconfig' }
  use {
    "folke/trouble.nvim",
    requires = "nvim-tree/nvim-web-devicons",
    config = function()
      require("trouble").setup {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
  use {
    'phaazon/hop.nvim',
    branch = 'v2', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  }

  use 'simrat39/rust-tools.nvim'
end)

-- require('leap').set_default_keymaps()

require('hlargs').setup()

require'lspconfig'.jdtls.setup{
  cmd = { 'sh', '-c', 'exec jdt-language-server -data ~/.jdt.workspace/$(pwd | md5sum | cut -d" " -f1)' }
}

require'nvim-web-devicons'.setup {
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
  default = true;
}

g['nvim_web_devicons'] = 1 -- temporary until nvim-tree removes check?

----------------------------------
-- VARIABLES ---------------------
----------------------------------
-- nvim-metals
g['metals_server_version'] = '0.11.12'

----------------------------------
-- OPTIONS -----------------------
----------------------------------
-- global
opt('o', 'completeopt', 'menuone,noinsert,noselect')
vim.o.shortmess = string.gsub(vim.o.shortmess, 'F', '') .. 'c'

-- nvim tree

g['nvim_tree_auto_ignore_ft'] = {} -- [ 'startify', 'dashboard' ] -- empty by default, don't auto open tree on specific filetypes.
g['nvim_tree_width_allow_resize']  = 1 -- 0 by default, will not resize the tree when opening a file
-- g['nvim_tree_add_trailing'] = 1 -- 0 by default, append a trailing slash to folder names
-- g['nvim_tree_group_empty'] = 1 --  0 by default, compact folders that only contain a single folder into one node in the file tree
-- g['nvim_tree_special_files'] = { 'README.md', 'Makefile', 'MAKEFILE' } --  List of filenames that gets highlighted with NvimTreeSpecialFile
-- g['nvim_tree_show_icons'] = { git = 1, folders = 1, files = 1 }

map('n', '<leader>tt', '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>tr', '<cmd>NvimTreeRefresh<CR>')
map('n', '<leader>tf', '<cmd>NvimTreeFindFile | NvimTreeFocus <CR>')


require'nvim-tree'.setup({
  actions = {
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
  -- open the tree when running this setup function
  open_on_setup       = false,
  -- will not open on setup if the filetype is in this list
  ignore_ft_on_setup  = {},
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
  diagnostics     = {
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
  system_open = {
    -- the command to run this, leaving nil should work in most cases
    cmd  = nil,
    -- the command arguments as a list
    args = {}
  },

  view = {
    -- width of the window, can be either a number (columns) or a string in `%`
    width = 40,
    -- side of the tree, can be one of 'left' | 'right' | 'top' | 'bottom'
    side = 'left',
    -- if true the tree will resize itself after opening a file
    -- auto_resize = false,
    mappings = {
      -- custom only false will merge the list with the default mappings
      -- if true, it will only use your list to set the mappings
      custom_only = false,
      -- list of mappings to set on the tree manually
      list = {}
    }
  },
  filters = {
    custom = { '^\\.git$', '^node_modules$', '^\\.cache$', '^target$', '^\\.tmp$', '^\\.gitignore$' },
    dotfiles = false
  },
  git = {
    enable = true,
    ignore = true,
    timeout = 500,
  },
  renderer = {
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
map('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>')
map('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('v', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
map('n', '<leader>a', '<cmd>TroubleToggle workspace_diagnostics<CR>')
map('n', '<leader>d', '<cmd>TroubleToggle document_diagnostics<CR>')
-- map('n', '<leader>a', '<cmd>lua vim.diagnostic.setqflist()<CR>')
-- map('n', '<leader>d', '<cmd>lua vim.diagnostic.setloclist()<CR>') -- buffer diagnostics only
map('n', '[e', '<cmd>lua vim.diagnostic.goto_prev { wrap = false, severity = vim.diagnostic.severity.ERROR }<CR>')
map('n', ']e', '<cmd>lua vim.diagnostic.goto_next { wrap = false, severity = vim.diagnostic.severity.ERROR }<CR>')
map('n', '[c', '<cmd>lua vim.diagnostic.goto_prev { wrap = false }<CR>')
map('n', ']c', '<cmd>lua vim.diagnostic.goto_next { wrap = false }<CR>')
map('n', '<leader>cv', '<cmd>Vista nvim_lsp<CR>')
map('n', '<leader>cc', '<cmd>Vista finder nvim_lsp<CR>')

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
    ["<Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      else
        fallback()
      end
    end,
    ["<S-Tab>"] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      else
        fallback()
      end
    end,
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
map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
-- map('i', '<CR>', 'compe#confirm("\\<CR>")', {expr = true})
-- map('i', '<C-Space>', 'compe#complete()', {expr = true})

----------------------------------
-- COMMANDS ----------------------
----------------------------------
-- LSP
cmd [[augroup lsp]]
cmd [[autocmd!]]
cmd [[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]]
cmd [[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(metals_config)]]
cmd [[autocmd FileType scala nnoremap <leader>cs  <cmd>lua require"metals".hover_worksheet()<CR>]]
cmd [[autocmd FileType scala nnoremap <leader>cl  <cmd>lua vim.lsp.codelens.run()<CR>]]
cmd [[autocmd FileType scala nnoremap <leader>sh  <cmd>lua vim.lsp.buf.signature_help()<CR>]]
cmd [[autocmd FileType scala nnoremap <leader>ae  <cmd>lua vim.diagnostic.setqflist({severity = "E"})<CR>]]
cmd [[autocmd FileType scala nnoremap <leader>aa  <cmd>lua vim.diagnostic.setqflist()<CR>]]
cmd [[autocmd FileType scala nnoremap <leader>aw  <cmd>lua vim.diagnostic.setqflist({severity = "W"})<CR>]]
cmd [[autocmd FileType scala nnoremap <leader>ad  <cmd>lua vim.diagnostic.setloclist()<CR>]]
cmd [[autocmd FileType scala nnoremap <leader>tm   <cmd>lua require("metals.tvp").toggle_tree_view()<CR>]]
cmd [[autocmd FileType scala nnoremap <leader>tg   <cmd>lua require("metals.tvp").reveal_in_tree()<CR>]]
cmd [[augroup end]]

-- Need for symbol highlights to work correctly
vim.cmd [[hi! link LspReferenceText CursorColumn]]
vim.cmd [[hi! link LspReferenceRead CursorColumn]]
vim.cmd [[hi! link LspReferenceWrite CursorColumn]]
----------------------------------
-- LSP Setup ---------------------
----------------------------------

local lsp_status = require('lsp-status')
lsp_status.register_progress()


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
  serverProperties = {
    "-XX:+UseG1GC", "-Xmx2g",
  }
}


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
      backend = "x11",
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

-- require'lspconfig'.jdtls.setup({
--   on_attach = lsp_status.on_attach,
--   capabilities = lsp_status.capabilities,
-- })

require('lspkind').init()

require('gitsigns').setup()

local custom_lualine_theme = require'lualine.themes.ayu_dark'
custom_lualine_theme.normal.c.bg = '#1c2326'

require'lualine'.setup {
  extensions = {'quickfix', 'nvim-tree', 'fzf'},
  sections = {
    lualine_c = {
        lsp_status.status,
        lsp_status.progress,
    }
  },
  options = {
    theme = custom_lualine_theme,
    disabled_filetypes = {'presenting_markdown'}
  },
}


require('bufferline').setup {
  options = {
    view = "default";
    numbers = "ordinal";
    max_name_length = 18;
    max_prefix_length = 15; -- prefix used when a buffer is de-duplicated
    tab_size = 18;
    diagnostics = "nvim_lsp";
    diagnostics_indicator = function(count, level, diagnostics_dict)
      return "("..count..")"
    end;
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
    end;
    offsets = {{filetype = "NvimTree", text = "File Explorer", text_align = "left"}};
    show_buffer_icons = true; -- disable filetype icons for buffers
    show_buffer_close_icons = false;
    show_close_icon = false;
    show_tab_indicators = true;
    persist_buffer_sort = true; -- whether or not custom sorted buffers should persist
    -- can also be a table containing 2 custom separators
    -- [focused and unfocused]. eg: { '|', '|' }
    separator_style = "slant";
    enforce_regular_tabs = false;
    always_show_bufferline = false;
    -- sort_by = 'extension' | 'relative_directory' | 'directory' | function(buffer_a, buffer_b)
    --   -- add custom logic
    --   return buffer_a.modified > buffer_b.modified
    -- end
  }
}


map('n', '<C-1>', '<cmd>lua require"bufferline".go_to_buffer(1)<CR>')
map('n', '<C-2>', '<cmd>lua require"bufferline".go_to_buffer(2)<CR>')


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
  }
}


-- treesitter

require'nvim-treesitter.configs'.setup {
  ensure_installed = require'nvim-treesitter.parsers'.available_parsers(),
  ignore_install = { 'markdown' }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { 'markdown' },  -- list of language that will be disabled
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


require'which-key'.register({
  ["<leader>"] = {
    ["1"] = "which_key_ignore",
    ["2"] = "which_key_ignore",
    ["3"] = "which_key_ignore",
    ["4"] = "which_key_ignore",
    ["5"] = "which_key_ignore",
    ["6"] = "which_key_ignore",
    ["7"] = "which_key_ignore",
    ["8"] = "which_key_ignore",
    ["9"] = "which_key_ignore",
    ["0"] = "which_key_ignore",
  }
})


require("winshift").setup({
  highlight_moving_win = true,  -- Highlight the window being moved
  focused_hl_group = "Visual",  -- The highlight group used for the moving window
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

-- Example mappings for usage with nvim-dap. If you don't use that, you can
-- skip these
map("n", "<leader>dc", [[<cmd>lua require"dap".continue()<CR>]])
map("n", "<leader>dr", [[<cmd>lua require"dap".repl.toggle()<CR>]])
map("n", "<leader>dK", [[<cmd>lua require"dap.ui.widgets".hover()<CR>]])
map("n", "<leader>dt", [[<cmd>lua require"dap".toggle_breakpoint()<CR>]])
map("n", "<leader>dso", [[<cmd>lua require"dap".step_over()<CR>]])
map("n", "<leader>dsi", [[<cmd>lua require"dap".step_into()<CR>]])
map("n", "<leader>dl", [[<cmd>lua require"dap".run_last()<CR>]])
map("n", "<leader>dx", [[<cmd>lua require"dap".run_to_cursor()<CR>]])
vim.keymap.set("n", "<leader>dz", function()
  local widgets = require('dap.ui.widgets')
  local my_sidebar = widgets.sidebar(widgets.frames)
  my_sidebar.open()
end, {desc = 'debugger frames'})
vim.keymap.set("n", "<leader>dy", function()
  local widgets = require('dap.ui.widgets')
  local my_sidebar = widgets.sidebar(widgets.scopes)
  my_sidebar.open()
end, {desc = 'debugger scopes'})


map("n", "<C-L>", [[10zl]])
map("n", "<C-H>", [[10zh]])



require'ltex-ls'.setup {
  use_spellfile = false, -- Uses the value of 'spellfile' as an external file when checking the document
  window_border = 'single', -- How the border should be rendered
  on_attach = on_attach,
  cmd = { "ltex-ls" },
  filetypes = { "markdown", "text", "latex", "tex", "bib" },
  flags = { debounce_text_changes = 300 },
  settings = {
    ltex = {
      enabled = { "latex", "tex", "bib", "markdown", },
      language = "en-GB",
      configurationTarget = {
            dictionary = "workspaceFolderExternalFile",
            disabledRules = "workspaceFolder",
            hiddenFalsePositives = "workspaceFolder",
      },
      disabledRules = {
        ["en-GB"] = {"OXFORD_SPELLING_Z_NOT_S", "PASSIVE_VOICE"},
      },
      enableRules = {
        ["en-GB"] = {"OXFORD_SPELLING_ISE_VERBS"},
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
            local fullpath = vim.fs.normalize(file, ":p")
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
            files['en-GB']:insert(1, ":"..vim.fn.getcwd() .. "/.ltex.dictionary.txt")
          else
            files['en-GB'] = {":"..vim.fn.getcwd().."/.ltex.dictionary.txt" }
          end
          -- print(vim.inspect(files))
          return files
        end)(),
    }
  }
}


-- haskell
local ht = require('haskell-tools')
local def_opts = { noremap = true, silent = true, }
ht.setup {
  hls = {
    -- See nvim-lspconfig's  suggested configuration for keymaps, etc.
    on_attach = function(client, bufnr)
      local opts = vim.tbl_extend('keep', def_opts, { buffer = bufnr, })
      -- haskell-language-server relies heavily on codeLenses,
      -- so auto-refresh (see advanced configuration) is enabled by default
      vim.keymap.set('n', '<space>ca', vim.lsp.codelens.run, opts)
      vim.keymap.set('n', '<space>hs', ht.hoogle.hoogle_signature, opts)
      -- default_on_attach(client, bufnr)  -- if defined, see nvim-lspconfig
    end,
  },
}
-- Suggested keymaps that do not depend on haskell-language-server
-- Toggle a GHCi repl for the current package
vim.keymap.set('n', '<leader>rr', ht.repl.toggle, def_opts)
-- Toggle a GHCi repl for the current buffer
vim.keymap.set('n', '<leader>rf', function()
  ht.repl.toggle(vim.api.nvim_buf_get_name(0))
end, def_opts)
vim.keymap.set('n', '<leader>rq', ht.repl.quit, def_opts)




local hop = require('hop')
hop.setup()
map('n', '<leader>ga', '<cmd>HopAnywhere<CR>')
map('n', '<leader>gw', '<cmd>HopWord<CR>')
map('n', '<C-x>', '<cmd>HopWord<CR>')
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

