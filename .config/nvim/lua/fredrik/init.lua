-- debugging of config;
-- 1. start neovim: nvim --cmd "lua init_debug=true" (starts server)
-- 2. start another neovim instance normally, set break points
-- 3. run require("dap").continue() (<leader>dc)
--
---@diagnostic disable-next-line: undefined-global
if init_debug then
  local osvpath = vim.fn.stdpath("data") .. "/lazy/one-small-step-for-vimkind"
  vim.opt.rtp:prepend(osvpath)
  require("osv").launch({ port = 8086, blocking = true })
end

-- set up backwards compatibility
require("fredrik.utils.version").setup_backwards_compat()

-- set options
require("fredrik.config.options")

-- set auto commands
require("fredrik.config.autocmds")

-- setup up plugin manager, load plugin configs
require("fredrik.config.lazy")

vim.cmd("colorscheme retrobox")

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


local set_hl = vim.api.nvim_set_hl
set_hl(0, 'Normal', { bg = '#151515' })
set_hl(0, 'NormalFloat', { bg = '#052a30' })
set_hl(0, 'FloatBorder', { bg = '#052a30' })
set_hl(0, 'FloatTitle', { bg = '#052a30' })
set_hl(0, 'FloatFooter', { bg = '#052a30' })
set_hl(0, 'FloatCursorLine', { bg = '#204040' })
-- set_hl(0, 'Pmenu', { bg = '#1b2222' })
-- set_hl(0, 'PmenuSel', { bg = '#7b8552' })
set_hl(0, 'WordUnderCursor', { bg = '#1f1f09' })
-- set_hl(0, 'NvimTreeIndentMarker', { fg = '#435C41' })
-- set_hl(0, 'NvimTreeRootFolder', { bold = true, fg = '#aacccc' })
set_hl(0, 'CursorLine', { bg = '#1c1c1c' })
set_hl(0, 'VertSplit', { fg = '#404040', bg = 'NONE', bold = false })
-- set_hl(0, 'LspCodeLens', { fg = '#205050' })

-- set_hl(0, 'lualine_c_normal', { bg = '#505050' })
-- local baleia = require('baleia').setup {}
-- vim.api.nvim_create_user_command('BaleiaColorize', function()
--   baleia.once(vim.api.nvim_get_current_buf())
-- end, {})

set_hl(0, 'Function', { cterm = {}, ctermfg = 142, fg = '#b8bb26' })
set_hl(0, 'Structure', { cterm = { bold = true }, ctermfg = 107, fg = '#8ec07c' })
vim.api.nvim_set_hl(0, '@lsp.type.namespace.scala', { link = 'Identifier' })




---------------------------------

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function(args)
    local win_id = vim.api.nvim_get_current_win()
    -- local winhl = vim.api.nvim_get_option_value("winhl", { win = win_id })
    local cfg = vim.api.nvim_win_get_config(win_id)

    if cfg.relative ~= "" then
      vim.api.nvim_set_option_value("winhl",
        "RenderMarkdownCode:MyPopupCode,RenderMarkdownCodeInline:MyPopupCodeInline,RenderMarkdownCodeBorder:MyPopupCodeBorder,RenderMarkdownInlineHighlight:MyPopupInlineHighlight,LineNr:MyPopupLineNr,Normal:MyPopupNormal,WordUnderCursor:MyPopupWordUnderCursor,RenderMarkdownH1Bg:MyPopupRenderMarkdownH1Bg,RenderMarkdownH2Bg:MyPopupRenderMarkdownH2Bg,RenderMarkdownH3Bg:MyPopupRenderMarkdownH3Bg,RenderMarkdownH4Bg:MyPopupRenderMarkdownH4Bg,RenderMarkdownH5Bg:MyPopupRenderMarkdownH5Bg,RenderMarkdownH6Bg:MyPopupRenderMarkdownH6Bg",
        { win = win_id })
      -- vim.api.nvim_set_option_value("winhl", "RenderMarkdownCode:MyPopupCode,Normal:MyPopupNormal", { win = win_id })
    end
  end
})
vim.cmd("highlight MyPopupCode guibg=#205070")
vim.cmd("highlight MyPopupCodeBorder guibg=#205070 guifg=#703020")
vim.cmd("highlight MyPopupCodeInline guibg=#053030")
vim.cmd("highlight MyPopupInlineHighlight guibg=#053030")
vim.cmd("highlight MyPopupNormal guibg=#052020")
vim.cmd("highlight MyPopupLineNr guibg=#052020")
vim.cmd("highlight MyPopupWordUnderCursor guibg=#406060")
vim.cmd("highlight MyPopupRenderMarkdownH1Bg guibg=#103030")
vim.cmd("highlight MyPopupRenderMarkdownH2Bg guibg=#307050")
vim.cmd("highlight MyPopupRenderMarkdownH3Bg guibg=#305070")
vim.cmd("highlight MyPopupRenderMarkdownH4Bg guibg=#305070")
vim.cmd("highlight MyPopupRenderMarkdownH5Bg guibg=#305070")
vim.cmd("highlight MyPopupRenderMarkdownH6Bg guibg=#305070")

