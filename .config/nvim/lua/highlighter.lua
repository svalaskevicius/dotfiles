--
-- BASED ON https://github.com/neovim/neovim/blob/master/runtime/lua/vim/treesitter/highlighter.lua
--
local api = vim.api
local query = vim.treesitter.query
local Range = require('vim.treesitter._range')

---@alias TSHlIter fun(end_line: integer|nil): integer, TSNode, TSMetadata

---@class TSHighlightState
---@field next_row integer
---@field iter TSHlIter|nil

---@class TSHighlighter
---@field active table<integer,TSHighlighter>
---@field bufnr integer
---@field orig_spelloptions string
---@field _highlight_states table<TSTree,TSHighlightState>
---@field _queries table<string,TSHighlighterQuery>
---@field tree LanguageTree
---@field redraw_count integer
local TSHighlighter = {} -- rawget(vim.treesitter, 'TSHighlighter') or {}
TSHighlighter.__index = TSHighlighter

--- @nodoc
TSHighlighter.active = TSHighlighter.active or {}
TSHighlighter.variable_colors = {"#9CD8F7", "#F5FA1D", "#F97C65", "#35D27F", "#EB75D6", "#E5D180", "#8997F5", "#D49DA5", "#7FEC35", "#F6B223", "#B4F1C3", "#99B730", "#F67C1B", "#3AC6BE", "#EAAFF1", "#DE9A4E", "#BBEA87", "#EEF06D", "#8FB272", "#EAA481", "#F58AAE", "#80B09B", "#5DE866", "#B5A5C5", "#88ADE6", "#4DAABD", "#EDD528", "#FA6BB2", "#47F2D4", "#F47F86", "#2ED8FF", "#B8E01C", "#C5A127", "#74BB46", "#D386F1", "#97DFD6", "#B1A96F", "#66BB75", "#97AA49", "#EF874A", "#48EDF0", "#C0AE50", "#89AAB6", "#D7D1EB", "#5EB894", "#57F0AC", "#B5AF1B", "#B7A5F0", "#8BE289", "#D38AC6", "#C8EE63", "#ED9C36", "#85BA5F", "#9DEA74", "#85C52D", "#40B7E5", "#EEA3C2", "#7CE9B6", "#8CEC58", "#D8A66C", "#51C03B", "#C4CE64", "#45E648", "#4DC15E", "#63A5F3", "#EA8C66", "#D2D43E", "#E5BCE8", "#E4B7CB", "#B092F4", "#44C58C", "#D1E998", "#76E4F2", "#E19392", "#A8E5A4", "#BF9FD6", "#E8C25B", "#58F596", "#6BAEAC", "#94C291", "#7EF1DB", "#E8D65C", "#A7EA38", "#D38AE0", "#ECF453", "#5CD8B8", "#B6BF6B", "#BEE1F1", "#B1D43E", "#EBE77B", "#84A5CD", "#CFEF7A", "#A3C557", "#E4BB34", "#ECB151", "#BDC9F2", "#5EB0E9", "#E09764", "#9BE3C8", "#B3ADDC", "#B2AC36", "#C8CD4F", "#C797AF", "#DCDB26", "#BCA85E", "#E495A5", "#F37DB8", "#70C0B1", "#5AED7D", "#E49482", "#8AA1F0", "#B3EDEE", "#DAEE34", "#EBD646", "#ECA2D2", "#A0A7E6", "#3EBFD3", "#C098BF", "#F1882E", "#77BFDF", "#7FBFC7", "#D4951F", "#A5C0D0", "#B892DE", "#F8CB31", "#75D0D9", "#A6A0B4", "#EA98E4", "#F38BE6", "#DC83A4"}
TSHighlighter.max_variable_colours = #(TSHighlighter.variable_colors)

---@class TSHighlighterQuery
---@field _query Query|nil
---@field hl_cache table<integer,integer>
local TSHighlighterQuery = {}
TSHighlighterQuery.__index = TSHighlighterQuery

local ns = api.nvim_create_namespace('sval/highlighter')

for i = 0,TSHighlighter.max_variable_colours-1
do
  api.nvim_set_hl(0, '@variable.'..i, {fg = TSHighlighter.variable_colors[i]})
end

local variable_counter = 0

local variable_hl = setmetatable({}, {
  __index = function(table, varname)
    local id = api.nvim_get_hl_id_by_name('@variable.' .. variable_counter)
    variable_counter = variable_counter + 1
    if variable_counter >= TSHighlighter.max_variable_colours then
      variable_counter = 0
    end

    rawset(table, varname, id)
    return id
  end,
})

