return {
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_no_tab_map = true
			vim.api.nvim_set_keymap("i", "<Tab>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
			vim.api.nvim_set_keymap("i", "<S-Tab>", "<Plug>(copilot-dismiss)", { silent = true })
			vim.api.nvim_set_keymap("i", "<D-Tab>", "<Plug>(copilot-next)", { silent = true })
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("nvim-treesitter.configs").setup({
				ensure_installed = {
					"python",
					"rust",
					"lua",
					"json",
					"yaml",
					"toml",
					"bash",
					"markdown",
					"markdown_inline",
					"nu",
					"dockerfile",
				},
				highlight = { enable = true },
				indent = { enable = true },
			})
		end,
	},
	{
		"windwp/nvim-autopairs",
		config = function()
			require("nvim-autopairs").setup({})
		end,
	},
	{
		"neovim/nvim-lspconfig",
		dependencies = { "mason-org/mason.nvim", "mason-org/mason-lspconfig.nvim" },
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "ruff", "rust_analyzer" },
				automatic_installation = true,
			})

			vim.keymap.set("n", "gd", vim.diagnostic.open_float, { desc = "Show line diagnostics" })
			vim.keymap.set("n", "K", vim.lsp.buf.hover, { desc = "Show documentation" })

			vim.lsp.config("ruff", {
				settings = {
					interpreter = {
						vim.fn.glob(vim.fn.getcwd() .. "/.venv/bin/python"),
					},
				},
			})
			vim.lsp.config("rust_analyzer", {
				settings = {
					["rust-analyzer"] = {
						cargo = {
							allFeatures = true,
						},
						checkOnSave = true,
					},
				},
			})
		end,
	},
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		config = function()
			require("conform").setup({
				notify_on_error = true,
				notify_no_formatters = true,
				formatters_by_ft = {
					python = { "ruff_fix", "ruff_format", "ruff_organize_imports" },
					pyproject = { "pyproject-fmt" },
					rust = { "rustfmt" },
					json = { "jq" },
					yaml = { "yq" },
					toml = { "taplo" },
					lua = { "stylua" },
					docker = { "dockerfmt" },
					bash = { "shfmt" },
					nu = { "nufmt" },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end,
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPost", "BufNewFile" },
		config = function()
			require("gitsigns").setup({})
		end,
	},
	{
		"ibhagwan/fzf-lua",
		dependencies = {
			"nvim-mini/mini.icons",
		},
		opts = {},
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd([[colorscheme tokyonight]])
		end,
	},
	{
		"Isrothy/neominimap.nvim",
		version = "v3.x.x",
		lazy = false,
	},
}
