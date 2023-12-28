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

########################################### INITIALISATION / PREPARATION ################################

################ PACKAGES #################

### UNZIP ###

# Vérifier si le package unzip est installé
if ! dpkg -s unzip >/dev/null 2>&1; then
    # Afficher le texte en rouge et en gras
    echo "${BOLD}Le package unzip n'est pas installé. Installation en cours...${RESET}"

    # Vérifier le gestionnaire de paquets
    if command -v apt-get &> /dev/null; then
         apt-get install -y unzip
    elif command -v yum &> /dev/null; then
         yum install -y unzip
    elif command -v brew &> /dev/null; then
        brew install unzip
    else
        echo "Impossible de déterminer le gestionnaire de paquets. Veuillez installer PHP manuellement."
        echo ""
        exit 1
    fi
else
    # Afficher le texte en vert et en gras
    echo "${GREEN}${BOLD}Le package unzip est déjà installé.${RESET}"
fi

### YARN ### (Ré-installation de celui ci)

# Vérifier si Yarn est installé
if command -v yarn &> /dev/null; then
    echo "${BOLD}Yarn est déjà installé sur votre machine.${RESET}"
else
    # Installer Yarn s'il n'est pas déjà installé
    echo "${BOLD}Yarn n'est pas installé. Installation en cours...${RESET}"
    echo ""

    # Installer Yarn via le script (get.tomv.ovh)
    bash <(curl -s https://get.tomv.ovh/yarninstall.sh)

    # Vérifier à nouveau si l'installation a réussi
    if command -v yarn &> /dev/null; then
        echo "${GREEN}${BOLD}Yarn a été installé avec succès.${RESET}"
        echo ""
    else
        echo "${RED}${BOLD}Une erreur s'est produite lors de l'installation de Yarn. Veuillez vérifier votre configuration.${RESET}"
        echo ""
        exit 1
    fi
fi

### PHP ###

# Vérifier si PHP est installé
if command -v php &> /dev/null; then
    echo "${BOLD}PHP est déjà installé sur votre machine.${RESET}"
else
    # Installer PHP s'il n'est pas déjà installé
    echo "${BOLD}PHP n'est pas installé. Installation en cours...${RESET}"
    echo ""
    
    # Vérifier le gestionnaire de paquets
    if command -v apt-get &> /dev/null; then
        apt-get install -y php
    elif command -v yum &> /dev/null; then
        yum install -y php
    elif command -v brew &> /dev/null; then
        brew install php
    else
        echo "${RED}${BOLD}Impossible de déterminer le gestionnaire de paquets. Veuillez installer PHP manuellement.${RESET}"
        echo ""
        exit 1
    fi

    # Vérifier à nouveau si l'installation a réussi
    if command -v php &> /dev/null; then
        echo "${GREEN}${BOLD}PHP a été installé avec succès.${RESET}"
    else
        echo "${RED}${BOLD}Une erreur s'est produite lors de l'installation de PHP. Veuillez vérifier votre configuration.${RESET}"
        echo ""
        exit 1
    fi
fi

### Node JS & npm ###

# Vérifier si Node.js est installé
if command -v node &> /dev/null; then
    echo "${BOLD}Node.js est déjà installé.${RESET}"
else
    # Installer Node.js
    curl -SLO https://deb.nodesource.com/nsolid_setup_deb.sh
    chmod 500 nsolid_setup_deb.sh
    ./nsolid_setup_deb.sh 16
    apt-get install nodejs -y
    echo "${GREEN}${BOLD}Node.js a été installé avec succès.${RESET}"
    rm ./nsolid_setup_deb.sh
fi

# Vérifier si npm est installé
if command -v npm &> /dev/null; then
    echo "${BOLD}npm est déjà installé.${RESET}"
else
    # Installer npm
    echo "${BOLD}npm n'est pas installé. Installation en cours...${RESET}"
    echo ""
    apt-get install -y npm
    echo "${GREEN}${BOLD}npm a été installé avec succès.${RESET}"
fi

### AUTRES ###


################ VERSIONS #################

### Node JS ### (16.20.2)

# Fonction pour comparer les versions
compare_versions() {
    local version1=$1
    local version2=$2
    if [[ "$(printf '%s\n' "$version1" "$version2" | sort -V | head -n 1)" == "$version1" ]]; then
        return 0  # version1 est supérieure ou égale à version2
    else
        return 1  # version1 est inférieure à version2
    fi
}

# Vérifier si Node.js est installé
if command -v node &> /dev/null; then
    # Récupérer la version de Node.js
    node_version=$(node --version | cut -c 2-)  # Supprimer le 'v' du numéro de version
    required_version="14.0.0"

    # Comparer les versions
    if compare_versions "$node_version" "$required_version"; then
        echo ""
        echo "${GREEN}${BOLD}La version de Node.js ($node_version) est déjà supérieure à 14.${RESET}"
    else
        echo "${BLUE}${BOLD}La version de Node.js ($node_version) est inférieure à 14. Installation de la version requise...${RESET}"

        # Installer Node.js 14
        npm install -g n
        n 16.20.2
        node -v

        # Vérifier à nouveau la version installée
        installed_version=$(node --version | cut -c 2-)
        echo ""
        echo "${GREEN}${BOLD}Node.js a été installé avec succès. Nouvelle version : $installed_version${RESET}"
        echo ""
    fi
else
    echo "${BLUE}${BOLD}Node.js n'est pas installé. Installation de la version 14...${RESET}"
    
    # Installer Node.js 14
    curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
    apt install -y nodejs


    # Vérifier la version installée
    installed_version=$(node --version | cut -c 2-)
    echo "${GREEN}${BOLD}Node.js a été installé avec succès. Nouvelle version : $installed_version${RESET}"
fi