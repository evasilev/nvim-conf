local map = vim.api.nvim_set_keymap
local opts = {noremap = true, silent = true}

require('telescope').setup {
	pickers = {
		buffers = {
			-- start in normal mode
			initial_mode = 'normal'
		}
	}
}

require('telescope').load_extension('harpoon')

-- setup hotkeys
map('n', '<leader>ff', '<cmd>Telescope find_files<CR>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>', opts)
map('n', '<leader>fb', '<cmd>Telescope buffers<CR>', opts)
