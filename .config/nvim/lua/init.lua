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
  use {'wbthomason/packer.nvim', opt = true}

  use {'hrsh7th/nvim-compe', requires = {{'hrsh7th/vim-vsnip'}}}
  use 'scalameta/nvim-metals'

  use { 'neovim/nvim-lspconfig' }
  use { 'onsails/lspkind-nvim' }
  use { 'RRethy/vim-illuminate' }
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    }
  }
  use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
  -- use 'svalaskevicius/material.nvim' -- '/home/sarunas/priv/dev/material.nvim/' --'marko-cerovac/material.nvim'
  use 'marko-cerovac/material.nvim'
  use {
    'hoob3rt/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use {'akinsho/nvim-bufferline.lua', requires = 'kyazdani42/nvim-web-devicons'}
  -- TODO: nvim-tree
  use {
    'kyazdani42/nvim-tree.lua',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
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
  use {
    'nvim-lua/lsp-status.nvim'
  }
  use {
    "folke/which-key.nvim",
    config = function()
      require("which-key").setup {
        -- https://github.com/folke/which-key.nvim
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    end
  }
end)

----------------------------------
-- VARIABLES ---------------------
----------------------------------
-- nvim-metals
g['metals_server_version'] = '0.10.2+98-364a4481-SNAPSHOT'

----------------------------------
-- OPTIONS -----------------------
----------------------------------
-- global
opt('o', 'completeopt', 'menuone,noinsert,noselect')
vim.o.shortmess = string.gsub(vim.o.shortmess, 'F', '') .. 'c'

-- nvim tree

g['nvim_tree_side'] = 'left' -- left by default
g['nvim_tree_width'] = 40 -- 30 by default
g['nvim_tree_ignore'] = { '.git', 'node_modules', '.cache', 'target' } -- empty by default
g['nvim_tree_gitignore'] = 1 -- 0 by default
g['nvim_tree_auto_open'] = 0 -- 0 by default, opens the tree when typing `vim $DIR` or `vim`
g['nvim_tree_auto_close'] = 1 -- 0 by default, closes the tree when it's the last window
g['nvim_tree_auto_ignore_ft'] = {} -- [ 'startify', 'dashboard' ] -- empty by default, don't auto open tree on specific filetypes.
g['nvim_tree_quit_on_open'] = 0 -- 0 by default, closes the tree when you open a file
g['nvim_tree_follow'] = 0 -- 0 by default, this option allows the cursor to be updated when entering a buffer
g['nvim_tree_indent_markers'] = 1 -- 0 by default, this option shows indent markers when folders are open
g['nvim_tree_hide_dotfiles'] = 1 -- 0 by default, this option hides files and folders starting with a dot `.`
g['nvim_tree_git_hl'] = 1 -- 0 by default, will enable file highlight for git attributes (can be used without the icons).
g['nvim_tree_highlight_opened_files'] = 1 -- 0 by default, will enable folder and file icon highlight for opened files/directories.
g['nvim_tree_root_folder_modifier'] = ':~' -- This is the default. See :help filename-modifiers for more options
g['nvim_tree_tab_open'] = 0 -- 0 by default, will open the tree when entering a new tab and the tree was previously open
g['nvim_tree_width_allow_resize']  = 1 -- 0 by default, will not resize the tree when opening a file
g['nvim_tree_disable_netrw'] = 1 -- 1 by default, disables netrw
g['nvim_tree_hijack_netrw'] = 1 -- 1 by default, prevents netrw from automatically opening when opening directories (but lets you keep its other utilities)
g['nvim_tree_add_trailing'] = 1 -- 0 by default, append a trailing slash to folder names
g['nvim_tree_group_empty'] = 1 --  0 by default, compact folders that only contain a single folder into one node in the file tree
g['nvim_tree_lsp_diagnostics'] = 1 -- 0 by default, will show lsp diagnostics in the signcolumn. See :help nvim_tree_lsp_diagnostics
g['nvim_tree_disable_window_picker'] = 0 -- 0 by default, will disable the window picker.
g['nvim_tree_special_files'] = { 'README.md', 'Makefile', 'MAKEFILE' } --  List of filenames that gets highlighted with NvimTreeSpecialFile
g['nvim_tree_show_icons'] = { git = 1, folders = 1, files = 1 }

map('n', '<leader>tt', '<cmd>NvimTreeToggle<CR>')
map('n', '<leader>tr', '<cmd>NvimTreeRefresh<CR>')
map('n', '<leader>tf', '<cmd>NvimTreeFindFile<CR>')

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
map('n', '<leader>ws', '<cmd>lua require"metals".worksheet_hover()<CR>')
map('n', '<leader>a', '<cmd>lua require"metals".open_all_diagnostics()<CR>')
map('n', '<leader>d', '<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>') -- buffer diagnostics only
map('n', '[c', '<cmd>lua vim.lsp.diagnostic.goto_prev { wrap = false }<CR>')
map('n', ']c', '<cmd>lua vim.lsp.diagnostic.goto_next { wrap = false }<CR>')

-- completion
-- This is just copied from the docs, edit to your liking
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  incomplete_delay = 400;
  allow_prefix_unmatch = false;

  source = {
    path = true;
    buffer = true;
    calc = true;
    vsnip = true;
    nvim_lsp = true;
    nvim_lua = true;
    spell = true;
    tags = true;
    snippets_nvim = true;
  };
}

map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})
map('i', '<CR>', 'compe#confirm("\\<CR>")', {expr = true})
map('i', '<C-Space>', 'compe#complete()', {expr = true})

