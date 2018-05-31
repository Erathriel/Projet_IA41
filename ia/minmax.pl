:- consult('gagnant.pl').

% numéro des cases :
%	  1  2  3  4  5
% 	6  7  8  9 10
%	 11 12 13 14 15
%	 16 17 18 19 20
%	 21 22 23 24 25

/* Regarde quel joueur est dans la case donnée
0 si libre
1 si joueur 1
2 si joueur 2 */
% quelNumDansCase(+NCase,+Plateau,?Res) Plateau est une liste

quelNumDansCase(NCase,Plateau,Res):- quelNumDansCase(NCase,Plateau,Res,1).
quelNumDansCase(NCase,[T|_],T,NCase):- !.
quelNumDansCase(NCase,[_|R],Res,I):- I<NCase, I2 is I+1, quelNumDansCase(NCase,R,Res,I2).



/* Retourne les indices d'un numero joueur donné /!\ pb
indexOf([NumJoueur|_], NumJoueur, 1).
indexOf([_|Tail], NumJoueur, Index):- indexOf(Tail, NumJoueur, Index1), Index is Index1+1.  % and increment the resulting index */

/* Retourne les 4 indices des cases d'joueur donné */
mesCases(Joueur,Plateau,[A,B,C,D]):-mesCases(Joueur,Plateau,[A,B,C,D|_],0).
mesCases(_,[],_,_).
mesCases(Joueur,[T|R],R2,I):-T\=Joueur, I2 is I+1, mesCases(Joueur,R,R2,I2).
mesCases(Joueur,[T|R],[I2|R2],I):-T==Joueur, I2 is I+1, mesCases(Joueur,R,R2,I2).

/* Vrai si un joueur donné a une configuration gagnante dans le plateau donné */
joueurGagnant(Plateau,Joueur):-mesCases(Joueur,Plateau,[A,B,C,D]), gagnant(A,B,C,D).

/* COnvertis un numéro de case en coordonnées x et y */
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

/* Retourne la distance moyenne entre 4 cases  */
moyenneDistancesTousLesPoints(A,B,C,D,R):-dist2Points(A,B,R1),
                                          dist2Points(A,C,R2),
                                          dist2Points(A,D,R3),
                                          dist2Points(B,C,R4),
                                          dist2Points(B,D,R5),
                                          dist2Points(C,D,R6),
                                          R7 is R1+R2+R3+R4+R5+R6,
                                          R is R7/6.

/* plateau exemple : [1,1,1,0,2,1,0,0,0,2,2,0,0,2,0,0,0,0,0,0,0,0,0,0,0]
1 1 1 0 2
1 0 0 0 2
2 0 0 2 0
0 0 0 0 0
0 0 0 0 0
*/

/* Res est la distance moyenne entre les 4 cases d'un joueur  */
evaluationJoueur(Joueur,Plateau,Res):-mesCases(Joueur,Plateau,[A1,B1,C1,D1]),
                         moyenneDistancesTousLesPoints(A1,B1,C1,D1,Res).

/* fonction evaluation ???? */
evaluation(Plateau,Res):-mesCases(1,Plateau,[A1,B1,C1,D1]),
                         mesCases(2,Plateau,[A2,B2,C2,D2]),
                         moyenneDistancesTousLesPoints(A1,B1,C1,D1,R1),
                         moyenneDistancesTousLesPoints(A2,B2,C2,D2,R2),
                         Res is R2-R1.

