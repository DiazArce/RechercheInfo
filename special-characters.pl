#!/usr/bin/perl

# ////////////////////////////////////////////////////////////////////////////////////////////////////
#/																									  /
#/ EXERCICE : 1.1.1 Preparation de fichier - Partie 2                                               /
#/                                                                                                    /
#/ DESCRIPTION :le script permet enlever les caracteres speciaux et accents dans les documents de la  /
#/             collection. il recoit en entree le fichier contenant la liste de noms de tous les      /
#/             documents de la collection ainsi que le dossier Collection qui contient tous les       /
#/             documents et donne en sortie un fichier par document ne contenant pas de caracteres    /
#/             speciaux ni d'accents et tout le contenu est en minuscule.                             /
#/   																								  /
#/ AUTEURS :   DIAZ Daniel et SAIDI Alhaye                                                            /
#/                                                                                                    /
# ////////////////////////////////////////////////////////////////////////////////////////////////////



my $filename = "./TPRIEtu2019/Collection/Collection"; #fichier contenant la liste de noms de documents

# Ouverture du fichier Collection
open(LISTFILENAME, $filename)or die "Sorry!! couldn't open";

while ( my $filecacm = <LISTFILENAME>) { #parcours le fichier Collection pour extraire le nom de chaque document de la collection
    chomp($filecacm); 
     
    # ouverture de chaque fichier
    open(FILE, "./TPRIEtu2019/Collection/${filecacm}")or die "Sorry!! couldn't open";
    
    # creation de fichier par document avec l'extension sans accent ni ponctuation
    open(NEWFILE, '>', "./TPRIEtu2019/Collection1/${filecacm}.sanp") or die $!;
    
    while ( my $row = <FILE>) { #parcours de chaque document pour extraire le contenu (les lignes
    	
    	chomp($row); 
    	$row =~ s/[^a-zA-Z0-9 ]/ /g; # supression de tous les caracteres speciaux
    	$row=~ s/\s+/ /g; # pour remplacer les espaces doubles qui ont ete generee par un espace
    	$row =~ tr/A-Z/a-z/;		# on remplace les mot mayuscules a minuscules
    	
		# ecriture du contenu dans le fichier 
    	print NEWFILE $row;
   		
   }
   close(NEWFILE); # fermeture de fichier
   close (FILE);
} 
close LISTFILENAME;
