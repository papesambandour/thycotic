#!/bin/bash
# Colors for output formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color
SCRIPT_DIR=$(dirname "$(realpath "$0")")
#config
FILE="$SCRIPT_DIR/thycotic.config"
validate_input() {
    if [ -z "$1" ]; then
        echo -e "${RED}Erreur: $2 ne peut pas être null${NC}"
        exit 1
    fi
}
# Check if the file exists
if [ ! -f "$FILE" ] || [ "$1" = "login" ]; then
#    echo -e "${YELLOW}Le fichier $FILE n'existe pas. Merci de saisir vos accès thycotic."
    echo -e "${GREEN}Configuration des accès Thycotic${YELLOW}"
    # Prompt the user for values
    read -rp "Entrer thycotic_username: " thycotic_username
    read -srp "Entrer thycotic_password: " thycotic_password
    echo # Move to a new line after password input
    read -rp "Entrer thycotic_sub_domaine: " thycotic_sub_domaine

    # Create the file and write the values to it
    echo "thycotic_username=$thycotic_username" > "$FILE"
    echo "thycotic_password=$thycotic_password" >> "$FILE"
    echo "thycotic_sub_domaine=$thycotic_sub_domaine" >> "$FILE"

    echo -e "${GREEN}La configuration est enregistrer dans le fichier $FILE.${NC}"
    echo -e "${GREEN}Vous pouvez á présent commencer à utiliser thycotic cli ${NC}"
    exit 0
fi

# Read values from the file
thycotic_username=$(grep 'thycotic_username' "$FILE" | cut -d '=' -f 2)
thycotic_password=$(grep 'thycotic_password' "$FILE" | cut -d '=' -f 2)
thycotic_sub_domaine=$(grep 'thycotic_sub_domaine' "$FILE" | cut -d '=' -f 2)
validate_input "$thycotic_username" "thycotic_username"
validate_input "$thycotic_password" "thycotic_password"
validate_input "$thycotic_sub_domaine" "thycotic_sub_domaine"

command -v jq >/dev/null 2>&1 || {
  echo -e "${RED}Erreur : jq n'est pas installé. Veuillez installer jq avant d'exécuter ce script.${NC}"
  echo -e "${YELLOW}Ubuntu/Debian: sudo apt-get install jq${NC}"
  echo -e "${YELLOW}CentOS/RHEL Versions 7 and below: sudo yum install jq${NC}"
  echo -e "${YELLOW}CentOS/RHEL Versions 8 and above: sudo dnf install jq${NC}"
  echo -e "${YELLOW}macOS: brew install jq${NC}"
  exit 1
}
command -v sshpass >/dev/null 2>&1 || {
  echo -e "${RED}Erreur : sshpass n'est pas installé. Veuillez installer sshpass avant d'exécuter ce script.${NC}"
  echo -e "${YELLOW}Ubuntu/Debian: sudo apt-get install sshpass${NC}"
  echo -e "${YELLOW}CentOS/RHEL Versions 7 and below: sudo yum install sshpass${NC}"
  echo -e "${YELLOW}CentOS/RHEL Versions 8 and above: sudo dnf install sshpass${NC}"
  echo -e "${YELLOW}macOS: brew install sshpass${NC}"
  exit 1
}
is_integer() {
    [[ $1 =~ ^[0-9]+$ ]]
}

# Function to check if a string is a valid IP address
is_valid_ip() {
  ip="$1"
  # Check if IP address is present
  if [[ -z "$ip" ]]; then
    false
  fi

  # Regex for valid IPv4 address
  re='^([0-9]{1,3}\.){3}[0-9]{1,3}$'
  # Check if IP matches the regex
  if [[ "$ip" =~ $re ]]; then
    # Split IP into octets
    IFS='.' read -r -a octets <<< "$ip"
    # Validate each octet (range 0-255)
    for octet in "${octets[@]}"; do
      if [[ $octet -lt 0 || $octet -gt 255 ]]; then
        false
      fi
    done
     true
  else
     false
  fi
}

# Function to check if a string is a valid domain name
is_valid_domain() {
  domain="$1"
  # Check if domain is present
  if [[ -z "$domain" ]]; then
     false
  fi

  # Regex for valid domain name
  re='^([a-zA-Z0-9-]{1,63}\.)+[a-zA-Z]{2,}$'
  # Check if domain matches the regex
  if [[ "$domain" =~ $re ]]; then
    # shellcheck disable=SC2152
     true
  else
     false
  fi
}

# Check if $1 is an integer
if ! is_integer "$1"; then
    echo -e "${RED}Erreur: Le secret id doit être un entier${NC}"
    exit 1
fi

# Check if $2 is a valid IP address or domain name
if ! (is_valid_ip "$2" || is_valid_domain "$2"); then
    echo "Le ip ou domaine du serveur n'est pas valide"
    exit 1
