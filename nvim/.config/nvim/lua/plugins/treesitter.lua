return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "windwp/nvim-ts-autotag", -- Auto close/rename HTML tags
    },
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            ensure_installed = {
                "c", "lua", "vim", "vimdoc", "query",
                -- Go
                "go", "gomod", "gosum", "gotmpl",
                -- Svelte/Web
                "svelte", "javascript", "typescript", "tsx", "html", "css", "scss",
                -- Others
                "json", "yaml", "markdown", "bash"
            },
            sync_install = false,
            highlight = { enable = true },
            indent = { enable = true },

            -- Auto tag closing for HTML/Svelte
            autotag = {
                enable = true,
                filetypes = { "html", "xml", "svelte", "javascriptreact", "typescriptreact" },
            },
        })
    end
}
