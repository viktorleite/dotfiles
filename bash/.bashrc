source ~/.bash_aliases
source ~/.bash_prompt
source ~/.bash_functions


# Diminuir Brilho
export PATH=$PATH:$HOME"/.viktor_pyenv/bin"
function diminuirbrilho() {
xrandr --output eDP-1 --brightness 0.3
}
