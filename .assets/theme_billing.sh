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
    echo "${RED}${BOLD}Ce script doit être exécuté en tant que root.${RESET}" 
    exit 1
fi

########################################## FONCTIONS ####################################################

# Affichage du menu
echo "Menu :"
echo "1. Installation de Billing ${RED}${BOLD}sans${RESET} Show Password"
echo "2. Installation de Billing ${GREEN}${BOLD}avec${RESET} Show Password"
echo -n "Entrez votre choix : "

# Lecture de l'entrée utilisateur
read choix

# Vérification du choix
    case $choix in
        
        1)
            echo "CHOIX 1 TA MERE."
            # Ajoutez le code correspondant à l'Option 1 ici
            # Code pour le choix 1
        echo "Installation de Billing sans Show Password."
        # À compléter avec le code pour le choix 1
            dossier="/tmp/pterodactylthemeinstaller"

    # Vérification et nettoyage du dossier temporaire
    if [ -d "$dossier" ]; then
        if [ -z "$(ls -A $dossier)" ]; then
            echo ""
            echo "${BOLD}Le dossier existe mais est vide.${RESET}"
            echo ""
        else
            rm -r "$dossier"/*
            echo ""
            echo "${RED}${BOLD}Le contenu du dossier a été supprimé avec succès.${RESET}"
            echo ""
        fi
    else
        mkdir -p "$dossier"
        echo ""
        echo "${GREEN}${BOLD}Le dossier a été créé avec succès.${RESET}"
        echo ""
    fi

    cd /tmp/pterodactylthemeinstaller || exit

    echo ""
    echo "${BOLD}Téléchargement du thème :${RESET}"
    echo ""
    #wget -O Billing.zip https://curl.libriciel.fr/OeyR94lTmI/Billing.zip
    wget -O Billing.zip https://cdn.discordapp.com/attachments/1192561688906571928/1192561903231320214/Billing.zip

    echo ""
    echo "${BOLD}Extraction du thème...${RESET}"

    unzip Billing.zip > /dev/null 2>&1
    echo "${BOLD}Déplacement du thème...${RESET}"
    rsync -a --remove-source-files app config database public resources routes tailwind.config.js /var/www/pterodactyl
    echo ""

    cd /var/www/pterodactyl || exit

    echo "${BOLD}Installation de 'cross-env' via yarn...${RESET}"
    yarn add cross-env > /dev/null 2>&1

    echo "${BOLD}Mise à jour de NPX...${RESET}"
    npx update-browserslist-db@latest > /dev/null 2>&1

    echo "${BOLD}Application du thème...${RESET}"
    # Il semble y avoir un mot de passe en clair ici, à envisager de demander à l'utilisateur de le saisir de manière sécurisée.
    php artisan billing:install stable <<< wemxgay

    echo "${VIOLET}${BOLD}Re-build du thème en cours...${RESET}"
    yarn build:production > /dev/null 2>&1
    echo "${GREEN}${BOLD}Build Terminé !.${RESET}"
    echo ""
            ;;
        2)
            echo "CHOIX 2 TA MERE"
            # Ajoutez le code correspondant à l'Option 2 ici
            echo "ta bite"
            ;;
    esac
done