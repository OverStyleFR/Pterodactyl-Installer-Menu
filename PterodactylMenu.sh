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

couleur_panel="\e[1;34m"  # Bleu clair
couleur_panel_texte="\e[1;32m"  # Vert clair
couleur_pterodactyl="\e[1;36m"  # Cyan clair
couleur_pterodactyl_texte="\e[1;36m"  # Cyan clair
couleur_reinitialisation="\e[1;31m"  # Rouge clair
couleur_reinitialisation_texte="\e[1;32m"  # Vert clair
couleur_chiffres="\e[1;33m"  # Jaune clair
couleur_reset="\e[0m"

echo -e "${couleur_panel}+-----------------------------------------------+"
echo -e "|              ${couleur_panel_texte}Panel Pterodactyl${couleur_panel} :              |"
echo -e "+-----------------------------------------------+"
echo -e "| ${couleur_chiffres}1${couleur_pterodactyl}. Installer Pterodactyl (Dernière Version)   ${couleur_panel}|"
echo -e "| ${couleur_chiffres}2${couleur_pterodactyl}. Installer MySQL et PhpMyAdmin              ${couleur_panel}|"
echo -e "|   ${couleur_reinitialisation_texte}- (Dernière Version)                        ${couleur_panel}|"
echo -e "+-----------------------------------------------+"
echo -e "                         ${couleur_pterodactyl}+"
echo -e "                         ${couleur_pterodactyl}|"
echo -e "                         ${couleur_pterodactyl}↓"
echo -e "${couleur_panel}+-----------------------------------------------+"
echo -e "|              ${couleur_panel_texte}Pterodactyl Thème${couleur_panel} :              |"
echo -e "+-----------------------------------------------+"
echo -e "| ${couleur_chiffres}3${couleur_pterodactyl}. Installer Stellar-V3.3      ${couleur_panel}|\e[1;36m Ptero 11.x.x${couleur_panel} |"
echo -e "| ${couleur_chiffres}4${couleur_pterodactyl}. Installer Enigma-V3.9       ${couleur_panel}|\e[1;36m Ptero 11.x.x${couleur_panel} |"
echo -e "| ${couleur_chiffres}5${couleur_pterodactyl}. Installer Billing           ${couleur_panel}|\e[1;36m Ptero 11.x.x${couleur_panel} |"
echo -e "| ${couleur_chiffres}6${couleur_pterodactyl}. Installer Carbon            ${couleur_panel}|\e[1;36m Ptero 11.x.x${couleur_panel} |"
echo -e "+-----------------------------------------------+"
echo -e "                         ${couleur_pterodactyl}+"
echo -e "                         ${couleur_pterodactyl}|"
echo -e "                         ${couleur_pterodactyl}↓"
echo -e "${couleur_panel}+-----------------------------------------------+"
echo -e "|             ${couleur_reinitialisation_texte}Réinitialisation${couleur_panel} :                |"
echo -e "+-----------------------------------------------+"
echo -e "| ${couleur_pterodactyl}${couleur_chiffres}7. Re-installer le thème du panel (RESET UI)  ${couleur_panel}|"
echo -e "|   ${couleur_reinitialisation_texte}- N'affecte pas les machines déjà installées${couleur_panel}|"
echo -e "|   ${couleur_reinitialisation_texte}- Aucune perte de sauvegarde                ${couleur_panel}|"
echo -e "+-----------------------------------------------+"
echo -e "| ${couleur_reinitialisation}8. Quitter${couleur_panel}                                    |"
echo -e "+-----------------------------------------------+${couleur_reset}"

read -p "Choisissez une option (1-8) : " choix



    case $choix in
        
        1)
            echo "Installation de Pterodactyl."
            bash <(curl -s https://raw.githubusercontent.com/LucieFairePy/Pterodactyl-Installer-FR/main/install.sh)
            ;;
        2)
            echo "Installer MySQL et PhpMyAdmin"
            echo "  - (Dernière Version)"
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/V2/.assets/pma%26mysql_installation.sh)
            ;;
        3)
            echo "Installation du thème Stellar v3.3."
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/V2/.assets/initialisation.sh)
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/V2/.assets/theme_stellar.sh)
            ;;
        4)
            echo "Installation du thème Enigma v3.9."
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/V2/.assets/initialisation.sh)
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/V2/.assets/theme_enigma.sh)
            ;;
        5)
            echo "Installation du thème Billing Module"
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/V2/.assets/theme_billing.sh)
            ;;
        6)
            echo "Installation du thème Carbon v1.6.6"
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/V2/.assets/theme_carbon.sh)
            ;;
        7)
            echo "Ré-installer le thème de Pterodactyl. (RESET UI)"
            echo "N'affecte pas les machines déjà installer"
            bash <(curl -s https://raw.githubusercontent.com/OverStyleFR/AutoScriptBash/main/.assets/pterodactylpanelreinstall.sh)
            ;;
        8)
            echo "Au revoir !"
            exit 0
            ;;
        *)
            echo "Choix non valide. Veuillez entrer un numéro entre 1 et 8."
            ;;
    esac
done