---@private
function TSHighlighterQuery.new(lang, query_string)
  local self = setmetatable({}, { __index = TSHighlighterQuery })

  self.is_variable = setmetatable({}, {
    __index = function(table, capture)
      local name = self._query.captures[capture]
      local ans = 0
      if name == "variable" then
        ans = 1
      end

      rawset(table, capture, ans)
      return ans
    end,
  })


  self.hl_cache = setmetatable({}, {
    __index = function(table, capture)
      local name = self._query.captures[capture]
      local id = 0
      if not vim.startswith(name, '_') then
        id = api.nvim_get_hl_id_by_name('@' .. name .. '.' .. lang)
      end

      rawset(table, capture, id)
      return id
    end,
  })



  if query_string then
    self._query = query.parse(lang, query_string)
  else
    self._query = query.get(lang, 'highlights')
  end

  return self
end

---@package
function TSHighlighterQuery:query()
  return self._query
end

---@package
---
--- Creates a highlighter for `tree`.
---
---@param tree LanguageTree parser object to use for highlighting
---@param opts (table|nil) Configuration of the highlighter:
---           - queries table overwrite queries used by the highlighter
---@return TSHighlighter Created highlighter object
function TSHighlighter.new(tree, opts)
  local self = setmetatable({}, TSHighlighter)

  if type(tree:source()) ~= 'number' then
    error('TSHighlighter can not be used with a string parser source.')
  end

  opts = opts or {} ---@type { queries: table<string,string> }
  self.tree = tree
  tree:register_cbs({
    on_bytes = function(...)
      self:on_bytes(...)
    end,
    on_detach = function()
      self:on_detach()
    end,
  })

  tree:register_cbs({
    on_changedtree = function(...)
      self:on_changedtree(...)
    end,
    on_child_removed = function(child)
      child:for_each_tree(function(t)
        self:on_changedtree(t:included_ranges(true))
      end)
    end,
  }, true)

  local source = tree:source()
  assert(type(source) == 'number')

  self.bufnr = source
  self.edit_count = 0
  self.redraw_count = 0
  self.line_count = {}
  -- A map of highlight states.
  -- This state is kept during rendering across each line update.
  self._highlight_states = {}

  ---@type table<string,TSHighlighterQuery>
  self._queries = {}

  -- Queries for a specific language can be overridden by a custom
  -- string query... if one is not provided it will be looked up by file.
  if opts.queries then
    for lang, query_string in pairs(opts.queries) do
      self._queries[lang] = TSHighlighterQuery.new(lang, query_string)
    end
  end

  self.orig_spelloptions = vim.bo[self.bufnr].spelloptions

  vim.bo[self.bufnr].syntax = ''
  vim.b[self.bufnr].ts_highlight = true

  TSHighlighter.active[self.bufnr] = self

  -- Tricky: if syntax hasn't been enabled, we need to reload color scheme
  -- but use synload.vim rather than syntax.vim to not enable
  -- syntax FileType autocmds. Later on we should integrate with the
  -- `:syntax` and `set syntax=...` machinery properly.
  if vim.g.syntax_on ~= 1 then
    vim.cmd.runtime({ 'syntax/synload.vim', bang = true })
  end

  api.nvim_buf_call(self.bufnr, function()
    vim.opt_local.spelloptions:append('noplainbuffer')
  end)

  self.tree:parse()

  return self
end

--- @nodoc
--- Removes all internal references to the highlighter
function TSHighlighter:destroy()
  if TSHighlighter.active[self.bufnr] then
    TSHighlighter.active[self.bufnr] = nil
  end

  if api.nvim_buf_is_loaded(self.bufnr) then
    vim.bo[self.bufnr].spelloptions = self.orig_spelloptions
    vim.b[self.bufnr].ts_highlight = nil
    if vim.g.syntax_on == 1 then
      api.nvim_exec_autocmds('FileType', { group = 'syntaxset', buffer = self.bufnr })
    end
  end
end

---@package
---@param tstree TSTree
---@return TSHighlightState
function TSHighlighter:get_highlight_state(tstree)
  if not self._highlight_states[tstree] then
    self._highlight_states[tstree] = {
      next_row = 0,
      iter = nil,
    }
  end

  return self._highlight_states[tstree]
end

---@private
function TSHighlighter:reset_highlight_state()
  self._highlight_states = {}
end

---@package
---@param start_row integer
---@param new_end integer
function TSHighlighter:on_bytes(_, _, start_row, _, _, _, _, _, new_end)
--  api.nvim__buf_redraw_range(self.bufnr, start_row, start_row + new_end + 1)
	api.nvim__redraw({ buf = self.bufnr, range = { start_row, start_row + new_end + 1 } })
end

---@package
function TSHighlighter:on_detach()
  self:destroy()
end

