
return {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
        "hrsh7th/cmp-buffer", -- source for text in buffer
        "hrsh7th/cmp-path", -- source for file system paths
        "rafamadriz/friendly-snippets",
        "onsails/lspkind.nvim", -- vs-code like pictograms
    },
    config = function()
        local cmp = require("cmp")
        local lspkind = require("lspkind")


        cmp.setup({
            snippet = {

            },
            mapping = cmp.mapping.preset.insert({
                -- trigger completion menu
                ['<C-Space>'] = cmp.mapping.complete(),

                -- scroll up and down the documentation window
                ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                ['<C-d>'] = cmp.mapping.scroll_docs(4),
                ["<C-e>"] = cmp.mapping.close(),
                ["<CR>"] = cmp.mapping.confirm({
                    behavior = cmp.ConfirmBehavior.Replace,
                    select = true,
                }),
            }),
            sources = cmp.config.sources({
                { name = "nvim_lsp" },
                { name = "buffer" },
                { name = "path" },
            }),
        })

        vim.cmd([[
      set completeopt=menuone,noinsert,noselect
      highlight! default link CmpItemKind CmpItemMenuDefault
    ]])
    end,
}