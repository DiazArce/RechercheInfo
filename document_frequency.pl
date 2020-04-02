#!/usr/bin/perl

# ////////////////////////////////////////////////////////////////////////////////////////////////////
#/																									  /
#/ EXERCICE : 1.2 Calcul de valeurs classiques - Partie 3                                             /
#/                                                                                                    /
#/ DESCRIPTION :le script permet creer un fichier sauvegardant le df(document frequency)              /
#/              pour chaque document. il recoit en entree la collection2 contenant les 
#/              fichiers sans mots vide et retourne un fichier nomme file.document-frequency
#/				 sous la forme #mot #df (un mot par ligne)
#/   																								  /
#/ AUTEURS :   DIAZ Daniel et SAIDI Alhaye                                                            /
#/                                                                                                    /
# /////////
print " begin program occurrence des mots....  " , " \n";

my $filename = "./TPRIEtu2019/Collection/Collection"; #fichier contenant la liste de noms de documents
# Ouverture du fichier Collection
open(LISTFILENAME, $filename)or die "Sorry!! couldn't open"; 

while ( my $filecacm = <LISTFILENAME>) { #parcours le fichier Collection pour extraire le nom de chaque document de la collection
    chomp($filecacm); 
    
    # ouverture de chaque fichier CACM-XX.sanp
    open(FILE, "./TPRIEtu2019/Collection3/${filecacm}.sp")or die "Sorry!! couldn't open";
    #open(FILE, "${filecacm}.sans-accent-ni-ponctuation")or die "Sorry!! couldn't open";
    	
	
	my $content_file = <FILE>; # on passe le contenu du document a une varible $content_file
	my @words = split / /, $content_file;  # le tableau contient le text du document mot par mot
	@words = grep{"$_"} @words;  # enlever les chaines vides du tableau
	my %hash = map {$_ => 1 } @words; # on passe le contenu du tableau a un hash pour enlever les mots doublons

	my @words_unique = keys %hash;             # tableau unique qui contient le text de documents sans doublons
	foreach my  $word(@words_unique) { 
	
		$df{$word}=$df{$word}+1;
		
	    }		
	
	close FILE;
 }

# Creation d'un nouveau fichier pour stocker le nombre d'occurrences de chaque mot

open(NEWFILE, '>', "./TPRIEtu2019/Output/file.document-frequency-sans-pluriel") or die $!;

# L'entete du nouveau fichier sera sous la forme suivante: #mot , #df

foreach $word ( sort keys %df){
   # on enregistre sur le nouveau fichier trier par ordre alphanumerique
	print NEWFILE $word, " ", $df{$word}, "\n"; 
}  
 
close NEWFILE;  
print " end program"	, "\n";

close LISTFILENAME;