#!/bin/bash

# Définir les couleurs
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
BLUE=$(tput setaf 4)
VIOLET=$(tput setaf 5)
BOLD=$(tput bold)
RESET=$(tput sgr0)
########################################## INITIALISATION ROOT ##########################################

# Vérifier si l'utilisateur est root
if [[ $EUID -ne 0 ]]; then
   echo "${RED}${BOLD}Ce script doit être exécuté en tant que root${RESET}" 
   # Demander le mot de passe
   sudo "$0" "$@"
   exit 1
fi

# Le reste du script ici

while true; do
    # Affichage du menu
    #echo "                +------------+"
    #echo "                |   Menu :   |"
    #echo "       +--------+------------+----------+"
    #echo "       |            Ptero :             |       "
    #echo "+------+--------------------------------+------+"
    #echo "|  1. Installer Pterodactyl (Dernière Version) |"
    #echo "+----------------------------------------------+"
    #echo ""
    #echo "                +-------------+"
    #echo "                |    Theme :  |"
    #echo "  +-------------+------------ +--------------+"
    #echo "  | 2. Installer Stellar-V3.3 | Ptero 11.x.x |"
    #echo "  |                           |              |"
    #echo "  | 3. Installer Enigma-V3.9  | Ptero 11.x.x |"
    #echo "  |                           |              |"
    #echo "  | 4. Installer Billing      | Ptero 11.x.x |"
    #echo "  |                           |              |"
    #echo "  | 5. Installer Carbon       | Ptero 11.x.x |"
    #echo "+-+---------------------------+--------------+-+"
    #echo "| 6. Re-installer le thème du panel (RESET UI) |"
    #echo "| ├ N'affecte pas les machines déjà installer  |"
    #echo "| └ Aucune perte de sauvegarde                 |"
    #echo "+----------------------------------------------+"
    #echo "| 7. Installer MySQL et PhpMyAdmin             |"
    #echo "| └  (Dernière Version)                        |"
    #echo "+---------------+------------+-----------------+"
    #echo "                | 8. Quitter |"
    #echo "                +------------+"

    echo -e "\e[1;34m+-----------------------------------------------+"
    echo -e "|              \e[1;32mPanel Pterodactyl\e[1;34m :                           |"
    echo -e "+-----------------------------------------------+"
    echo -e "| \e[1;36m1. Installer Pterodactyl (Dernière Version)   \e[1;34m|"
    echo -e "+-----------------------------------------------+"
    echo -e "| \e[1;36m2. Installer MySQL et PhpMyAdmin              \e[1;34m|"
    echo -e "|   \e[1;33m- (Dernière Version)                        \e[1;34m|"
    echo -e "+-----------------------------------------------+"
    echo ""
    echo -e "\e[1;34m+-----------------------------------------------+"
    echo -e "|              \e[1;32Pterodactyl Thème\e[1;34m :                           |"
    echo -e "+-----------------------------------------------+"
    echo -e "| \e[1;36m2. Installer Stellar-V3.3      \e[1;34m|\e[1;36m Ptero 11.x.x\e[1;34m |"
    echo -e "| \e[1;36m3. Installer Enigma-V3.9       \e[1;34m|\e[1;36m Ptero 11.x.x\e[1;34m |"
    echo -e "| \e[1;36m4. Installer Billing           \e[1;34m|\e[1;36m Ptero 11.x.x\e[1;34m |"
    echo -e "| \e[1;36m5. Installer Carbon            \e[1;34m|\e[1;36m Ptero 11.x.x\e[1;34m |"
    echo -e "+-----------------------------------------------+"
    echo -e ""
    echo -e "+-----------------------------------------------+"
    echo -e "|             \e[1;32Réinitialisation\e[1;34m :                            |"
    echo -e "+-----------------------------------------------+"
    echo -e "| \e[1;36m6. Re-installer le thème du panel (RESET UI)  \e[1;34m|"
    echo -e "|   \e[1;33m- N'affecte pas les machines déjà installées\e[1;34m|"
    echo -e "|   \e[1;33m- Aucune perte de sauvegarde                \e[1;34m|"
    echo -e "+-----------------------------------------------+"
    echo -e "| \e[1;31m8. Quitter\e[1;34m                                    |"
    echo -e "+-----------------------------------------------+\e[0m"

    
    echo -e "          +---------------------+          |"
    echo -e "          |                     |          |"
    echo -e "          V                     V          V"
    echo -e "    +-----------------+ +-------------------+"
    echo -e "    |                 | |                   |"
    echo -e "    V                 V V                   V\e[0m"


    read -p "Choisissez une option (1-7) : " choix

    case $choix in
        
        1)
            echo "Installation de Pterodactyl."
            bash <(curl -s https://raw.githubusercontent.com/LucieFairePy/Pterodactyl-Installer-FR/main/install.sh)
            ;;
        2)
            echo "Installation du thème Stellar v3.3."
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/V2/.assets/initialisation.sh)
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/V2/.assets/theme_stellar.sh)
            ;;
        3)
            echo "Installation du thème Enigma v3.9."
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/V2/.assets/initialisation.sh)
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/V2/.assets/theme_enigma.sh)
            ;;
        4)
            echo "Installation du thème Billing Module"
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/V2/.assets/theme_billing.sh)
            ;;
        5)
            echo "Installation du thème Carbon v1.6.6"
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/V2/.assets/theme_carbon.sh)
            ;;
        6)
            echo "Ré-installer le thème de Pterodactyl. (RESET UI)"
            echo "N'affecte pas les machines déjà installer"
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/AutoScriptBash/main/pterodactylpanelreinstall.sh)
            ;;
        7)
            echo "Installer MySQL et PhpMyAdmin"
            echo "  - (Dernière Version)"
            bash <(curl -s lien raw ici)
            ;;
        8)
            echo "Au revoir !"
            exit 0
            ;;
        *)
            echo "Choix non valide. Veuillez entrer un numéro entre 1 et 7."
            ;;
    esac
done
