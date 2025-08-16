return {

  {
    'kyazdani42/nvim-tree.lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    lazy = true,
    init = function()
      vim.g.nvim_tree_auto_ignore_ft     = {} -- [ 'startify', 'dashboard' ] -- empty by default, don't auto open tree on specific filetypes.
      vim.g.nvim_tree_width_allow_resize = 1  -- 0 by default, will not resize the tree when opening a file
      -- g['nvim_tree_add_trailing'] = 1 -- 0 by default, append a trailing slash to folder names
      -- g['nvim_tree_group_empty'] = 1 --  0 by default, compact folders that only contain a single folder into one node in the file tree
      -- g['nvim_tree_special_files'] = { 'README.md', 'Makefile', 'MAKEFILE' } --  List of filenames that gets highlighted with NvimTreeSpecialFile
      -- g['nvim_tree_show_icons'] = { git = 1, folders = 1, files = 1 }
    end,
    cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFindFile", "NvimTreeFocus" },
    keys = function() return require("fredrik.config.keymaps").setup_nvimtree_keymaps() end,

    config = function()
      require("nvim-tree").setup({
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
    end
  }
}
