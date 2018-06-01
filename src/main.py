import pygame
from pygame.locals import *

class Board:

	def __init__(self):
		pygame.init()
		self.fenetre = pygame.display.set_mode((569, 600))
		self.fond = pygame.image.load("../img/teeko_board.jpg").convert()
		self.plateau = [0]*25

	def display(self):
		self.fenetre.blit(self.fond, (0,0))
		pygame.display.flip()

	def checkWin(self, x, y):
		pass

	def isMovePossible(self, index, indexPion):
		# verifier si tous les pions ont été posé
		if self.plateau.count(0) < 8:
			if self.plateau[i] == 0:
				return True
			return False
		# sinon verifier que la distance soit egale a 1 ET que la case soit vide
		else:
			if self.plateau[i] == 0 and abs(indexPion-index) == 1 :
				pass

	def getCase(self, x, y):
		if( (x > 90 and x < 150) or (x > 150 and (x-150)%84 > 24)) and ( (y > 90 and y < 150) or (y > 150 and(y-150)%84 > 24)) and ( y < 483 and x < 483) :
			i = 0 if y < 150 else (int(y / 84)-1)*5
			i+= 0 if x < 150 else (int(x / 84)-1)
			print("dans la case d'index : "+str(i)+"\n")
		else:
			print("pas dans une case\n")
		pass

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

	while 1:
		for event in pygame.event.get():
			if event.type == QUIT:
				exit()
			if event.type == pygame.MOUSEBUTTONUP:
				board.getCase(pygame.mouse.get_pos()[0], pygame.mouse.get_pos()[1])

if __name__ == '__main__':
    main()