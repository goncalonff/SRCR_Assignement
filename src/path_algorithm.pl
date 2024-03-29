% - Returns the next stop closer - %

check_closer_adjacencia(NEXT_STOP, CURRENT_STOP, PATH) :-
    prox_adjacencias(CURRENT_STOP, PATH, PROXS),
    sort_distance(CURRENT_STOP, PROXS, SORTED_BY_DISTANCE),
    member(NEXT_STOP, SORTED_BY_DISTANCE)
.


% -  - %
prox_adjacencias(CURRENT_STOP, PATH, PROXS) :-
    findall(TRY, adjacencia(TRY, CURRENT_STOP,_), ADJACENTES),
    remove_dups(ADJACENTES, NO_DUPS),
    remove_equal(PATH, NO_DUPS, PROXS)
.


%- sort_distance('183',['791','595','182'],R).
% - sorts a list o stops with a given stop - %

sort_distance(FST, LIST, SORTED) :-
    adjacentes_to_distanceKey(FST, LIST, PAIR_LIST),
    keysort(PAIR_LIST, SORTED_LIST),
    keys_and_values(SORTED_LIST, _, SORTED)
.



% - with stop FST and List of stops - %
% - makes list of (Distance to FST)-(stop) - %

adjacentes_to_distanceKey(_, [], []).
adjacentes_to_distanceKey(FST, [HL|TL], [PAIR|PAIR_LIST]) :-
    distance_key(FST, HL, PAIR),
    adjacentes_to_distanceKey(FST, TL, PAIR_LIST)
.



% - makes pair of (Distance to FST)-(stop) - %

distance_key(FST, Old, Dist - Old) :-
    distance(FST, Old, Dist)
.



%remove_equal(['003','004','005'],['002','003','007','005','005'],R).
remove_equal([],L,L).
remove_equal([H|T],L,R) :-
    remove_equal(T,L,RL),
    delete(RL,H,R)
.



% - R = arithmetic distance between A and B - %

distance(A,B,R) :-
    paragem(A,AX,AY,_,_,_,_,_,_,_,_),
    paragem(B,BX,BY,_,_,_,_,_,_,_,_),
    R is sqrt((BX - AX) ** 2 + (BY - AY) ** 2)
.
