%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CS 352 - Prolog Project
%
% Name: Andrew Williams
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/******
 * basic assignment: divide into teams of four
 *
 * The implementation below is VERY complete. It works if
 * the original list contains a multiple of four names. In
 * every case, it checks for team compatibility.
 *
 * divideIntoFours(LIST, TEAMS) :- divideIntoRange(4, 4, LIST, TEAMS)
 ******/
divideIntoFours([],[]).
divideIntoFours([MEM|INPUT], [[MEM|PICKED]|REST2]) :-
    pickN(4, [MEM|INPUT], [MEM|PICKED], UNPICKED),
    teamCompat([MEM|PICKED]),
    divideIntoFours(UNPICKED, REST2).



/******
 * enhancement assignment: divide into teams of range
 *
 * The implementation below is VERY incomplete. It only works if
 * the original list contains zero or four names. In the case of four
 * names, it then checks for pairwise compatibility.
 *
 * divideIntoRange(LO, HI, INPUT, OUTPUT)
 ******/
divideIntoRange(_, _, [], []).
divideIntoRange(LO, HI, [MEM|INPUT], [[MEM|PICKED]|REST2]) :-
    between(LO, HI, N),
    pickN(N, [MEM|INPUT], [MEM|PICKED], UNPICKED),
    teamCompat([MEM|PICKED]),
    divideIntoRange(LO, HI, UNPICKED, REST2).



/******
 * test if team is compatible, any size:
 *
 * Parameters:
 *      [LIST]: List of team members
 *
 ******/
teamCompat([]).
teamCompat([MEM|REST]) :-
    memCompat(MEM, REST),
    teamCompat(REST).



/******
 * test if one memeber is compatible with a team:
 *
 * Parameters:
 *      [MEMBER, TEAM]: List of four team members
 *
 ******/
memCompat(_, []).
memCompat(MEM1, [MEM2|TEAM]) :-
    compatWith(MEM1, MEM2),
    compatWith(MEM2, MEM1),
    memCompat(MEM1, TEAM).


/******
 * test if one memeber is compatible with a team:
 *
 * Parameters:
 *      [MEMBER, TEAM]: List of four team members
 *
 ******/
teamFriendliness([]).


/******
 * basic picker: chooses N members from the given list
 *              and returns the rest in their own list.
 *
 *  Parameters:
 *      1: Number to pick from given list
 *      2: Given List
 *      3: Picked list
 *      4: Unpicked list
 *
 ******/
pickN(0, [], [], []).
pickN(N, [VAL|REST1], [VAL|REST2], REST3) :-
    M is N-1,
    pickN(M, REST1, REST2, REST3).
pickN(N, [VAL|REST1], REST2, [VAL|REST3]) :-
    pickN(N, REST1, REST2, REST3).



/******
 * enhancement: divide into groups of 3 or 4
 ******/
divideIntoThreesOrFours(LIST, RESULT) :- divideIntoRange(3, 4, LIST, RESULT).



/******
 * some tests
 ******/

% this one should succeed (assuming thresholdLimit(20) is still in force)
test1(RESULT) :-
    divideIntoFours([aaron,tim,alexa,dee], RESULT).

% this one should fail (assuming thresholdLimit(20))
test2(RESULT) :-
    divideIntoFours([bob,ike,june,karen], RESULT).

% this one should fail (assuming thresholdLimit(20))
test3(RESULT) :-
    groupOfSize(8,LIST), divideIntoFours(LIST, RESULT).

% this one should have something like 22 solutions (assuming ...)
test4(RESULT) :-
    groupOfSize(16,LIST), divideIntoFours(LIST, RESULT).

% Test the pickN function
test5(RESULT, UNPICKED) :-
    groupOfSize(20, LIST), pickN(4, LIST, RESULT, UNPICKED).

% teamCompat test
test6() :-
    groupOfSize(4, LIST), teamCompat(LIST).

% Redundancy Test
test7(RESULT) :-
    groupOfSize(16, LIST), divideIntoRange(4, 4, LIST, RESULT).
