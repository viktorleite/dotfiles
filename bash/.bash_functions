# Start a PHP server from a directory, optionally specifying the port
# (Requires PHP 5.4.0+.)
function phpserver() {
	local port=$2;
	local ip=$1
	sleep 1 && open "http://${ip}:${port}/" &
	php -S "${ip}:${port}";
}
