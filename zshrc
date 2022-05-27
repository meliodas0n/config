# my aliases
alias g=g++
alias p=python3
alias pip=pip3
alias UU="sudo apt-get update && sudo apt full-upgrade -y"
alias up="sudo apt-get update"
alias ug="sudo apt full-upgrade -y"
alias install="sudo apt-get install -y"
alias tmux="tmux -u -2"
alias jn="jupyter notebook"
alias copy="xclip -sel c < "
alias chrome="google-chrome"


# colorls
if [ -x "$(command -v colorls)" ]; then
    alias ls="colorls"
    alias lt="colorls --tree"
    alias la="colorls -al"
fi
