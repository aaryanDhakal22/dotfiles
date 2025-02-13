
return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        { "folke/neodev.nvim", opts = {} },
    },
    config = function()
        local nvim_lsp = require("lspconfig")
        local mason_lspconfig = require("mason-lspconfig")

        local protocol = require("vim.lsp.protocol")

        local on_attach = function(client, bufnr)
            -- format on save
            if client.server_capabilities.documentFormattingProvider then
                vim.api.nvim_create_autocmd("BufWritePre", {
                    group = vim.api.nvim_create_augroup("Format", { clear = true }),
                    buffer = bufnr,
                    callback = function()
                        vim.lsp.buf.format()
                    end,
                })
                vim.api.nvim_create_autocmd('LspAttach', {
                    desc = 'LSP actions',
                    callback = function(event)
                        local opts = {buffer = event.buf}
                
                        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opts)
                        vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<cr>', opts)
                        vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<cr>', opts)
                        vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<cr>', opts)
                        vim.keymap.set('n', 'go', '<cmd>lua vim.lsp.buf.type_definition()<cr>', opts)
                        vim.keymap.set('n', 'gr', '<cmd>lua vim.lsp.buf.references()<cr>', opts)
                        vim.keymap.set('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<cr>', opts)
                        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opts)
                        vim.keymap.set({'n', 'x'}, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts)
                        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opts)
                    end,
                })
            end
        end

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        mason_lspconfig.setup_handlers({
            function(server)
                nvim_lsp[server].setup({
                    capabilities = capabilities,
                })
            end,
            ["tsserver"] = function()
                nvim_lsp["tsserver"].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end,
            ["cssls"] = function()
                nvim_lsp["cssls"].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end,
            ["tailwindcss"] = function()
                nvim_lsp["tailwindcss"].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end,
            ["html"] = function()
                nvim_lsp["html"].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end,
            ["jsonls"] = function()
                nvim_lsp["jsonls"].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end,
            ["eslint"] = function()
                nvim_lsp["eslint"].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end,
            ["pyright"] = function()
                nvim_lsp["pyright"].setup({
                    on_attach = on_attach,
                    capabilities = capabilities,
                })
            end,
        })
    end,
}