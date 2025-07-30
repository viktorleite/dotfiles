# Configuração de cores para o comando ls
# Detect which `ls` flavor is in use
if ls --color > /dev/null 2>&1; then # GNU `ls`
	colorflag="--color"
	export LS_COLORS='no=00:fi=00:di=01;31:ln=01;36:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.avi=01;35:*.fli=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.ogg=01;35:*.mp3=01;35:*.wav=01;35:'
else # macOS `ls`
	colorflag="-G"
	export LSCOLORS='BxBxhxDxfxhxhxhxhxcxcx'
fi

# Configuração de cores para o comando grep
export GREP_OPTIONS='--color=auto'
# Configurações de cores para o terminal
export CLICOLOR=1

# Alias úteis
alias ls='ls ${colorflag}'
alias la='ls -A ${colorflag}'
alias l='ls -CF ${colorflag}'
alias ll='ls -alF ${colorflag}'
# List only directories
alias lsd="ls -lF ${colorflag} | grep --color=never '^d'"
# Lista somente Diretorios
# Esta confundindo com o linkador ld
# alias ld="ls -d1 */"
alias ldir="ls -d1 */"
# Get week number
alias week='date +%V'
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=always'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias cls='clear'

alias ..="cd .."
alias ...="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."
alias ~="cd ~" 
alias -- -="cd -"

alias df='df -h'
alias free='free -m'
alias psa='ps auxf'
alias psgrep='ps aux | grep -v grep | grep -i -e VSZ -e'
alias psmem='ps aux | sort -nr -k 4'
alias pscpu='ps aux | sort -nr -k 3'



if [ "$(nano --version | head -n1 | cut -d" " -f5 )" == "8.2" ]; then
  alias nano="nano --tabstospaces --multibuffer --positionlog --zap \
  --breaklonglines --autoindent --linenumbers --mouse --indicator --minibar -T2"
fi

# IP addresses
#alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

alias ifactive="ifconfig | pcregrep -M -o '^[^\t:]+:([^\n]|\n\t)*status: active'"

alias emptytrash=""

alias path='echo -e ${PATH//:/\\n}'

alias chromekill="ps ux | grep '[C]hrome Helper --type=renderer' | grep -v extension-process | tr -s ' ' | cut -d ' ' -f2 | xargs kill"


