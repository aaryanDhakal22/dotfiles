local set = vim.opt
set.guicursor = ""
set.number = true
set.relativenumber = true
set.autoindent = true
set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true

set.smartindent = true

set.wrap = false

set.swapfile = false
set.backup = false
set.undodir = os.getenv("HOME") .. "/.vim/undodir"
set.undofile = true

set.hlsearch = false
set.incsearch = true

set.termguicolors = true

set.scrolloff = 8
set.signcolumn = "yes"
set.isfname:append("@-@")

set.updatetime = 50

set.mouse = ""
-- Diagnostic configuration
vim.diagnostic.config({
    virtual_text = {
        prefix = "●",
        spacing = 2,
    },
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
        focusable = false,
    },
})

-- Define diagnostic signs with simple text
vim.fn.sign_define("DiagnosticSignError", { text = "E", texthl = "DiagnosticSignError" })
vim.fn.sign_define("DiagnosticSignWarn", { text = "W", texthl = "DiagnosticSignWarn" })
vim.fn.sign_define("DiagnosticSignInfo", { text = "I", texthl = "DiagnosticSignInfo" })
vim.fn.sign_define("DiagnosticSignHint", { text = "H", texthl = "DiagnosticSignHint" })

-- Force diagnostic highlights (in case colorscheme doesn't define them)
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        -- Underlines
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, sp = "#f38ba8" })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, sp = "#f9e2af" })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, sp = "#89b4fa" })
        vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, sp = "#94e2d5" })

        -- Signs
        vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#f38ba8" })
        vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#f9e2af" })
        vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#89b4fa" })
        vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#94e2d5" })
    end
})

-- Apply highlights immediately
vim.api.nvim_set_hl(0, "DiagnosticUnderlineError", { underline = true, sp = "#f38ba8" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineWarn", { underline = true, sp = "#f9e2af" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineInfo", { underline = true, sp = "#89b4fa" })
vim.api.nvim_set_hl(0, "DiagnosticUnderlineHint", { underline = true, sp = "#94e2d5" })

vim.api.nvim_set_hl(0, "DiagnosticSignError", { fg = "#f38ba8" })
vim.api.nvim_set_hl(0, "DiagnosticSignWarn", { fg = "#f9e2af" })
vim.api.nvim_set_hl(0, "DiagnosticSignInfo", { fg = "#89b4fa" })
vim.api.nvim_set_hl(0, "DiagnosticSignHint", { fg = "#94e2d5" })

-- Auto show diagnostic popup on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        local opts = {
            focusable = false,
            close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
            border = 'rounded',
            source = 'always',
            prefix = ' ',
            scope = 'cursor',
        }
        vim.diagnostic.open_float(nil, opts)
    end
})