---@package
---@param changes Range6[]
function TSHighlighter:on_changedtree(changes)
  for _, ch in ipairs(changes) do
    -- api.nvim__buf_redraw_range(self.bufnr, ch[1], ch[4] + 1)
    api.nvim__redraw({ buf = self.bufnr, range = { ch[1], ch[4] + 1 } })
  end
end

--- Gets the query used for @param lang
---@package
---@param lang string Language used by the highlighter.
---@return TSHighlighterQuery
function TSHighlighter:get_query(lang)
  if not self._queries[lang] then
    local q;
    -- vim.print(lang)
    -- vim.print(xpcall(function()
    --   q = TSHighlighterQuery.new(lang)
    -- end, function(e)
      q = { query = function() return false end }
    -- end))
    -- vim.print(q)
    self._queries[lang] = q
  end

  return self._queries[lang]
end

---@param self TSHighlighter
---@param buf integer
---@param line integer
---@param is_spell_nav boolean
local function on_line_impl(self, buf, line, is_spell_nav)
  self.tree:for_each_tree(function(tstree, tree)
    if not tstree then
      return
    end

    local root_node = tstree:root()
    local root_start_row, _, root_end_row, _ = root_node:range()

    -- Only worry about trees within the line range
    if root_start_row > line or root_end_row < line then
      return
    end

    local state = self:get_highlight_state(tstree)
    local highlighter_query = self:get_query(tree:lang())

    -- Some injected languages may not have highlight queries.
    if not highlighter_query:query() then
      return
    end

    if state.iter == nil or state.next_row < line then
      state.iter =
        highlighter_query:query():iter_captures(root_node, self.bufnr, line, root_end_row + 1)
    end

    while line >= state.next_row do
      local capture, node, metadata = state.iter(line)

      local range = { root_end_row + 1, 0, root_end_row + 1, 0 }
      if node then
        range = vim.treesitter.get_range(node, buf, metadata and metadata[capture])
      end
      local start_row, start_col, end_row, end_col = Range.unpack4(range)

      if capture then
        local hl = 0
        -- print(vim.treesitter.get_node_text(node, self.bufnr ) .. " " .. highlighter_query._query.captures[capture])
        if highlighter_query.is_variable[capture] == 1 then
          hl = variable_hl[vim.treesitter.get_node_text(node, self.bufnr )]
          api.nvim_buf_set_extmark(buf, ns, start_row, start_col, {
            end_line = end_row,
            end_col = end_col,
            hl_group = hl,
            ephemeral = true,
            priority = 150,
            conceal = metadata.conceal,
            spell = true,
          })
        end
      end

      if start_row > line then
        state.next_row = start_row
      end
    end
  end)
end

---@private
---@param _win integer
---@param buf integer
---@param line integer
function TSHighlighter._on_line(_, _win, buf, line, _)
  local self = TSHighlighter.active[buf]
  if not self then
    return
  end

  on_line_impl(self, buf, line, false)
end

---@private
---@param buf integer
---@param srow integer
---@param erow integer
function TSHighlighter._on_spell_nav(_, _, buf, srow, _, erow, _)
  local self = TSHighlighter.active[buf]
  if not self then
    return
  end

  self:reset_highlight_state()

  for row = srow, erow do
    on_line_impl(self, buf, row, true)
  end
end

---@private
---@param _win integer
---@param buf integer
---@param topline integer
---@param botline integer
function TSHighlighter._on_win(_, _win, buf, topline, botline)
  local self = TSHighlighter.active[buf]
  if not self then
    return false
  end
  self.tree:parse({ topline, botline + 1 })
  self:reset_highlight_state()
  self.redraw_count = self.redraw_count + 1
  return true
end

api.nvim_set_decoration_provider(ns, {
  on_win = TSHighlighter._on_win,
  on_line = TSHighlighter._on_line,
  _on_spell_nav = TSHighlighter._on_spell_nav,
})


vim.api.nvim_create_autocmd( 'LspTokenUpdate', {
    callback = function(args)
      local token = args.data.token
      if (token.type == "variable") or (token.type == "parameter") then
        local text = api.nvim_buf_get_text(args.buf, token.line, token.start_col, token.line, token.end_col, {})
        if text[1] ~= nil then
      -- print(vim.inspect(text[1]) .. " - " .. token.type)
          -- local text = api.nvim_buf_get_text(args.buf, token.line, token.start_col, token.line, token.end_col, {})
          local hl = variable_hl[text[1]]
          -- local hl = rawget(variable_hl, text[1])
          -- print(hl)
          -- print(vim.inspect(args))
          -- print("AAA " .. vim.inspect(text[1]))
          if hl ~= nil then
            vim.lsp.semantic_tokens.highlight_token(token, args.buf, args.data.client_id, hl, {priority = 150})
          end
        end
      end
    end
})

return TSHighlighter
