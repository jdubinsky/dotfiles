local status_ok, configs = pcall(require, "nvim-treesitter.configs")
if not status_ok then
	return
end

configs.setup {
  ensure_installed = {
    "ruby",
    "graphql",
    "json",
    "javascript",
    "typescript",
    "lua",
    "tsx",
    "markdown",
    "yaml",
    "http",
    "html",
    "python",
    "scss",
    "vim",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
