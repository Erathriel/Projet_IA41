import pygame
from pygame.locals import *
#import src.ressources as ressources

class Board:

	def __init__(self):
		pygame.init()
		self.fenetre = pygame.display.set_mode((600, 600))
		self.fond = pygame.image.load("../img/teeko_board.jpg").convert()
		self.plateau = []

	def display(self):
		self.fenetre.blit(self.fond, (0,0))
		pygame.display.flip()

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
	display = 1
	while display:
		for event in pygame.event.get():
			if event.type == QUIT:
				display = 0

if __name__ == '__main__':
    main()