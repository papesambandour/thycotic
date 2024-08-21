#value=$(get_value_by_key "$FILE" thycotic_usernamekk)
#echo "value is $value"

if [ ! -f "$FILE" ] || [ "$1" = "login" ]; then

    if [ ! -f "$FILE" ] ; then
       touch "$FILE"
    fi
    echo -e "${GREEN}Configuration des accès Thycotic${YELLOW}"

    read -rp "Entrer thycotic_username: " thycotic_username
    read -srp "Entrer thycotic_password: " thycotic_password
    read -rp "Entrer thycotic_sub_domaine: " thycotic_sub_domaine

    #echo "thycotic_username=$thycotic_username" > "$FILE"
    update_line_value "thycotic_username=" "$thycotic_username" "$FILE" ""
    #echo "thycotic_password=$thycotic_password" >> "$FILE"
    update_line_value "thycotic_password=" "$thycotic_password" "$FILE" ""
    #echo "thycotic_sub_domaine=$thycotic_sub_domaine" >> "$FILE"
    update_line_value "thycotic_sub_domaine=" "$thycotic_sub_domaine" "$FILE" ""

    echo -e "${GREEN}La configuration est enregistrer dans le fichier $FILE.${NC}"
    echo -e "${GREEN}Vous pouvez á présent commencer à utiliser thycotic cli ${NC}"
    exit 0
fi

thycotic_username=$(get_value_by_key "$FILE" thycotic_username)
#$(grep 'thycotic_username' "$FILE" | cut -d '=' -f 2)
thycotic_password=$(get_value_by_key "$FILE" thycotic_password)
# $(grep 'thycotic_password' "$FILE" | cut -d '=' -f 2)
thycotic_sub_domaine=$(get_value_by_key "$FILE" thycotic_sub_domaine)
#thycotic_sub_domaine=$(grep 'thycotic_sub_domaine' "$FILE" | cut -d '=' -f 2)
validate_input "$thycotic_username" "thycotic_username"
validate_input "$thycotic_password" "thycotic_password"
validate_input "$thycotic_sub_domaine" "thycotic_sub_domaine"


#if ! is_integer "$1"; then
#    echo -e "${RED}Erreur: Le secret id doit être un entier${NC}"
#    exit 1
#fi

if ! (is_valid_ip "$1" || is_valid_domain "$1"); then
    echo "Le ip ou domaine du serveur n'est pas valide"
    exit 1
fi