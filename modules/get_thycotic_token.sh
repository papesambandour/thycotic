API_URL="https://${thycotic_sub_domaine}.secretservercloud.eu/oauth2/token"

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
echo -e "${YELLOW}Start getting access ...${NC}"
