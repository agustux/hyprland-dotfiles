local status, ts = pcall(require, "nvim-treesitter")
if not status then return end

-- Modern versions hook into configuration automatically 
-- or expose the main setup directly
require'nvim-treesitter'.setup {
	ensure_installed = "all",

	sync_install = false,

	auto_install = true,

	ignore_install = { },

	highlight = {
		enable = true,
		additional_vim_regex_highlighting = false
	},
	indent = {
		enable = true,
	},
}

