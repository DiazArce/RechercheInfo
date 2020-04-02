#!/usr/bin/perl

# ////////////////////////////////////////////////////////////////////////////////////////////////////
#/																									  /
#/ EXERCICE : 1.1.2 analyse de la collection - Partie 4.3                                             /
#/                                                                                                    /
#/ DESCRIPTION :le script permet avoir une 3eme version  pour une representation des documents        /
#/       	   sur tf.idf , avec tf comme la frequence de termes et idf comme l'inverse de df         /
#/             il recoit en entree le fichier du vocabulaire sans les mots vides ainsi que le fichier /
#/             Collection et il donne en sortie un fichier contenant la representation des document   /
#/             sous la forme: id_mot1:tf1*idf1 id_mot2:tf2*idf2 id_mot3:tf3*idf3 ..........                          /
#/   																								  /
#/ AUTEURS :   DIAZ Daniel et SAIDI Alhaye                                                            /
#/                                                                                                    /
# ////////////////////////////////////////////////////////////////////////////////////////////////////


print " begin program ....  " , " \n";

open(FILEDF, "./TPRIEtu2019/Output/file.document-frequency-sans-pluriel") or die "Sorry!! couldn't open";
$i=0;
while (my $line = <FILEDF>) {
	chomp($line);
	$i++;
	my ($word, $freq) = split / /, $line	;
	$df{$word} = $freq;
	$vocabulaire{$word} = $i;
}

close(FILEDF);

my $filename = "./TPRIEtu2019/Collection/Collection"; #fichier contenant la liste de noms de documents
# Ouverture du fichier Collection
open(LISTFILENAME, $filename)or die "Sorry!! couldn't open";
open(NEWFILE, '>', "./TPRIEtu2019/Output/file.representation-tf-idf-sans-pluriel") or die "Sorry!! couldn't open"; 
while ( my $filecacm = <LISTFILENAME>) { #parcours le fichier Collection pour extraire le nom de chaque document de la collection
    chomp($filecacm); 
    open(FILE, "./TPRIEtu2019/Collection3/${filecacm}.sp")or die "Sorry!! couldn't open";
    while ( $row = <FILE>) {
    	
    	chomp($row);
    	@words= split / /, $row;
    	@words = grep{"$_"} @words;
    	
    }	
    foreach my  $word(@words) {
			$count{$word}++;
    }	
    foreach $word ( reverse sort { $count{$a} <=> $count{$b} } keys %count){
      print NEWFILE $vocabulaire{$word}, ":", $count{$word}*log(3204/$df{$word}), " ";
   }
    %count = ();
    print NEWFILE "\n";
	close(FILE)
}
  
print " end program", "\n";
close(LISTFILENAME);
####
