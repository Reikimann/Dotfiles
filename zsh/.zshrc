# Misc
unsetopt beep
setopt autocd		# Automatically cd into typed directory.
stty stop undef		# Disable ctrl-s to freeze terminal.
setopt interactive_comments

# Enable colors
autoload -U colors && colors

# History in state directory:
HISTFILE="${XDG_STATE_HOME}"/zsh/history
HISTSIZE=1000
SAVEHIST=1000

# comp
zstyle :compinstall filename '$ZDOTDIR/.zshrc'
zstyle ':completion:*' menu select
autoload -Uz compinit
zmodload zsh/complist
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"
_comp_options+=(globdots) # Include hidden files

# Prompt ZSH
autoload -Uz promptinit
promptinit
PS1="%B%{$fg[red]%}[%{$fg[yellow]%}%n%{$fg[green]%}@%{$fg[blue]%}%M %{$fg[magenta]%}%~%{$fg[red]%}]%{$reset_color%}$%b "
# prompt walters

# Vi mode
bindkey -v
export KEYTIMEOUT=1

# Use vim keys in tab complete menu
bindkey -M menuselect "h" vi-backward-char
bindkey -M menuselect "j" vi-down-line-or-history
bindkey -M menuselect "k" vi-up-line-or-history
bindkey -M menuselect "l" vi-forward-char

# Edit line in vim with ctrl-e
autoload edit-command-line; zle -N edit-command-line
bindkey "^e" edit-command-line

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'
  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  #elif [[ ${KEYMAP} == viopp ]] ||
  #     [[ $1 = 'underline' ]]; then
  #  echo -ne '\e[3 q'
  fi
}
zle -N zle-keymap-select
zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init
echo -ne '\e[5 q' # Use beam shape cursor on startup.
preexec() { echo -ne '\e[5 q' ;} # Use beam shape cursor for each new prompt.


# Use lf to switch directories and bind it to ctrl-o
lfcd () {
    tmp="$(mktemp)"
    lf -last-dir-path="$tmp" "$@"
    if [ -f "$tmp" ]; then
        dir="$(cat "$tmp")"
        rm -f "$tmp"
        [ -d "$dir" ] && [ "$dir" != "$(pwd)" ] && cd "$dir"
    fi
}
bindkey -s '^o' 'lfcd\n'


