% num�ro des cases :
%	  1  2  3  4  5
% 	  6  7  8  9 10
%	 11 12 13 14 15
%	 16 17 18 19 20
%	 21 22 23 24 25

/* true si configuration gagnante */
% gagnant(+P1,+P2,+P3,+P4)
% les points doivent �tre dans l ordre croissant

gagnant(P1,P2,P3,P4) :- sort([P1,P2,P3,P4],[A,B,C,D]), gagnant_horizontal(A,B,C,D).				% ex : 10 8 9 7
gagnant(P1,P2,P3,P4) :- sort([P1,P2,P3,P4],[A,B,C,D]), gagnant_vertical(A,B,C,D).				% ex : 14 19 9 4
gagnant(P1,P2,P3,P4) :- sort([P1,P2,P3,P4],[A,B,C,D]), gagnant_diagonale_descendante(A,B,C,D).			% ex : 7 1 19 13
gagnant(P1,P2,P3,P4) :- sort([P1,P2,P3,P4],[A,B,C,D]), gagnant_diagonale_montante(A,B,C,D).			% ex : 21 13 9 17
gagnant(P1,P2,P3,P4) :- sort([P1,P2,P3,P4],[A,B,C,D]), gagnant_carre(A,B,C,D).					% ex : 11 16 17 12

gagnant_horizontal(P1,P2,P3,P4) :-  P1==1, A is P1+1, P2 == A, B is P2+1, P3==B, C is P3+1, P4==C.
gagnant_horizontal(P1,P2,P3,P4) :-  P1==2, A is P1+1, P2 == A, B is P2+1, P3==B, C is P3+1, P4==C.
gagnant_horizontal(P1,P2,P3,P4) :-  P1==6, A is P1+1, P2 == A, B is P2+1, P3==B, C is P3+1, P4==C.
gagnant_horizontal(P1,P2,P3,P4) :-  P1==7, A is P1+1, P2 == A, B is P2+1, P3==B, C is P3+1, P4==C.
gagnant_horizontal(P1,P2,P3,P4) :-  P1==11, A is P1+1, P2 == A, B is P2+1, P3==B, C is P3+1, P4==C.
gagnant_horizontal(P1,P2,P3,P4) :-  P1==12, A is P1+1, P2 == A, B is P2+1, P3==B, C is P3+1, P4==C.
gagnant_horizontal(P1,P2,P3,P4) :-  P1==16, A is P1+1, P2 == A, B is P2+1, P3==B, C is P3+1, P4==C.
gagnant_horizontal(P1,P2,P3,P4) :-  P1==17, A is P1+1, P2 == A, B is P2+1, P3==B, C is P3+1, P4==C.
gagnant_horizontal(P1,P2,P3,P4) :-  P1==21, A is P1+1, P2 == A, B is P2+1, P3==B, C is P3+1, P4==C.
gagnant_horizontal(P1,P2,P3,P4) :-  P1==22, A is P1+1, P2 == A, B is P2+1, P3==B, C is P3+1, P4==C.

gagnant_vertical(P1,P2,P3,P4) :- P1=<10, A is P1+5, P2==A, B is P1+10, P3==B, C is P1+15, P4==C.

gagnant_diagonale_descendante(P1,P2,P3,P4) :- P1==1, A is P1+6, B is P1+12, C is P1+18, P2==A, P3==B, P4==C.
gagnant_diagonale_descendante(P1,P2,P3,P4) :- P1==7, A is P1+6, B is P1+12, C is P1+18, P2==A, P3==B, P4==C.


gagnant_diagonale_montante(P1,P2,P3,P4) :- P1==5, A is P1+4, B is P1+8, C is P1+12, P2==A, P3==B, P4==C.
gagnant_diagonale_montante(P1,P2,P3,P4) :- P1==9, A is P1+4, B is P1+8, C is P1+12, P2==A, P3==B, P4==C.

gagnant_carre(P1,_,_,_) :- P1==5, false.
gagnant_carre(P1,_,_,_) :- P1==10, false.
gagnant_carre(P1,_,_,_) :- P1==15, false.
gagnant_carre(P1,_,_,_) :- P1==20, false.
gagnant_carre(P1,_,_,_) :- P1==25, false.
gagnant_carre(P1,_,_,_) :- P1==21, false.
gagnant_carre(P1,_,_,_) :- P1==22, false.
gagnant_carre(P1,_,_,_) :- P1==23, false.
gagnant_carre(P1,_,_,_) :- P1==24, false.
gagnant_carre(P1,P2,P3,P4) :- A is P1+1, B is P1+5, C is P1+6, P2==A, P3==B, P4==C.
