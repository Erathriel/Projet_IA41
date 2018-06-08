# from pyswip import Prolog

# prolog=Prolog()
# prolog.consult("minmax.pl")
# #l=list(prolog.query("member(X,[1,2,3])"))
# #print(l[1])



# print("avant")
# print(prolog.query("effectuerUnDeplacement([1,1,1,0,2,1,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0],1,4,X)"))

# #print(list(prolog.query("evaluationJoueur(2,[1,1,1,0,2,1,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0],X)")))
# #print(list(prolog.query("deplacementsPossibles(1,[1,1,1,0,2,1,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0],X)")))
# #print(prolog.query("effectuerTousLesDeplacementsJoueur(1,[1,1,1,0,2,1,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0],X)"))
# #print(list(prolog.query("mesCases(1,[1,1,1,0,2,1,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0],L)")))





# print("apres")

from sys import exit
from dico import *
import pygame
from pygame.locals import *
 
TAILLE_BLOC = 20
NB_BLOC_MAX = 30
DIMENSION_ECRAN = TAILLE_BLOC * NB_BLOC_MAX
 
 
def dire_bonjour():
    print("\n\nJe suis la fonction dire bonjour, donc bonjour")
#-------------------------------------------------------------------------------
#Initialisation de pygame
#-------------------------------------------------------------------------------
pygame.init()
pygame.font.init()
ecran = pygame.display.set_mode((DIMENSION_ECRAN, DIMENSION_ECRAN))
pygame.display.set_caption("Un petit menu avec Pygame !")
#-------------------------------------------------------------------------------
#Variables
#-------------------------------------------------------------------------------
var_1, var_2, var_3, var_4 = "Menu", "Pause", "Quitter", "Autre"
#-------------------------------------------------------------------------------
#Importation et gestion des classes <Conteneur> <Contenu>
#-------------------------------------------------------------------------------
conteneur_1 = Conteneur(5) #On creer un menu avec 5 cellules au maximum
conteneur_1.ajouter_contenu(var_1)
conteneur_1.ajouter_contenu(var_2)
conteneur_1.ajouter_contenu(var_3)
conteneur_1.ajouter_contenu(var_4)
conteneur_1.supprimer_contenu(var_4)
#
conteneur_1[var_1].set_nom_methode_a_executer(dire_bonjour)
conteneur_1[var_1].set_couleur((0,0,255))
#On boucle chaque contenu pour draw le rect respectif en couleur + contour
conteneur_1.dessiner(ecran, DIMENSION_ECRAN//2, DIMENSION_ECRAN//2) 
pygame.display.flip() 
#-------------------------------------------------------------------------------
#Boucle principale
#-------------------------------------------------------------------------------
continuer = True
while continuer:
    event            = pygame.event.wait()
    mouse_x, mouse_y = pygame.mouse.get_pos()
    if event.type == pygame.QUIT:
        continuer = False
        break
#-------------------------------------------------------------------------------
#Suite de la boucle
#-------------------------------------------------------------------------------
    #La methode evenement_souris(mouse_x, mouse_y, event) permet de savoir
    #si chaque le pointeur de notre souris est ou clique sur une cellule.
    for i in conteneur_1.values(): #On donne l'evenement a nos contenus
        i.evenement_souris(mouse_x, mouse_y, event)
#-------------------------------------------------------------------------------
#On redessine l'ecran
#-------------------------------------------------------------------------------
    ecran.fill(0)
    conteneur_1.dessiner(ecran, DIMENSION_ECRAN//2, DIMENSION_ECRAN//2)
    pygame.display.flip()
#-------------------------------------------------------------------------------
#Que faire si l'on sort de la boucle
#-------------------------------------------------------------------------------
print("\nAu revoir, vous quittez le programme...")
pygame.quit()
exit(0)
