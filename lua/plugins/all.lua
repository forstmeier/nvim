return {
    {
        "github/copilot.vim",
        config = function()
            vim.g.copilot_no_tab_map = true
            vim.api.nvim_set_keymap("i", "<Tab>", 'copilot#Accept("")',
                { silent = true, expr = true })
            vim.api.nvim_set_keymap("i", "<S-Tab>", "<Plug>(copilot-dismiss)", { silent = true })
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
                    "go",
                    "gomod",
                    "gosum",
                    "gotmpl",
                    "typescript",
                    "tsx",
                    "javascript",
                    "sql",
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
                ensure_installed = { "ruff", "rust_analyzer", "gopls", "tsserver" },
                automatic_installation = true,
            })

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


            vim.lsp.config("gopls", {
                settings = {
                    gopls = {
                        analyses = {
                            unusedparams = true,
                            shadow = true,
                        },
                        staticcheck = true,
                    },
                },
            })

            vim.lsp.config("tsserver", {})

            vim.lsp.config("lua_ls", {
                settings = {
                    Lua = {
                        diagnostics = {
                            globals = { "vim" },
                        },
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
                    lua = {},
                    docker = { "dockerfmt" },
                    bash = { "shfmt" },
                    nu = { "nufmt" },
                    go = { "gofmt" },
                    javascript = { "prettierd", "prettier" },
                    typescript = { "prettierd", "prettier" },
                    typescriptreact = { "prettierd", "prettier" },
                    sql = { "sqruff" },
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
    -- {
    --     "ibhagwan/fzf-lua",
    --     dependencies = {
    --         "nvim-mini/mini.icons",
    --     },
    --     opts = {},
    -- },
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
    {
        "nvim-tree/nvim-tree.lua",
        version = "*",
        lazy = false,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("nvim-tree").setup {}
        end,
    },
}
