local status_ok, lualine = pcall(require, "lualine")
if not status_ok then
 		return
end

lualine.setup({
  sections = {
    lualine_c = {
      { "filename", path = 1 },
      {
        require("nvim-possession").status,
        cond = function()
            return require("nvim-possession").status() ~= nil
        end,
      },
    },
  },
  inactive_sections = {
    lualine_c = { { "filename", path = 1 } },
  },
	options = {
		theme = "dracula-nvim",
	},
})
