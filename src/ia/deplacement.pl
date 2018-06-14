/**************************************DEPLACEMENT.PL**************************************

possibiliteDeplacerPion(Case,CasesAutour)
list_to_set(L1,L2)
deplacementsPossibles(Joueur,PlateauActuel,ListeDeplacementsPossibles) : toutes les cases disponibles pour un joueur
effectuerUnDeplacement(PlateauActuel,CaseAvant,CaseApres,PlateauApres) : vide CaseAvant et rempli CaseApres avec ce qu'il y a dans CaseAvant
effectuerDeplacementsPourUneCase(PlateauActuel,NCase,LesPlateauxApres) : LesPlateauxApres sont les possibilités de déplacements en partant d'une seule case
effectuerTousLesDeplacementsJoueur(Joueur,PlateauActuel,PlateauxApres) : Toutes les possibilités de déplacements qua un joueur en partant de PlateauActuel

*******************************************************************************************/

/*
Donne les cases adjacentes où un pion peut bouger
possibiliteDeplacerPion(+Case,-Liste).
*/
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

/*
Transforme une liste en une liste sans récurrence
list_to_set(+L1,-L2)
*/
list_to_set(L1,L2):-list_to_set(L1,L2,[]).
list_to_set([],[],_).
list_to_set([X|R1],L,T):-member(X,T),!,list_to_set(R1,L,T).
list_to_set([X|R1],[X|R2],T):-append(T,[X],T1),list_to_set(R1,R2,T1).

/*
Donne pour le moment toutes les cases où le joueur aura la possibilité de se déplacer
deplacementsPossibles(+Joueur,+PlateauActuel,-ListeDeplacementsPossibles)
*/
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

/*
Transfère contenu d'une case à une autre (simule mouvement pion)
effectuerUnDeplacement(+PlateauActuel,+CaseAvant,+CaseApres,-PlateauApres)
*/
effectuerUnDeplacement(PlateauActuel,CaseAvant,CaseApres,PlateauApres):-quelNumDansCase(CaseAvant,PlateauActuel,A), effectuerUnDeplacement(PlateauActuel,CaseAvant,CaseApres,PlateauApres,A,1).
effectuerUnDeplacement([],_,_,[],_,_).
effectuerUnDeplacement([_|R],CaseAvant,CaseApres,[0|R2],A,I):-I==CaseAvant, I2 is I+1, effectuerUnDeplacement(R,CaseAvant,CaseApres,R2,A,I2).
effectuerUnDeplacement([_|R],CaseAvant,CaseApres,[A|R2],A,I):-I==CaseApres, I2 is I+1, effectuerUnDeplacement(R,CaseAvant,CaseApres,R2,A,I2).
effectuerUnDeplacement([T|R],CaseAvant,CaseApres,[T|R2],A,I):-I\=CaseAvant, I2 is I+1, effectuerUnDeplacement(R,CaseAvant,CaseApres,R2,A,I2).
effectuerUnDeplacement([T|R],CaseAvant,CaseApres,[T|R2],A,I):-I\=CaseApres, I2 is I+1, effectuerUnDeplacement(R,CaseAvant,CaseApres,R2,A,I2).

/*
Retourne les plateaux après avoir fait les déplacements possibles en partant d'une case
effectuerDeplacementsPourUneCase(+PlateauActuel,+NCase,-LesPlateauxApres)
*/
effectuerDeplacementsPourUneCase(PlateauActuel,NCase,LesPlateauxApres):-possibiliteDeplacerPion(NCase,Poss),effectuerDeplacementsPourUneCase(PlateauActuel,NCase,LesPlateauxApres,Poss).
effectuerDeplacementsPourUneCase(_,_,[],[]).
effectuerDeplacementsPourUneCase(PlateauActuel,NCase,[T|R],[T2|R2]):-quelNumDansCase(T2,PlateauActuel,0),effectuerUnDeplacement(PlateauActuel,NCase,T2,T),effectuerDeplacementsPourUneCase(PlateauActuel,NCase,R,R2).
effectuerDeplacementsPourUneCase(PlateauActuel,NCase,L,[T2|R2]):-quelNumDansCase(T2,PlateauActuel,Z),Z\=0,effectuerDeplacementsPourUneCase(PlateauActuel,NCase,L,R2).

/*
Retourne tous les plateaux possibles qu'un joueur peut obtenir à un moment donné
A utiliser pour l'algo MinValue et MaxValue (cf. diapo IA41 CM6)
effectuerTousLesDeplacementsJoueur(+Joueur,+PlateauActuel,-PlateauxApres)
*/
effectuerTousLesDeplacementsJoueur(Joueur,PlateauActuel,PlateauxApres):-mesCases(Joueur,PlateauActuel,L),
                                                                        effectuerTousLesDeplacementsJoueur(Joueur,PlateauActuel,X,L),
                                                                        append(X,PlateauxApres),!.
effectuerTousLesDeplacementsJoueur(_,_,[],[]).
effectuerTousLesDeplacementsJoueur(Joueur,PlateauActuel,[PT|PR],[LT|LR]):-effectuerDeplacementsPourUneCase(PlateauActuel,LT,PT),effectuerTousLesDeplacementsJoueur(Joueur,PlateauActuel,PR,LR).
