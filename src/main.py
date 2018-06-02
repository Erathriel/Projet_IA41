import pygame
from pygame.locals import *

class Board:

	def __init__(self):
		pygame.init()
		self.fenetre = pygame.display.set_mode((569, 600))
		self.fond = pygame.image.load("../img/teeko_board.jpg").convert()
		self.jeton = [pygame.image.load("../img/jeton1.png").convert_alpha(), pygame.image.load("../img/jeton2.png").convert_alpha()]
		self.plateau = [0]*25	
		#self.plateau = [1,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	def display(self):
		self.fenetre.blit(self.fond, (0,0))
		for i in range(0, 25):
			if self.plateau[i] != 0:
				self.fenetre.blit(self.jeton[self.plateau[i]-1], self.getCasePos(i))
		pygame.display.flip()

	def displayCase(self, index, _id):
		self.fenetre.blit(self.jeton[_id-1], self.getCasePos(index))
		pygame.display.flip()

	def checkWin(self):
		for i in range(0, 25):
			if self.plateau[i] != 0:
				# check horizontal
				if i%5 <= 1 and self.plateau[i:i+4].count(self.plateau[i]) == 4:
					return self.plateau[i]
				# check vertical
		return False

	def isMovePossible(self, index, indexPion):
		if(index < 0 or self.plateau[index] != 0):
			return False
		# verifier si tous les pions ont été posé
		if self.plateau.count(0) > 17:
			return True
		# sinon verifier que la distance soit egale a 1 ET que la case soit vide
		else:
			if abs(indexPion-index) == 1 or (abs(indexPion - index) >= 4 and abs(indexPion-index) <= 6) :
				return True
			return False

	def getCase(self, x, y):
		if( (x > 90 and x < 150) or (x > 150 and (x-150)%84 > 24)) and ( (y > 90 and y < 150) or (y > 150 and(y-150)%84 > 24)) and ( y < 483 and x < 483) :
			i = 0 if y < 150 else (int(y / 84)-1)*5
			i += 0 if x < 150 else (int(x / 84)-1)
			return i
		else:
			return -1
		pass

	def getCasePos(self, index):
		x = 90 if index%5 == 0 else ((index%5)-1)*83+174
		y = 90 if int(index/5) == 0 else (int(index/5)-1)*80.5+174
		return (x, y)

	def playMove(self, joueur, case, casePrev):
		if(self.isMovePossible(case, casePrev)):
			if casePrev:
				self.plateau[casePrev] = 0
			self.plateau[case] = joueur._id
			self.display()
			return True
		return False

class Joueur:

	def __init__(self, _id, is_real):
		self._id = _id
		self.is_real = is_real
		self.nb_pion_pose = 0

	def play(self, plateau):
		if self.is_real:
			self.plateau = plateau
		#else appeler predicat avec plateau

def main():
	board = Board()
	board.display()

	joueurs = [Joueur(1, True), Joueur(2, True)]
	swap = 1

	joueurs[swap].play(board)
	swap = abs(swap - 1)

	while 1:
		for event in pygame.event.get():
			if event.type == QUIT:
				exit()
			if event.type == pygame.MOUSEBUTTONUP and joueurs[swap].is_real :
				case = board.getCase(pygame.mouse.get_pos()[0], pygame.mouse.get_pos()[1])
				if board.playMove(joueurs[swap], case, None):
					jwin = board.checkWin()
					if(jwin):
						print("Le joueur "+str(jwin)+" a gagne")
					joueurs[swap].play(board)
					swap = abs(swap - 1)
			if event.type == pygame.MOUSEMOTION and joueurs[swap].is_real :
				case = board.getCase(pygame.mouse.get_pos()[0], pygame.mouse.get_pos()[1])
				if board.isMovePossible(case, None):
					board.display()
					board.displayCase(case, joueurs[swap]._id)
				else:
					board.display()

if __name__ == '__main__':
    main()