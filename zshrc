# Created by newuser for 5.7.1

#
# Exports
#
module_path+=("$HOME/.zinit/bin/zmodules/Src"); zmodload zdharma/zplugin &>/dev/null

typeset -g HISTSIZE=290000 SAVEHIST=290000 HISTFILE=~/.zsh_history ABSD=${${(M)OSTYPE:#*(darwin|bsd)*}:+1}

typeset -ga mylogs
zflai-msg() { mylogs+=( "$1" ); }
zflai-assert() { mylogs+=( "$4"${${${1:#$2}:+FAIL}:-OK}": $3" ); }

(( ABSD )) && {
    export LSCOLORS=dxfxcxdxbxegedabagacad CLICOLOR="1"
}

export EDITOR="nvim" VISUAL="nvim" LESS="-iRFX" CVS_RSH="ssh"

umask 022

#
# Setopts
#

setopt interactive_comments hist_ignore_dups  octal_zeroes   no_prompt_cr
setopt no_hist_no_functions no_always_to_end  append_history list_packed
setopt inc_append_history   complete_in_word  no_auto_menu   auto_pushd
setopt pushd_ignore_dups    no_glob_complete  no_glob_dots   c_bases
setopt numeric_glob_sort    share_history  promptsubst    auto_cd
setopt rc_quotes            extendedglob      notify         correct_all

#setopt IGNORE_EOF
#setopt NO_SHORT_LOOPS
#setopt PRINT_EXIT_VALUE
#setopt RM_STAR_WAIT

#
# Bindkeys
#

autoload up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -e

key[Home]=${terminfo[khome]}
key[End]=${terminfo[kend]}
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}
key[Up]=${terminfo[kcuu1]}
key[Down]=${terminfo[kcud1]}
key[Left]=${terminfo[kcub1]}
key[Right]=${terminfo[kcuf1]}
key[PageUp]=${terminfo[kpp]}
key[PageDown]=${terminfo[knp]}

# setup key accordingly
[[ -n "${key[Home]}"    ]]  && bindkey  "${key[Home]}"    beginning-of-line
[[ -n "${key[End]}"     ]]  && bindkey  "${key[End]}"     end-of-line
[[ -n "${key[Insert]}"  ]]  && bindkey  "${key[Insert]}"  overwrite-mode
[[ -n "${key[Delete]}"  ]]  && bindkey  "${key[Delete]}"  delete-char
[[ -n "${key[Up]}"      ]]  && bindkey  "${key[Up]}"      up-line-or-history
[[ -n "${key[Down]}"    ]]  && bindkey  "${key[Down]}"    down-line-or-history
[[ -n "${key[Left]}"    ]]  && bindkey  "${key[Left]}"    backward-char
[[ -n "${key[Right]}"   ]]  && bindkey  "${key[Right]}"   forward-char
[[ -n "${key[PageUp]}"   ]]  && bindkey  "${key[PageUp]}"    history-beginning-search-backward
[[ -n "${key[PageDown]}" ]]  && bindkey  "${key[PageDown]}"  history-beginning-search-forward

zflai-assert "${+terminfo[kpp]}${+terminfo[knp]}${+terminfo[khome]}${+terminfo[kend]}" "1111" "terminfo test" "[zshrc] "

bindkey "^A"      beginning-of-line     "^E"      end-of-line
bindkey "^?"      backward-delete-char  "^H"      backward-delete-char
bindkey "^W"      backward-kill-word    "\e[1~"   beginning-of-line
bindkey "\e[7~"   beginning-of-line     "\e[H"    beginning-of-line
bindkey "\e[4~"   end-of-line           "\e[8~"   end-of-line
bindkey "\e[F"    end-of-line           "\e[3~"   delete-char
bindkey "^J"      accept-line           "^M"      accept-line
bindkey "^T"      accept-line           "^R"      history-incremental-search-backward

#
# Modules
#

zmodload -i zsh/complist

#
# Autoloads
#

zinit ice silent wait!1 atload"ZINIT[COMPINIT_OPTS]=-C; zpcompinit"

autoload -Uz allopt zed zmv zcalc colors
colors

autoload -Uz edit-command-line
zle -N edit-command-line
#bindkey -M vicmd v edit-command-line

autoload -Uz select-word-style
select-word-style shell

autoload -Uz url-quote-magic
zle -N self-insert url-quote-magic

zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}'

#
# Aliases
#

# Define aliases.
alias tree='tree -a -I .git'
alias vi=nvim
alias vim=nvim

alias norg="gron --ungron"
alias ungron="gron --ungron"

function mkcd() {
    mkdir -p $1
    cd $1
}

# extract files: depends on zip, unrar and p7zip
function ex {
    if [ -f $1 ] ; then
      case $1 in
        *.tar.bz2)   tar xjf $1     ;;
        *.tar.gz)    tar xzf $1     ;;
        *.bz2)       bunzip2 $1     ;;
        *.rar)       unrar e $1     ;;
        *.gz)        gunzip $1      ;;
        *.tar)       tar xf $1      ;;
        *.tbz2)      tar xjf $1     ;;
        *.tgz)       tar xzf $1     ;;
        *.zip)       unzip $1       ;;
        *.Z)         uncompress $1  ;;
        *.7z)        7z x $1        ;;
        *)     echo "'$1' cannot be extracted via ex()" ;;
         esac
     else
         echo "'$1' is not a valid file"
     fi
}

