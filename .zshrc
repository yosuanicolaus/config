# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
plugins=(git zsh-syntax-highlighting zsh-autosuggestions)
source $ZSH/oh-my-zsh.sh
eval $(thefuck --alias)

alias c=clear
alias t=touch
alias sz='source ~/.zshrc'
alias code=code-insiders
alias py='python3'
alias kittyupdate='curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin'

alias diary='export DIARY_FILE="$(date +'%y%m%d').md" && cd ~/codes/text/diary/ && touch $DIARY_FILE && nvim $DIARY_FILE'
alias cdiary='~/codes/text/diary/'
alias ndiary='~/codes/text/diary/ && nvim'
alias pdiary='~/codes/text/diary/ && git add . && git commit -m "diary update" && git push'

alias setclip="xclip -selection c"
alias getclip="xclip -selection c -o"

alias ct=~/codes/text/
alias cg=~/codes/godot/
alias cdd=~/Downloads/
alias cda=~/app/
alias ccn=~/.config/nvim/

alias cnvz='~ && nvim .zshrc'
alias cnvi='~ && nvim ~/.ideavimrc'
alias cnvc='~/.config/nvim/ && nvim lua/custom/mappings.lua'
alias cnvp='~/.config/nvim/ && nvim lua/custom/plugins.lua'
alias cnvl='~/.config/nvim/ && nvim lua/custom/configs/lspconfig.lua'
alias cnvk='~/.config/kitty/ && nvim kitty.conf'
alias cnvd='~/codes/text/diary/ && nvim'

alias nvz='nvim ~/.zshrc'
alias nvi='nvim ~/.ideavimrc'
alias nvc='nvim ~/.config/nvim/lua/custom/mappings.lua'
alias nvr='nvim --listen /tmp/nvim.pipe'
alias nvk='nvim ~/.config/kitty/kitty.conf'

alias gpfwl='git push --force-with-lease'
alias gfap='git fetch --all --prune'
alias grhm='git reset HEAD~1'
alias grhp='git reset HEAD@{1}'
alias wip='git add . && git commit -m "wip"'

codes() { ~/codes/$1 }
repos() { ~/repos/$1 }

# ----------------------------------------------------------------------------------------------------------------------------------------

# PRODUCTIVE ALIASES FOR WORK @ ODOO
# heavily inspired by wan's script https://gist.github.com/william-andre/5428d3e7dba179168016ca6211bdb07b

ODOO_ROOT=/home/yosuanicolaus/work

