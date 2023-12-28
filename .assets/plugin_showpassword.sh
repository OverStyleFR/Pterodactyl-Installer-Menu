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
https://raw.githubusercontent.com/OverStyleFR/Pterodactyl-Installer-Menu/V2/.assets/plugin_showpassword.sh


# Changement de répertoire
cd /var/www/pterodactyl/resources/scripts/components/auth

# Fichier source
fichier="LoginContainer.tsx"

# Code à rechercher
code_a_remplacer='
<div css={tw`mt-6`} style={{display: \'inline-block\', width: \'100%\'}}>
    <Field light type={\'password\'} label={\'Password\'} name={\'password\'} disabled={isSubmitting} />
    <button type="button" style={{transform: \'translate(-10%, -125%)\', float: \'right\', border: \'none\', backgroundColor: \'transparent\'}} onClick={_ => {
        let passwordElement = document.querySelector(\'[name=\'password\']\');
        if (passwordElement == null) return;
        let showIcon = document.getElementById(\'pwd-show\');
        if (showIcon == null) return;
        let hideIcon = document.getElementById(\'pwd-hide\');
        if (hideIcon == null) return;
        if(passwordElement.getAttribute(\'type\') === \'password\') {
            passwordElement.setAttribute(\'type\', \'text\');
            hideIcon.style.display = \'none\';
            showIcon.style.display = \'\';
        } else {
            passwordElement.setAttribute(\'type\', \'password\');
            hideIcon.style.display = \'\';
            showIcon.style.display=\'none\';
        }
    }}>
        <svg width="40px" height="40px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" id="pwd-show" style={{display: \'none\', backgroundColor: \'white\'}}>
            <path d="M12 5C5.63636 5 2 12 2 12C2 12 5.63636 19 12 19C18.3636 19 22 12 22 12C22 12 18.3636 5 12 5Z" stroke="#000000" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />
            <path d="M12 15C13.6569 15 15 13.6569 15 12C15 10.3431 13.6569 9 12 9C10.3431 9 9 10.3431 9 12C9 13.6569 10.3431 15 12 15Z" stroke="#000000" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />
        </svg>
        <svg width="40px" height="40px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" id="pwd-hide" style={{backgroundColor: \'white\'}}>
            <path d="M20 14.8335C21.3082 13.3317 22 12 22 12C22 12 18.3636 5 12 5C11.6588 5 11.3254 5.02013 11 5.05822C10.6578 5.09828 10.3244 5.15822 10 5.23552M12 9C12.3506 9 12.6872 9.06015 13 9.17071C13.8524 9.47199 14.528 10.1476 14.8293 11C14.9398 11.3128 15 11.6494 15 12M3 3L21 21M12 15C11.6494 15 11.3128 14.9398 11 14.8293C10.1476 14.528 9.47198 13.8524 9.1707 13C9.11386 12.8392 9.07034 12.6721 9.04147 12.5M4.14701 9C3.83877 9.34451 3.56234 9.68241 3.31864 10C2.45286 11.1282 2 12 2 12C2 12 5.63636 19 12 19C12.3412 19 12.6746 18.9799 13 18.9418" stroke="#000000" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />
        </svg>
    </button>
</div>'

# Nouveau code
nouveau_code='{/* DisplayPassword Start */}
<div css={tw`mt-6`} style={{display: \'inline-block\', width: \'100%\'}}>
    <Field light type={\'password\'} label={\'Password\'} name={\'password\'} disabled={isSubmitting} />
    <button type="button" style={{transform: \'translate(-10%, -125%)\', float: \'right\', border: \'none\', backgroundColor: \'transparent\'}} onClick={_ => {
        let passwordElement = document.querySelector(\'[name=\'password\']\');
        if (passwordElement == null) return;
        let showIcon = document.getElementById(\'pwd-show\');
        if (showIcon == null) return;
        let hideIcon = document.getElementById(\'pwd-hide\');
        if (hideIcon == null) return;
        if(passwordElement.getAttribute(\'type\') === \'password\') {
            passwordElement.setAttribute(\'type\', \'text\');
            hideIcon.style.display = \'none\';
            showIcon.style.display = \'\';
        } else {
            passwordElement.setAttribute(\'type\', \'password\');
            hideIcon.style.display = \'\';
            showIcon.style.display=\'none\';
        }
    }}>
        <svg width="40px" height="40px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" id="pwd-show" style={{display: \'none\', backgroundColor: \'white\'}}>
            <path d="M12 5C5.63636 5 2 12 2 12C2 12 5.63636 19 12 19C18.3636 19 22 12 22 12C22 12 18.3636 5 12 5Z" stroke="#000000" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />
            <path d="M12 15C13.6569 15 15 13.6569 15 12C15 10.3431 13.6569 9 12 9C10.3431 9 9 10.3431 9 12C9 13.6569 10.3431 15 12 15Z" stroke="#000000" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />
        </svg>
        <svg width="40px" height="40px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg" id="pwd-hide" style={{backgroundColor: \'white\'}}>
            <path d="M20 14.8335C21.3082 13.3317 22 12 22 12C22 12 18.3636 5 12 5C11.6588 5 11.3254 5.02013 11 5.05822C10.6578 5.09828 10.3244 5.15822 10 5.23552M12 9C12.3506 9 12.6872 9.06015 13 9.17071C13.8524 9.47199 14.528 10.1476 14.8293 11C14.9398 11.3128 15 11.6494 15 12M3 3L21 21M12 15C11.6494 15 11.3128 14.9398 11 14.8293C10.1476 14.528 9.47198 13.8524 9.1707 13C9.11386 12.8392 9.07034 12.6721 9.04147 12.5M4.14701 9C3.83877 9.34451 3.56234 9.68241 3.31864 10C2.45286 11.1282 2 12 2 12C2 12 5.63636 19 12 19C12.3412 19 12.6746 18.9799 13 18.9418" stroke="#000000" strokeWidth="1.5" strokeLinecap="round" strokeLinejoin="round" />
        </svg>
    </button>
</div>
{/* DisplayPassword End */}'

# Échapper les caractères spéciaux pour sed
code_a_remplacer_escaped=$(printf '%s\n' "$code_a_remplacer" | sed -e 's/[]$.*[\^]/\\&/g')

# Utilisation de sed pour effectuer le remplacement
sed -i "s/$code_a_remplacer_escaped/$nouveau_code/g" $fichier

# Ajout de la commande yarn build:production
yarn build:production

echo "Remplacement effectué avec succès pour $fichier. La commande yarn build:production a été exécutée."
