#case "$1" in
#    "login" | "show" | "add-host" | "r_copy"| "l_copy" )
#        # Your code for when $1 matches one of the values
#        ;;
#    *)
#        # Your code for when $1 doesn't match any of the values
#        echo -e "${RED} $1 : is not in the command list"
#        exit 1
#        ;;
#esac


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