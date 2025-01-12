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

alias ls=exa  # https://the.exa.website/ "modern replacement for ls"
alias c=clear
alias t=touch
alias sz='source ~/.zshrc'
alias code=code-insiders
alias py=python3
alias ipy=ipython3
alias kittyupdate='curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin'
alias wezterm='flatpak run org.wezfurlong.wezterm'
alias lg=lazygit

alias diary='export DIARY_FILE="$(date +'%y%m%d').md" && cd ~/codes/obsidian/ && touch diary/$DIARY_FILE && nvim diary/$DIARY_FILE'
alias buffer='export BUFFER_FILE="b$(date +'%y%m%d').md" && cd ~/codes/obsidian/ && touch buffer/$BUFFER_FILE && nvim buffer/$BUFFER_FILE'
alias cdiary='~/codes/obsidian/diary/'
alias cdob='~/codes/obsidian/'
alias cnvo='~/codes/obsidian/ && nvim README.md'
alias obsync='~/codes/obsidian/ && git add . && git commit -m "obsidian update" && git push'

alias irust=evcxr
alias icpp=termic++
alias rcph="RUST_BACKTRACE=1 cargo run --manifest-path ~/repos/rust-competitive-helper/Cargo.toml"

alias setclip="xclip -selection c"
alias getclip="xclip -selection c -o"

alias ccn='cd ~/.config/nvim/'
alias cda='cd ~/app/'
alias cdd='cd ~/Downloads/'
alias cg='cd ~/codes/godot/'
alias ct='cd ~/codes/obsidian/'
alias ccr='cd ~/codes/competitive-rust/'
alias cu='cd ~/codes/university/'

alias cnvc='~/.config/nvim/ && nvim'
alias cnvd='~/codes/obsidian/diary/ && nvim'
alias cnve='~/.config/espanso/ && nvim match/base.yml'
alias cnvi='~ && nvim ~/.ideavimrc'
alias cnvk='~/.config/kitty/ && nvim kitty.conf'
alias cnvrc='~/repos/config/ && nvim'
alias cnvz='~ && nvim .zshrc'
alias cnvrcph='~/.config/rust-competitive-helper/ && nvim rust-competitive-helper.toml'
alias cnvw='~/.config/wezterm/ && nvim'
alias cnvcr="~/codes/competitive-rust/ && nvim --listen localhost:3708"

alias nvc='nvim ~/.config/nvim/lua/mappings.lua'
alias nve='nvim ~/.config/espanso/match/base.yml'
alias nvi='nvim ~/.ideavimrc'
alias nvk='nvim ~/.config/kitty/kitty.conf'
alias nvr='nvim --listen /tmp/nvim.pipe'
alias nvz='nvim ~/.zshrc'
alias nvrcph='nvim ~/.config/rust-competitive-helper/rust-competitive-helper.toml'
alias nvcr="nvim --listen localhost:3708"

alias gfap='git fetch --all --prune'
alias grhm='git reset HEAD~1'    # "git reset head minus"
alias grhp='git reset HEAD@{1}'  # "git reset head plus"

unalias gwip
gwip() {
    git add . && git commit -m "[IMP] WIP/to-squash: $*"
}

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
    echo $(git --git-dir=$ODOO_ROOT/odoo/.git branch --show-current)
}

