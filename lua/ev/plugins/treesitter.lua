require('nvim-treesitter.configs').setup {
  ensure_installed = {
		"bash",
		"dockerfile",
		"glsl",
		"go",
		"hcl",
		"javascript",
		"json",
		"lua",
		"toml",
		"typescript",
		"vim",
		"yaml",
		"python"
	},
  sync_install = true,
  ignore_install = { 'phpdoc' },
  hightlight = { enable = true },
}
