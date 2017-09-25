sum([], 0).
sum([EL|REST], X) :- sum(REST, Y), X is +(EL, Y).
