unset RESPONSE_PROXY
SECRET_SERVER_URL="https://${thycotic_sub_domaine}.secretservercloud.eu/api/v1/secrets/sshproxy"
unset SECRET_ID
unset TARGET_SERVER_IP
SECRET_ID=$(get_value_by_key "$FILE" $1)
 if [ -z "$SECRET_ID" ]; then
        echo -e "${RED}L'ip $1 n'a pas de secret associé."

        echo -e "${GREEN}Merci de presiser son secret associé ${YELLOW}"

        read -rp "Entrer le secret: " secret

        if ! is_integer "$secret"; then
            echo -e "${RED}Erreur: Le secret id doit être un entier${NC}"
            exit 1
        fi

        ip=$1
        SECRET_ID=$secret
        update_line_value "$ip=" "$secret" "$FILE" ""
        echo -e "${GREEN} Le secret $secret est lié a l'adresse ip suivant : $ip ${NC}"
    else
        echo "Le secret $SECRET_ID de l'ip $1 trouvé avec succès"
fi
#10.0.92.44=1067
TARGET_SERVER_IP="$1"

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

