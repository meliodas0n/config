-- Set the background to dark
vim.opt.background = "dark"

-- Use the system clipboard
vim.opt.clipboard = "unnamedplus"

-- Configure completion options
vim.opt.completeopt = { "noinsert", "menuone", "noselect" }

-- Enable cursorline
vim.opt.cursorline = true

-- Enable hidden buffers
vim.opt.hidden = true

-- Incremental command execution with split screen
vim.opt.inccommand = "split"

-- Enable mouse support
vim.opt.mouse = "a"

-- Show line numbers
vim.opt.number = true

-- Show relative line numbers
vim.opt.relativenumber = true

-- Open splits below and to the right
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Set the title of the terminal window
vim.opt.title = true

-- Disable timeout for key sequences
vim.opt.ttimeoutlen = 0

-- Enable the wildmenu
vim.opt.wildmenu = true

-- Set tabs to spaces, with a width of 2 spaces
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2

-- Set transparency for the Normal highlight group
vim.cmd([[command! -nargs=0 Prettier :lua require'coc'.action('runCommand', 'prettier.formatFile')]])

-- Colorscheme
vim.cmd('colorscheme nightfox')

-- Set leader key for emmet
vim.g.user_emmet_leader_key = ','

-- Enable the airline tabline extension
vim.g.airline_extensions_tabline_enabled = 1

-- Use Powerline fonts for airline
vim.g.airline_powerline_fonts = 1

-- Set the airline theme to "apprentice"
vim.g.airline_theme = "apprentice"

-- Enable rainbow parentheses highlighting
vim.g.rainbow_active = 1

-- Disable indentLine color changes
vim.g.indentLine_setColors = 0

-- Set the character for indentLine
vim.g.indentLine_char = '┊'

-- Customize the list of characters for indentLine
vim.g.indentLine_char_list = {'|', '¦', '┆', '┊'}

