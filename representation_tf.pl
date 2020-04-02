#!/usr/bin/perl

# ////////////////////////////////////////////////////////////////////////////////////////////////////
#/																									  /
#/ EXERCICE : 1.1.2 analyse de la collection - Partie 4.2                                             /
#/                                                                                                    /
#/ DESCRIPTION :le script permet avoir une version amelioree pour une representation des documents    /
#/       	   avec les frequence des termes.                                                         /
#/             il recoit en entree le fichier du vocabulaire sans les mots vides ainsi que le fichier /
#/             Collection et il donne en sortie un fichier contenant la representation des document   /
#/             sous la forme: id_mot1:tf1 id_mot2:tf2 id_mot3:tf3 ..........                                /
#/   																								  /
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
open(NEWFILE, '>', "./TPRIEtu2019/Output/file.representation-tf-sans-pluriel") or die $!; 
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
      #ce fichier est trier par ordre croissant de numero de document selon la liste de noms du fichier Collection, la ligne 1 correspond donc au document CACM-1,...
      #fichier sous la forme pour chaque ligne representant un document->l'ensemble de id_mot:tf (frequence brute du mot)/nb total des mots par document
	  #print NEWFILE $vocabulaire{$word}, ":", $tf=sprintf("%.2f", $count{$word}/@words), " "; 
	  #fichier sous la forme pour chaque ligne representant un document->l'ensemble de id_mot:tf (frequence brute du mot)
   	  print NEWFILE $vocabulaire{$word}, ":",$count{$word}, " ";
   }
    %count = ();
    print NEWFILE "\n";
	close(FILE)
}
  
print " end program", "\n";
close(LISTFILENAME);
