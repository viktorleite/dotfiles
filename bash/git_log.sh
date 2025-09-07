#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

H_LINE="─"
V_LINE="│"
TL_CORNER="┌"
TR_CORNER="┐"
BL_CORNER="└"
BR_CORNER="┘"
T_JOIN="┬"
B_JOIN="┴"
L_JOIN="├"
R_JOIN="┤"
CROSS="┼"
TREE_FIRST="┬── "
TREE_BRANCH="├── "
TREE_END="└── "

if [ $# -eq 0 ]; then
	echo "Uso: $0 <caminho-do-repositorio> [dias]"
	echo "Exemplo: $0 /agencias_back 3"
	exit 1
fi

repo=$1
dias=$2

[[ -z $dias ]] && dias="1 days ago"

length() {
	local string="$1"
	echo -n "$string" | sed -E 's/\\033\[0-9;]*m//g' | wc -c
}

file_tree() {
	local files="$1"
	local fcount=$(echo "$files" | wc -l)
	#se count for igual a 1
	if [ $fcount -eq 1 ]; then
		echo "$files"
		return
	fi

	tree=""
	count=0
	totalNod=30

	while IFS= read -r file; do
		[ -z "$file" ] && continue

		count=$((count + 1))

		if [ $count -eq 1 ]; then
			tree+="\n ${TREE_FIRST}${file}"
		elif [ $count -eq $fcount ]; then
			tree+="\n ${TREE_END}${file}"
		else
			tree+="\n ${TREE_BRANCH}${file}"
		fi
	done <<< "$(echo "$files" | head -${totalNod})"

	#se fcount for maior que 10
	if [ $fcount -gt $totalNod ]; then
		tree+="\n ${TREE_END}... (+$((fcount - $totalNod)) mais)"
	fi

	echo -e "$tree"
}

commits=$(git -C "$repo" log --since="${dias}" --pretty=format:"%h|%ad|%an|%s" --date=iso)

while IFS="|" read -r hash date author message; do
	[ -z "$hash" ] && continue

	# Busca cada arquivo baseado no hash
	files=$(git -C "$repo" show --name-only --pretty=format:"" "$hash" | grep -v "^$")

	commitCount=$((commitCount + 1))

	fmtDate=$(date -d "$date" "+%d/%m/%Y %H:%M" || echo "$date")
	shorHash="${hash:0:8}"
	fmtDate="${fmtDate:0:10}"


	displayFiles=$(file_tree "$files")

	countLine=$(echo -e "$displayFiles" | wc -l)

	if [ $countLine -gt 1 ]; then
		numLine=0
		while IFS= read -r fileLine; do
			numLine=$((numLine + 1))

			if [ $numLine -eq 1 ]; then
				echo -e "${BLUE}$fmtDate ${YELLOW}$shorHash ${GREEN}<$author>${NC} $message"
			else
				echo -e "${MAGENTA} $fileLine${NC}"
			fi

		done <<< "$(echo -e "$displayFiles")"
		echo ""
	else
		echo -e "${BLUE}$fmtDate${NC} ${YELLOW}$shorHash${NC} $fileLine ${GREEN}<$author>${NC} $message"
		echo -e " ${MAGENTA}$displayFiles${NC}"
		echo ""

	fi
done <<< "$commits"
