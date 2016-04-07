#!/bin/bash
# # # # #
# Script de sauvegarde et de nettoyage des fichiers joueurs sur ARK : SE
# Ugo : keups91@hotmail.com - 7/04/2016
# Pour SurvivARK.fr
# version 0.1.a-07-04-16
# # # # #

# Variables :
error="Une erreur s'est produite"
instant_t=`date +%d-%m-%y-a-%Hh%M`

# nombre de jour depuis la dernière activité connu du joueur
xday="60"

# exemple : "/home/steam/servers/arkdedicated/ShooterGame/Saved/SavedArks"
chemin="SavedArks"

# exemple : "/home/steam/servers/backup/"
backup="backup"

# script

# ./maintenance sauvegarde
if [ $1 = "sauvegarde" ]
	then
	echo "Vous allez effectuer une sauvegarde des fichiers joueurs de ARK : SE"
	echo "dans" $backup "sous la forme : fichier-jour-mois-annee-à-heure-minute à" $instant_t 

# copie les $chemin/.arkprofile
	for player in `ls $chemin/*.arkprofile`
	do
        cp $player $player-$instant_t
        echo "Sauvegarde de" $player "en" $player-$instant_t "effectuée avec succès !"
        #echo "Dans le répertoire : players-"$instant_t  <====== FIX
	done
# copie les $chemin/.profilebak
	for player2 in `ls $chemin/*.profilebak`
	do
        cp $player2 $player2-$instant_t
        echo "Sauvegarde de" $player2 "en" $player2-$instant_t "effectuée avec succès !"
        #echo "Dans le répertoire : players-"$instant_t  <====== FIX
	done
# déplace les .arkprofile et .profilebak dans le dossier $backup
	find $chemin -type f -iname "*$instant_t*" -print -exec mv \{\} $backup/ \;

# ./maintenance nettoyage
elif [ $1 = "nettoyage" ]
	then
	echo "Vous allez effectuer un nettoyage des joueurs inactifs depuis" $xday "jours"
# cherche les joueurs innactifs depuis xday et les supprimes
	find $chemin -type f -iname "*.arkprofile*" -mtime +$xday -print -delete
	find $chemin -type f -iname "*.profilebak*" -mtime +$xday -print -delete
	echo "Nettoyage terminé ! vous avez supprimé les fichiers des joueurs inactifs depuis" $xday "!"

# ./maintenance effacer
elif [ $1 = "effacer" ]
	then
	echo "Vous allez effectuer un effacement de tous les joueurs sauvegardés"
	find $backup -type f -iname "*.arkprofile*" -print -exec rm \{\} \;
	find $backup -type f -iname "*.profilebak*" -print -exec rm \{\} \;
	echo "Effacement terminé ! vous avez supprimé les fichiers des joueurs sauvegardés"

# erreurs script : "sans/mauvais paramètre"

# sans paramètre
elif [ -z $1 ]
	then
	echo $error
	echo "Sans paramètre, utilisez ./maintenance sauvegarde|nettoyage|effacer"
# mauvais paramètre
elif [ -n $1 ]
	then
	echo $error
	echo "Mauvais paramètre, utilisez ./maintenance sauvegarde|nettoyage|effacer"
fi