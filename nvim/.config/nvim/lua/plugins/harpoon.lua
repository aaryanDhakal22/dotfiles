return {
	"ThePrimeagen/harpoon",
	branch = "harpoon2",
	opts = {
		menu = {
			width = vim.api.nvim_win_get_width(0) - 4,
		},
		settings = {
			save_on_toggle = true,
		},
	},
	keys = function()
		local keys = {
			{
				"<leader>a",
				function()
					require("harpoon"):list():add()
				end,
				desc = "Harpoon File",
			},
			{
				"<leader>h",
				function()
					local harpoon = require("harpoon")
					harpoon.ui:toggle_quick_menu(harpoon:list())
				end,
				desc = "Harpoon Quick Menu",
			},
			{
				"<C-h>",
				function()
					require("harpoon"):list():select(1)
				end,
				desc = "Harpoon Option 1",
			},
			{
				"<C-j>",
				function()
					require("harpoon"):list():select(2)
				end,
				desc = "Harpoon Option 2",
			},
			{
				"<C-k>",
				function()
					require("harpoon"):list():select(3)
				end,
				desc = "Harpoon Option 3",
			},
			{
				"<C-l>",
				function()
					require("harpoon"):list():select(4)
				end,
				desc = "Harpoon Option 4",
			},
		}

		return keys
	end,
}
