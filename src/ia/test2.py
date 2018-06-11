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
print("debut")
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




'''
def MinMaxPL(j,e,p):
    v=MaxValue(j,e,p,10000000,-10000000)
    return v.getPlat();

def MaxValue(j,e,p,alpha,beta):
    if p==0 or list(prolog.query("joueurGagnant("+str(e)+","+str(j)+")")):
        #return list(prolog.query("evaluationJoueur("+str(j)+","+str(e)+",X)"))[0]['X'];
        return Resultat(list(prolog.query("evaluationJoueur("+str(j)+","+str(e)+",X)"))[0]['X'],e);
    v=1000
    succ=list(prolog.query("effectuerTousLesDeplacementsJoueur("+str(j)+","+str(e)+",X)"))[0]
    plat=e
    for s in succ['X']:
        tmp=MinValue(j,s,p-1,alpha,beta)
        if(tmp.getVal()<v):
            plat=s
        v=min(v,tmp.getVal())
        if v<=beta:
            return Resultat(list(prolog.query("evaluationJoueur("+str(j)+","+str(s)+",X)"))[0]['X'],s);
        alpha=min(alpha,v)
    return Resultat(v,plat);

def MinValue(j,e,p,alpha,beta):
    aj=changeJoueur(j)
    if p==0 or list(prolog.query("joueurGagnant("+str(e)+","+str(j)+")")):
        #return list(prolog.query("evaluationJoueur("+str(j)+","+str(e)+",X)"))[0]['X'];
        return Resultat(list(prolog.query("evaluationJoueur("+str(j)+","+str(e)+",X)"))[0]['X'],e);
    v=-1000
    succ=list(prolog.query("effectuerTousLesDeplacementsJoueur("+str(aj)+","+str(e)+",X)"))[0]
    plat=e
    for s in succ['X']:
        tmp=MaxValue(j,s,p-1,alpha,beta)
        if(tmp.getVal()>v):
            plat=s
        v=max(v,tmp.getVal())
        if v<=alpha:
            return Resultat(list(prolog.query("evaluationJoueur("+str(j)+","+str(s)+",X)"))[0]['X'],s);
        beta=min(beta,v)
    return Resultat(v,plat);


v=MinMaxPL(1,[1,2,0,0,0,1,0,2,0,0,1,0,0,2,0,0,1,0,0,0,0,0,2,0,0],1)
#print(v)
'''


class Resultat:
    def __init__(self,valo,plato):
        self.val=valo
        self.plat=plato

    def getVal(self):
        return self.val;

    def getPlat(self):
        return self.plat;

class IA:
    def __init__(self,nJoueur):
        self.joueur=nJoueur

    def jouer(self,e,p):
        v=self.MaxValue(e,p,10000000,-10000000)
        return v.getPlat();

    def MaxValue(self,e,p,alpha,beta):
        if p==0 or list(prolog.query("joueurGagnant("+str(e)+","+str(self.joueur)+")")):
            #return list(prolog.query("evaluationJoueur("+str(j)+","+str(e)+",X)"))[0]['X'];
            return Resultat(list(prolog.query("evaluationJoueur("+str(self.joueur)+","+str(e)+",X)"))[0]['X'],e);
        v=1000
        succ=list(prolog.query("effectuerTousLesDeplacementsJoueur("+str(self.joueur)+","+str(e)+",X)"))[0]
        plat=e
        for s in succ['X']:
            tmp=self.MinValue(s,p-1,alpha,beta)
            if(tmp.getVal()<v):
                plat=s
            v=min(v,tmp.getVal())
            if v<=beta:
                return Resultat(list(prolog.query("evaluationJoueur("+str(self.joueur)+","+str(s)+",X)"))[0]['X'],s);
            alpha=min(alpha,v)
        return Resultat(v,plat);

    def MinValue(self,e,p,alpha,beta):
        aj=self.changeJoueur()
        if p==0 or list(prolog.query("joueurGagnant("+str(e)+","+str(self.joueur)+")")):
            #return list(prolog.query("evaluationJoueur("+str(j)+","+str(e)+",X)"))[0]['X'];
            return Resultat(list(prolog.query("evaluationJoueur("+str(self.joueur)+","+str(e)+",X)"))[0]['X'],e);
        v=-1000
        succ=list(prolog.query("effectuerTousLesDeplacementsJoueur("+str(aj)+","+str(e)+",X)"))[0]
        plat=e
        for s in succ['X']:
            tmp=self.MaxValue(s,p-1,alpha,beta)
            if(tmp.getVal()>v):
                plat=s
            v=max(v,tmp.getVal())
            if v<=alpha:
                return Resultat(list(prolog.query("evaluationJoueur("+str(self.joueur)+","+str(s)+",X)"))[0]['X'],s);
            beta=min(beta,v)
        return Resultat(v,plat);

    def changeJoueur(self):
        aj=0
        if self.joueur==1:
            aj=2
        elif self.joueur==2:
            aj=1
        return aj;

ia=IA(1)
p=ia.jouer([1,2,0,0,0,1,0,2,0,0,1,0,0,2,0,0,0,0,0,1,0,0,2,0,0],4)
print(list(prolog.query("afficher("+str(p)+")")))
'''
[1,2,0,0,0,
 1,0,2,0,0,
 1,0,0,2,0,
 0,0,0,0,1,
 0,0,2,0,0]


ia1=IA(1)
ia2=IA(2)
while(True):
    p1=ia1.jouer([1,2,0,0,0,1,0,2,0,0,1,0,0,2,0,0,0,0,0,1,0,0,2,0,0],4)
    print(list(prolog.query("afficher("+str(p1)+")")))
    p2=ia2.jouer(p1,4)
    print(list(prolog.query("afficher("+str(p2)+")")))

'''
