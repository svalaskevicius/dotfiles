return {
	{
		"scalameta/nvim-metals",
		lazy = true,
		dependencies = { "nvim-lua/plenary.nvim" },
		init = function()
			vim.g["metals_server_version"] = "1.6.0"
		end,
		opts = function()
			local metals_config = require("metals").bare_config()
			--metals_config.capabilities = require("cmp_nvim_lsp").default_capabilities()
			--metals_config.on_attach = function(client, bufnr)
			--vim.keymap.set("n", "K", vim.lsp.buf.hover)
			--end
			return metals_config
		end,
		ft = { "scala", "sbt", "java" },
		config = function(metals, metals_config)
			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "scala", "sbt", "java" },
				callback = function()
					require("metals").initialize_or_attach(metals_config)
				end,
			})
		end,
	},
}