----------------------------------
-- COMMANDS ----------------------
----------------------------------
-- LSP
cmd [[augroup lsp]]
cmd [[autocmd!]]
cmd [[autocmd FileType scala setlocal omnifunc=v:lua.vim.lsp.omnifunc]]
cmd [[autocmd FileType scala,sbt lua require("metals").initialize_or_attach(metals_config)]]
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

-- local metals = require('metals')
--
-- metals.setup({
--   on_attach = lsp_status.on_attach,
--   capabilities = lsp_status.capabilities,
--   settings = {
--     showImplicitArguments = true,
--     excludedPackages = {'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl'}
--   },
-- })

metals_config = require'metals'.bare_config

-- Example of settings
metals_config.settings = {
  showImplicitArguments = true,
  excludedPackages = {'akka.actor.typed.javadsl', 'com.github.swagger.akka.javadsl'}
}

-- Example of how to ovewrite a handler
metals_config.handlers['textDocument/publishDiagnostics'] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {virtual_text = {prefix = ''}})

-- Example if you are including snippets
-- local capabilities = vim.lsp.protocol.make_client_capabilities()
local capabilities = lsp_status.capabilities
capabilities.textDocument.completion.completionItem.snippetSupport = true
metals_config.capabilities = capabilities

metals_config.on_attach = lsp_status.on_attach


require'lspconfig'.rust_analyzer.setup({
  on_attach = lsp_status.on_attach,
  capabilities = lsp_status.capabilities,
})

require('lspkind').init()

require('gitsigns').setup()

require'lualine'.setup {
  extensions = {'quickfix', 'nvim-tree', 'fzf'},
  theme = 'material-nvim',
  sections = {lualine_c = {lsp_status.status, lsp_status.progress }},
} 


require('bufferline').setup {
  options = {
    view = "default";
    numbers = "ordinal";
    number_style = "superscript"; -- buffer_id at index 1, ordinal at index 2
    mappings = true;
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



require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = { }, -- List of parsers to ignore installing
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = {  },  -- list of language that will be disabled
  },
  indent = {
    enable = true
  }
}




-- Theme
-- https://github.com/marko-cerovac/material.nvim/blob/pure-lua/lua/material/colors.lua
vim.g.material_style = 'darker' -- 'deep ocean'
vim.g.material_custom_colors = { bg = "#1A1A1A" , bg_alt = "#0A0A0A", contrast = "#0A0A0A", yellow = '#EFBB5B', } 
vim.g.material_italic_comments = true
vim.g.material_italic_keywords = true
vim.g.material_italic_functions = true
vim.g.material_italic_variables = false
vim.g.material_contrast = true
vim.g.material_borders = true
vim.g.material_disable_background = false
vim.g.material_variable_color = '#60ABA5'

vim.api.nvim_set_keymap('n', '<F11>', [[<Cmd>lua require('material.functions').toggle_style()<CR>]], { noremap = true, silent = true })

-- Load the colorscheme
require('material').set()




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