# find or create tmux session
function tat {
  name=$(basename `pwd` | sed -e 's/\.//g')

  if tmux ls 2>&1 | grep "$name"; then
    tmux attach -t "$name"
  elif [ -f .envrc ]; then
    direnv exec / tmux new-session -s "$name"
  else
    tmux new-session -s "$name"
  fi
}

# find and edit
function find_and_edit () {
  if test -d .git
  then
    SOURCE="$(git ls-files)"
  else
    SOURCE="$(find . -type f)"
  fi
  files="$(fzf --preview='bat --color=always --paging=never --style=changes {} | head -$FZF_PREVIEW_LINES' --select-1 --multi --query="$@" <<< "$SOURCE")"
  if [[ "$?" != "0" ]]
  then
    return 1
  fi
  vim $files
}

# Remove python compiled byte-code and mypy/pytest cache in either the current
# directory or in a list of specified directories (including sub directories).
function pyclean() {
    ZSH_PYCLEAN_PLACES=${*:-'.'}
    find ${ZSH_PYCLEAN_PLACES} -type f -name "*.py[co]" -delete
    find ${ZSH_PYCLEAN_PLACES} -type d -name "__pycache__" -delete
    find ${ZSH_PYCLEAN_PLACES} -depth -type d -name ".mypy_cache" -exec rm -r "{}" +
    find ${ZSH_PYCLEAN_PLACES} -depth -type d -name ".pytest_cache" -exec rm -r "{}" +
}

function man() {
    env \
    LESS_TERMCAP_mb=$(printf "\e[1;31m") \
    LESS_TERMCAP_md=$(printf "\e[1;31m") \
    LESS_TERMCAP_me=$(printf "\e[0m") \
    LESS_TERMCAP_se=$(printf "\e[0m") \
    LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
    LESS_TERMCAP_ue=$(printf "\e[0m") \
    LESS_TERMCAP_us=$(printf "\e[1;32m") \
    man "$@"
}

function cdf() {
    target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
    if [ "$target" != "" ]; then
        cd "$target"; pwd
    else
        echo 'No Finder window found' >&2
    fi
}

function realpath()
{
  CURR_PATH=$(pwd)
  TARGET_FILE=$1
  cd $(dirname ${TARGET_FILE})
  TARGET_FILE=$(basename ${TARGET_FILE})

  # Iterate down a (possible) chain of symlinks
  while [ -L "${TARGET_FILE}" ]
  do
      TARGET_FILE=$(readlink ${TARGET_FILE})
      cd $(dirname ${TARGET_FILE})
      TARGET_FILE=$(basename ${TARGET_FILE})
  done

  # Compute the canonicalized name by finding the physical path
  # for the directory we're in and appending the target file.
  PHYS_DIR=$(pwd -P)
  RESULT=${PHYS_DIR}/${TARGET_FILE}
  echo ${RESULT}
  cd ${CURR_PATH}
}

sudo-command-line() {
    [[ -z $BUFFER ]] && zle up-history
    if [[ $BUFFER == sudo\ * ]]; then
        LBUFFER="${LBUFFER#sudo }"
    elif [[ $BUFFER == $EDITOR\ * ]]; then
        LBUFFER="${LBUFFER#$EDITOR }"
        LBUFFER="sudoedit $LBUFFER"
    elif [[ $BUFFER == sudoedit\ * ]]; then
        LBUFFER="${LBUFFER#sudoedit }"
        LBUFFER="$EDITOR $LBUFFER"
    else
        LBUFFER="sudo $LBUFFER"
    fi
}
zle -N sudo-command-line
# Defined shortcut keys: [Esc] [Esc]
bindkey "\e\e" sudo-command-line
bindkey -M vicmd '\e\e' sudo-command-line

