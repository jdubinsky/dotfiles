require("nvim-test").setup({
	term = "toggleterm",
	create_commands = true,
	run = true,
	runners = {
    javascriptreact = "nvim-test.runners.jest",
    javascript = "nvim-test.runners.jest",
    typescript = "nvim-test.runners.jest",
    typescriptreact = "nvim-test.runners.jest",
		ruby = "nvim-test.runners.rails",
	},
})

require("nvim-test.runners.rails").setup({
	command = "./bin/rails test",
	file_pattern = "\\v(__tests__/.*|(test))\\.(rb)$",
	find_files = { "{name}_test.{ext}" },
})
