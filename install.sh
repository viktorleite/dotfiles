#!/bin/bash

# Constantes
readonly REAL_PATH="$( realpath ${BASH_SOURCE[0]} )"
readonly WORKSPACE_DIR="$HOME/workspace/"
readonly DOTFILES_DIR="$( dirname ${REAL_PATH} )"
readonly DATA_DMHMA=$(date +"%d%m%H%M%Y")
readonly ENV=develop

if [[ $ENV != "develop" ]]; then
	exit;
else
	HOME_CONFIG_DIR="$HOME/.config"

	diretorios=(
		"$HOME/.config/tint2"
		"$HOME/.config/polybar"
		"$HOME/.config/kitty"
		"$HOME/.config/openbox"
		"$HOME/.config/nvim"
		#"$HOME/.config/plank"
		"$HOME/.local/share/plank"
		"$HOME/.config/plank"
		"$HOME/.config/bash"
	)


	for dir in "${diretorios[@]}";
	do
		alvo="$DOTFILES_DIR/$(basename "$dir")"
		link="$dir"

		# verifica se o diretorio existe
		if [[ -d "$dir" ]]; then
		# Se existir vamos mover de $HOME/.../Diretorio para $HOME/.../Diretorio.backup.110314092025
			# E a vamos criar criar os symlinks
			echo "ln -sf $alvo $link"
			#echo "Diretorio $dir movido para $dir.backup.$DATA_DMHMA"
		else 
			#echo -ne "\033[41m\033[37mERRO:\033[0m\033[31m diretorio \033[1m$dir\033[0m\033[31m não encontrado \033[0m \n"
			echo "ln -sf $alvo $link"
		fi
	done

fi