obranchfin() {
    echo $(git --git-dir=$ODOO_ROOT/odoofin/.git branch --show-current)
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

ofdel() {
    odel $(obranchfin)
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
        xdg-open "https://www.odoo.com/odoo/project/967/tasks?cids=1"
    else
        xdg-open "https://www.odoo.com/odoo/project/967/tasks/$1?cids=1"
    fi
}

oexpire() {
    psql -d "$('obranch')" -c "update ir_config_parameter set value='2060-05-05' where key='database.expiration_date';"
}

l1='--limit-time-cpu=99999999'
l2='--limit-time-real=99999999'
l3='--limit-memory-soft=17179869184'
l4='--limit-memory-hard=17179869184'
addons="--addons-path=$ODOO_ROOT/odoo/addons,$ODOO_ROOT/enterprise"
addons_iap="--addons-path=$ODOO_ROOT/odoo15/addons,$ODOO_ROOT/enterprise15/,$ODOO_ROOT/iap-apps/iap_services/,$ODOO_ROOT/iap-apps/iap_common/"
addons_with_fin="--addons-path=$ODOO_ROOT/odoo/addons,$ODOO_ROOT/enterprise,$ODOO_ROOT/odoofin"
addons_with_upgrade="--addons-path=$ODOO_ROOT/odoo/addons,$ODOO_ROOT/enterprise,$ODOO_ROOT/upgrade,$ODOO_ROOT/upgrade-util"
dev='--dev=xml,reload'
param_fin_1="--http-port="6969""
param_fin_2="--unaccent"

alias tobin='db=$(obranch); [[ $db != 1  ]] && $ODOO_ROOT/odoo/odoo-bin -d $db $l1 $l2 $l3 $l4 $dev --addons-path=$ODOO_ROOT/odoo/addons,$ODOO_ROOT/enterprise,$ODOO_ROOT/tutorials'
alias obin='db=$(obranch); [[ $db != 1  ]] && $ODOO_ROOT/odoo/odoo-bin -d $db $l1 $l2 $l3 $l4 $addons $dev'

alias ibin='$ODOO_ROOT/odoo15/odoo-bin -d peppol-iap-db $l1 $l2 $l3 $l4 $addons_iap $dev -p 8070'
alias ishell='$ODOO_ROOT/odoo15/odoo-bin shell --shell-interface=ipython -d peppol-iap-db $addons_iap'

# odoofin legacy
alias ofbin='db=odoofin; [[ $db != 1  ]] && $ODOO_ROOT/odoo/odoo-bin -d $db $l1 $l2 $l3 $l4 $addons_with_fin $dev $param_fin_1 $param_fin_2'
alias obinf='db=$(obranchfin); [[ $db != 1  ]] && $ODOO_ROOT/odoo/odoo-bin -d $db $l1 $l2 $l3 $l4 $addons_with_fin $dev $param_fin_1 $param_fin_2'
# odoofin docker 
alias ofin='db=$(obranchfin); [[ $db != 1  ]] && $ODOO_ROOT/odoofin/odoofin -d $db $l1 $l2 $l3 $l4 $dev $param_fin_1 $param_fin_2'
 
alias oshell='db=$(obranch); [[ $db != 1  ]] && $ODOO_ROOT/odoo/odoo-bin shell --shell-interface=ipython -d $db $addons'
alias oshellupg='db=$(obranch); [[ $db != 1  ]] && $ODOO_ROOT/odoo/odoo-bin shell --shell-interface=ipython -d $db $addons_with_upgrade'
alias obincom='$ODOO_ROOT/odoo/odoo-bin -d $(obranchcom) --addons-path=$ODOO_ROOT/odoo/addons'
alias obackup='odup $("obranch") $("obranch")-dup'
alias oreset='odel $("obranch") && odup $("obranch")-dup $("obranch")'
alias opopulate='db=$(obranch); [[ $db != 1  ]] && $ODOO_ROOT/odoo/odoo-bin populate -d $db --addons-path="$ODOO_ROOT/odoo/addons,$ODOO_ROOT/enterprise"'

alias otab='xdg-open "http://localhost:8069"'
alias omail='xdg-open "https://mail.google.com/mail/u/2/#inbox"'
alias otime='xdg-open "https://www.odoo.com/web#action=4528&model=hr.leave.report.calendar&view_type=gantt&cids=1&menu_id=6279"'

alias cw=~/work/
alias cwo=~/work/odoo/
alias cwe=~/work/enterprise/
alias cwu=~/work/upgrade/
alias cwuu=~/work/upgrade-util/
alias cwd=~/work/documentation/
alias cwn=~/work/notes/
alias cwf=~/work/odoofin/
alias cwi=~/work/iap-apps/

# alias nvn='db=$(obranch); [[ $db != 1  ]] && touch "~/work/notes/$db.md" && nvim "~/work/notes/$db.md" '
alias cnvn='db=$(obranch); [[ $db != 1  ]] && ~/work/notes/ && nvim "$db.md"'
alias cnvnx='db=$(obranch); [[ $db != 1  ]] && ~/work/notes/ && touch "$db.md" && nvim "$db.md" '
alias codoo='code-insiders ~/work/odoo.code-workspace'

# alias orun="~/work/odoo/odoo-bin $addons $dev"
# alias oruncdb='db="db$(date +'%y%m%d%H%M%S')" && ~/work/odoo/odoo-bin --addons=~/work/odoo/addons,~/work/enterprise --dev=xml,reload -d $db'
# alias otestcdb='db="db$(date +'%y%m%d%H%M%S')" && ~/work/odoo/odoo-bin --addons=~/work/odoo/addons,~/work/enterprise --stop-after-init --log-level=test -d $db'

alias nvb='nvim ~/work/notes/!branch.md'
alias cnvb='~/work/notes/ && nvim "!branch.md"'

ogh() {
    local current_dir=$(pwd)
    echo '------ odoo ------' && cd ~/work/odoo/ && gh "$@" &&
      echo '\n--- enterprise ---' && cd ~/work/enterprise/ && gh "$@"
    cd "$current_dir" || return 1
}

ogit() {
    local current_dir=$(pwd)
    echo '------ odoo ------' && cd ~/work/odoo/ && git "$@" &&
      echo '\n--- enterprise ---' && cd ~/work/enterprise/ && git "$@"
    cd "$current_dir" || return 1
}

ofgit() {
    local current_dir=$(pwd)
    ogit "$@" && echo '\n---- odoofin -----' && cd ~/work/odoofin/ && git "$@"
    cd "$current_dir" || return 1
}

ougit() {
    local current_dir=$(pwd)
    ogit "$@" && echo '\n---- upgrade -----' && cd ~/work/upgrade/ && git "$@"
    cd "$current_dir" || return 1
}

oigit() {
    local current_dir=$(pwd)
    ogit "$@" && echo '\n---- iap-apps -----' && cd ~/work/iap-apps/ && git "$@"
    cd "$current_dir" || return 1
}

otest() { obin --stop-after-init --test-tags="$1" "${@:2}" }
oftest() { ofbin --stop-after-init --test-tags="$1" "${@:2}" }

# 240215
ogfa() { ogit fetch --all --prune }
ogco() { ogit checkout "$1" }
ogb() { ogit branch "$1" }
ogrb() { [ -z "$1" ] && ogit rebase || ogit rebase "$1"; }
ogp() { ogit push }
ogpf() { ogit push --force-with-lease --force-if-includes }
ogst() { ogit status }

# 240314 include odoofin with 'ofg' prefix instead of 'og'
ofgfa() { ofgit fetch --all --prune }
ofgco() { ofgit checkout "$1" }
ofgb() { ofgit branch "$1" }
ofgrb() { [ -z "$1" ] && ofgit rebase || ofgit rebase "$1"; }
ofgpf() { ofgit push --force-with-lease --force-if-includes }
ofgst() { ofgit status }

# 240529 include upgrade with 'oug'
ougfa() { ougit fetch --all --prune }
ougco() { ougit checkout "$1" }
ougb() { ougit branch "$1" }
ougrb() { [ -z "$1" ] && ougit rebase || ougit rebase "$1"; }
ougpf() { ougit push --force-with-lease --force-if-includes }
ougst() { ougit status }

# 250110 include iap-apps with 'oig*'
oigst() { oigit status }

# ----------------------------------------------------------------------------------------------------------------------------------------
# Work Aliases END -----------------------------------------------------------------------------------------------------------------------
# ----------------------------------------------------------------------------------------------------------------------------------------

# 230514 -> set PYTHONPATH to odoo 
# (2023-08-03 not sure it's necessary with the pycharm extension)
export PYTHONPATH=${PYTHONPATH}:${HOME}/work/odoo/

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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

# zoxide and fzf - 240215
eval "$(zoxide init --cmd cd zsh)"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# 230806 autocomplete with Tab, update 240215
bindkey '^I' autosuggest-accept
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

# 240405 Kattis CLI - submit competitive programming problem to Kattis
export PATH="$PATH:/home/yosuanicolaus/.kattis"

# 240601 add ~/app/bin/ to $PATH
export PATH="$PATH:/home/yosuanicolaus/app/bin"

# 240812 add Go language
export PATH=$PATH:/usr/local/go/bin

# 241222 add DOOMEMACS (letsgo!!) 241224 wait... spacemacs ?! letsgo!!
export PATH="$HOME/.emacs.d/bin:$PATH"
# alias emacs="emacsclient -c -a 'emacs'"

# 240911 ensure xmodmap run as often as possible
xmodmap ~/.Xmodmap
# update 241210; found input remapper (prebuilt mint app), the GOAT for this! ... update: nvm
# xmodmap -e "keycode 64 = Mode_switch"
