

if [ "$1" = "add-host" ]; then

    if [ ! -f "$FILE" ] ; then
       touch "$FILE"
    fi
    echo -e "${GREEN}Configuration Secret thycotic ${YELLOW}"

    read -rp "Entrer le secret: " secret
    read -rp "Entrer i'ip du serveur: " ip
    if ! is_integer "$secret"; then
                echo -e "${RED}Erreur: Le secret id doit être un entier${NC}"
                exit 1
    fi

    if ! (is_valid_ip "$ip" || is_valid_domain "$ip"); then
        echo "Le ip ou domaine du serveur n'est pas valide"
        exit 1
    fi
    update_line_value "$ip=" "$secret" "$FILE" ""
    echo -e "${GREEN} Le secret $secret est lié a l'adresse ip suivant : $ip ${NC}"
    exit 0
fi