/* Donne les cases adjacentes où un pion peut bouger */
possibiliteDeplacerPion(1,[2,6,7]).
possibiliteDeplacerPion(2,[1,3,6,7,8]).
possibiliteDeplacerPion(3,[2,4,7,8,9]).
possibiliteDeplacerPion(4,[3,5,8,9,10]).
possibiliteDeplacerPion(5,[4,9,10]).
possibiliteDeplacerPion(6,[1,2,7,11,12]).
possibiliteDeplacerPion(7,[1,2,3,7,8,11,12,13]).
possibiliteDeplacerPion(8,[2,3,4,7,9,12,13,14]).
possibiliteDeplacerPion(9,[3,4,5,8,10,13,14,15]).
possibiliteDeplacerPion(10,[4,5,9,14,15]).
possibiliteDeplacerPion(11,[6,7,12,16,17]).
possibiliteDeplacerPion(12,[6,7,8,11,13,16,17,18]).
possibiliteDeplacerPion(13,[7,8,9,12,14,17,18,19]).
possibiliteDeplacerPion(14,[8,9,10,13,15,18,19,20]).
possibiliteDeplacerPion(15,[9,10,14,19,20]).
possibiliteDeplacerPion(16,[11,12,17,21,22]).
possibiliteDeplacerPion(17,[11,12,13,16,18,21,22,23]).
possibiliteDeplacerPion(18,[12,13,14,17,19,22,23,24]).
possibiliteDeplacerPion(19,[13,14,15,18,20,23,24,25]).
possibiliteDeplacerPion(20,[14,15,19,24,25]).
possibiliteDeplacerPion(21,[16,17,22]).
possibiliteDeplacerPion(22,[16,17,18,21,23]).
possibiliteDeplacerPion(23,[17,18,19,22,23]).
possibiliteDeplacerPion(24,[18,19,20,23,25]).
possibiliteDeplacerPion(25,[19,20,24]).

/* Transforme une liste en une liste sans récurrence */
list_to_set(L1,L2):-list_to_set(L1,L2,[]).
list_to_set([],[],_).
list_to_set([X|R1],L,T):-member(X,T),!,list_to_set(R1,L,T).
list_to_set([X|R1],[X|R2],T):-append(T,[X],T1),list_to_set(R1,R2,T1).

/* donne pour le moment toutes les cases où le joueur aura la possibilité de se déplacer */
deplacementsPossibles(Joueur,PlateauActuel,ListeDeplacementsPossibles):- mesCases(Joueur,PlateauActuel,[A,B,C,D]),
                                                               possibiliteDeplacerPion(A,La),
                                                               possibiliteDeplacerPion(B,Lb),
                                                               possibiliteDeplacerPion(C,Lc),
                                                               possibiliteDeplacerPion(D,Ld),
                                                               append(La,Lb,Le),
                                                               append(Le,Lc,Lf),
                                                               append(Lf,Ld,Lg),
                                                               list_to_set(Lg,Lh),
                                                               deplacementsPossibles2(PlateauActuel,Lh,ListeDeplacementsPossibles).

deplacementsPossibles2(_,[],[]).
deplacementsPossibles2(PlateauActuel,[T|R],L):-quelNumDansCase(T,PlateauActuel,QNDC),QNDC\=0,deplacementsPossibles2(PlateauActuel,R,L).
deplacementsPossibles2(PlateauActuel,[T|R],[T|R2]):-quelNumDansCase(T,PlateauActuel,QNDC),QNDC==0,deplacementsPossibles2(PlateauActuel,R,R2).

/* Transfère contenu d'une case à une autre (simule mouvement pion) */
effectuerUnDeplacement(PlateauActuel,CaseAvant,CaseApres,PlateauApres):-quelNumDansCase(CaseAvant,PlateauActuel,A), effectuerUnDeplacement(PlateauActuel,CaseAvant,CaseApres,PlateauApres,A,1).
effectuerUnDeplacement([],_,_,[],_,_).
effectuerUnDeplacement([_|R],CaseAvant,CaseApres,[0|R2],A,I):-I==CaseAvant, I2 is I+1, effectuerUnDeplacement(R,CaseAvant,CaseApres,R2,A,I2).
effectuerUnDeplacement([_|R],CaseAvant,CaseApres,[A|R2],A,I):-I==CaseApres, I2 is I+1, effectuerUnDeplacement(R,CaseAvant,CaseApres,R2,A,I2).
effectuerUnDeplacement([T|R],CaseAvant,CaseApres,[T|R2],A,I):-I\=CaseAvant, I2 is I+1, effectuerUnDeplacement(R,CaseAvant,CaseApres,R2,A,I2).
effectuerUnDeplacement([T|R],CaseAvant,CaseApres,[T|R2],A,I):-I\=CaseApres, I2 is I+1, effectuerUnDeplacement(R,CaseAvant,CaseApres,R2,A,I2).

