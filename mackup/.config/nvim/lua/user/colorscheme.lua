-- local colorscheme = "tokyonight"
-- vim.g.tokyonight_style = "night"

local colorscheme = "dracula"

local status_ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not status_ok then
  return
end
