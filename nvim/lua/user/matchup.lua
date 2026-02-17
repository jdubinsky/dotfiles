local status_ok, matchup = pcall(require, "anymass/vim-matchup")
if not status_ok then
 		return
end

matchup.setup({})
