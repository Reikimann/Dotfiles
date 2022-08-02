#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

if [ "$TERM" = "linux" ]; then
    echo -en "\e]P0232323" #black
    echo -en "\e]P82B2B2B" #darkgrey
    echo -en "\e]P1D75F5F" #darkred
    echo -en "\e]P9E33636" #red
    echo -en "\e]P287AF5F" #darkgreen
    echo -en "\e]PA98E34D" #green
    echo -en "\e]P3D7AF87" #brown
    echo -en "\e]PBFFD75F" #yellow
    echo -en "\e]P48787AF" #darkblue
    echo -en "\e]PC7373C9" #blue
    echo -en "\e]P5BD53A5" #darkmagenta
    echo -en "\e]PDD633B2" #magenta
    echo -en "\e]P65FAFAF" #darkcyan
    echo -en "\e]PE44C9C9" #cyan
    echo -en "\e]P7E5E5E5" #lightgrey
    echo -en "\e]PFFFFFFF" #white
    clear #for background artifacting
fi




################################################

export VISUAL=nvim
export EDITOR="$VISUAL"
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

alias nvidia-settings="nvidia-settings --config="$XDG_CONFIG_HOME"/nvidia/settings"

################################################


neofetch

set -o vi

eval "$(starship init bash)"
eval "$(zoxide init bash)"


alias matrix="unimatrix -l cCaGgkr -s 98 -a -f"
alias c="clear && bash"
alias exa="exa --sort=type --icons"
alias exal="exa -lah --sort=type --icons"
alias v="nvim"
alias ..="cd"
alias ls="ls --group-directories-first --color=always"
alias ls="ls -lah --group-directories-first --color=always"
alias fzff="fzf --preview 'bat --style=numbers --color=always --line-range :500 {}'"

source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash


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