function bc_convert {
  echo "$@" | bc
}

# Median function
# Probably best to keep with Odd numbers
# $ median 5 7 3 4 9
# >>> 5
function median {
  echo  $@ | xargs -n1 | sort -n | sed -n $((($#+1)/2))p
}

# Mean function
function mean {
  # need to figure out how to take these from stdin and convert them to array
  test_nums=[1,2,3,4,5]
  mean=$(python -c "print(sum($test_nums) / len($test_nums))")
  echo $mean
}

function ip {
    curl -Ss icanhazip.com
}

function ips {
    ifconfig | grep "inet " | awk '{ print $2 }'
    echo "External: $(ip)"
}


alias calc="bc_convert"
alias pl='print -rl --'
alias ls='lsd -l'
alias l='lsd -l'
alias la='ls -lah'
alias lla='ls -lah'
alias ltree='ls --tree'
alias k="k -A"
alias l.='ls -d .*'   la='ls -lah'   ll='ls -lbt created'  l='la' rm='command rm -i'
alias df='df -h'  du='du -h'      cp='cp -v'   mv='mv -v'      plast="last -20"

# Image Magick
alias imgsize="identify -format '%w, %h\n'"

# Quick typing
alias n1ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias n1ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias n1sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias n1httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

alias newest_ls="ls -lh --sort date -r --color=always | head -25"
alias cpfile="rsync --progress"
alias recently_changed='find . -newerct "15 minute ago" -print'
recently_changed_x() { find . -newerct "$1 minute ago" -print; }


function lsgrep {
    export needle=$(echo $1 | sed -E 's/\.([a-z0-9]+)$/\\.\1/' | sed -E 's/\?/./' | sed -E 's/[ *]/.*?/g')
    command ag --depth 3 -S -g "$needle" 2>/dev/null
}

function lt {
    ls -Atr1 $1 && echo "⇡⎽⎽⎽⎽Newest⎽⎽⎽⎽⇡"
}

function ltr {
    ls -At1 $1 && echo "⇡⎽⎽⎽⎽Oldest⎽⎽⎽⎽⇡"
}

whichcomp() {
    for 1; do
        ( print -raC 2 -- $^fpath/${_comps[$1]:?unknown command}(NP*$1*) )
    done
}

osxnotify() {
    osascript -e 'display notification "'"$*"'"'
}

# Set shell options: http://zsh.sourceforge.net/Doc/Release/Options.html.
setopt glob_dots     # no special treatment for file names with a leading dot
setopt no_auto_menu  # require an extra TAB press to open the completion menu
alias zmv='noglob zmv -w'
alias recently_changed='find . -newerct "15 minute ago" -print'
recently_changed_x() { find . -newerct "$1 minute ago" -print; }
alias -g SPRNG=" | curl -F 'sprunge=<-' http://sprunge.us"

#
# Patches for various problems
#

fpath+=( $HOME/.config/home-manager/zsh-functions)

autoload -Uz psprobe_host   psffconv    pssetup_ssl_cert    psrecompile    pscopy_xauth  \
             psls           pslist      psfind \
             mandelbrot     optlbin_on  optlbin_off         localbin_on    localbin_off    g1all   g1zip \
             zman \
             t1uncolor 	    t1fromhex   t1countdown \
             f1rechg_x_min  f1biggest \
             n1gglinks      n1dict      n1diki              n1gglinks      n1ggw3m         n1ling  n1ssl_tunnel \
	     n1ssl_rtunnel  \
             pngimage       deploy-code deploy-message

autoload +X zman
functions[zzman]="${functions[zman]}"
function run_diso {
  sh -c "$@" &
  disown
}

function pbcopydir {
  pwd | tr -d "\r\n" | pbcopy
}

function ip {
    curl -Ss icanhazip.com
}

function ips {
    ifconfig | grep "inet " | awk '{ print $2 }'
    echo "External: $(ip)"
}

function update {
    echo "update brew, zsh, zinit and mac app store"
    echo 'start updating ...'

    echo 'updating zsh shell'
    zinit self-update
    zinit update -p

    echo 'checking Apple Updates'
    /usr/sbin/softwareupdate -ia
}

function from-where {
    echo $^fpath/$_comps[$1](N)
    whence -v $_comps[$1]
    #which $_comps[$1] 2>&1 | head
}

localbin_on

#PS1="READY > "
zstyle ":plugin:zconvey" greeting "none"
zstyle ':notify:*' command-complete-timeout 3
zstyle ':notify:*' notifier plg-zsh-notify

palette() { local colors; for n in {000..255}; do colors+=("%F{$n}$n%f"); done; print -cP $colors; }

zflai-msg "[zshrc] ssl tunnel PID: $!"

#
# Zplugin
#

typeset -F4 SECONDS=0

[[ ! -f ~/.zinit/bin/zinit.zsh ]] && {
    command mkdir -p ~/.zinit
    command git clone https://github.com/zdharma-continuum/zinit ~/.zinit/bin
}

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Zplugin annexes
# zdharma-continuum/z-a-man \
zinit light-mode for \
    zdharma-continuum/z-a-test \
    zdharma-continuum/z-a-patch-dl \
    zdharma-continuum/z-a-submods \
    zdharma-continuum/z-a-bin-gem-node \
    zdharma-continuum/z-a-rust

# Fast-syntax-highlighting & autosuggestions
zinit wait lucid for \
 atinit"ZINIT[COMPINIT_OPTS]=-C; zpcompinit; zpcdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
 atload"!_zsh_autosuggest_start" \
    zsh-users/zsh-autosuggestions \
 blockf \
    zsh-users/zsh-completions

# lib/git.zsh is loaded mostly to stay in touch with the plugin (for the users)
# and for the themes 2 & 3 (lambda-mod-zsh-theme & lambda-gitster)
zinit wait lucid for \
    zdharma-continuum/zsh-unique-id \
    OMZ::lib/git.zsh \
 atload"unalias grv g" \
    OMZ::plugins/git/git.plugin.zsh

# zunit, color
zinit wait"2" lucid as"null" for \
 sbin atclone"./build.zsh" atpull"%atclone" \
    molovo/zunit \
 sbin"color.zsh -> color" \
    molovo/color

# revolver
zinit wait"2" lucid as"program" pick"revolver" for molovo/revolver

# On OSX, you might need to install coreutils from homebrew and use the
# g-prefix – gsed, gdircolors
: zinit wait"0c" lucid reset \
 atclone"local P=${${(M)OSTYPE:#*darwin*}:+g}
        \${P}sed -i \
        '/DIR/c\DIR 38;5;63;1' LS_COLORS; \
        \${P}dircolors -b LS_COLORS > c.zsh" \
 atpull'%atclone' pick"c.zsh" nocompile'!' \
 atload'zstyle ":completion:*:default" list-colors "${(s.:.)LS_COLORS}";' for \
    trapd00r/LS_COLORS

# Zconvey shell integration plugin
zinit wait lucid \
 sbin"cmds/zc-bg-notify" sbin"cmds/plg-zsh-notify" for \
    zdharma-continuum/zconvey

# zsh-startify, a vim-startify like plugin
: zinit wait"0b" lucid atload"zsh-startify" for zdharma-continuum/zsh-startify
zinit wait lucid pick"manydots-magic" compile"manydots-magic" for knu/zsh-manydots-magic

# fzy
zinit wait"1" lucid as"program" pick"$ZPFX/bin/fzy*" \
 atclone"cp contrib/fzy-* $ZPFX/bin/" \
 make"!PREFIX=$ZPFX install" for \
    jhawthorn/fzy

# zsh-autopair
# fzf-marks, at slot 0, for quick Ctrl-G accessibility
zinit wait lucid for \
    hlissner/zsh-autopair \
    urbainvaes/fzf-marks


zinit lucid for \
    as"command" \
    from"gh-r" \
    atinit'export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"' atload'eval "$(starship init zsh)"' \
    starship/starship

# aditional plugins
zinit ice wait lucid
zinit light 'supercrabtree/k'

zinit ice wait lucid
zinit light 'wookayin/fzf-fasd'

zinit ice wait lucid
zinit light 'RobertAudi/tsm'

zinit ice wait lucid
zinit light 'le0me55i/zsh-extract'

zinit wait lucid atload"zicompinit; zicdreplay" blockf for \
    'esc/conda-zsh-completion'

# A few wait1 plugins
zinit wait"1" lucid for \
    psprint/zsh-navigation-tools \
 atinit'zstyle ":history-search-multi-word" page-size "7"' \
    zdharma-continuum/history-search-multi-word \
 atinit"local zew_word_style=whitespace" \
    psprint/zsh-editing-workbench

# Gitignore plugin – commands gii and gi
zinit wait"2" lucid trigger-load'!gi;!gii' \
 dl'https://gist.githubusercontent.com/psprint/1f4d0a3cb89d68d3256615f247e2aac9/raw -> templates/Zsh.gitignore' \
 for \
    voronkovich/gitignore.plugin.zsh

# F-Sy-H automatic themes – available for patrons
# https://patreon.com/psprint
: zinit wait"1" lucid from"psprint@gitlab.com" for psprint/fsh-auto-themes

# ogham/exa, sharkdp/fd, fzf
zinit wait"2" lucid as"null" from"gh-r" for \
    mv"exa* -> exa" sbin  ogham/exa \
    mv"fd* -> fd" sbin"fd/fd"  @sharkdp/fd \
    sbin junegunn/fzf-bin

# A few wait'2' plugins
zinit wait"2" lucid for \
    zdharma-continuum/declare-zsh \
    zdharma-continuum/zflai \
 blockf \
    zdharma-continuum/zui \
    zdharma-continuum/zinit-console \
 atinit"forgit_ignore='fgi'" \
    wfxr/forgit

# git-cal
zinit wait"2" lucid as"null" \
 atclone'perl Makefile.PL PREFIX=$ZPFX' \
 atpull'%atclone' make sbin"git-cal" for \
    k4rthik/git-cal

# A few wait'3' git extensions
zinit as"null" wait"3" lucid for \
    sbin Fakerr/git-recall \
    sbin paulirish/git-open \
    sbin paulirish/git-recent \
    sbin davidosomething/git-my \
    sbin atload"export _MENU_THEME=legacy" \
        arzzen/git-quick-stats \
    make"PREFIX=$ZPFX"         tj/git-extras \
    sbin"bin/git-dsf;bin/diff-so-fancy" zdharma-continuum/zsh-diff-so-fancy \
    sbin"git-url;git-guclone" make"GITURL_NO_CGITURL=1" zdharma-continuum/git-url

# Notifications, configured to use zconvey
: zinit wait lucid for marzocchi/zsh-notify

zflai-msg "[zshrc] Zplugin block took ${(M)$(( SECONDS * 1000 ))#*.?} ms"


# Zstyles & other
#

zle -N znt-kill-widget
bindkey "^[kk" znt-kill-widget

cdpath=( "$HOME" "$HOME/development" "$HOME/Downloads" )

zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:*:descriptions' format $'%{\e[0;33m%} %B%d%b%{\e[0m%}'
zstyle ':completion:*:*:*:default' menu yes select search
zstyle ':completion:*' completer _complete _correct _approximate
zstyle ':completion:*' max-errors 3 numeric
zstyle ':completion::complete:*' gain-privileges 1
#zstyle ":completion:*" list-colors “${(s.:.)LS_COLORS}”

source /Users/sadanand/.zinit/plugins/tj---git-extras/etc/git-extras-completion.zsh

function double-accept { deploy-code "BUFFER[-1]=''"; }
zle -N double-accept
bindkey -M menuselect '^F' history-incremental-search-forward
bindkey -M menuselect '^R' history-incremental-search-backward
bindkey -M menuselect ' ' .accept-line

function mem() { ps -axv | grep $$  }

zflai-msg "[zshrc] Finishing, loaded custom modules: ${(j:, :@)${(k)modules[@]}:#zsh/*}"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Ensure path arrays do not contain duplicates.
typeset -gU cdpath fpath mailpath path

# Set the list of directories that Zsh searches for programs.
path=(
  $path
)

export PATH

# conda liases
alias py3="conda activate dev"
alias unload_py="conda deactivate"
alias update_py="conda update --all"

# pnpm
export PNPM_HOME="/Users/sadanand/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/Volumes/Development/anaconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/Volumes/Development/anaconda3/etc/profile.d/conda.sh" ]; then
        . "/Volumes/Development/anaconda3/etc/profile.d/conda.sh"
    else
        export PATH="/Volumes/Development/anaconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# compdef based functions

function md() { [[ $# == 1 ]] && mkdir -p -- "$1" && cd -- "$1" }
compdef _directories md

function gi() { curl -fLw '\n' https://www.gitignore.io/api/"${(j:,:)@}" }

_gitignoreio_get_command_list() {
  curl -sfL https://www.gitignore.io/api/list | tr "," "\n"
}

_gitignoreio () {
  compset -P '*,'
  compadd -S '' `_gitignoreio_get_command_list`
}

compdef _gitignoreio gi
