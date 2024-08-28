
echo -e "${GREEN}Proxy access granted ${NC}"
echo -e "${YELLOW}\n============================PROXY ACCESS START SESSION===========================\n${NC}"
if [ "${2}" = "show" ] ; then
  echo -e "${GREEN}USERNAME: $USERNAME_PROXY"
  echo -e "${GREEN}PASSWORD: $PASSWORD_PROXY"
  echo -e "${GREEN}HOST: $HOST_PROXY"
  echo -e "${GREEN}COMMAND: ssh $USERNAME_PROXY@$HOST_PROXY"
 elif  [ "${2}" = "l_copy" ] ; then
   clear
  echo -e "${GREEN}Local copy Starting ... ${NC}"
  sshpass -p "$PASSWORD_PROXY" scp -r -o StrictHostKeyChecking=no "$3" "$USERNAME_PROXY"@"$HOST_PROXY":"$4"
  echo -e "${GREEN}Copy successful ${NC}"
 elif  [ "${2}" = "r_copy" ] ; then
   clear
   echo -e "${GREEN}Remote copy Starting ... ${NC}"
   sshpass -p "$PASSWORD_PROXY" scp -r  -o StrictHostKeyChecking=no "$USERNAME_PROXY"@"$HOST_PROXY":"$3" "$4"
   echo -e "${GREEN}Copy successful ${NC}"
 elif  [ "${2}" = "connect" ] ; then
   echo -e "${GREEN}SSH login running ...${NC}"
   clear
   sshpass -p "$PASSWORD_PROXY" ssh -o StrictHostKeyChecking=no "$USERNAME_PROXY@$HOST_PROXY"
 else
   echo -e "${YELLOW}Unsupported arg : $2 ${NC}"
fi

echo -e "${YELLOW}\n============================PROXY ACCESS END SESSION=============================${NC}"

