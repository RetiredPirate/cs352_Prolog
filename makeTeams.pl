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
 ******/
divideIntoFours(LIST, TEAMS) :- divideIntoRange(4, 4, LIST, TEAMS, 0).

%%%% Leaving the original implementation here in case it is needed.
% divideIntoFours([],[]).
% divideIntoFours([MEM|INPUT], [[MEM|PICKED]|REST2]) :-
%     pickN(4, [MEM|INPUT], [MEM|PICKED], UNPICKED),
%     teamCompat([MEM|PICKED]),
%     divideIntoFours(UNPICKED, REST2).




/******
 * test if team is compatible, any size, uses compatWith():
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
 * test if one memeber is compatible with a team, uses compatWith():
 * helper for teamCompat
 * Parameters:
 *      [MEMBER, TEAM]: One member and list of team members
 *
 ******/
memCompat(_, []).
memCompat(MEM1, [MEM2|TEAM]) :-
    compatWith(MEM1, MEM2),
    compatWith(MEM2, MEM1),
    memCompat(MEM1, TEAM).



/******
 * anhancement: get total team friendliness, uses likes():
 *
 * Parameters:
 *      [TARGET, TEAM]: target threshhold, List of team members
 *
 ******/
teamLikes([_], 0).
teamLikes([MEM|TEAM], SUM) :-
    memLikes(MEM, TEAM, N),
    teamLikes(TEAM, M),
    SUM is N + M.



/******
 * anhancement: get total team friendliness with single member, uses likes():
 * helper for teamLikes
 *
 * Parameters:
 *      [MEMBER, TEAM, SUM]: target threshhold, List of team members
 *
 ******/
memLikes(_, [], 0).
memLikes(MEM1, [MEM2|TEAM], SUM) :-
    likes(MEM1, MEM2, N),
    memLikes(MEM1, TEAM, M),
    SUM is N + M.



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
 * enhancement assignment: divide into teams of range
 *
 * divides the given list into teams with size in the range
 * specified by HI and LO.
 *
 * divideIntoRange(LO, HI, INPUT, OUTPUT, LEFTOVER)
 *
 * HI and LO define the inclusive range of the teams sizes
 * INPUT is the list of people to make teams from
 * OUTPUT is the list of compatible team lists
 * LEFTOVER is the number of people who may be unpicked.
 *
 * NOTE: for behavior without the last enhancement:
 *          run with LEFTOVER = 0.
 ******/
divideIntoRange(_, _, LIST, [], LEFTOVER) :-
    length(LIST, LEN),
    LEN =< LEFTOVER.
divideIntoRange(LO, HI, [MEM|INPUT], [[MEM|PICKED]|REST2], LEFTOVER) :-
    between(LO, HI, N),
    pickN(N, [MEM|INPUT], [MEM|PICKED], UNPICKED),
    teamCompat([MEM|PICKED]),
    divideIntoRange(LO, HI, UNPICKED, REST2, LEFTOVER).



/******
 * enhancement: divide into groups of 3 or 4
 *
 * simply use the divideIntoRange function
 ******/
divideIntoThreesOrFours(LIST, RESULT) :- divideIntoRange(3, 4, LIST, RESULT, 0).



/******
 * enhancement assignment: divide into teams of range with target
 *
 * Version of divideIntoRange that uses the total team friendliness
 * instead of the compatibility to decide if a team is valid
 *
 * divideIntoRange(TARGET, LO, HI, INPUT, OUTPUT)
 ******/
divideIntoRangeWithTarget(_, _, _, [], []).
divideIntoRangeWithTarget(TARGET, LO, HI, [MEM|INPUT], [[MEM|PICKED]|REST2]) :-
    between(LO, HI, N),
    pickN(N, [MEM|INPUT], [MEM|PICKED], UNPICKED),
    teamLikes([MEM|PICKED], LIKES),
    TARGET =< LIKES,
    divideIntoRangeWithTarget(TARGET, LO, HI, UNPICKED, REST2).



/******
 * enhancement: divide into groups 4 with target
 *
 * simply use the divideIntoRangeWithTarget function
 ******/
divideIntoFoursWithTarget(TARGET, LIST, TEAM) :-
    divideIntoRangeWithTarget(TARGET, 4, 4, LIST, TEAM).








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
    groupOfSize(17, LIST), divideIntoRange(4, 4, LIST, RESULT, 2).

% Target function Test
test8(RESULT) :-
    groupOfSize(10, LIST), divideIntoRangeWithTarget(150, 3, 5, LIST, RESULT).
