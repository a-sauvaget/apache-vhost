# Définition des codes couleurs + formatage
GREEN='\e[32m'
YELLOW='\e[33m'
RED='\e[31m'
BOLD='\e[1m'

# Code pour remise a zero des mise en page du texte
NC='\e[0m'

# Permet de verifier qu'on execute bien le script en tant que root pour eviter des problemes de droits
if [ "$EUID" -ne 0 ]
  then echo -ne "${RED}${BOLD}Ce script necessite d'etre en super utilisateur${NC}\n"
  exit 1
fi

# Affichage de toutes les couleurs possibles
#for (( i = 30; i < 38; i++ )); do echo -e "\033[0;"$i"m Normal: (0;$i); \033[1;"$i"m Light: (1;$i)"; done


# Chargement des fichiers necessaire, equivalent a require en PHP
source "./scripts/create.sh"
source "./scripts/delete.sh"

# Récuperation de la liste des Vhost activés
VHOST=$(ls /etc/apache2/sites-enabled)

echo -e "${GREEN}${BOLD}-----  VHOST MANAGER ${NC} -----\n"
echo -e "${GREEN}${BOLD}----- Liste de vos Vhosts activés : ${NC} -----\n"

# Affichage de tout les vhost activé
echo -e "$VHOST\n"

# Affichage d'un choix multiple qui permet de decider ce que l'on souhaite faire
echo "Vous voulez faire quoi ?"
select choice in "Créer un Vhost" "Supprimer un Vhost" "Rien"; do
    case $choice in
        "Créer un Vhost" ) create;;
        "Supprimer un Vhost" ) delete;;
        "Rien" ) exit;;
    esac
done


