vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Navigate to the previous buffer with F2
vim.api.nvim_set_keymap('n', '<F2>', ':bprevious<CR>', { noremap = true, silent = true })

-- Navigate to the next buffer with F3
vim.api.nvim_set_keymap('n', '<F3>', ':bnext<CR>', { noremap = true, silent = true })

-- Autoformat with F4 (you may need to replace 'Autoformat' with the actual command you use)
vim.api.nvim_set_keymap('n', '<F4>', ':Autoformat<CR>', { noremap = true, silent = true })

-- Use Tab to select the autocompletion option when available, otherwise, insert a Tab character
vim.api.nvim_set_keymap('i', '<Tab>', 'pumvisible() ? coc#_select_confirm() : "<Tab>"', { expr = true, noremap = true })

-- Toggle Tagbar with F8
vim.api.nvim_set_keymap('n', '<F8>', ':TagbarToggle<CR>', { noremap = true, silent = true })

-- Split and open terminal with F6
vim.api.nvim_set_keymap('n', '<F6>', ':sp<CR>:terminal<CR>', { noremap = true, silent = true })

-- Navigate to the previous tab with Shift-Tab
vim.api.nvim_set_keymap('n', '<S-Tab>', 'gT', { noremap = true })

-- Navigate to the next tab with Tab
vim.api.nvim_set_keymap('n', '<Tab>', 'gt', { noremap = true })

-- Create a new tab with Shift-t
vim.api.nvim_set_keymap('n', '<silent> <S-t>', ':tabnew<CR>', { noremap = true })

