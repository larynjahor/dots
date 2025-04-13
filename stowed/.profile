# eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH="$PATH:$(go env GOPATH)/bin"

export RED='\033[0;31m'
export YELLOW='\033[0;33m'
export GREEN='\033[0;32m'
export NC='\033[0m'

# export PATH=~/neovim/build/bin:~/bin:~/.local/bin:$PATH
export NAME=jahor
export EDITOR=nvim

export LS_COLORS="di=01;34:ln=01;93:ex=01;31:or=01;90:cd=01;35:fi=01;32"
export NNN_FCOLORS="010104010203030808050505"

[ $(uname) = Linux ] && alias ls="ls --color=auto" || alias ls="ls -G"
[ $(uname) = Darwin ] && export LANG=ru_RU.UTF-8

export FZF_OPTS="--color=16"

alias cdf="cd \$(find * -type d 2>/dev/null | fzf)"
alias dcd="docker compose down"
alias dcu="docker compose up -d"
alias dcl="docker compose logs"
alias dcr="docker compose restart"
alias dc="docker compose"
alias x="startx"
alias please="sudo"
alias drun="docker run --rm --name temp -it -v $PWD:/app -w /app "

cd() {
    if [[ -o interactive ]]; then 
        builtin cd "$@" 2>/dev/null && ls || printf "${RED}No such directory${NC}: ${YELLOW}${@}${NC}\n"
    else
        builtin cd "$@"
    fi
}

vim () {
    if [[ -z "$@" ]]; then
        nvim .
    else
        nvim "$@"
    fi
}

[ ! -s ~/.config/mpd/mpd.pid ] && mpd 2> /dev/null
[ -f ~/.cargo/env ] && . "$HOME/.cargo/env"

pidof picom >/dev/null || picom -b 2>/dev/null >/dev/null

