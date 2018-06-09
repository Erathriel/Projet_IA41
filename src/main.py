import pygame
import random
import sys
import easygui
from pyswip import Prolog
from pygame.locals import *

menu_data = (
    'Main',
    'Item 0',
    'Item 1',
    (
        'Things',
        'Item 0',
        'Item 1',
        'Item 2',
        (
            'More Things',
            'Item 0',
            'Item 1',
        ),
    ),
    'Quit',
)

class Board:

	def __init__(self):
		pygame.init()
		self.fenetre = pygame.display.set_mode((569, 600))
		self.fond = pygame.image.load("../img/teeko_board.jpg").convert()
		self.jeton = [pygame.image.load("../img/jeton1.png").convert_alpha(), pygame.image.load("../img/jeton2.png").convert_alpha()]
		self.select = pygame.image.load("../img/select.png").convert()
		self.plateau = [0]*25
		#self.plateau = [1,1,0,1,2,0,0,0,2,0,0,0,0,0,0,0,2,2,0,0,0,0,0,0,0]

	def menu(self):
		#Variables
		v1, v2, v3, v4 = "Menu", "Pause", "Quitter", "Autre"

		#Conteneur
		conteneur_1 = Conteneur(5) #On creer un menu avec 5 cellules au maximum
		conteneur_1.ajouter_contenu(v1)
		conteneur_1.ajouter_contenu(v2)
		conteneur_1.ajouter_contenu(v3)
		conteneur_1.ajouter_contenu(v4)
		conteneur_1.supprimer_contenu(v4)
		conteneur_1.dessiner(ecran, DIMENSION_ECRAN//2, DIMENSION_ECRAN//2)
		pygame.display.flip()

	def display(self):
		self.displayBackground()
		self.displayCases()
		pygame.display.flip()

	def displayBackground(self):
		self.fenetre.blit(self.fond, (0,0))

	def displayCases(self):
		for i in range(0, 25):
			if self.plateau[i] != 0:
				self.fenetre.blit(self.jeton[self.plateau[i]-1], self.getCasePos(i))

	def displayCase(self, index, _id, select):
		self.displaySelect(select)
		self.fenetre.blit(self.jeton[_id-1], self.getCasePos(index))
		pygame.display.flip()

	def displaySelect(self, index):
		if(index == None):
			return
		self.displayBackground()
		self.displayCases()
		self.fenetre.blit(self.select, self.getCasePos(index))
		self.fenetre.blit(self.jeton[self.plateau[index]-1], self.getCasePos(index))
		pygame.display.flip()

	def checkWin(self, joueur):
		if(self.plateau.count(0) < 18):
			prolog=Prolog()
			prolog.consult("ia/minmax.pl")
			if list(prolog.query("joueurGagnant(" +  str(self.plateau) + ","+str(joueur._id)+")")):
				return True
		return False

	def isMovePossible(self, index, indexPion):
		if(index < 0 or self.plateau[index] != 0):
			return False
		# verifier si tous les pions ont ete pose
		elif self.plateau.count(0) > 17:
			return True
		# si tout les pions ont ete place alors un pion doit etre selectionne pour savoir lequel bouger
		elif indexPion == None:
			return False
		# sinon verifier que la distance soit egale a 1 ET que la case soit vide
		elif abs(indexPion-index) == 1 or (abs(indexPion - index) >= 4 and abs(indexPion-index) <= 6) :
				return True
		else:
			return False

	def getCase(self, x, y):
		if( (x > 90 and x < 150) or (x > 150 and (x-150)%84 > 24)) and ( (y > 90 and y < 150) or (y > 150 and(y-150)%84 > 24)) and ( y < 483 and x < 483) :
			i = 0 if y < 150 else (int(y / 84)-1)*5
			i += 0 if x < 150 else (int(x / 84)-1)
			return i
		else:
			return -1

	def getCasePos(self, index):
		x = 90 if index%5 == 0 else ((index%5)-1)*83+174
		y = 90 if int(index/5) == 0 else (int(index/5)-1)*80.5+174
		return (x, y)

	def playMove(self, joueur, case, casePrev):
		if(self.isMovePossible(case, casePrev)):
			if casePrev:
				self.plateau[casePrev] = 0
			else:
				joueur.nb_pion_pose+=1
			self.plateau[case] = joueur._id
			self.display()
			return True
		return False

class Joueur:

	def __init__(self, _id, is_real, board):
		self._id = _id
		self.is_real = is_real
		self.nb_pion_pose = 0
		self.board = board

	def play(self, board):
		if not self.is_real:
			if self.nb_pion_pose < 4:
				rand = random.randint(0 ,24)
				while self.board.playMove(self, rand, None) != True:
					rand = random.randint(0 ,24)
			else:
				prolog=Prolog()
				prolog.consult("ia/minmax.pl")
				self.board.plateau = list(next(prolog.query("meilleurMouvement("+str(self._id)+","+str(self.board.plateau)+",X)"))["X"])
				self.board.display()

##################### IA ###################
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
############################################

def main():
	board = Board()
	board.display()

	joueurs = [Joueur(1, True, board), Joueur(2, False, board)]
	swap = 1
	select = None

	while 1:

		if(joueurs[swap].is_real == False):
			joueurs[swap].play(board)
			if board.checkWin(joueurs[swap]) != 0:
				print("Le joueur "+str(joueurs[swap]._id)+" a gagne")
			swap = abs(swap - 1)
			select = None
		for event in pygame.event.get():
			if event.type == QUIT:
				exit()
			if event.type == pygame.MOUSEBUTTONUP and joueurs[swap].is_real :
				case = board.getCase(pygame.mouse.get_pos()[0], pygame.mouse.get_pos()[1])
				if board.playMove(joueurs[swap], case, select):
					if board.checkWin(joueurs[swap]) != 0:
						s="Le joueur "+str(joueurs[swap]._id)+" a gagne"
						easygui.msgbox(s, title="End")
						exit()
					joueurs[swap].play(board)
					swap = abs(swap - 1)
					select = None
				elif case != -1 and joueurs[swap].nb_pion_pose == 4 and board.plateau[case] == joueurs[swap]._id:
					select = case
					board.displaySelect(case)
			if event.type == pygame.MOUSEMOTION and joueurs[swap].is_real :
				case = board.getCase(pygame.mouse.get_pos()[0], pygame.mouse.get_pos()[1])
				if board.isMovePossible(case, select):
					board.display()
					board.displayCase(case, joueurs[swap]._id, select)
				else:
					board.display()
					board.displaySelect(select)

if __name__ == '__main__':
    main()
