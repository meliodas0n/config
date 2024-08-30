-- Lua:
-- For dark theme (neovim's default)
vim.o.background = 'dark'

local c = require('vscode.colors').get_colors()
require('vscode').setup({
    -- Disable nvim-tree background color
    disable_nvimtree_bg = true,
})
require('vscode').load()
