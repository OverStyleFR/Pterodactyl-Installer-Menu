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
    wget -O Billing.zip https://curl.libriciel.fr/OeyR94lTmI/Billing.zip

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
        # Code pour le choix 2
        echo "Vous avez choisi le choix 2."
        # À compléter avec le code pour le choix 2
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
    wget -O Billing.zip https://curl.libriciel.fr/OeyR94lTmI/Billing.zip

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

    ################################## Edit Login.tsx Plugin Show Password ##################################

    # Chemin du fichier à éditer
    file_path="resources/scripts/components/auth/LoginContainer.tsx"

    # Vérification si le fichier existe
    if [ -f "$file_path" ]; then
    # Remplacement de la section de code
    sed -i 's|<div css={tw`mt-6`}>\n    <Field light type={'\''password'\''} label={'\''Password'\''} name={'\''password'\''} disabled={isSubmitting} />\n</div>|{/* DisplayPassword Start */\n<div css={tw`mt-6`} style={{display: '\''inline-block'\'', width: '\''100%'\''}}>\n    <Field light type={'\''password'\''} label={'\''Password'\''} name={'\''password'\''} disabled={isSubmitting} />\n    <button type="button" style={{transform: '\''translate(-10%, -125%)'\'', float: '\''right'\'', border: '\''none'\'', backgroundColor: '\''transparent'\'', opacity: 0.5}} onClick={_ => {\n        let passwordElement = document.querySelector('[name='\''password'\'']');\n        if (passwordElement == null) return;\n        let showIcon = document.getElementById('\''pwd-show'\'');\n        if (showIcon == null) return;\n        let hideIcon = document.getElementById('\''pwd-hide'\'');\n        if (hideIcon == null) return;\n        if(passwordElement.getAttribute('\''type'\'') === '\''password'\'') {\n            passwordElement.setAttribute('\''type'\'', '\''text'\'');\n            hideIcon.style.display = '\''none'\'';\n            showIcon.style.display = '\'''\';\n        } else {\n            passwordElement.setAttribute('\''type'\'', '\''password'\'');\n            hideIcon.style.display = '\'''\';\n            showIcon.style.display='\''none'\'';\n        }\n    }}>\n        <svg width="40px" height="40px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" id="pwd-show" style={{display: '\''none'\'', backgroundColor: '\''white'\''}}>\n            <path d="M12 5C5.63636 5 2 12 2 12C2 12 5.63636 19 12 19C18.3636 19 22 12 22 12C22 12 18.3636 5 12 5Z" stroke="#000000" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />\n            <path d="M12 15C13.6569 15 15 13.6569 15 12C15 10.3431 13.6569 9 12 9C10.3431 9 9 10.3431 9 12C9 13.6569 10.3431 15 12 15Z" stroke="#000000" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />\n        </svg>\n        <svg width="40px" height="40px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" id="pwd-hide" style={{backgroundColor: '\''white'\''}}>\n            <path d="M20 14.8335C21.3082 13.3317 22 12 22 12C22 12 18.3636 5 12 5C11.6588 5 11.3254 5.02013 11 5.05822C10.6578 5.09828 10.3244 5.15822 10 5.23552M12 9C12.3506 9 12.6872 9.06015 13 9.17071C13.8524 9.47199 14.528 10.1476 14.8293 11C14.9398 11.3128 15 11.6494 15 12M3 3L21 21M12 15C11.6494 15 11.3128 14.9398 11 14.8293C10.1476 14.528 9.47198 13.8524 9.1707 13C9.11386 12.8392 9.07034 12.6721 9.04147 12.5M4.14701 9C3.83877 9.34451 3.56234 9.68241 3.31864 10C2.45286 11.1282 2 12 2 12C2 12 5.63636 19 12 19C12.3412 19 12.6746 18.9799 13 18.9418" stroke="#000000" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />\n        </svg>\n    </button>\n</div>\n{/* DisplayPassword End */}|g' "$file_path"
    echo "Section de code remplacée avec succès."
    else
    echo "Le fichier spécifié n'existe pas."
    fi

        ;;
    *)
        # En cas de choix invalide
        echo "Choix invalide. Veuillez entrer 1 ou 2."
        ;;
