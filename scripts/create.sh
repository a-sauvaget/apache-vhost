# Permettre de créer un vhost
create() {
    echo -ne "${GREEN}${BOLD}Merci de donner le nom de votre Vhost (ex : monsupersite):${NC}\n"
    read VHOSTNAME

    echo -ne "${GREEN}${BOLD}Merci de donner le chemin absolu vers le dossier a servir (ex : /var/www/html/$VHOSTNAME):${NC}\n"
    read VHOSTPATH
    
    # Verification que le dossier du path existe
    if [ ! -d "$VHOSTPATH" ] 
    then
        echo -ne "${RED}${BOLD}$VHOSTPATH n'existe pas ....${NC}\n"
        exit 1;
    fi

    # Créer un fichier vhost avec des données par defaut
    VHOSTFILE=$(cat src/vhost.conf)
    TEMPRESULT="${VHOSTFILE/SERVERNAME/"$VHOSTNAME.local"}"
    VHOSTRESULT="${TEMPRESULT/DIRECTORY/"$VHOSTPATH"}"

    echo "$VHOSTRESULT">/etc/apache2/sites-available/$VHOSTNAME.conf

    # Activer le vhost et reload apache2
    echo -ne "${YELLOW}${BOLD}Création et activation du Vhost${NC}\n"
    a2ensite $VHOSTNAME.conf &> /dev/null
    service apache2 reload &> /dev/null

    # Créer l'entrée dans le fichier hosts
    echo -ne "${YELLOW}${BOLD}Ajout du nom de domaine local${NC}\n"
    echo "127.0.0.1 $VHOSTNAME.local" >> /etc/hosts


    echo -ne "${GREEN}${BOLD}C'est fini !${NC}\n"

    exit;
}
