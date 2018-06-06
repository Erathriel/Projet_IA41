




/*
minmax(Joueur,PlateauActuel,Profondeur,PlateauApresCoup):-maxValue(Joueur,PlateauActuel,Profondeur,PlateauApresCoup).

maxValue(_,_,0,_).
maxValue(Joueur,PlateauActuel,_,_):-joueurGagnant(PlateauActuel,Joueur).
maxValue(Joueur,PlateauActuel,Profondeur,PlateauApresCoup):-effectuerTousLesDeplacementsJoueur(Joueur,PlateauActuel,[T|R]),

meilleurCoupAJouer(JoueurPlateau,PLateauApres):-forall(member(S, Plateau), string_codes(S, X)),*/

minmax(Joueur,PlateauActuel,Profondeur,PlateauApresCoup,Res):-maxValue(Joueur,PlateauActuel,Profondeur,PlateauApresCoup,1000,Res).

maxValue(Joueur,PlateauActuel,Profondeur,PlateauApresCoup,Res):-maxValue(Joueur,PlateauActuel,Profondeur,PlateauApresCoup,1000,Res).
/*maxValue(Joueur,PlateauActuel,0,PlateauActuel,_,Res).*/
maxValue(Joueur,PlateauActuel,0,PlateauActuel,_,Res):-evaluationJoueur(Joueur,PlateauActuel,Res).
maxValue(Joueur,PlateauActuel,_,PlateauActuel,_,Res):-joueurGagnant(PlateauActuel,Joueur),evaluationJoueur(Joueur,PlateauActuel,Res).
maxValue(Joueur,PlateauActuel,Profondeur,PlateauActuel,Val,Val):-effectuerTousLesDeplacementsJoueur(Joueur,PlateauActuel,X),member(M,X),write(Profondeur),write(M), minValue(Joueur,M,Profondeur,_,ResMin),ResMin>=Val.
maxValue(Joueur,PlateauActuel,Profondeur,PlateauApresCoup,Val,ResMin):-effectuerTousLesDeplacementsJoueur(Joueur,PlateauActuel,X),member(M,X),write(Profondeur),write(M), minValue(Joueur,M,Profondeur,PlateauRes,ResMin),ResMin<Val,val is ResMin,PlateauApresCoup is PlateauRes.



minValue(Joueur,PlateauActuel,Profondeur,PlateauApresCoup,Res):-Joueur==1,minValue(2,PlateauActuel,Profondeur-1,PlateauApresCoup,-1000,Res).
minValue(Joueur,PlateauActuel,Profondeur,PlateauApresCoup,Res):-Joueur==2,minValue(1,PlateauActuel,Profondeur-1,PlateauApresCoup,-1000,Res).

minValue(Joueur,PlateauActuel,0,_,_,Res).
/*minValue(Joueur,PlateauActuel,0,PlateauActuel,_,Res):-evaluationJoueur(Joueur,PlateauActuel,Res).*/
/*minValue(Joueur,PlateauActuel,_,PlateauActuel,_,Res):-joueurGagnant(PlateauActuel,Joueur),evaluationJoueur(Joueur,PlateauActuel,Res).*/
minValue(Joueur,PlateauActuel,Profondeur,PlateauActuel,Val,Val):-Joueur==1,effectuerTousLesDeplacementsJoueur(2,PlateauActuel,X),member(M,X)./*, maxValue(2,M,Profondeur,_,ResMax),ResMax=<Val.*/
/*dans le cas on on peux choisir qui joue en premier*/
minValue(Joueur,PlateauActuel,Profondeur,PlateauApresCoup,Val,ResMax):-Joueur==1,effectuerTousLesDeplacementsJoueur(2,PlateauActuel,X),member(M,X)./*, maxValue(2,M,Profondeur,PlateauRes,ResMax),ResMax>Val,val is ResMax,PlateauApresCoup is PlateauRes.*/
minValue(Joueur,PlateauActuel,Profondeur,PlateauActuel,Val,Val):-Joueur==2,effectuerTousLesDeplacementsJoueur(1,PlateauActuel,X),member(M,X), maxValue(1,M,Profondeur,_,ResMax),ResMax=<Val.
minValue(Joueur,PlateauActuel,Profondeur,PlateauApresCoup,Val,ResMax):-Joueur==2,effectuerTousLesDeplacementsJoueur(1,PlateauActuel,X),member(M,X), maxValue(1,M,Profondeur,PlateauRes,ResMax),ResMax>Val,val is ResMax,PlateauApresCoup is PlateauRes.




/*en test ici pas fini*/
maxValue(Joueur,PlateauActuel,Profondeur,PlateauApresCoup,Val,Res):-effectuerTousLesDeplacementsJoueur(Joueur,PlateauActuel,X),minElement(Joueur,Profondeur,X,PlateauApresCoup,-1000,Res),.

maxElement(Joueur,0,[T|_],T,Val,Res):-evaluationJoueur(Joueur,T,Res).
maxElement(Joueur,_,[T|R],T,Val,Res):-joueurGagnant(T,Joueur),evaluationJoueur(Joueur,T,Res).
maxElement(Joueur,Profondeur,[T|R],Val,Res):--Joueur==1,effectuerTousLesDeplacementsJoueur(2,T,X2),minElement(2,Profondeur-1,X2,-1000,ResMin),getMeilleur(Val,ResMin,,PlateauFinalMin),


getMeilleur(A,B,PlateauA,PlateauB,ValRetour,PlateauRetour)

minElement(Joueur,0,[T[R]])
minElement(Joueur,Profondeur,[T|R],PlateauApresCoup,val,res):-minElement(Joueur,Profondeur,R,P1,val,res),Joueur==1,effectuerTousLesDeplacementsJoueur(2,T,X2),maxElement(Joueur,Profondeur-1,X2,PlateauApresCoup,1000,ResMax),ResMax=<val,



minElement(Joueur,Profondeur,[],PlateauApresCoup,val,res):-minElement(Joueur,Profondeur,[],PlateauApresCoup,val,res,0).
minElement(Joueur,Profondeur,[T|R],PlateauApresCoup,val,Res,Res):-evaluationJoueur(Joueur,T,Res2),Res2>=Res.
minElement(Joueur,Profondeur,[T|R],PlateauApresCoup,val,Res,Res2):-evaluationJoueur(Joueur,T,Res2),Res2<Res.

/*fin test*/