--------------------------------
-- Define command :HiPick
vim.api.nvim_create_user_command("HiPick", function()
  print("Click somewhere to inspect highlight…")

  -- temporary key listener
  local listener
  listener = vim.on_key(function(key)
    -- left mouse click is "<LeftMouse>"
    if key == vim.keycode("<LeftMouse>") then
      local m = vim.fn.getmousepos()
      print(vim.inspect(m))
      local synid = vim.fn.synIDtrans(vim.fn.screenattr(m.screenrow, m.screencol))
      local group = vim.fn.synIDattr(synid, "name")

      if group ~= "" then
        vim.cmd("highlight " .. group)
      else
        print("No highlight at clicked position")
      end

      -- unregister listener
      vim.on_key(nil, listener)
    end
  end, vim.api.nvim_get_current_buf())
end, { desc = "Click to inspect highlight group" })



-----------------------


vim.api.nvim_create_user_command("FloatsList", function()
  local floats = {}
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local cfg = vim.api.nvim_win_get_config(win)
    if cfg.relative ~= "" then
      local buf = vim.api.nvim_win_get_buf(win)
      local name = vim.api.nvim_buf_get_name(buf)
      local ft = vim.bo[buf].filetype
      local bt = vim.bo[buf].buftype
      local lines = vim.api.nvim_buf_get_lines(buf, 0, 3, false) -- preview first 3 lines

      table.insert(floats, {
        win = win,
        buf = buf,
        name = name ~= "" and name or "[No Name]",
        filetype = ft,
        buftype = bt,
        focusable = cfg.focusable,
        zindex = cfg.zindex,
        relative = cfg.relative,
        row = cfg.row,
        col = cfg.col,
        width = cfg.width,
        height = cfg.height,
        border = cfg.border,
        preview = table.concat(lines, " "),
      })
    end
  end

  -- open scratch buffer
  vim.cmd("botright new")
  local out_buf = vim.api.nvim_get_current_buf()
  vim.bo[out_buf].buftype = "nofile"
  vim.bo[out_buf].bufhidden = "wipe"
  vim.bo[out_buf].swapfile = false
  vim.bo[out_buf].modifiable = true

  if vim.tbl_isempty(floats) then
    vim.api.nvim_buf_set_lines(out_buf, 0, -1, false, { "No floating windows found" })
  else
    local lines = {}
    for _, f in ipairs(floats) do
      table.insert(lines, string.rep("=", 50))
      table.insert(lines, ("Win: %d | Buf: %d"):format(f.win, f.buf))
      table.insert(lines, ("Name: %s"):format(f.name))
      table.insert(lines, ("Filetype: %s | Buftype: %s"):format(f.filetype, f.buftype))
      table.insert(lines, ("Focusable: %s | Zindex: %s"):format(tostring(f.focusable), tostring(f.zindex)))
      table.insert(lines, ("Pos: row=%s col=%s | size=%dx%d"):format(f.row, f.col, f.width, f.height))
      table.insert(lines, ("Border: %s"):format(vim.inspect(f.border)))
      table.insert(lines, ("Preview: %s"):format(f.preview))
    end
    vim.api.nvim_buf_set_lines(out_buf, 0, -1, false, lines)
  end

  vim.bo[out_buf].modifiable = false
end, { desc = "List current floating windows in scratch buffer" })

vim.cmd("hi TreesitterContext guibg=#052010")
vim.cmd("hi TreesitterContextLineNumber guibg=#051010")
vim.cmd("hi TreesitterContextBottom gui=underline guisp=#205040")
vim.cmd("hi TreesitterContextLineNumberBottom gui=underline guisp=#205040")








------


vim.keymap.set('n', '<leader>yop',
  function()
    local current_buffer = vim.api.nvim_get_current_buf()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled({ bufnr = current_buffer }), { bufnr = current_buffer })
  end,
  { noremap = true }
)


------

vim.cmd("nnoremap <C-M-Left> <C-O>")
vim.cmd("nnoremap <C-M-Right> <C-I>")
vim.cmd("inoremap <C-M-Left> <ESC><C-O>a")
vim.cmd("inoremap <C-M-Right> <ESC><C-I>a")

