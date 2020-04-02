#!/usr/bin/perl

# ////////////////////////////////////////////////////////////////////////////////////////////////////
#/																									  /
#/ EXERCICE : 1.3 MODIFICATION DES FICHIERS DE LA COLLECTION - Partie 3                               /
#/                                                                                                    /
#/ DESCRIPTION :
#/             Le script est une version amelioree du fichier plural.pl il permet eliminer            /
#/             les mots pluriels de tous les documents de la collection, ici nous allons ouvrir la    /
#			   collection2 contenant les documents sans mots vides et ce programme donne en sortie    /
#/             la collection 3 qui va contenir les documents avec l'extension sp.                     /
#/																	                            	  /
#/ AUTEURS :   DIAZ Daniel et SAIDI Alhaye                                                            /
#/                                                                                                    /
# ////////////////////////////////////////////////////////////////////////////////////////////////////

my $filename = "./TPRIEtu2019/Collection/Collection"; #fichier contenant la liste de noms de documents

# Ouverture du fichier Collection
open(LISTFILENAME, $filename)or die "Sorry!! couldn't open";

while ( my $filecacm = <LISTFILENAME>) { #parcours le fichier Collection pour extraire le nom de chaque document de la collection
    chomp($filecacm); 
     
    # ouverture de chaque fichier
    open(FILE, "./TPRIEtu2019/Collection2/${filecacm}.smv")or die "Sorry!! couldn't open";
    
    # creation de fichier par document avec l'extension sans accent ni ponctuation
    open(NEWFILE, '>', "./TPRIEtu2019/Collection3/${filecacm}.sp") or die $!;
    
    while ( my $row = <FILE>) { #parcours de chaque document pour extraire le contenu (les lignes
    	
    	chomp($row); 
    	@words= split / /, $row; # on coupe le contenu mot par mot et on le met dans une liste
    	foreach my  $word(@words) { 
		   if($word !~ /s\b|es\b|ies\b/){	
		   		
    	   		print NEWFILE $word," ";
           }
		}
   		
   }
   close(NEWFILE); # fermeture de fichier
   close (FILE);
}
close(LISTFILENAME)