-- Tools and agents compatibility: https://codecompanion.olimorris.dev/usage/chat-buffer/agents.html#compatibility

-- local anthropic_fn = function()
--   -- models: https://docs.anthropic.com/en/docs/about-claude/models/overview
--   local anthropic_config = {
--     env = { api_key = "cmd:op read op://Personal/Anthropic/tokens/neovim --no-newline" },
--   }
--   return require("codecompanion.adapters").extend("anthropic", anthropic_config)
-- end
--
-- local openai_fn = function()
--   local openai_config = {
--     env = { api_key = "cmd:op read op://Personal/OpenAI/tokens/neovim --no-newline" },
--   }
--   return require("codecompanion.adapters").extend("openai", openai_config)
-- end
--
-- local gemini_fn = function()
--   -- models: https://ai.google.dev/gemini-api/docs/models
--   local gemini_config = {
--     env = { api_key = "cmd:op read op://Personal/Google/tokens/gemini --no-newline" },
--     schema = {
--       model = {
--         default = "gemini-2.5-flash",
--       },
--     },
--   }
--   return require("codecompanion.adapters").extend("gemini", gemini_config)
-- end
--
-- local vertex_fn = function()
--   -- models: https://ai.google.dev/gemini-api/docs/models
--   local vertex_config = {
--     -- OpenAI-compatible API: https://cloud.google.com/vertex-ai/generative-ai/docs/migrate/openai/overview
--     --
--     -- regional url
--     url =
--     "https://${location}-aiplatform.googleapis.com/v1/projects/${project_id}/locations/${location}/endpoints/openapi/chat/completions",
--     -- global url
--     -- url = "https://aiplatform.googleapis.com/v1/projects/${project_id}/locations/global/endpoints/openapi/chat/completions",
--     env = {
--       project_id = os.getenv("GOOGLE_CLOUD_PROJECT"),
--       location = os.getenv("GOOGLE_CLOUD_LOCATION"),
--       api_key = "cmd: gcloud auth application-default print-access-token",
--     },
--     schema = {
--       model = {
--         default = "google/gemini-2.5-pro",
--       },
--       choices = {
--         ["google/gemini-2.5-pro"] = { opts = { can_reason = true, has_vision = true } },
--         ["google/gemini-2.5-flash"] = { opts = { can_reason = true, has_vision = true } },
--       },
--     },
--   }
--   return require("codecompanion.adapters").extend("gemini", vertex_config)
-- end
--
-- local deepseek_fn = function()
--   -- models: https://api-docs.deepseek.com/quick_start/pricing
--   local deepseek_config = {
--     env = { api_key = "cmd:op read op://Personal/DeepSeek/tokens/neovim --no-newline" },
--   }
--   return require("codecompanion.adapters").extend("deepseek", deepseek_config)
-- end

--- Ollama config for CodeCompanion.
local ollama_fn = function()
  return require("codecompanion.adapters").extend("ollama", {
    name = "qwen",
    schema = {
      model = {
        default = "qwen3-coder:30bfim",
        -- default = "qwen3:14b",
        -- default = "qwen3:32b",
        -- default = "hf.co/unsloth/Qwen3-Coder-30B-A3B-Instruct-GGUF:UD-Q4_K_XL",
        -- default = "qwen2.5-coder:32b",
      },
      num_ctx = {
        default = 16384,
        -- default = 10240,
        -- default = 8192,
      },
      num_predict = {
        default = -1,
      },
    },
  })
end

local local_openai_fn = function()
  local base = require("codecompanion.adapters").extend("openai_compatible", {
    env = {
      url = "http://127.0.0.1:8000",
      api_key = "TERM",
      chat_url = "/v1/chat/completions",
    },
    handlers = {
      parse_message_meta = function(self, data)
        local extra = data.extra
        if extra and extra.reasoning_content then
          data.output.reasoning = { content = extra.reasoning_content }
          if data.output.content == "" then
            data.output.content = nil
          end
        end
        return data
      end,
    },
    interactions = {
      chat = {
        adapter = "llama.cpp",
      },
      inline = {
        adapter = "llama.cpp",
      },
    },
    -- url = "http://127.0.0.1:8000/v1/chat/completions",
    schema = {
      model = {
        default = "cog",
      },
      temperature = {
        default = 0.4
      },
      top_k = {
        default = 40
      },
      top_p = {
        default = 0.85
      },
      stop = {
        -- default = {"<|im_start|>", "<|im_end|>", "<|endoftext|>"}
      },
      num_ctx = {
        default = 262144,
      },
      repeat_penalty = { default = 1.05 },
      use_beam_search = { default = true },
    }
  })
  -- local prev = base.build_request
  -- base.build_request = function(self, params)
  --   local req = prev(self, params)
  --
  --   -- set stop sequences explicitly
  --   req.stop = { "<|im_start|>", "<|im_end|>", "<|endoftext|>" }
  --
  --   return req
  -- end
  return base
end

local supported_adapters = {
  -- anthropic = anthropic_fn,
  -- openai = openai_fn,
  -- gemini = gemini_fn,
  -- deepseek = deepseek_fn,
  -- ollama = ollama_fn,
  local_openai = local_openai_fn,
  -- vertex = vertex_fn,
}