/* Retourne les plateaux après avoir fait les déplacements possibles en partant d'une case */
effectuerDeplacementsPourUneCase(PlateauActuel,NCase,LesPlateauxApres):-possibiliteDeplacerPion(NCase,Poss),effectuerDeplacementsPourUneCase(PlateauActuel,NCase,LesPlateauxApres,Poss).
effectuerDeplacementsPourUneCase(_,_,[],[]).
effectuerDeplacementsPourUneCase(PlateauActuel,NCase,[T|R],[T2|R2]):-quelNumDansCase(T2,PlateauActuel,0),effectuerUnDeplacement(PlateauActuel,NCase,T2,T),effectuerDeplacementsPourUneCase(PlateauActuel,NCase,R,R2).
effectuerDeplacementsPourUneCase(PlateauActuel,NCase,L,[T2|R2]):-quelNumDansCase(T2,PlateauActuel,Z),Z\=0,effectuerDeplacementsPourUneCase(PlateauActuel,NCase,L,R2).

/* Retourne tous les plateaux possibles qu'un joueur peut obtenir à un moment donné
A utiliser pour l'algo MinValue et MaxValue (cf. diapo IA41 CM6) */
effectuerTousLesDeplacementsJoueur(Joueur,PlateauActuel,PlateauxApres):-mesCases(Joueur,PlateauActuel,L),
                                                                        effectuerTousLesDeplacementsJoueur(Joueur,PlateauActuel,X,L),
                                                                        append(X,PlateauxApres).
effectuerTousLesDeplacementsJoueur(_,_,[],[]).
effectuerTousLesDeplacementsJoueur(Joueur,PlateauActuel,[PT|PR],[LT|LR]):-effectuerDeplacementsPourUneCase(PlateauActuel,LT,PT),effectuerTousLesDeplacementsJoueur(Joueur,PlateauActuel,PR,LR).

/*
minmax(Joueur,PlateauActuel,Profondeur,PlateauApresCoup):-maxValue(Joueur,PlateauActuel,Profondeur,PlateauApresCoup).

maxValue(_,_,0,_).
maxValue(Joueur,PlateauActuel,_,_):-joueurGagnant(PlateauActuel,Joueur).
maxValue(Joueur,PlateauActuel,Profondeur,PlateauApresCoup):-effectuerTousLesDeplacementsJoueur(Joueur,PlateauActuel,[T|R]),


meilleurCoupAJouer(JoueurPlateau,PLateauApres):-forall(member(S, Plateau), string_codes(S, X)),*/




minmax(Joueur,PlateauActuel,Profondeur,PlateauApresCoup):-maxValue(Joueur,PlateauActuel,Profondeur,PlateauApresCoup).

maxValue(_,PlateauActuel,0,PlateauActuel,Res):-evaluationJoueur(Joueur,PlateauActuel,Res).
maxValue(Joueur,PlateauActuel,_,PlateauActuel,Res):-joueurGagnant(PlateauActuel,Joueur),evaluationJoueur(Joueur,PlateauActuel,Res).
maxValue(Joueur,PlateauActuel,Profondeur,PlateauApresCoup,Res):-effectuerTousLesDeplacementsJoueur(Joueur,PlateauActuel,X),V is 10000,MeilleurPlateau is PlateauActuel,forall( member(M,X), maxTest(Joueur,PlateauActuel,M,Profondeur,Z,Res)).
/*Pour les RES: plus ellle est petite plus elle est avantageuse pour joueur*/
maxTest(Joueur,PlateauActuel,PlateauATest,Profondeur,PlateauApresCoup,Res):- /*Comparaison resultat min avec les precedentes iterations du forall*/minValue(Joueur,PlateauATest,Profondeur-1,PlateauApresCoup,Res2),Res1<Res2,PlateauApresCoup is PlateauActuel,Res is Res1.
maxTest(Joueur,PlateauActuel,PlateauATest,Profondeur,PlateauApresCoup,Res):- minValue(Joueur,PlateauATest,Profondeur-1,PlateauApresCoup),Res1>=Res2,Res is Res2.

minValue(_,PlateauActuel,0,PlateauActuel).
minValue(Joueur,PlateauActuel,_,PlateauActuel):-joueurGagnant(PlateauActuel,Joueur).
minValue(Joueur,PlateauActuel,Profondeur,PlateauApresCoup):-maxValue(Jouer,PlateauActuel,Profondeur-1,PlateauApresCoup).
