#!/usr/bin/perl

# ////////////////////////////////////////////////////////////////////////////////////////////////////
#/																									  /
#/ EXERCICE : 1.2 Calcul de valeurs classiques - Partie 1                                             /
#/                                                                                                    /
#/ DESCRIPTION :le script permet creer un fichier par document en filtrant les mots vides             /
#/              il recoit en entree la collection1  contenant les fichiers sans accent                /
#/             ni ponctuation et donne en sortie un fichier par document ne contenant pas             /
#/             les mots vide                                                                          /
#/                                                                                                    /
#/   																								  /
#/ AUTEURS :   DIAZ Daniel et SAIDI Alhaye                                                            /
#/                                                                                                    /
# ////////////////////////////////////////////////////////////////////////////////////////////////////


print " begin program fichier sans mot vide....  " , " \n";

my $filename = "./TPRIEtu2019/Collection/Collection"; #fichier contenant la liste de noms de documents

#ouverture du fichier collection
open(LISTFILENAME, $filename)or die "Sorry!! couldn't open"; 

# bibliotheque pour l'obtention de mots vides en anglais
#use Lingua::StopWords qw( getStopWords );
#my $stopwords = getStopWords('en');
my %stopwords;
open(STOPWORDS, "./TPRIEtu2019/cacm/common_words")or die "Sorry!! couldn't open";
while (my $words=<STOPWORDS>){
	
	chomp($words);
	$stopwords{$words}=1;
	
}
close STOPWORDS;
while ( my $filecacm = <LISTFILENAME>) { #parcours le fichier Collection pour extraire le nom de chaque document de la collection
    chomp($filecacm); 
    
    # ouverture de chaque fichier
	open(FILE, "./TPRIEtu2019/Collection1/${filecacm}.sanp")or die "Sorry!! couldn't open";
	
	# creation de fichier par document avec l'extension sans mot vide
	open(NEWFILE, '>', "./TPRIEtu2019/Collection2/${filecacm}.smv") or die $!;
	
	while ( $row = <FILE>) { #parcours de chaque document pour extraire le contenu (les lignes
	    	
	    	chomp($row);
	    	@words= split / /, $row;  #on coupe le contenu mot par mot et on le met dans une liste
	    	print NEWFILE join ' ', grep { !$stopwords{$_} } @words; #on sauvegarde les mots du tableau
	    															 #@words qui sont differents aux mots du hash stopwords
	}
	
	
    close(FILE);
	close(NEWFILE); # fermeture du fichier
} 	
print " end program. "	, "\n";

close(LISTFILENAME);