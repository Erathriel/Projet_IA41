:- consult('gagnant.pl').
:- consult('deplacement.pl').

/*
numéros des cases :
 1  2  3  4  5
 6  7  8  9 10
11 12 13 14 15
16 17 18 19 20
21 22 23 24 25

plateau exemple : [1,1,1,0,2,1,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0]
1 1 1 0 2
1 0 0 0 2
2 0 0 2 0
0 0 0 0 0
0 0 0 0 0
*/

afficher([A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y]):-write([A,B,C,D,E]),write('\n'),write([F,G,H,I,J]),write('\n'),write([K,L,M,N,O]),write('\n'),write([P,Q,R,S,T]),write('\n'),write([U,V,W,X,Y]).

/* Regarde quel joueur est dans la case donnée
0 si libre
1 si joueur 1
2 si joueur 2
quelNumDansCase(+NCase,+Plateau,?Res) Plateau est une liste */
quelNumDansCase(NCase,Plateau,Res):- quelNumDansCase(NCase,Plateau,Res,1).
quelNumDansCase(NCase,[T|_],T,NCase):- !.
quelNumDansCase(NCase,[_|R],Res,I):- I<NCase, I2 is I+1, quelNumDansCase(NCase,R,Res,I2).

/* Retourne les indices d'un numero joueur donné /!\ pb*/
indexOf([NumJoueur|_], NumJoueur, 1).
indexOf([_|Tail], NumJoueur, Index):- indexOf(Tail, NumJoueur, Index1), Index is Index1+1.  % and increment the resulting index

/* Retourne les 4 indices des cases d'joueur donné */
mesCases(Joueur,Plateau,[A,B,C,D]):-mesCases(Joueur,Plateau,[A,B,C,D|_],0).
mesCases(_,[],_,_).
mesCases(Joueur,[T|R],R2,I):-T\=Joueur, I2 is I+1, mesCases(Joueur,R,R2,I2).
mesCases(Joueur,[T|R],[I2|R2],I):-T==Joueur, I2 is I+1, mesCases(Joueur,R,R2,I2).

/* Vrai si un joueur donné a une configuration gagnante dans le plateau donné */
joueurGagnant(Plateau,Joueur):-mesCases(Joueur,Plateau,[A,B,C,D]), gagnant(A,B,C,D).

partieGagnee(Plateau):-joueurGagnant(Plateau,1).
partieGagnee(Plateau):-joueurGagnant(Plateau,2).














/************************ EVALUATION ************************/

/* Convertis un numéro de case en coordonnées x et y */
coord(1,1,1).
coord(2,1,2).
coord(3,1,3).
coord(4,1,4).
coord(5,1,5).
coord(6,2,1).
coord(7,2,2).
coord(8,2,3).
coord(9,2,4).
coord(10,2,5).
coord(11,3,1).
coord(12,3,2).
coord(13,3,3).
coord(14,3,4).
coord(15,3,5).
coord(16,4,1).
coord(17,4,2).
coord(18,4,3).
coord(19,4,4).
coord(20,4,5).
coord(21,5,1).
coord(22,5,2).
coord(23,5,3).
coord(24,5,4).
coord(25,5,5).

/* Res est la distance entre les points données A et B */
dist2Points(A,B,Res):-coord(A,Xa,Ya),coord(B,Xb,Yb), Res is sqrt((Xb-Xa)*(Xb-Xa)+(Yb-Ya)*(Yb-Ya)).

/* Retourne la distance moyenne entre 4 cases */
moyenneDistancesTousLesPoints(A,B,C,D,R):-dist2Points(A,B,R1),
                                          dist2Points(A,C,R2),
                                          dist2Points(A,D,R3),
                                          dist2Points(B,C,R4),
                                          dist2Points(B,D,R5),
                                          dist2Points(C,D,R6),
                                          R7 is R1+R2+R3+R4+R5+R6,
                                          R is R7/6.

/* Res est la distance moyenne entre les 4 cases d'un joueur  */
evaluationJoueur(Joueur,Plateau,Res):-mesCases(Joueur,Plateau,[A1,B1,C1,D1]),
                                          gagnant(A1,B1,C1,D1),moyenneDistancesTousLesPoints(A1,B1,C1,D1,Res).
evaluationJoueur(Joueur,Plateau,Res):-mesCases(Joueur,Plateau,[A1,B1,C1,D1]),
                         moyenneDistancesTousLesPoints(A1,B1,C1,D1,Res).

/* fonction evaluation ???? */
evaluation(Plateau,Res):-mesCases(1,Plateau,[A1,B1,C1,D1]),
                         mesCases(2,Plateau,[A2,B2,C2,D2]),
                         moyenneDistancesTousLesPoints(A1,B1,C1,D1,R1),
                         moyenneDistancesTousLesPoints(A2,B2,C2,D2,R2),
                         Res is R2-R1.
/*
minmax(PlateauDepart,Profondeur,PlateauAJouer):-maxValue(1,[PlateauDepart],Profondeur,Valeur,[-1000]),getAction(PlateauDepart,Valeur,PlateauAJouer).


maxValue(_,PlateauActuel,0,Valeur,_):-evaluation(PlateauActuel,Valeur).
maxValue(_,PlateauActuel,_,Valeur,_):-joueurGagnant(1,PlateauActuel),evaluation(PlateauActuel,Valeur).

maxValue(1,[T|R],Profondeur,Valeur,Tmp):-Profondeur2 is Profondeur-1,effectuerTousLesDeplacementsJoueur(1,T,X),minValue(2,X,Profondeur2,Valeur1,[1000]),append(Tmp,[Valeur1],ListRes),list_max(ListRes,Res),maxValue(1,R,Profondeur,Valeur,Res),.
*/










list_min([L|Ls], Min) :-list_min(Ls, L, Min).
list_min([], Min, Min).
list_min([L|Ls], Min0, Min) :-Min1 is min(L, Min0),list_min(Ls, Min1, Min).

list_max([T|R], Max) :-list_max(R, T, Max).
list_max([], Max, Max).
list_max([T|R], Max0, Max) :-Max1 is max(T, Max0),list_max(R, Max1, Max).


liste_eval(_,[],[]).
liste_eval(Joueur,[P|Rp],[V|Rv]):-evaluationJoueur(Joueur,P,V),liste_eval(Joueur,Rp,Rv).



/*   SUBSTITUT A MINMAX AU CAS OU */
meilleurMouvement(Joueur,Dep,Arr):-effectuerTousLesDeplacementsJoueur(Joueur,Dep,X),liste_eval(Joueur,X,Lev),list_max(Lev,M),indexOf(Lev,M,I),quelNumDansCase(I,X,Arr).

/*jouer(E,P):-maxValue(E,P,V),write(V).

maxValue(E,0,V):-evaluationJoueur(1,E,V).
maxValue(E,_,V):-partieGagnee(E).
maxValue(E,P,V):-effectuerTousLesDeplacementsJoueur(1,E,TLD),maxValue(E,P,TLD,-1000,V).
maxValue(E,P,[S|R],V0,V):-Pm1 is P-1,
                       minValue(S,Pm1,1000,V1),
                       V is max(V0,V1),
                       maxValue(E,P,R,V).*/
