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
'''
a=prolog.query("effectuerTousLesDeplacementsJoueur(1,[1,1,1,0,2,1,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0],X)")
a=list(a)[0]#c0 car nous retourne un tableau de 1 case
a=a['X']#indice pour chercher la valeur
for i in a:
    print(i)
if list(prolog.query("joueurGagnant([1,1,1,1,2,0,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0],1)")):
    print("ok")
'''
print('devb')
'''
a=list(prolog.query("effectuerTousLesDeplacementsJoueur(1,[1,1,1,0,2,1,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0],X)"))[0]['X']
for i in a:
    print i'''


def changeJoueur(j):
    aj=0
    if j==1:
        aj=2
    elif j==2:
        aj=1
    return aj;

class Resultat:
    def __init__(self,valo,plato):
        self.val=valo
        self.plat=plato

    def getVal(self):
        return self.val;

    def getPlat(self):
        return self.plat;



def MinMaxPL(j,e,p):
    v=MaxValue(j,e,p)
    return v.getPlat();

def MaxValue(j,e,p):
    if p==0 or list(prolog.query("joueurGagnant("+str(e)+","+str(j)+")")):
        return list(prolog.query("evaluationJoueur("+str(j)+","+str(e)+",X)"))[0]['X']
    v=1000
    succ=list(prolog.query("effectuerTousLesDeplacementsJoueur("+str(j)+","+str(e)+",X)"))[0]
    plat=e
    for s in succ['X']:
        tmp=MinValue(j,s,p-1)
        if(tmp<v):
            plat=s
        v=min(v,tmp)
    return Resultat(v,plat);

def MinValue(j,e,p):

    if p==0 or list(prolog.query("joueurGagnant("+str(e)+","+str(j)+")")):
        return list(prolog.query("evaluationJoueur("+str(j)+","+str(e)+",X)"))[0]['X']
    v=-1000
    succ=list(prolog.query("effectuerTousLesDeplacementsJoueur("+str(j)+","+str(e)+",X)"))[0]
    plat=e
    for s in succ['X']:
        tmp=MaxValue(j,s,p-1)
        if(tmp>v):
            plat=s
        v=max(v,tmp)
    return Resultat(v,plat);


v=MinMaxPL(1,[1,1,1,0,2,0,0,2,0,0,2,0,0,2,0,0,0,0,0,0,0,0,0,1,0],3)
print(v)
