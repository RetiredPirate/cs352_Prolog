%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CS 352 - Prolog Project
%
% Name: PUT YOUR NAME HERE
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
divideIntoFours([A,B,C,D], [[A,B,C,D]]) :-
    compat(A,B),
    compat(A,C),
    compat(A,D),
    compat(B,C),
    compat(B,D),
    compat(C,D).
% divideIntoFours().



/******
 * basic choosing: chooses four compatible members from the given list
 *
 ******/


pickN(0, [], [], REST).
pickN(N, [VAL|REST1], [VAL|REST2], REST3) :-
    M is N,
    pickN(M, REST1, REST2).
pickN(N, [VAL|REST1], REST2, [VAL|REST3]) :-
    pickN(N, REST1, REST2).
pickN(N, [_|REST1], REST2, REST3) :- pickN(N, REST1, REST2, REST3).


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