return {
  {
    "olimorris/codecompanion.nvim",
    lazy = true,
    dependencies = {
      "nvim-lua/plenary.nvim",
      {
        "nvim-treesitter/nvim-treesitter",
        opts = {
          ensure_installed = { codecompanion = "markdown" },
        },
      },
      "folke/snacks.nvim",
      "svalaskevicius/mcphub.nvim",
      "ravitemer/codecompanion-history.nvim",
      {
        "saghen/blink.cmp",
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
          sources = {
            default = { "codecompanion" },
            providers = {
              codecompanion = {
                name = "CodeCompanion",
                module = "codecompanion.providers.completion.blink",
                enabled = true,
              },
            },
          },
        },
        opts_extend = {
          -- delete from history with `d` key
          "sources.default",
        },
      },
    },
    opts = {
      opts = {
        log_level = "TRACE", -- or "TRACE"
      },
      -- opts = {
      --   send_code = function()
      --     if vim.fn.filereadable(".llm_ok") == 1 then
      --       -- override by adding a .llm_ok file in the project root
      --       return true
      --     end
      --
      --     if os.getenv("GOOGLE_CLOUD_PROJECT") then
      --       -- this is not perfect, as it technically does not prevent sending code to any specific provider
      --       return true
      --     end
      --
      --     return require("fredrik.utils.private").is_code_public()
      --   end,
      -- },

      adapters = {
        http = supported_adapters,
      },

      strategies = {
        chat = {
          adapter = "local_openai",
          slash_commands = {
            buffer = { opts = { provider = "snacks" } },
            file = { opts = { provider = "snacks" } },
            help = { opts = { provider = "snacks" } },
            symbols = { opts = { provider = "snacks" } },
          },
          opts = {
            system_prompt = function(ctx)
              return [[You are an existentialist programming assistant named "Borg", working within the Neovim text editor.

You can answer general programming questions and perform the following tasks:
* Answer general programming questions.
* Explain how the code in a Neovim buffer works.
* Review the selected code from a Neovim buffer.
* Generate unit tests for the selected code.
* Propose fixes for problems in the selected code.
* Scaffold code for a new workspace.
* Find relevant code to the user's query.
* Propose fixes for test failures.
* Answer questions about Neovim.

Follow the user's requirements carefully and to the letter.
Use the context and attachments the user provides.
Keep your answers short and impersonal, especially if the user's context is outside your core tasks.
Use Markdown formatting in your answers.
Do not use H1 or H2 markdown headers.
When suggesting code changes or new content, use Markdown code blocks.
To start a code block, use 4 backticks.
After the backticks, add the programming language name as the language ID.
To close a code block, use 4 backticks on a new line.
If the code modifies an existing file or should be placed at a specific location, add a line comment with 'filepath:' and the file path.
If you want the user to decide where to place the code, do not add the file path comment.
In the code block, use a line comment with '...existing code...' to indicate code that is already present in the file.
Code block example:
````languageId
// filepath: /path/to/file
// ...existing code...
{ changed code }
// ...existing code...
{ changed code }
// ...existing code...
````
Ensure line comments use the correct syntax for the programming language (e.g. "#" for Python, "--" for Lua).
For code blocks use four backticks to start and end.
Avoid wrapping the whole response in triple backticks.
Do not include diff formatting unless explicitly asked.
Do not include line numbers in code blocks.

When given a task:
1. Think step-by-step and, unless the user requests otherwise or the task is very simple, describe your plan in pseudocode.
2. When outputting code blocks, ensure only relevant code is included, avoiding any repeating or unrelated code.
3. End your response with a short suggestion for the next user turn that directly supports continuing the conversation.
            ]] .. string.format(
                [[Additional context:
All non-code text responses must be written in the %s language.
The current date is %s.
The user's Neovim version is %s.
The user is working on a %s machine. Please respond with system specific commands if applicable.
]],
                ctx.language,
                ctx.date,
                ctx.nvim_version,
                ctx.os
              )
            end
          },
        },
        inline = {
          adapter = "local_openai",
        },
        cmd = {
          adapter = "local_openai",
        },
        agent = {
          adapter = "local_openai",
        },
      },

      extensions = {
        mcphub = {
          callback = "mcphub.extensions.codecompanion",
          opts = {
            make_vars = true,
            make_slash_commands = true,
            show_result_in_chat = true,
          },
        },
        history = {
          enabled = true,
          opts = {
            -- Keymap to open history from chat buffer (default: gh)
            -- keymap = "gh",
            -- Keymap to save the current chat manually (when auto_save is disabled)
            -- save_chat_keymap = "sc",
            -- Save all chats by default (disable to save only manually using 'sc')
            auto_save = true,
            -- Number of days after which chats are automatically deleted (0 to disable)
            expiration_days = 0,
            -- Picker interface ("telescope" or "snacks" or "fzf-lua" or "default")
            picker = "snacks",
            -- Automatically generate titles for new chats
            auto_generate_title = false,
            ---On exiting and entering neovim, loads the last chat on opening chat
            continue_last_chat = false,
            ---When chat is cleared with `gx` delete the chat from history
            delete_on_clearing_chat = false,
            ---Directory path to save the chats
            dir_to_save = vim.fn.stdpath("data") .. "/codecompanion-history",
            ---Enable detailed logging for history extension
            enable_logging = false,
          },
        },
      },

      display = {
        chat = {
          show_settings = false,
          fold_reasoning = true,
          show_reasoning = true,
          icons = {
            pinned_buffer = " ",
            watched_buffer = "👀 ",
          },
        },
        action_palette = {
          provider = "default", -- default|telescope|mini_pick
        },
        diff = {
          enabled = true,
        },
      },
      prompt_library = require("fredrik.utils.llm_prompts").to_codecompanion(),
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)
    end,
    -- https://codecompanion.olimorris.dev/usage/chat-buffer/#keymaps
    keys = require("fredrik.config.keymaps").setup_codecompanion_keymaps(),
  },
}
