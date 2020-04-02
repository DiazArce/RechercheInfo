#!/usr/bin/perl

# ////////////////////////////////////////////////////////////////////////////////////////////////////
#/																									 /
#/ EXERCICE : 1.1.2 analyse de la collection - partie 2                                              /
#/                                                                                                   /
#/ DESCRIPTION :le script permet calculer le nombre moyen d'apparitions du terme le plus frequent    /
#/             dans les documents. il recoit en entree le fichier contenant la liste de termes       /
#/             plus frequent et donne en sortie le nombre moyen d'apparitions pour chaque terme.     /
#/                                                                                                   /
#/ AUTEURS :   DIAZ Daniel et SAIDI Alhaye                                                           /
#/                                                                                                   /
# ////////////////////////////////////////////////////////////////////////////////////////////////////

print " begin program ....  " , " \n";

# Ouverture du fichier file.termes-plus-frequent	
my $wordsList = "./TPRIEtu2019/Output/file.termes-plus-frequent"; # fichier contenant les 16 termes le plus frequent de la collection
open(LISTE, $wordsList)or die "Sorry!! couldn't open";
open(NEWFILE, '>', "./TPRIEtu2019/Output/file.nb-moyen-occurrence-total") or die $!;
print NEWFILE "mot,"," ","nb_docs,"," ","occurrence,"," ","moyen,","\n"; #format du nouveau fichier
while (my $terme = <LISTE>){ # Parcours sur le fichier contenant la liste de termes le plus frequent
	chomp($terme);
	
#   Initialisation de variables pour le calcul de la moyen
	my $somme = 0.0; # stocke nombre total d'apparitions du terme
	my $i=0; # stocke le nombre total de documents ou le terme apparait
	my $moyen = 0.0; #stocke le nombre moyen d'apparitions

# Ouverture du fichier Collection	
	my $filenameList = "./TPRIEtu2019/Collection/Collection";
    open(FILENAMELIST, $filenameList)or die "Sorry!! couldn't open";

	while ( my $cacmfile = <FILENAMELIST>) { #parcours le fichier Collection pour extraire le nom de chaque document de la collection
	    chomp($cacmfile); 
	    
	    # ouverture de chaque fichier avec l'extension sans accent ni ponctuation
	    open(FILE, "./TPRIEtu2019/Collection1/${cacmfile}.sanp")or die "Sorry!! couldn't open";
	    
	    while (my $row = <FILE>) { #parcours de chaque document pour extraire le contenu (les lignes)
	    	chomp($row);
	    	
	    	if($row=~ $terme){ # si le terme le plus frequent se trouve dans le document
	    		
	    		@words= split / /, $row; # on coupe le contenu mot par mot et on le met dans une liste
	    		
	    		foreach my  $word(@words) { # on va compter le nombre d'apparitions du terme dans la liste
					$count{$word}++;	
				}
				$i++;	# on va incrementer le nombre de documents ou le terme apparait
	    	}		
	   }
	   
	   close (FILE);
	   	
    }
   close(FILENAMELIST);
   
# On calcul le nombre total d'apparitions du terme
   	 
	$somme=$count{$terme};

# On calcul la moyenne et on affiche le resultat
	
	#$moyen=$somme/$i;  # si on calcul la moyenne d'occurrence par document
	$moyen=$somme/3204; # si on calcul la moyenne d'occurrence parmis tous les documents
	
	print NEWFILE $terme," , ",$i," , ",$somme," , ",$moyen,"\n";
	
	%count = 0;
	
}
close NEWFILE;
close LISTE;