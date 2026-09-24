local tab_buffers = {}

local function current_tab()
  return vim.api.nvim_get_current_tabpage()
end

local function add_buffer(bufnr, tab)
  if vim.api.nvim_buf_is_valid(bufnr) then
    tab_buffers[tab] = tab_buffers[tab] or {}
    tab_buffers[tab][bufnr] = true
  end
end

local function cleanup_tab(tab)
  local buffers = tab_buffers[tab]

  if not buffers then
    return
  end

  for bufnr in pairs(buffers) do
    if not vim.api.nvim_buf_is_valid(bufnr) then
      buffers[bufnr] = nil
    end
  end
end

-- Autocmds
vim.api.nvim_create_autocmd("BufEnter", {
  callback = function(args)
    add_buffer(args.buf, current_tab())
  end,
})

vim.api.nvim_create_autocmd("BufDelete", {
  callback = function(args)
    for _, buffers in pairs(tab_buffers) do
      buffers[args.buf] = nil
    end
  end,
})

vim.api.nvim_create_autocmd("TabNew", {
  callback = function()
    local tab = current_tab()

    vim.schedule(function()
      if not vim.api.nvim_tabpage_is_valid(tab) then
        return
      end

      for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
        add_buffer(vim.api.nvim_win_get_buf(win), tab)
      end
    end)
  end,
})

vim.api.nvim_create_autocmd("TabClosed", {
  callback = function(args)
    tab_buffers[tonumber(args.file)] = nil
  end,
})

return {

  {
    "akinsho/bufferline.nvim",
    lazy = true,
    event = "VeryLazy",
    opts = {
      options = {
        -- mode = "tabs", -- only show tabpages instead of buffers
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
        custom_filter = function(bufnr)
          if vim.bo[bufnr].filetype == "qf" then
            return false
          end

          local tab = current_tab()
          cleanup_tab(tab)

          return tab_buffers[tab] and tab_buffers[tab][bufnr] == true
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
      },
    },
  },
}
