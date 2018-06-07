from pyswip import *

prolog=Prolog()
prolog.consult("minmax.pl")
#l=list(prolog.query("member(X,[1,2,3])"))
#print(l[1])



#print(prolog.query("effectuerUnDeplacement([1,1,1,0,2,1,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0],1,4,X)"))

#print(list(prolog.query("evaluationJoueur(2,[1,1,1,0,2,1,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0],X)")))
#print(list(prolog.query("deplacementsPossibles(1,[1,1,1,0,2,1,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0],X)")))
#print(prolog.query("effectuerTousLesDeplacementsJoueur(1,[1,1,1,0,2,1,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0],X)"))
#print(list(prolog.query("mesCases(1,[1,1,1,0,2,1,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0],L)")))

#soln=prolog.query("effectuerTousLesDeplacementsJoueur(1,[1,1,1,0,2,1,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0],X)")
#a=prolog.query("effectuerUnDeplacement([1,1,1,0,2,1,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0],1,4,X)")

#for i in a:
#    print(i)

a=prolog.query("meilleurMouvement(1,[1,1,1,0,2,1,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0],X).")
a=list(a)[0]#c0 car nous retourne un tableau de 1 case
a=a['X']#indice pour chercher la valeur
print(a)#la valeur
