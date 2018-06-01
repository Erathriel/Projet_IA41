import pygame
from pygame.locals import *

class Board:

	def __init__(self):
		pygame.init()
		self.fenetre = pygame.display.set_mode((569, 600))
		self.fond = pygame.image.load("../img/teeko_board.jpg").convert()
		self.jeton = [None, pygame.image.load("../img/jeton1.jpg").convert(), pygame.image.load("../img/jeton2.jpg").convert()]
		#self.plateau = [0]*25	
		self.plateau = [1,1,0,1,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
	def display(self):
		self.fenetre.blit(self.fond, (0,0))
		pygame.display.flip()

	def displayCase(self, index, joueur):
		self.fenetre.blit(self.jeton[joueur], self.getCasePos(index))
		pygame.display.flip()
		pass

	def checkWin(self):
		for i in range(0, 25):
			if self.plateau[i] != 0:
				# check horizontal
				if i%5 <= 1 and self.plateau[i:i+4].count(self.plateau[i]) == 4:
					return self.plateau[i]
				# check vertical
		return False

	def isMovePossible(self, index, indexPion):
		if(index < 0):
			return False
		# verifier si tous les pions ont été posé
		if self.plateau.count(0) > 17:
			if self.plateau[index] == 0:
				return True
			return False
		# sinon verifier que la distance soit egale a 1 ET que la case soit vide
		else:
			if self.plateau[index] == 0 and ( abs(indexPion-index) == 1 or (abs(indexPion - index) >= 4 and abs(indexPion-index) <= 6) ) :
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
		x = 90 if index%5 == 0 else ((index%5)-1)*84+174
		y = 90 if int(index/5) == 0 else (int(index/5)-1)*84+174
		return (x, y)

class Joueur:

	def __init__(self, is_real):
		self.is_real = is_real

	def jouer(self, plateau):
		if is_real:
			self.plateau = plateau
		#else appeler predicat avec plateau

def main():
	board = Board()
	board.display()

	jwin = board.checkWin()
	if(jwin):
		print("Le joueur "+str(jwin)+" a gagne")

	while 1:
		for event in pygame.event.get():
			if event.type == QUIT:
				exit()
			if event.type == pygame.MOUSEBUTTONUP:
				board.getCase(pygame.mouse.get_pos()[0], pygame.mouse.get_pos()[1])
			if event.type == pygame.MOUSEMOTION :
				case = board.getCase(pygame.mouse.get_pos()[0], pygame.mouse.get_pos()[1])
				if board.isMovePossible(case, None):
					board.display()
					board.displayCase(case, 1)
				else:
					board.display()

if __name__ == '__main__':
    main()