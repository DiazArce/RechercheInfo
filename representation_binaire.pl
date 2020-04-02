#!/usr/bin/perl

# ////////////////////////////////////////////////////////////////////////////////////////////////////
#/																									  /
#/ EXERCICE : 1.1.2 analyse de la collection - Partie 4.1                                             /
#/                                                                                                    /
#/ DESCRIPTION :le script permet avoir une representation compacte des documents de la Collection     /
#/       	                                                                                          /
#/             il recoit en entree le fichier du vocabulaire sans les mots vides ainsi que le fichier /
#/             Collection et il donne en sortie un fichier contenant la representation des document   /
#/             sous la forme: id_mot1:1 id_mot2:1 id_mot3:1 ... la valeur 1 indique que le mot        /
#/   		   est dans le document.																						  /
#/ AUTEURS :   DIAZ Daniel et SAIDI Alhaye                                                            /
#/                                                                                                    /
# ////////////////////////////////////////////////////////////////////////////////////////////////////


print " begin program ....  " , " \n";

my $wordsList = "./TPRIEtu2019/Output/file.vocabulaire-sans-pluriel";
open(LISTE, $wordsList)or die "Sorry!! couldn't open";
$i=0;
while(my $mot = <LISTE>){
	chomp($mot);
	$i++;
	$vocabulaire{$mot} = $i;	
}

close(LISTE);

my $filename = "./TPRIEtu2019/Collection/Collection"; #fichier contenant la liste de noms de documents
# Ouverture du fichier Collection
open(LISTFILENAME, $filename)or die "Sorry!! couldn't open";
open(NEWFILE, '>', "./TPRIEtu2019/Output/file.representation-binaire-sans-pluriel") or die $!; 
while ( my $filecacm = <LISTFILENAME>) { #parcours le fichier Collection pour extraire le nom de chaque document de la collection
    chomp($filecacm); 
    open(FILE, "./TPRIEtu2019/Collection3/${filecacm}.sp")or die "Sorry!! couldn't open";
    my $row = <FILE>;
    	
	my @content = split / /, $row;  # le tableau contient le text du document mot par mot
	my %hash = map {$_ => 1 } @content; # on passe le contenu du tableau a un hash pour enlever les mots doublons
	my @words_unique = keys %hash; 

	foreach $word (@words_unique)
	{
		
		print NEWFILE $vocabulaire{$word}, ":", "1"," ";
	}
	print NEWFILE "\n"; 
	close(FILE)
}
  
print " end program", "\n";
close(LISTFILENAME);
