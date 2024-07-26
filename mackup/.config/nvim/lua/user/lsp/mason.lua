require("mason").setup()

local servers = {
	"lua_ls",
  "graphql",
  "jsonls",
  "tsserver",
	"ruby_lsp",
	-- "sorbet",
}

require("mason-lspconfig").setup({ ensure_installed = servers, automatic_installation = true })
