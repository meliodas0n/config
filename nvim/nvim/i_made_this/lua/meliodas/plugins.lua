local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  -- my plugins starts here.....
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use 'nvim-lualine/lualine.nvim'
  use 'Mofiqul/vscode.nvim'
  use {'neoclide/coc.nvim', branch = 'release'}
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'
  use 'jiangmiao/auto-pairs'
  use 'sheerun/vim-polyglot'
  use 'Yggdroot/indentLine'
  use 'powerline/powerline-fonts'
  use 'mattn/emmet-vim'
  use 'alvan/vim-closetag'
  use 'AndrewRadev/tagalong.vim'
  use 'luochen1990/rainbow'
  use 'bling/vim-bufferline'
  use 'vim-airline/vim-airline'
  use 'vim-airline/vim-airline-themes'
  use 'EdenEast/nightfox.nvim'
  -- my plugins ends here.......
  if packer_bootstrap then
    require('packer').sync()
  end
end)
