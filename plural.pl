#!/usr/bin/perl

# ////////////////////////////////////////////////////////////////////////////////////////////////////
#/																									  /
#/ EXERCICE : 1.3 MODIFICATION DES FICHIERS DE LA COLLECTION - Partie 3                               /
#/                                                                                                    /
#/ DESCRIPTION :Le script permet eliminer les pluriels du vocabulaire                                 /
#/             il recoit en entree le fichier du vocabulaire sans les mots vides et il donne en       /
#/             sortie un fichier contenant le vocabulaire sans les termes en pluriels reguliers       /
#/																	                            	  /
#/ AUTEURS :   DIAZ Daniel et SAIDI Alhaye                                                            /
#/                                                                                                    /
# ////////////////////////////////////////////////////////////////////////////////////////////////////

open(FILE, "./TPRIEtu2019/Output/file.vocabulaire-sans-mots-vides") or die "Sorry!! couldn't open"; 
open(NEWFILE, '>', "./TPRIEtu2019/Output/file.vocabulaire-sans-pluriel") or die "Sorry!! couldn't open"; 

while ( my $row = <FILE>) { #parcours de chaque document pour extraire le contenu (les lignes    	
	chomp($row);
	if($row	!~ /s\b|es\b|ies\b/){ # on verifier si le mot contient un pluriel regulier terminee en s, es ou ies
		
		print NEWFILE $row,"\n"; #on sauvegarde sur le fichier tous les mots sans pluriels
	}
    	
   		
}
close(FILE);
close(NEWFILE);
