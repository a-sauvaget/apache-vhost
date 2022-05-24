delete() {
    echo -ne "Merci de donner le nom du vhost a supprimer (ex : monsupersite):\n"
    read VALUE

    echo -ne "${YELLOW}${BOLD}Desactivation et suppression du Vhost${NC}\n"

    # Desactivation de vhost et suppression du fichier
    a2dissite $VALUE.conf &> /dev/null
    service apache2 reload &> /dev/null
    rm /etc/apache2/sites-available/$VALUE.conf &> /dev/null

    echo -ne "${YELLOW}${BOLD}Suppression du nom de domaine local${NC}\n"
    # Suppression du nom de domaine local
    HOSTS=$(cat /etc/hosts)
    TEMPRESULT="${HOSTS/"127.0.0.1 $VALUE.local"/""}"
    #echo "$TEMPRESULT"
    echo "$TEMPRESULT" > /etc/hosts
    echo -ne "${GREEN}${BOLD}C'est fini !${NC}\n"

    exit;
}
