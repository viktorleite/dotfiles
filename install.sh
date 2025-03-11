#!/bin/bash

# Constantes
readonly WORKSPACE_DIR="$HOME/workspace"
readonly DATA_DMHMA=$(date +"%d%m%H%M%Y")


#if [[ ! -d $WORKSPACE_DIR ]]; then
#	echo "		*** ERRO: Não foi possivel encontrar $WORKSPACE_DIR ***" 2>&1 | tee -a dotfiles_install-$(date -Is).log
#fi

# Preciso verificar se os diretorios existe
# Se existe renomear para DIRETORIO.backup.$(date +"%d%m%H%M%Y")

#if [[ -d $HOME/.config/tint2 ]];
#then
#	mv $HOME/.config/tint2 $HOME/.config/tint2.backup.$DATA_DMHMA
#	echo "debug 1 [$DATA_DMHMA]"
#else
#	echo "debug 2 [$DATA_DMHMA]"
#fi
 
# Configuração do plank dock {{
# Tema:
# 	$HOME/.local/share/plank/themes/ViktorLeite/dock.theme
# 	ln -s $SRC/plank/themes/ryuzue/dock.theme $HOME/.local/share/plank/themes/ryuzue/dock.theme
# Launchers
# 	$HOME/.config/plank/dock1/launchers/
# 	ln -s $SRC/plank/dock1/launchers/* $HOME/.config/plank/dock1/launchers/
# }}

# Configuração do nvim {{
# mv $HOME/.config/nvim $HOME/.config/nvim.backup.$(date +"%d%m%H%M%Y")
# ln -s $SRC/nvim $HOME/.config/nvim
#
# }}

#dunst/
#git/
#kitty/
#polybar/
#rofi/
#vim/
#vscode/

diretorios=(
	"$HOME/.config/tint2"
	"$HOME/.config/polybar"
	"$HOME/.config/kitty"
	"$HOME/.config/openbox"
	"$HOME/.config/nvim"
	"$HOME/.config/plank"
	"$HOME/.local/share/plank"
	"$HOME/.config/plank"
	"$HOME/.config/bash"
)

for dir in "${diretorios[@]}";
do
	if [[ -d "$dir" ]]; then
		# Aqui temos que verificar se o diretorio existe
		# Se existir vamos mover para $HOME/.../Diretorio $HOME/.../Diretorio.backup.110314092025
		# E a vamos criar os diretorios e criar os symlinks
		#
		echo "Diretorio $dir movido para $dir.backup.$DATA_DMHMA"
	else 
		echo -ne "\033[41m\033[37mERRO:\033[0m\033[31m diretorio \033[1m$dir\033[0m\033[31m não encontrado \033[0m \n"
	fi
done