esac





    #    #!/bin/bash

    #    # Chemin du fichier à éditer
    #    file_path="resources/scripts/components/auth/LoginContainer.tsx"

    #    # Vérification si le fichier existe
    #    if [ -f "$file_path" ]; then
    #        # Remplacement de la section de code
    #    sed -i 's|<div css={tw`mt-6`}>\n    <Field light type={'\''password'\''} label={'\''Password'\''} name={'\''password'\''} disabled={isSubmitting} />\n</div>|{/* DisplayPassword Start */\n<div css={tw`mt-6`} style={{display: '\''inline-block'\'', width: '\''100%'\''}}>\n    <Field light type={'\''password'\''} label={'\''Password'\''} name={'\''password'\''} disabled={isSubmitting} />\n    <button type="button" style={{transform: '\''translate(-10%, -125%)'\'', float: '\''right'\'', border: '\''none'\'', backgroundColor: '\''transparent'\'', opacity: 0.5}} onClick={_ => {\n        let passwordElement = document.querySelector('[name='\''password'\'']');\n        if (passwordElement == null) return;\n        let showIcon = document.getElementById('\''pwd-show'\'');\n        if (showIcon == null) return;\n        let hideIcon = document.getElementById('\''pwd-hide'\'');\n        if (hideIcon == null) return;\n        if(passwordElement.getAttribute('\''type'\'') === '\''password'\'') {\n            passwordElement.setAttribute('\''type'\'', '\''text'\'');\n            hideIcon.style.display = '\''none'\'';\n            showIcon.style.display = '\'''\';\n        } else {\n            passwordElement.setAttribute('\''type'\'', '\''password'\'');\n            hideIcon.style.display = '\'''\';\n            showIcon.style.display='\''none'\'';\n        }\n    }}>\n        <svg width="40px" height="40px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" id="pwd-show" style={{display: '\''none'\'', backgroundColor: '\''white'\''}}>\n            <path d="M12 5C5.63636 5 2 12 2 12C2 12 5.63636 19 12 19C18.3636 19 22 12 22 12C22 12 18.3636 5 12 5Z" stroke="#000000" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />\n            <path d="M12 15C13.6569 15 15 13.6569 15 12C15 10.3431 13.6569 9 12 9C10.3431 9 9 10.3431 9 12C9 13.6569 10.3431 15 12 15Z" stroke="#000000" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />\n        </svg>\n        <svg width="40px" height="40px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" id="pwd-hide" style={{backgroundColor: '\''white'\''}}>\n            <path d="M20 14.8335C21.3082 13.3317 22 12 22 12C22 12 18.3636 5 12 5C11.6588 5 11.3254 5.02013 11 5.05822C10.6578 5.09828 10.3244 5.15822 10 5.23552M12 9C12.3506 9 12.6872 9.06015 13 9.17071C13.8524 9.47199 14.528 10.1476 14.8293 11C14.9398 11.3128 15 11.6494 15 12M3 3L21 21M12 15C11.6494 15 11.3128 14.9398 11 14.8293C10.1476 14.528 9.47198 13.8524 9.1707 13C9.11386 12.8392 9.07034 12.6721 9.04147 12.5M4.14701 9C3.83877 9.34451 3.56234 9.68241 3.31864 10C2.45286 11.1282 2 12 2 12C2 12 5.63636 19 12 19C12.3412 19 12.6746 18.9799 13 18.9418" stroke="#000000" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />\n        </svg>\n    </button>\n</div>\n{/* DisplayPassword End */}|g' "$file_path"
    #        echo "Section de code remplacée avec succès."
    #    else
    #       echo "Le fichier spécifié n'existe pas."
    #    fi
