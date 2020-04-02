#!/usr/bin/perl

# ////////////////////////////////////////////////////////////////////////////////////////////////////
#/																									  /
#/ EXERCICE : 1.1.2 analyse de la collection - Partie 1                                               /
#/                                                                                                    /
#/ DESCRIPTION :le script permet compter le nombre d'occurrences de chaque mot dans la collection     /
#/             dans les documents. il recoit en entree le fichier contenant la liste de noms de       /
#/             de tous les fichiers ainsi que le dossier Collection1 qui contient tous les documents  /
#/             et donne en sortie un fichier contenant les information sous la forme: Rang du mots    /
#/             compte du mot et Mot trie par ordre croissant des rangs                                /
#/   																								  /
#/ AUTEURS :   DIAZ Daniel et SAIDI Alhaye                                                            /
#/                                                                                                    /
# ////////////////////////////////////////////////////////////////////////////////////////////////////


print " begin program occurrence des mots....  " , " \n";
my $filename = "./TPRIEtu2019/Collection/Collection"; #fichier contenant la liste de noms de documents
# Ouverture du fichier Collection
open(LISTFILENAME, $filename)or die "Sorry!! couldn't open"; 


while ( my $filecacm = <LISTFILENAME>) { #parcours le fichier Collection pour extraire le nom de chaque document de la collection
    chomp($filecacm); 
    
    # ouverture de chaque fichier
    open(FILE, "./TPRIEtu2019/Collection3/${filecacm}.sp")or die "Sorry!! couldn't open";
    my $row;
    while ( $row = <FILE>) {  #parcours de chaque document pour extraire le contenu (les lignes)
    	
    	chomp($row);
    	@words= split / /, $row; # on coupe le contenu mot par mot et on le met dans une liste
    	@words = grep{"$_"} @words;  # enlever les chaines vides du tableau si il exise
    	foreach my  $word(@words) { 
			$count{$word}++; # on va compter le nombre d'apparitions du chaque mot dans la liste
			}  
    }	
    
 }
close FILE;
# Creation d'un nouveau fichier pour stocker le nombre d'occurrences de chaque mot
open(NEWFILE, '>', "./TPRIEtu2019/Output/file.nb_occurrence_sans_pluriel") or die "Sorry!! couldn't open";

# L'entete du fichier sera sous la forme suivante:
print NEWFILE  "rang", " ", "mot", " ", "frequence", "\n"; 

my $i=1;
# on va trier par ordre croissant des rangs
foreach $word ( reverse sort { $count{$a} <=> $count{$b} } keys %count){
   # on enregistre sur le fichier
	print NEWFILE  $i++, " ", $word, " ", $count{$word}, "\n"; 
}  
close NEWFILE;  
print " end program"	, "\n";

close LISTFILENAME;