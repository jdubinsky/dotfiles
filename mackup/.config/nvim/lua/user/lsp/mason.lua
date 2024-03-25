require("mason").setup()

local servers = {
	"lua_ls",
  "graphql",
  "jsonls",
  "tsserver",
	-- "ruby_ls",
	"sorbet",
	"lua_ls",
}

require("mason-lspconfig").setup({ ensure_installed = servers, automatic_installation = true })
