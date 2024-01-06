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

# Le reste du script ici

########################################### CLEAR CACHE DOCKER ###########################################

# Demander à l'utilisateur de faire l'action "save file"
read -p "Voulez vous supprimer tous le cache de docker ? ${RED}${BOLD}NON REVERSIBLE ${RESET}(${GREEN}Yes/${RED}Non) > ${RESET}" response

# Liste des réponses acceptées, séparées par des espaces
accepted_responses=("oui" "o" "yes" "y")

# Vérifier si la réponse est dans la liste des réponses acceptées
if [[ " ${accepted_responses[@]} " =~ " ${response} " ]]; then
    echo "L'utilisateur a répondu 'oui'. Suppresion du cache..."
else
    echo "Réponse incorrecte. Le script se termine."
    exit 1
fi

echo ""
echo "${VIOLET}${BOLD}Suppresion du cache docker ${RESET}"
echo ""
docker system prune -a <<< y

echo ""
echo "${BOLD}Re-création du network 'pterodactyl_nw'${RESET}"
echo ""
docker network create --driver bridge pterodactyl_nw

# FIN
echo ""
echo "${BLUE}${BOLD}Fin du script.${RESET}"
echo ""