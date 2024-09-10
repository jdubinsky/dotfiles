require("mason").setup()

local servers = {
	"lua_ls",
  "graphql",
  "jsonls",
	"ruby_lsp",
	"sorbet",
  "ts_ls",
}

require("mason-lspconfig").setup({ ensure_installed = servers, automatic_installation = true })