obranch() {
    com=$(git --git-dir=$ODOO_ROOT/odoo/.git branch --show-current)
    ent=$(git --git-dir=$ODOO_ROOT/enterprise/.git branch --show-current)
    if [ ${#com} -gt ${#ent} ]; then
        if [[ $com == $ent* ]]; then
            echo $com
        else
            >&2 echo "Error: Wrong branches"
            return 1
        fi
    else
        if [[ $ent == $com* ]]; then
            echo $ent
        else
            >&2 echo "Error: Wrong branches"
            return 1
        fi
    fi
}

obranchcom() {
    com=$(git --git-dir=$ODOO_ROOT/odoo/.git branch --show-current)
    echo $com
}

odel() {
    if [ "$#" -gt 1 ]; then
        echo "Illegal number of parameters"
        return
    elif [ "$#" -eq 1 ]; then
        br="$1"
    elif [ "$#" -eq 0 ]; then
        br="$('obranch')"
    fi 
    dropdb "$br"
}

odup() {
    if [ "$#" -ne 2  ]; then
        echo "Illegal number of parameters"
        return
    fi
    createdb -T "$1" "$2"
}

odebug() {
    dropdb debug
    createdb -T "$('obranch')" debug
}

otask() { 
    if [ -z "$1" ]; then
        microsoft-edge "https://www.odoo.com/web#action=333&active_id=967&model=project.task&view_type=kanban&cids=1&menu_id=4720"
    else
        microsoft-edge "https://www.odoo.com/web#id=$1&cids=1&menu_id=4720&action=333&active_id=967&model=project.task&view_type=form"
    fi
}

l1='--limit-time-cpu=99999999'
l2='--limit-time-real=99999999'
l3='--limit-memory-soft=17179869184'
l4='--limit-memory-hard=17179869184'
addons="--addons-path=$ODOO_ROOT/odoo/addons,$ODOO_ROOT/enterprise"
dev='--dev=xml,reload'

alias obin='db=$(obranch); [[ $db != 1  ]] && $ODOO_ROOT/odoo/odoo-bin --dev=xml,reload -d $db $l1 $l2 $l3 $l4 $addons $dev'
alias oshell='db=$(obranch); [[ $db != 1  ]] && $ODOO_ROOT/odoo/odoo-bin shell --shell-interface=ipython -d $db $addons'
alias obincom='$ODOO_ROOT/odoo/odoo-bin -d $(obranchcom) --addons-path=$ODOO_ROOT/odoo/addons'
alias obackup='odup $("obranch") $("obranch")-dup'
alias oreset='odel $("obranch") && odup $("obranch")-dup $("obranch")'
alias opopulate='db=$(obranch); [[ $db != 1  ]] && $ODOO_ROOT/odoo/odoo-bin populate -d $db --addons-path="$ODOO_ROOT/odoo/addons,$ODOO_ROOT/enterprise"'

alias otab='microsoft-edge "http://localhost:8069"'
alias omail='microsoft-edge "https://mail.google.com/mail/u/2/#inbox"'
alias otime='microsoft-edge "https://www.odoo.com/web#action=4528&model=hr.leave.report.calendar&view_type=gantt&cids=1&menu_id=6279"'

alias cw=~/work/
alias cwo=~/work/odoo/
alias cwe=~/work/enterprise/
alias cwu=~/work/upgrade/
alias cwd=~/work/documentation/
alias cwn=~/work/notes/

alias nvn='db=$(obranch); [[ $db != 1  ]] && touch "~/work/notes/$db.md" && nvim "~/work/notes/$db.md" '
alias cnvn='db=$(obranch); [[ $db != 1  ]] && ~/work/notes/ && touch "$db.md" && nvim "$db.md" '
alias codoo='code-insiders ~/work/odoo.code-workspace'

alias orun="~/work/odoo/odoo-bin $addons $dev"
alias oruncdb='db="db$(date +'%y%m%d%H%M%S')" && ~/work/odoo/odoo-bin --addons=~/work/odoo/addons,~/work/enterprise --dev=xml,reload -d $db'
alias otestcdb='db="db$(date +'%y%m%d%H%M%S')" && ~/work/odoo/odoo-bin --addons=~/work/odoo/addons,~/work/enterprise --stop-after-init --log-level=test -d $db'

alias nvb='nvim ~/work/notes/!branch.md'
alias cnvb='~/work/notes/ && nvim "!branch.md"'

ogit() {
    local current_dir=$(pwd)
    echo '------ odoo ------' && cd ~/work/odoo/ && git "$@" && echo '\n--- enterprise ---' && cd ~/work/enterprise/ && git "$@"
    cd "$current_dir" || return 1
}

ogfap() { ogit fetch --all --prune }
ogco() { ogit checkout "$1" }
ogb() { ogit branch "$1" }
ogrb() { [ -z "$1" ] && ogit rebase || ogit rebase "$1"; }
ogpfwl() { ogit push --force-with-lease }
ogst() { ogit status }

otest() { obin --stop-after-init --test-tags="$1" "${@:2}" }

# Unused anymore
# alias ndb='export db="db$(date +'%y%m%d%H%M%S')"'
# alias cdb='export db="db$(date +'%y%m%d%H%M%S')"'
# alias ocdb='export db="db$(date +'%y%m%d%H%M%S')" && ~/work/odoo/odoo-bin --addons=~/work/odoo/addons,~/work/enterprise --stop-after-init -d $db'
# alias orundb='~/work/odoo/odoo-bin --addons=~/work/odoo/addons,~/work/enterprise --dev=xml,reload -d $db'
# alias otestdb='~/work/odoo/odoo-bin --addons=~/work/odoo/addons,~/work/enterprise --stop-after-init --log-level=test -d $db'
# alias cwos=~/work/odoo-stubs/
# alias otest='~/work/odoo/odoo-bin --addons=~/work/odoo/addons,~/work/enterprise --stop-after-init --log-level=test'

# ----------------------------------------------------------------------------------------------------------------------------------------

# 230514 -> set PYTHONPATH to odoo 
# (2023-08-03 not sure it's necessary with the pycharm extension)
export PYTHONPATH=${PYTHONPATH}:${HOME}/work/odoo/

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# 230806 autocomplete with Tab
bindkey '^I' autosuggest-accept

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "/home/yosuanicolaus/.bun/_bun" ] && source "/home/yosuanicolaus/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# rust - 2023-11-12
. "$HOME/.cargo/env"
