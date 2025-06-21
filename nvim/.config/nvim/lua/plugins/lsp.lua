return {
    {
        "williamboman/mason.nvim",
        lazy = false,
        opts = {},
    },
    {
        "neovim/nvim-lspconfig",
        cmd = { "LspInfo", "LspInstall", "LspStart" },
        event = { "BufReadPre", "BufNewFile" },
        dependencies = {
            { "hrsh7th/cmp-nvim-lsp" },
            { "hrsh7th/cmp-buffer" },             -- Buffer completions
            { "hrsh7th/cmp-path" },               -- Path completions
            { "saadparwaiz1/cmp_luasnip" },       -- Snippet completions
            { "supermaven-inc/supermaven-nvim" }, -- AI completions
            { "williamboman/mason.nvim" },
            { "williamboman/mason-lspconfig.nvim" },
            { "hrsh7th/nvim-cmp" },
        },
        init = function()
            vim.opt.signcolumn = "yes"
        end,
        config = function()
            local lsp_defaults = require("lspconfig").util.default_config
            lsp_defaults.capabilities =
                vim.tbl_deep_extend("force", lsp_defaults.capabilities, require("cmp_nvim_lsp").default_capabilities())

            -- Minimal but smart nvim-cmp setup
            local cmp = require('cmp')
            local luasnip = require('luasnip')

            -- Load friendly snippets
            require('luasnip.loaders.from_vscode').lazy_load()

            -- Setup Super Maven
            require("supermaven-nvim").setup({
                keymaps = {
                    accept_suggestion = "<Tab>",
                    clear_suggestion = "<C-]>",
                    accept_word = "<C-j>",
                },
                ignore_filetypes = { "cpp" }, -- or { "cpp", "lua" } to ignore specific filetypes
                color = {
                    suggestion_color = "#ffffff",
                    cterm = 244,
                },
                log_level = "info",                -- set to "off" to disable logging completely
                disable_inline_completion = false, -- disables inline completion for use with cmp
                disable_keymaps = false            -- disables built in keymaps for more manual control
            })

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },

                -- Clean bordered windows
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },

                -- Simple formatting with source labels
                formatting = {
                    format = function(entry, vim_item)
                        -- Source labels
                        vim_item.menu = ({
                            nvim_lsp = '[LSP]',
                            luasnip = '[Snippet]',
                            buffer = '[Buffer]',
                            path = '[Path]',
                        })[entry.source.name]
                        return vim_item
                    end,
                },

                -- Auto-select first item
                completion = {
                    completeopt = 'menu,menuone,noinsert',
                },

                -- Essential keymaps
                mapping = cmp.mapping.preset.insert({
                    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-f>'] = cmp.mapping.scroll_docs(4),
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-e>'] = cmp.mapping.abort(),
                    ['<C-y>'] = cmp.mapping.confirm({ select = true }),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),

                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<C-p>'] = cmp.mapping.select_prev_item(),

                    -- Snippet navigation only (no completion cycling)
                    ['<Tab>'] = cmp.mapping(function(fallback)
                        if luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback() -- Let Super Maven handle Tab
                        end
                    end, { 'i', 's' }),

                    ['<S-Tab>'] = cmp.mapping(function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { 'i', 's' }),
                }),

                -- Essential sources only
                sources = cmp.config.sources({
                    { name = 'nvim_lsp' },
                    { name = 'luasnip' },
                }, {
                    { name = 'buffer', keyword_length = 3 },
                    { name = 'path' },
                }),
            })

            -- Snippet navigation
            vim.keymap.set({ "i", "s" }, "<C-L>", function()
                if luasnip.expand_or_jumpable() then
                    luasnip.expand_or_jump()
                end
            end, { silent = true })

            vim.keymap.set({ "i", "s" }, "<C-J>", function()
                if luasnip.jumpable(-1) then
                    luasnip.jump(-1)
                end
            end, { silent = true })

            -- LSP keymaps
            vim.api.nvim_create_autocmd("LspAttach", {
                desc = "LSP actions",
                callback = function(event)
                    local opts = { buffer = event.buf }

                    vim.keymap.set("n", "K", "<cmd>lua vim.lsp.buf.hover()<cr>", opts)
                    vim.keymap.set("n", "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", opts)
                    vim.keymap.set("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<cr>", opts)
                    vim.keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<cr>", opts)
                    vim.keymap.set("n", "go", "<cmd>lua vim.lsp.buf.type_definition()<cr>", opts)
                    vim.keymap.set("n", "gr", "<cmd>lua vim.lsp.buf.references()<cr>", opts)
                    vim.keymap.set("n", "gs", "<cmd>lua vim.lsp.buf.signature_help()<cr>", opts)
                    vim.keymap.set("n", "<F2>", "<cmd>lua vim.lsp.buf.rename()<cr>", opts)
                    vim.keymap.set({ "n", "x" }, "<F3>", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", opts)
                    vim.keymap.set("n", "<F4>", "<cmd>lua vim.lsp.buf.code_action()<cr>", opts)
                end,
            })

            local lsp_capabilities = require("cmp_nvim_lsp").default_capabilities()

            require("mason-lspconfig").setup({
                ensure_installed = { "ts_ls", "biome", "gopls", "pyright", "lua_ls","svelte","tailwindcss","emmet_ls","html","cssls","jsonls"},
                handlers = {
                    -- Default handler
                    function(server_name)
                        require("lspconfig")[server_name].setup({
                            capabilities = lsp_capabilities,
                        })
                    end,

                    ["biome"] = function()
                        require("lspconfig").biome.setup({
                            capabilities = lsp_capabilities,
                            settings = {},
                        })
                    end,
                    ["svelte"] = function()
                        require("lspconfig").svelte.setup({
                            capabilities = lsp_capabilities,
                            settings = {
                                svelte = {
                                    plugin = {
                                        html = { completions = { enable = true, emmet = true } },
                                        svelte = { completions = { enable = true, emmet = true } },
                                        css = { completions = { enable = true, emmet = true } },
                                    },
                                },
                            },
                        })
                    end,

                    ["tailwindcss"] = function()
                        require("lspconfig").tailwindcss.setup({
                            capabilities = lsp_capabilities,
                            settings = {
                                tailwindCSS = {
                                    includeLanguages = {
                                        svelte = "html",
                                    },
                                },
                            },
                        })
                    end,

                    ["emmet_ls"] = function()
                        require("lspconfig").emmet_ls.setup({
                            capabilities = lsp_capabilities,
                            filetypes = { "html", "css", "scss", "svelte", "javascriptreact", "typescriptreact" },
                        })
                    end,
                    -- Enhanced Go setup (minimal but useful)
                    ["gopls"] = function()
                        require("lspconfig").gopls.setup({
                            capabilities = lsp_capabilities,
                            settings = {
                                gopls = {
                                    usePlaceholders = true,
                                    completeUnimported = true,
                                    staticcheck = true,
                                    analyses = {
                                        unusedparams = true,
                                    },
                                },
                            },
                        })
                    end,
                },
            })
        end,
    },
}
