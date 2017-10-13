%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CS 352 - Prolog Project
%
% Name: Andrew Williams
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

/******
 * basic assignment: divide into teams of four
 *
 * The implementation below is VERY incomplete. It only works if
 * the original list contains zero or four names. In the case of four
 * names, it then checks for pairwise compatibility.
 ******/
divideIntoFours([],[]).
divideIntoFours(INPUT, [PICKED|REST2]) :-
    % teamCompat([A,B,C,D]),
    pickN(4, INPUT, PICKED, UNPICKED),
    % teamCompat(PICKED),
    divideIntoFours(UNPICKED, REST2).



/******
 * test if team is compatible:
 *
 * Parameters:
 *      [A,B,C,D]: List of four team members
 *
 ******/
teamCompat([A,B,C,D]) :-
    compatWith(A, B),
    compatWith(A, C),
    compatWith(A, D),
    compatWith(B, C),
    compatWith(B, D),
    compatWith(C, D).
% teamCompat(_, []).
% teamCompat(MEM1, [MEM2|TEAM]) :-
%     compatWith(MEM1, MEM2),
%     compatWith(MEM2, MEM1),
%     teamCompat(MEM1, TEAM).



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
    % teamCompat(VAL, REST2), %TODO: Fix this line
    pickN(M, REST1, REST2, REST3).
pickN(N, [VAL|REST1], REST2, [VAL|REST3]) :-
    pickN(N, REST1, REST2, REST3).




/******
 * get all pairs: gets pairs of list to check compatibility
 *
 ******/






/******
 * enhancement: divide into groups of 3 or 4
 ******/
% divideIntoThreesOrFours(LIST, RESULT) :-

/******
 * enhancement: divide into groups whose size is within a range
 ******/
% divideIntoRange(LOW, HIGH, LIST, RESULT) :-

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
    groupOfSize(20,LIST), divideIntoFours(LIST, RESULT).

% Test the pickN function
test5(RESULT, UNPICKED) :-
    groupOfSize(20, LIST), pickN(4, LIST, RESULT, UNPICKED).

% % Test teamCompat function
% test6() :-
%     teamCompat(aaron, []).
