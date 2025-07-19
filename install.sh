#!/bin/bash

# Constantes
readonly REAL_PATH="$( realpath ${BASH_SOURCE[0]} )"
readonly WORKSPACE_DIR="$HOME/workspace/"
readonly DOTFILES_DIR="$( dirname ${REAL_PATH} )"
readonly DATA_DMHMA=$(date +"%d%m%H%M%S%Y")
readonly ENV=develop

HOME_CONFIG_DIR="$HOME/.config"

if [[ $ENV == 'develop' ]]; 
then
	MV_FLAGS="-v"
	LN_FLAGS="-sfv"
else
	MV_FLAGS=""
	LN_FLAGS="-sf"
fi

if [[ ! -d $WORKSPACE_DIR ]]; then
	echo
	echo "	[*] Criando workspace..."
	echo 
	mkdir -pv $WORKSPACE_DIR
fi

echo
echo "		[*] Configurando GIT"
echo

arquivos_git=(
	".gitconfig"
	".git-completion.bash"
	".git-prompt.sh"
)

for arquivo in "${arquivos_git[@]}";
do
	alvo="$DOTFILES_DIR/git/${arquivo}"
	echo
	echo "		[*] Adicionando ${arquivo}..."
	echo
	
	if [[ -f "$HOME/$arquivo" ]]; then
		mv "$HOME/$arquivo" "$HOME/$arquivo.backup.$DATA_DMHMA"
	fi

	ln $LN_FLAGS "$alvo" "$HOME/${arquivo}"
done

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
	alvo="$DOTFILES_DIR/$(basename "$dir")"
	link="$dir"

	# verifica se o diretorio existe
	if [[ -d "$dir" ]]; then
		echo
		echo "	[*] Criando backup das configurçoes anteriores..."
		echo
		backups_dirs=$dir.backup.$DATA_DMHMA
		mv $MV_FLAGS $dir $backups_dirs
		echo "$backups_dirs" >> $HOME/.config/diretorios_backups
		echo
	fi
	echo
	echo "	[*] Criando symbolic..."
	echo
	ln $LN_FLAGS $alvo $HOME_CONFIG_DIR
	echo
done
echo
echo "	[*] Configurando VSCode..."
echo
vscode_snippets_dir="${HOME_CONFIG_DIR}/Code/User/snippets"

if [[ -d $vscode_snippets_dir ]]; 
then
	echo
	echo "		[*] Criando backup das configuraçoes anteriores..."
	echo
	mv $MV_FLAGS $vscode_snippets_dir $vscode_snippets_dir.backup.$DATA_DMHMA
	echo
fi
echo
echo "		[*] Criando symbolic..."
echo
ln $LN_FLAGS $DOTFILES_DIR/vscode/snippets/ $HOME_CONFIG_DIR/Code/User/
echo




