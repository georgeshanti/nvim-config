vim.g.mapleader = " "

vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>gd", function()
	local pos = vim.api.nvim_win_get_cursor(0)
	vim.cmd.tabnew('%')
	vim.api.nvim_win_set_cursor(0, pos)
	vim.lsp.buf.definition()
end)
vim.keymap.set("n", "te", vim.cmd.tabprev)
vim.keymap.set("n", "tr", vim.cmd.tabnext)
vim.keymap.set("n", "tt", vim.cmd.tabnew)
vim.keymap.set("n", "tw", vim.cmd.tabclose)
