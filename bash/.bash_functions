# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
	local port=$2;
	local ip=$1
	sleep 1 && open "http://${ip}:${port}/" &
	php -S "${ip}:${port}";
}
# function diminuebrilho() {
function diminuirbrilho() {
  xrandr --output eDP-1 --brightness 0.3
}
# function para setar o teclado abnt2 pt-br
function kbabnt2br() {
  echo -ne "[*] Configurando teclado para Pt-BR ABNT2
  setxkbmap -model abnt2 -layout br -variant abnt2
}