fi
# Configuration
API_URL="https://${thycotic_sub_domaine}.secretservercloud.eu/oauth2/token"
SECRET_SERVER_URL="https://${thycotic_sub_domaine}.secretservercloud.eu/api/v1/secrets/sshproxy"
unset SECRET_ID
unset TARGET_SERVER_IP
SECRET_ID="$1"
TARGET_SERVER_IP="$2"

# Obtenir un jeton d'accès
echo -e "${YELLOW}Start login ...${NC}"
unset RESPONSE
RESPONSE=$(curl -s --location $API_URL \
           --header 'Content-Type: application/x-www-form-urlencoded' \
           --data-urlencode "username=$thycotic_username" \
           --data-urlencode "password=$thycotic_password" \
           --data-urlencode 'grant_type=password')
unset ACCESS_TOKEN
ACCESS_TOKEN=$(echo "$RESPONSE" | jq -r '.access_token')
ERROR_LOGIN=$(echo "$RESPONSE" | jq -r '.error')

if [ -z "$ACCESS_TOKEN" ] || [ "${ACCESS_TOKEN}" = "null" ]; then
  echo -e "${RED}Failed to obtain access token . Message : $ERROR_LOGIN ${NC}"
  exit 1
  else
     echo -e "${GREEN}Login to thycotic success ${NC}"
fi
echo -e "${YELLOW}Start get access ...${NC}"
unset RESPONSE_PROXY
RESPONSE_PROXY=$(curl -s --location $SECRET_SERVER_URL \
                 --header 'Content-Type: application/json' \
                 --header "Authorization: Bearer $ACCESS_TOKEN" \
                 --data "{
                      \"secretId\": \"$SECRET_ID\",
                      \"machine\": \"$TARGET_SERVER_IP\",
                      \"launcherType\": \"2\"
                 }")
unset USERNAME_PROXY
unset HOST_PROXY
unset PORT_PROXY
unset PASSWORD_PROXY
USERNAME_PROXY=$(echo "$RESPONSE_PROXY" | jq -r '.username')
HOST_PROXY=$(echo "$RESPONSE_PROXY" | jq -r '.host')
PORT_PROXY=$(echo "$RESPONSE_PROXY" | jq -r '.port')
PASSWORD_PROXY=$(echo "$RESPONSE_PROXY" | jq -r '.password')
ERROR_PROXY=$(echo "$RESPONSE_PROXY" | jq -r '.errorCode')

if  [ "${ERROR_PROXY}" != "null" ]; then
    echo -e "${RED}Error get proxy access: message: $ERROR_PROXY ${NC}"
    exit 1
fi

if [ -z "${USERNAME_PROXY}" ] || [ "${USERNAME_PROXY}" = "null" ]; then
    echo -e "${YELLOW} USERNAME_PROXY is null or not set ${NC}"
    exit 1
fi

if [ -z "$HOST_PROXY" ] || [ "${HOST_PROXY}" = "null" ]; then
  echo -e "${YELLOW}Failed to obtain HOST PROXY ${YELLOW}"
  exit 1
fi

if [ -z "$PORT_PROXY" ] || [ "${PORT_PROXY}" = "null" ]; then
  echo -e "${YELLOW}Failed to obtain PRT PROXY ${NC}"
  exit 1
fi
if [ -z "$PASSWORD_PROXY" ] || [ "${PASSWORD_PROXY}" = "null" ]; then
  echo -e "${YELLOW}Failed to obtain PASSWORD PROXY ${NC}"
  exit 1
fi

echo -e "${GREEN}Proxy access granted ${NC}"
echo -e "${YELLOW}\n============================PROXY ACCESS===========================\n"
if [ "${3}" = "show" ] ; then
  echo -e "${GREEN}PASSWORD: $PASSWORD_PROXY"
  echo -e "${YELLOW}ssh $USERNAME_PROXY@$HOST_PROXY"
 elif  [ "${3}" = "l_copy" ] ; then
   echo -e "${GREEN}Password: $PASSWORD_PROXY ${NC}"
   echo -e "${GREEN}scp -r $4 $USERNAME_PROXY@$HOST_PROXY:$5 ${NC}"
 elif  [ "${3}" = "r_copy" ] ; then
   echo -e "${GREEN}Password: $PASSWORD_PROXY ${NC}"
   echo -e "${GREEN}scp -r $USERNAME_PROXY@$HOST_PROXY:$5 $4  ${NC}"
 elif  [ "${3}" = "connect" ] ; then
   echo -e "${GREEN}SSH login running ...${NC}"
   sshpass -p "$PASSWORD_PROXY" ssh "$USERNAME_PROXY@$HOST_PROXY"
 else
   echo -e "${YELLOW}Unsupported arg : $3 ${NC}"
   exit
fi

echo -e "${YELLOW}\n============================PROXY ACCESS===========================\n"
exit
