########################################
# Start a PHP server from a directory,
# optionally specifying the port
# (Requires PHP 5.4.0+.)
# Globals:
#
#
# Arguments:
#
#
# Usage:
# phpserver localhost:8000
#######################################

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Caracteres Unicode para bordas
#readonly BORDER_HORIZONTAL="═"
#readonly BORDER_VERTICAL="║"
#readonly BORDER_CORNER_TL="╔"
#readonly BORDER_CORNER_TR="╗"
#readonly BORDER_CORNER_BL="╚"
#readonly BORDER_CORNER_BR="╝"
#readonly BORDER_T_TOP="╦"
#readonly BORDER_T_BOTTOM="╩"
#readonly BORDER_T_LEFT="╠"
#readonly BORDER_T_RIGHT="╣"
#readonly BORDER_CROSS="╬"

H_LINE="─"
V_LINE="│"
TL_CORNER="┌"
TR_CORNER="┐"
BL_CORNER="└"
BR_CORNER="┘"
T_JOIN="┬"
B_JOIN="┴"
CROSS_JOIN="┼"

function phpserver() {
    local port=$2;
    local ip=$1
    
    #[ -z "$port" ] && $port=8000
    if [[ -z $port ]]
    then
        port=8000
    fi
    # [ -z "$ip" ] && $ip=0.0.0.0
    if [[ -z $ip ]]
    then
        ip="0.0.0.0"
    fi
    
    sleep 1 && open "http://${ip}:${port}/" &
    php -S "${ip}:${port}";
}
# function diminuebrilho() {
function diminuirbrilho() {
    xrandr --output eDP-1 --brightness 0.3
}
# function para setar o teclado abnt2 pt-br
function kbabnt2br() {
    echo -ne "[*] Configurando teclado para Pt-BR ABNT2"
    setxkbmap -model abnt2 -layout br -variant abnt2
}

function err() {
    echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')]: $*" >&2
}

# adiciona a chave pem
function sshAddPem() {
    local pem=$1
    eval $(ssh-agent -s)
    ssh-add $pem
}


# Comparar repositorios do git
function gitCompare()
{
    local repo="$1"
    local name="2"
    
    COL_STATUS=21
    COL_AHEAD=7
    COL_BEHIND=8
    
    TABLE_WIDTH=$((COL_PATH + COL_STATUS + COL_AHEAD + COL_BEHIND + 13))
    
    
    if [ $# -ne 1 ]; then
        echo "Uso: ${FUNCNAME[0]} <Repositorio>" >&2
        return 1
    fi
    
    git -C $repo fetch
    
    local LOCAL=$(git -C "$repo" rev-parse @)
    local REMOTE=$(git -C "$repo" rev-parse @{u})
    local BASE=$(git -C "$repo" merge-base @ @{u})
    
    local PULL=$(git -C "$repo" rev-list --count @..@{u}) #// BEHIND
    local PUSH=$(git -C "$repo" rev-list --count @{u}..@) #// AHEAD
    local MSG=""
    
    if [ $PULL -gt 0 ]; then
        MSG="⚠️  Há updates remotos disponíveis!"
        totalExtra=8
    fi
    
    if [ $PUSH -gt 0 ]; then
        MSG="🚀 Você tem commits para enviar!"
        totalExtra=5
    fi
    
    local STATUS=""
    local COR=""
    
    if [[ "$LOCAL" == "$REMOTE" ]];
    then
        STATUS="Atualizado"
        COR=$GREEN
        elif [[ "$LOCAL" == "$BASE" ]]; then
        STATUS="Remoto Atualizado"
        COR=$BLUE
        elif [[ "$REMOTE" == "$BASE" ]]; then
        STATUS="Local Atualizado"
        COR=$YELLOW
    else
        STATUS="Diferente"
        COR=$RED
    fi
    
    # Gambiarra para calcular o tamanho do conteudo
    max_path_length=0
    
    while read -r repoo; do
        length=${#repo}
        if (( length > max_path_length )); then
            max_path_length=$length
        fi
    done < <(find $repo -name ".git" -type d | sed 's/\/.git$//')

    
    COLPATH=$((max_path_length > 40 ? (max_path_length < 60 ? max_path_length : 60) : 40 ))
    
    printf "\n"
    printf "%s" "$TL_CORNER"
    #printf "%$((COLPATH+2))s" "" | tr ' ' "$H_LINE"
    printf "%.0s$H_LINE" $(seq 1 $((COLPATH + 2)))
    printf "%s" "$T_JOIN"
    printf "%.0s$H_LINE" $(seq 1 $((COL_STATUS + 2)))
    printf "%s" "$T_JOIN"
    printf "%.0s$H_LINE" $(seq 1 $((COL_AHEAD + 2)))
    printf "%s" "$T_JOIN"
    printf "%.0s$H_LINE" $(seq 1 $((COL_BEHIND + 2)))
    printf "%s" "$TR_CORNER"
    
    # Conteudo
    printf "\n"
    echo -n "$V_LINE"
    tExtraCol=$((COLPATH + $totalExtra ))
    printf "$YELLOW%-${tExtraCol}s$NC" "$MSG"
    echo -n "$V_LINE"
    tExtraCol=$((COL_STATUS + 2))
    printf "%-${tExtraCol}s" "Status"
    echo -n "$V_LINE"
    tExtraCol=$((COL_AHEAD + 2))
    printf "%-${tExtraCol}s" "Push"
    echo -n "$V_LINE"
    tExtraCol=$((COL_BEHIND + 2))
    printf "%-${tExtraCol}s" "Pull"
    echo -n "$V_LINE"
    
    printf "\n"
    printf "%s" "├─"
    #printf "%$((COLPATH+2))s" "" | tr ' ' "$H_LINE"
    printf "%.0s$H_LINE" $(seq 1 $((COLPATH + 1)))
    printf "%s" "$CROSS_JOIN"
    printf "%.0s$H_LINE" $(seq 1 $((COL_STATUS + 2)))
    printf "%s" "$CROSS_JOIN"
    printf "%.0s$H_LINE" $(seq 1 $((COL_AHEAD + 2)))
    printf "%s" "$CROSS_JOIN"
    printf "%.0s$H_LINE" $(seq 1 $((COL_BEHIND + 1)))
    printf "%s" "─┤"
    printf "\n"
    
    echo -n "$V_LINE "
    printf "%-${COLPATH}s" "$repo"
    echo -n " $V_LINE "
    printf "$COR%-${COL_STATUS}s$NC" "$STATUS"
    echo -n " $V_LINE "
    printf "%${COL_AHEAD}s" "$PUSH"
    echo -n " $V_LINE "
    printf "%${COL_BEHIND}s" "$PULL"
    echo " $V_LINE"
    
    printf "%s" "$BL_CORNER"
    #printf "%$((COLPATH+2))s" "" | tr ' ' "$H_LINE"
    printf "%.0s$H_LINE" $(seq 1 $((COLPATH + 2)))
    printf "%s" "$B_JOIN"
    printf "%.0s$H_LINE" $(seq 1 $((COL_STATUS + 2)))
    printf "%s" "$B_JOIN"
    printf "%.0s$H_LINE" $(seq 1 $((COL_AHEAD + 2)))
    printf "%s" "$B_JOIN"
    printf "%.0s$H_LINE" $(seq 1 $((COL_BEHIND + 2)))
    printf "%s" "$BR_CORNER"
    printf "\n"
    
}

function compress() {
  tar -czf "${1%/}.tar.gz" "${1%/}";
}


