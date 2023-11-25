#!/bin/bash

# couleurs :
VERTE='\033[0;32m'
ROUGE='\033[0;31m'
TEXTE='\033[0m'

# bannière :
echo -e "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-" | lolcat
echo
echo -e "Reconnai55ance" | lolcat
echo 
echo -e "+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-" | lolcat
echo 

# Logiciels utilisés :
# https://github.com/sensepost/gowitness
# https://github.com/busyloop/lolcat

# fonction aide :
montrer_aide() {
    echo -e 'Reconnai55ance par Christophe Hédé' | lolcat
    echo -e 'usage : ./reconnai55.sh [OPTIONS]'
    echo -e 'options :' | lolcat
    echo -e '  -h, --help\t\t Afficher les commandes'
    echo -e '  -d, --domaine\t\t Exécuter la reconnaissance sur un domaine'
    echo -e '  -v, --version\t\t Version du script'
    echo
}

# options de l'aide :
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            montrer_aide
            exit
            ;;
        -d|--domaine)
            if [[ -n "$2" ]]; then
                cible+=("$2")
                shift 2
            else
                echo -e "${ROUGE}ATTENTION :${TEXTE} N'oubliez pas le domaine !"
                exit
            fi
            ;;
        -v|--version)
            echo -e "Reconnai55ance V0.03";
            exit
            ;;
        *)
            echo -e "${ROUGE}ATTENTION :${TEXTE} Commande non reconnue $1"
            exit
            ;;
    esac
done

# exécution des programmes :

ip=$(host ${cible} | grep "address" | awk '{print $4}')
nom=$(echo ${cible} | tr . _)
ladate=$(date +%F)

echo -e "Domaine : ${cible}"
echo -e "Adresse IP : ${ip}"
echo -e "Nom : ${nom}"

mkdir "$HOME/reconnai55"
mkdir "$HOME/reconnai55/${nom}"
mkdir "$HOME/reconnai55/${nom}/${ladate}"
CHEMIN="$HOME/reconnai55/${nom}/${ladate}"
echo -e "${VERTE}Création du répertoire.${TEXTE}"

echo ${ip} > $CHEMIN/adresse_ip.txt
echo "http://${cible}" > $CHEMIN/domaine.txt
echo -e "${VERTE}Création des fichiers (adresse ip et domaine).${TEXTE}"

gowitness single --disable-db -o $CHEMIN/${nom}-1.png http://${cible}
echo -e "${VERTE}Copie écran de la cible.${TEXTE}"



