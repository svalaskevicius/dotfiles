local function macro_recording()
  local reg = vim.fn.reg_recording()
  if reg == "" then
    return ""
  else
    return "Recording @" .. reg
  end
end

local function folder()
  local cwd = vim.fn.getcwd()
  local foldername = cwd:match("([^/]+)$")
  return foldername
end

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = {
    -- "zbirenbaum/copilot.lua",
  },
  opts = {

    -- see copilot.lua...
    -- copilot = {
    --   lualine_component = "filename",
    -- },
    --
    -- see debug.lua...
    -- dap_status = {
    --  lualine_component = "filename",
    --  },
    --
    -- see noice.lua...
    -- noice = {
    --   lualine_component = "filename",
    -- },

    options = {
      theme = "auto",
      component_separators = { left = "", right = "" },
      section_separators = { left = "", right = "" },
      globalstatus = true,
      disabled_filetypes = {},
    },

    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        {
          "branch",
          fmt = function(str)
            local slash_index = str:find("/")
            if slash_index then
              return str:sub(1, slash_index) .. "..."
            elseif #str > 12 then
              return str:sub(1, 9) .. "..."
            else
              return str
            end
          end,
        },
        "diagnostics",
      },
      lualine_c = {
        { folder,     color = { gui = "bold" }, separator = "/",                  padding = { left = 1, right = 0 } },
        { "filename", path = 1,                 padding = { left = 0, right = 1 } },
      },
      lualine_x = {
        -- {
        --   require 'minuet.lualine',
        --   -- the follwing is the default configuration
        --   -- the name displayed in the lualine. Set to "provider", "model" or "both"
        --   display_name = 'model',
        --   -- separator between provider and model name for option "both"
        --   provider_model_separator = ':',
        --   -- whether show display_name when no completion requests are active
        --   display_on_idle = false,
        -- },
        macro_recording,
        "encoding",
        "filetype"
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },

    extensions = { "lazy", "man", "quickfix" },
  },
  opts_extend = {
    "options.disabled_filetypes",
    "sections.extensions",
  },
  config = function(_, opts)
    -- TODO: make more generic insertion function which can insert anywhere.
    -- if opts.copilot then
    --   table.insert(opts.sections.lualine_x, 1, opts.copilot.lualine_component)
    -- else
    --   vim.notify("Lualine: copilot component not loaded", vim.log.levels.WARN)
    -- end

    if opts.dap_status then
      table.insert(opts.sections.lualine_x, 2, opts.dap_status.lualine_component)
    else
      vim.notify("Lualine: dap_status component not loaded", vim.log.levels.WARN)
    end

    if opts.noice then
      table.insert(opts.sections.lualine_x, 3, opts.noice.lualine_component)
    else
      vim.notify("Lualine: noice component not loaded", vim.log.levels.WARN)
    end

    if opts.mcphub then
      table.insert(opts.sections.lualine_x, 4, opts.mcphub.lualine_component)
    else
      -- vim.notify("Lualine: mcphub component not loaded", vim.log.levels.DEBUG)
    end

    require("lualine").setup(opts)
  end,
}