# Ctrl+z sleep process
ctrlz() {
  if [[ $#BUFFER == 0 ]]; then
    fg >/dev/null 2>&1 && zle redisplay
  else
    zle push-input
  fi
}
zle -N ctrlz
bindkey '^Z' ctrlz




eval "$(zoxide init zsh)"
eval "$(starship init zsh)"

################################################

export VISUAL=nvim
export EDITOR="$VISUAL"
export TERMINAL="kitty"
export BROWSER="waterfox-g4"
export READER="zathura"
export FILE="lf"
export RANGER_LOAD_DEFAULT_RC=FALSE
export LC_ALL=en_DK.UTF-8
export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border --info=inline --cycle'

#############Home Fixes#################

export HISTFILE="${XDG_STATE_HOME}"/bash/history
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GOPATH="$XDG_DATA_HOME"/go
export GRADLE_USER_HOME="$XDG_DATA_HOME"/gradle
export LESSHISTFILE="$XDG_CACHE_HOME"/less/history
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export ZDOTDIR="$HOME/.config/zsh"

alias nvidia-settings="nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings"

################################################


neofetch

alias matrix="unimatrix -l cCaGgkr -s 98 -a -f"
alias c="clear && zsh"
alias C="clear && bash"
alias exa="exa --sort=type --icons"
alias exal="exa -lah --sort=type --icons"
alias v="nvim"
alias ..="cd .."
alias ls="ls --group-directories-first --color=always"
alias ls="ls -lah --group-directories-first --color=always"
alias fzff="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"
alias py="python3"

alias rtfm='man'
alias nomnom='killall'
alias yolo='git commit -m "$(curl -s http://whatthecommit.com/index.txt)"'


# Rehash when downloading new program
zshcache_time="$(date +%s%N)"

autoload -Uz add-zsh-hook

rehash_precmd() {
  if [[ -a /var/cache/zsh/pacman ]]; then
    local paccache_time="$(date -r /var/cache/zsh/pacman +%s%N)"
    if (( zshcache_time < paccache_time )); then
      rehash
      zshcache_time="$paccache_time"
    fi
  fi
}

add-zsh-hook -Uz precmd rehash_precmd

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"
key[Control-Left]="${terminfo[kLFT5]}"
key[Control-Right]="${terminfo[kRIT5]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-history
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-history
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete
[[ -n "${key[Control-Left]}"  ]] && bindkey -- "${key[Control-Left]}"  backward-word
[[ -n "${key[Control-Right]}" ]] && bindkey -- "${key[Control-Right]}" forward-word


# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi



source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh



export LF_ICONS="\
*.7z=:\
*.aac=:\
*.ace=:\
*.alz=:\
*.arc=:\
*.arj=:\
*.asf=:\
*.atom=:\
*.au=:\
*.avi=:\
*.bash=:\
*.bash_history=:\
*.bashprofile=:\
*.bashrc=:\
*.bmp=:\
*.bz2=:\
*.bz=:\
*.c=:\
*.cab=:\
*.cc=:\
*.cfg=:\
*.cgm=:\
*.clang-format=:\
*.clj=:\
*.cmd=:\
*.coffee=:\
*.cpio=:\
*.cpp=:\
*.css=:\
*.d=:\
*.dart=:\
*.deb=:\
*.dl=:\
*.DS_Store=:\
*.dwm=:\
*.dz=:\
*.ear=:\
*.emf=:\
*.env=:\
*.erl=:\
*.esd=:\
*.exs=:\
*.fish=:\
*.flac=:\
*.flc=:\
*.fli=:\
*.flv=:\
*.fs=:\
*.gif=:\
*.git=:\
*.gitattributes=:\
*.gitconfig=:\
*.github=:\
*.gitignore=:\
*.gitignore_global=:\
*.gitkeep=:\
*.gitmodules=:\
*.gl=:\
*.go=:\
*.gz=:\
*.h=:\
*.hh=:\
*.hidden=:\
*.hpp=:\
*.hs=:\
*.html=:\
*.hyper.js=:\
*.jar=:\
*.java=:\
*.jl=:\
*.jpeg=:\
*.jpg=:\
*.js=:\
*.json=:\
*.jsx=:\
*.lha=:\
*.lrz=:\
*.lua=:\
*.lz4=:\
*.lz=:\
*.lzh=:\
*.lzma=:\
*.lzo=:\
*.m2v=:\
*.m4a=:\
*.m4v=:\
*.map=:\
*.md=:\
*.mdx=:\
*.mid=:\
*.midi=:\
*.mjpeg=:\
*.mjpg=:\
*.mka=:\
*.mkv=:\
*.mng=:\
*.mov=:\
*.mp3=:\
*.mp4=:\
*.mp4v=:\
*.mpc=:\
*.mpeg=:\
*.mpg=:\
*.nix=:\
*.npmignore=:\
*.npmrc=:\
*.nuv=:\
*.nvmrc=:\
*.oga=:\
*.ogg=:\
*.ogm=:\
*.ogv=:\
*.ogx=:\
*.opus=:\
*.pbm=:\
*.pcx=:\
*.pdf=:\
*.pgm=:\
*.php=:\
*.pl=:\
*.png=:\
*.ppm=:\
*.pro=:\
*.ps1=:\
*.py=:\
*.qt=:\
*.ra=:\
*.rar=:\
*.rb=:\
*.rm=:\
*.rmvb=:\
*.rpm=:\
*.rs=:\
*.rvm=:\
*.rz=:\
*.sar=:\
*.scala=:\
*.sh=:\
*.skhdrc=:\
*.sol=ﲹ:\
*.spx=:\
*.svg=:\
*.svgz=:\
*.swm=:\
*.t7z=:\
*.tar=:\
*.taz=:\
*.tbz2=:\
*.tbz=:\
*.tga=:\
*.tgz=:\
*.tif=:\
*.tiff=:\
*.tlz=:\
*.tmux.conf=:\
*.trash=:\
*.ts=:\
*.tsx=:\
*.txz=:\
*.tz=:\
*.tzo=:\
*.tzst=:\
*.vim=:\
*.vimrc=:\
*.vob=:\
*.vscode=:\
*.war=:\
*.wav=:\
*.webm=:\
*.wim=:\
*.xbm=:\
*.xcf=:\
*.xpm=:\
*.xspf=:\
*.xwd=:\
*.xz=:\
*.yabairc=:\
*.yaml=פּ:\
*.yarn-integrity=:\
*.yarnrc=:\
*.yml=פּ:\
*.yuv=:\
*.z=:\
*.zip=:\
*.zoo=:\
*.zprofile=:\
*.zprofile=:\
*.zsh=:\
*.zsh_history=:\
*.zshrc=:\
*.zst=:\
*bin=:\
*config=:\
*docker-compose.yml=:\
*dockerfile=:\
*gradle=:\
*gruntfile.coffee=:\
*gruntfile.js=:\
*gruntfile.ls=:\
*gulpfile.coffee=:\
*gulpfile.js=:\
*gulpfile.ls=:\
*include=:\
*lib=:\
*localized=:\
*node_modules=:\
*package.json=:\
*rubydoc=:\
*tsconfig.json=:\
*yarn.lock=:\
di=:\
dt=:\
ex=:\
fi=:\
ln=:\
or=:\
ow=:\
st=:\
tw=:\
"
