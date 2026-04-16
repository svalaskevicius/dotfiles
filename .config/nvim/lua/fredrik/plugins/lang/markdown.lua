-- Fix conceallevel for markdown files
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   group = vim.api.nvim_create_augroup("markdown_conceal", { clear = true }),
--   pattern = { "markdown" },
--   callback = function()
--     vim.opt_local.wrap = true
--     vim.opt_local.conceallevel = 2
--   end,
-- })

return {
  {
    "stevearc/conform.nvim",
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "prettier", "mdformat", "markdown-toc" })
        end,
      },
    },
    opts = {
      formatters_by_ft = {
        markdown = { "prettier" },
      },
      formatters = {
        prettier = {
          -- https://prettier.io/docs/en/options.html
          prepend_args = { "--prose-wrap", "always", "--print-width", "80", "--tab-width", "2" },
        },
        mdformat = {
          -- https://github.com/einride/sage/blob/master/tools/sgmdformat/tools.go
          prepend_args = { "--number", "--wrap", "80" },
        },
      },
    },
  },

  {
    "mfussenegger/nvim-lint",
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "markdownlint" })
        end,
      },
    },
    opts = {
      linters_by_ft = {
        markdown = { "markdownlint" },
      },
      linters = {
        markdownlint = {
          args = {
            "--config", vim.fn.expand("~/.markdownlint.json"),
            "--stdin",
          },
        },
      },
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    lazy = true,
    ft = { "markdown" },
    -- build = function()
    --   vim.fn["mkdp#util#install"]()
    -- end,
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
  },

  -- {
  --   "MeanderingProgrammer/render-markdown.nvim",
  --   lazy = true,
  --   ft = { "markdown" },
  --   dependencies = {
  --     "nvim-treesitter/nvim-treesitter",
  --     "echasnovski/mini.icons",
  --     {
  --       "saghen/blink.cmp",
  --       ---@module 'blink.cmp'
  --       ---@type blink.cmp.Config
  --       opts = {
  --         sources = {
  --           default = { "markdown" },
  --           providers = {
  --             markdown = { name = "RenderMarkdown", module = "render-markdown.integ.blink" },
  --           },
  --         },
  --       },
  --       opts_extend = {
  --         "sources.default",
  --       },
  --     },
  --     -- {
  --     --   -- "epwalsh/obsidian.nvim",
  --     --   "obsidian-nvim/obsidian.nvim",
  --     --   opts = {
  --     --     ui = { enable = false },
  --     --   },
  --     -- },
  --   },
  --   ---@module 'render-markdown'
  --   ---@type render.md.UserConfig
  --   opts = {
  --     code = {
  --       sign = false,
  --       width = "block",
  --       right_pad = 1,
  --     },
  --     heading = {
  --       enabled = false,
  --       -- width = "block",
  --       -- sign = false,
  --       -- icons = {},
  --     },
  --   },
  --   keys = require("fredrik.config.keymaps").setup_markdown_keymaps(),
  -- },

  {
    "virtual-lsp-config",
    dependencies = {
      {
        "mason-org/mason-lspconfig.nvim",
        dependencies = {
          {
            "mason-org/mason.nvim",
          },
        },
        opts = function(_, opts)
          opts.ensure_installed = opts.ensure_installed or {}
          vim.list_extend(opts.ensure_installed, { "ltex_plus" })
        end,
      },
      { "barreiroleo/ltex-extra.nvim" },
    },
    ft = { "markdown", "tex", "latex", "bib", "gitcommit" },
    opts = {
      servers = {
        ---@type vim.lsp.Config
        ltex_plus = {
          cmd = { "ltex-ls-plus" },
          filetypes = { "markdown", "tex", "latex", "bib", "gitcommit" },
          root_markers = { ".git", ".ltex" },
          on_attach = function(client, bufnr)
            require("ltex_extra").setup {
              -- table <string> : languages for witch dictionaries will be loaded, e.g. { "es-AR", "en-US" }
              -- https://valentjn.github.io/ltex/supported-languages.html#natural-languages
              load_langs = { "en-GB" }, -- en-US as default
              -- boolean : whether to load dictionaries on startup
              init_check = true,
              -- string : relative or absolute path to store dictionaries
              -- e.g. subfolder in the project root or the current working directory: ".ltex"
              -- e.g. shared files for all projects:  vim.fn.expand("~") .. "/.local/share/ltex"
              path = ".ltex", -- project root or current working directory
              -- string : "none", "trace", "debug", "info", "warn", "error", "fatal"
              log_level = "warn",
            }
          end,
          settings = {
            ltex = {
              enabled = { "latex", "tex", "bib", "markdown", "gitcommit" },
              language = "en-GB",
              configurationTarget = {
                dictionary = "workspaceFolderExternalFile",
                disabledRules = "workspaceFolder",
                hiddenFalsePositives = "workspaceFolder",
              },
              enabledRules = {
                ["en-GB"] = { "OXFORD_SPELLING_ISE_VERBS" },
              },
              disabledRules = {
                ["en-GB"] = { "OXFORD_SPELLING_Z_NOT_S", "PASSIVE_VOICE" },
              },
              -- dictionary = (function()
              --   -- For dictionary, search for files in the runtime to have
              --   -- and include them as externals the format for them is
              --   -- dict/{LANG}.txt
              --   --
              --   -- Also add dict/default.txt to all of them
              --   local files = {}
              --   for _, file in ipairs(vim.api.nvim_get_runtime_file("dict/*", true)) do
              --     local lang = vim.fn.fnamemodify(file, ":t:r")
              --     local fullpath = vim.fs.normalize(file)
              --     files[lang] = { ":" .. fullpath }
              --   end
              --
              --   if files.default then
              --     for lang, _ in pairs(files) do
              --       if lang ~= "default" then
              --         vim.list_extend(files[lang], files.default)
              --       end
              --     end
              --     files.default = nil
              --   end
              --   if files["en-GB"] then
              --     files["en-GB"]:insert(1, ":" .. vim.fn.getcwd() .. "/.ltex.dictionary.txt")
              --   else
              --     files["en-GB"] = { ":" .. vim.fn.getcwd() .. "/.ltex.dictionary.txt" }
              --   end
              --   -- print(vim.inspect(files))
              --   return files
              -- end)(),
            },
          },
        },
      },
    },
  },
}
