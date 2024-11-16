source ~/.bash_aliases
source ~/.bash_prompt
source ~/.bash_functions

export PATH=$PATH:"/snap/bin"
export PATH=$PATH:$HOME"/.viktor_pyenv/bin"

function diminuirbrilho() {
  xrandr --output eDP-1 --brightness 0.3
}

# pnpm
export PNPM_HOME="/home/viktorleite/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
