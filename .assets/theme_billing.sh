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

########################################## CHOIX D'INSTALLATION ##########################################

choix=""
while [[ "$choix" != "1" && "$choix" != "2" ]]; do
    echo "${BOLD}Choisissez l'installation :${RESET}"
    echo "1. Installer le plugin 'ShowPassword'"
    echo "2. Installer le thème 'Billing' sans le plugin 'ShowPassword'"
    read -p "Entrez votre choix (1 ou 2) : " choix
done

######################################### INSTALLATION CHOISIE ############################################

if [ "$choix" == "1" ]; then
    echo "${BOLD}Téléchargement du script d'installation du plugin 'ShowPassword'...${RESET}"
    wget -O plugin_showpassword.sh https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/V2/.assets/plugin_showpassword.sh
    bash plugin_showpassword.sh
elif [ "$choix" == "2" ]; then
    dossier="/tmp/pterodactylthemeinstaller"

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

    cd /tmp/pterodactylthemeinstaller
    echo ""
    echo "${BOLD}Téléchargement du thème :${RESET}"
    echo ""
    wget -O Billing.zip https://curl.libriciel.fr/OeyR94lTmI/Billing.zip

    echo ""
    echo "${BOLD}Extraction du thème...${RESET}"

    unzip Billing.zip > /dev/null 2>&1
    echo "${BOLD}Déplacement du thème...${RESET}"
    rsync -a --remove-source-files app config database public resources routes tailwind.config.js /var/www/pterodactyl
    echo ""

    cd /var/www/pterodactyl

    echo "${BOLD}Installation de 'cross-env' via yarn...${RESET}"
    yarn add cross-env > /dev/null 2>&1

    echo "${BOLD}Mise à jour de NPX...${RESET}"
    npx update-browserslist-db@latest > /dev/null 2>&1

    echo "${BOLD}Application du thème...${RESET}"
    php artisan billing:install stable <<< wemxgay

    echo "${VIOLET}${BOLD}Re-build du thème en cours...${RESET}"
    yarn build:production > /dev/null 2>&1
    echo "${GREEN}${BOLD}Build Terminé !.${RESET}"
    echo ""
else
    echo "${RED}${BOLD}Choix invalide.${RESET}"
    exit 1
fi
