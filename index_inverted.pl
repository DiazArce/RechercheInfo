#!/usr/bin/perl

# ////////////////////////////////////////////////////////////////////////////////////////////////////
#/																									  /
#/ EXERCICE : 1.1.2 analyse de la collection - Partie 5                                              /
#/                                                                                                    /
#/ DESCRIPTION :le script permet avoir un access rapide au document a travers l'index inversee       /
#/             il recoit en entre le fichier du vocabulaire sans les mots vides ainsi que le fichier /
#/             Collection et il donne en sortie un fichier contenant la representation des document   /
#/             sous la forme: id_mot1->  id_docx:tf - id_docy:tf ... la premier ligne correspond a l'id /
#/   		   du mot en suivant l'ordre du fichier vocabulaire.																		  /
#/ AUTEURS :   DIAZ Daniel et SAIDI Alhaye                                                            /
#/                                                                                                    /
# ////////////////////////////////////////////////////////////////////////////////////////////////////

print " begin program ....  " , " \n";

my $wordsList = "./TPRIEtu2019/Output/file.vocabulaire-sans-mots-vides";
open(LISTE, $wordsList)or die "Sorry!! couldn't open";
my $i=0;
while(my $mot = <LISTE>){
	chomp($mot);
	$i++;
	$vocabulaire{$mot} = $i;	
}
close(LISTE);

my $filename = "./TPRIEtu2019/Collection/Collection"; #fichier contenant la liste de noms de documents
# Ouverture du fichier Collection
open(LISTFILENAME, $filename)or die "Sorry!! couldn't open"; 
my $idDoc=0;
while ( my $filecacm = <LISTFILENAME>) { #parcours le fichier Collection pour extraire le nom de chaque document de la collection
    chomp($filecacm); 
    
    # ouverture de chaque fichier CACM-XX.sanp
    
    open(FILE, "./TPRIEtu2019/Collection2/${filecacm}.smv")or die "Sorry!! couldn't open";
    $idDoc++;
	my $content_file = <FILE>; # on passe le contenu du document a une varible $content_file
	my @words= split / /, $content_file;  # le tableau contient le text du document mot par mot
	
	foreach my $word(@words){
		$count{$word}++;	
	}
	my %hash = map {$_ => 1 } @words; # on passe le contenu du tableau a un hash pour enlever les mots doublons

	my @words_unique = keys %hash;             # tableau unique qui contient le text de documents sans doublons
	foreach my  $mot(@words_unique) { 
		
		if (exists  $inverted_index{$mot}){
			my $idDoc_tf = join(":",$idDoc,$count{$mot});
		    push @{ $inverted_index{$mot} }, $idDoc_tf;
		}
		else{
			@docs= @{ $inverted_index{$mot}};
			my $idDoc_tf = join(":",$idDoc,$count{$mot});
			push @{ $inverted_index{$mot} }, $idDoc_tf;
		}
	}
	%count = ();
	%hash = ();

	close (FILE);
 }

# Creation d'un nouveau fichier pour stocker le nombre d'occurrences de chaque mot
# on parcours le hash count pour trier par ordre croissant des rangs
open(NEWFILE, '>', "./TPRIEtu2019/Output/file.index-inverted-sans-mots-vides") or die $!; 
foreach $word ( sort { $vocabulaire{$a} <=> $vocabulaire{$b} } keys %vocabulaire){
   # on enregistre sur le nouveau fichier 
	print NEWFILE $vocabulaire{$word}, " ", join("-", @{ $inverted_index{$word} }) ,"\n"; 
} 	
close(NEWFILE);
print " end program", "\n";

close LISTFILENAME;