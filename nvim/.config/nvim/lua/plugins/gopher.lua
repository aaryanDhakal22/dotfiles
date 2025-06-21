return {
  "ray-x/go.nvim",
  dependencies = {
    "ray-x/guihua.lua",
    "neovim/nvim-lspconfig",
    "nvim-treesitter/nvim-treesitter",
  },
  config = function()
    require("go").setup({
      goimports = "gopls", -- Use gopls for imports
      gofmt = "gofumpt",   -- Use gofumpt for formatting
      tag_transform = "camelcase",
      test_dir = "",
      comment_placeholder = "   ",
      icons = { breakpoint = "🧘", currentpos = "🏃" },
      verbose = false,
      log_path = vim.fn.expand("$HOME") .. "/tmp/gonvim.log",
      lsp_cfg = false, -- Don't override your existing LSP config
      lsp_gofumpt = true,
      lsp_on_attach = false,
      dap_debug = true,
    })

    -- Go-specific keymaps
    vim.keymap.set("n", "<leader>gsj", "<cmd>GoAddTag json<CR>", { desc = "Add JSON tags" })
    vim.keymap.set("n", "<leader>gsy", "<cmd>GoAddTag yaml<CR>", { desc = "Add YAML tags" })
    vim.keymap.set("n", "<leader>gsr", "<cmd>GoRmTag<CR>", { desc = "Remove tags" })
    vim.keymap.set("n", "<leader>ger", "<cmd>GoIfErr<CR>", { desc = "Add if err" })
    vim.keymap.set("n", "<leader>gfs", "<cmd>GoFillStruct<CR>", { desc = "Fill struct" })
    vim.keymap.set("n", "<leader>gt", "<cmd>GoTest<CR>", { desc = "Run tests" })
    vim.keymap.set("n", "<leader>gtf", "<cmd>GoTestFunc<CR>", { desc = "Test function" })
    vim.keymap.set("n", "<leader>gtp", "<cmd>GoTestPkg<CR>", { desc = "Test package" })
  end,
  event = { "CmdlineEnter" },
  ft = { "go", "gomod" },
  build = ':lua require("go.install").update_all_sync()',
}
