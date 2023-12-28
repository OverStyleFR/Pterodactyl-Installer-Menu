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

######################################### MENU ###########################################################

### DOSSIER TEMPORAIRE ###

# Définir le chemin du dossier à vérifier
dossier="/tmp/pterodactylthemeinstaller"

# Vérifier si le dossier existe
if [ -d "$dossier" ]; then
    # Vérifier si le dossier est vide
    if [ -z "$(ls -A $dossier)" ]; then
        echo ""
        echo "${BOLD}Le dossier existe mais est vide.${RESET}"
        echo ""
    else
        # Supprimer le contenu du dossier s'il n'est pas vide
        rm -r "$dossier"/*
        echo ""
        echo "${RED}${BOLD}Le contenu du dossier a été supprimé avec succès.${RESET}"
        echo ""
    fi
else
    # Créer le dossier s'il n'existe pas
    mkdir -p "$dossier"
    echo ""
    echo "${GREEN}${BOLD}Le dossier a été créé avec succès.${RESET}"
    echo ""
fi

# Fonction pour le choix 1
choice_one() {
    # Télécharger le fichier ZIP
    ### DOWNLOAD ###

    cd /tmp/pterodactylthemeinstaller
    echo ""
    echo "${BOLD}Téléchargement du thème :${RESET}"
    echo ""
    wget -O stellar-v3.3.zip https://files.catbox.moe/ldjbsz.zip

    # Vérifier si le téléchargement a réussi
    if [ -f "stellar-v3.3.zip" ]; then
        # Extraire les dossiers spécifiques du ZIP
        cd /tmp/pterodactylthemeinstaller
        echo ""
        echo "${BOLD}Extraction du thème...${RESET}"
        unzip stellar-v3.3.zip > /dev/null 2>&1
        echo "${BOLD}Déplacement du thème...${RESET}"
        rsync -a --remove-source-files pterodactyl/app pterodactyl/resources pterodactyl/database pterodactyl/routes /var/www/pterodactyl
        echo ""

        # Supprimer le fichier ZIP après l'extraction (si nécessaire)
        echo "${BOLD}Suppresion du fichier temporaire...${RESET}"
        rm stellar-v3.3.zip
        echo ""
    else
        echo "${RED}${BOLD}Échec du téléchargement du fichier ZIP.${RESET}"
        exit 1
    fi

    # Se déplacer dans le répertoire /var/www/pterodactyl/
    cd /var/www/pterodactyl/ || exit

    # Installer react-feather via Yarn
    echo "${BOLD}Installation de 'react-feather' via yarn...${RESET}"
    yarn add react-feather > /dev/null 2>&1

    ## NPX Installation
    echo "${BOLD}Mise à jour de NPX...${RESET}"
    npx update-browserslist-db@latest > /dev/null 2>&1

    # Exécuter les migrations
    echo "${BOLD}Migration en cour...${RESET}"
    php artisan migrate <<< "yes" > /dev/null 2>&1

    # Construire la version de production
    echo ""
    echo "${VIOLET}${BOLD}Re-build du thème en cour...${RESET}"
    echo ""
    yarn build:production > /dev/null 2>&1
    echo "${GREEN}${BOLD}Build Terminé !.${RESET}"

    # Effacer le cache des vues
    echo ""
    echo "${BOLD}Effacement du cache.${RESET}"
    php artisan view:clear > /dev/null 2>&1
}

# Fonction pour le choix 2
choice_two() {
    # Se déplacer dans le répertoire /var/www/pterodactyl/
    cd /var/www/pterodactyl/ || exit

    # Construire la version de production
    echo ""
    echo "${VIOLET}${BOLD}Re-build du thème en cour...${RESET}"
    echo ""
    yarn build:production > /dev/null 2>&1
    echo "${GREEN}${BOLD}Build Terminé !.${RESET}"

    # Effacer le cache des vues
    echo ""
    echo "${BOLD}Effacement du cache.${RESET}"
    php artisan view:clear > /dev/null 2>&1
}

# Affichage du menu de choix
echo "Choisissez une action :"
echo "1. Installer le thème et exécuter les étapes complètes."
echo "2. Seulement yarn build:production et php artisan view:clear."
read -p "Entrez votre choix (1 ou 2): " user_choice

# Logique pour les choix
case $user_choice in
    1)
        echo "Vous avez choisi d'installer le thème et d'exécuter les étapes complètes."
        choice_one  # Assurez-vous que la fonction est définie avant cet appel
        ;;
    2)
        echo "Vous avez choisi de seulement exécuter yarn build:production et php artisan view:clear."
        choice_two
        ;;
    *)
        echo "Choix invalide. Veuillez entrer 1 ou 2."
        exit 1
        ;;
esac
