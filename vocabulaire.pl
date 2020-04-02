#!/usr/bin/perl

# ////////////////////////////////////////////////////////////////////////////////////////////////////
#/																									  /
#/ EXERCICE : 1.2 Calcul de valeurs classiques - Partie 2                                             /
#/                                                                                                    /
#/ DESCRIPTION :le script permet creer un fichier contenant le vocabulaire de la collection           /
#/              il recoit en entree la collection1  contenant les fichiers sans accent ni             /
#/             ponctuation et donne en sortie un fichier contenant le vocabulaire de la collection    /
#/             egalement il peut recevoir la collection3 contenant les fichiers sans mots vide        /
#/             et retourner le vocabulaire de la collection3 sans mot vide.                           /
#/   																								  /
#/ AUTEURS :   DIAZ Daniel et SAIDI Alhaye                                                            /
#/                                                                                                    /
# ////////////////////////////////////////////////////////////////////////////////////////////////////


print " begin program vocabulaire des mots....  " , " \n";
my $filename = "./TPRIEtu2019/Collection/Collection"; #fichier contenant la liste de noms de fichier
open(LISTFILENAME, $filename)or die "Sorry!! couldn't open"; #ouverture du fichier collection
my $filecacm;

while ( $filecacm = <LISTFILENAME>) { #boucle pour parcourir le fichier Collection et extraire le nom de cahque document de la collection
    chomp($filecacm); 
    
    # ouverture de chaque fichier
    open(FILE, "./TPRIEtu2019/Collection3/${filecacm}.sp")or die "Sorry!! couldn't open";
    
    while (my $row = <FILE>) {  #parcours de chaque document pour extraire le contenu (les lignes
    	
    	chomp($row);
    	@words = split / /,$row;  #on coupe le contenu mot par mot et on le met dans une liste
    	@words = grep{"$_"} @words;
    }	
    foreach my  $word(@words) {
    	
		$count{$word}++;# on va compter le nombre d'apparitions du chaque mot dans la liste
	} 
    close FILE; 
 }
# Creation d'un nouveau fichier pour stocker le vocabulaire de la collection

open(NEWFILE, '>', "./TPRIEtu2019/Output/file.vocabulaire-sans-pluriel2") or die $!;

#my @key = sort { $count$a} <=> $count->{$b}} keys (%count);

foreach $word (  sort keys %count){
#foreach $word(@key){
   #ecriture sur le fichier un mot par ligne , en ordre croissant de rangs
    
	print NEWFILE  $word, "\n"; 
}  
close NEWFILE;  
print " end program"	, "\n";

close LISTFILENAME;