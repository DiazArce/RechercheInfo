#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
@Created on Fri Dec 27 18:22:15 2019

@Description: 
              ce programme recoit en entree un fichier contenant l'occurrence
              des mots dans les documents-sans mots vide sous la forme:
              #rang,#mot,#frequence. ce script permet representer le graphique
              representant la loi de zipf. L'abscisse correspond au rang du mot
              et l'ordonne a la frequence du mot.
              
@author: DIAZ ARCE Daniel
"""

import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


#ouverture du fichier 
data=pd.read_csv('./TPRIEtu2019/Output/file.nb_occurrence_sans_pluriel',sep=' ')

#contenu du fichier dans un dataframe
content_file=pd.DataFrame(data)

print("\tContenu du fichier 'nb-occurrence-sans-pluriel'\n\n\n",content_file); # affichage dufichier 

X=content_file.values # on recupere les valeurs des colonnes
X=np.array(X) # on transforme ses valeurs a un array
rang=X[:,0] # on recupere du array la colonne 0 correspondant au rang du mot
fn=X[:,2] # on recupere du array la colonne 2 correspondant a la frequence du mot

X=np.array(list(zip(rang,fn))).reshape(len(rang),2) #on reshape les valeurs

plt.figure(figsize=(12,8)) # on va redimensionner la taille de la fenetre d'affichage
plt.title('Loi de zipf sur la collection sans pluriel') # on met un tittle
plt.plot(rang,fn,'r.') # on met la couleur rouge a la courbe

plt.xlabel('rang du mot')  # on va nomme l'axe d'abscisse 
plt.ylabel('frequence des mots')  # on va nommer l-axe de l'ordonnee

plt.show()  # on va ploter le graphe