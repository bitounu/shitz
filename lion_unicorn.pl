% author: Przemyslaw Kobylanski <przemko@pwr.wroc.pl>

day(monday).
day(tuesday).
day(wednesday).
day(thursday).
day(friday).
day(saturday).
day(sunday).

next(monday, tuesday).
next(tuesday, wednesday).
next(wednesday, thursday).
next(thursday, friday).
next(friday, saturday).
next(saturday, sunday).
next(sunday, monday).

resolve_day(D, D) :- var(D), !, day(D).
resolve_day(D, D) :- atom(D), !, day(D).
resolve_day(after(X), D) :- resolve_day(X, D1), next(D1, D).
resolve_day(before(X), D) :- resolve_day(X, D1), next(D, D1).

lies(lion, monday).
lies(lion, tuesday).
lies(lion, wednesday).
lies(unicorn, thursday).
lies(unicorn, friday).
lies(unicorn, saturday).

said(lion, X, Y) :- resolve_day(X, D), lies(lion, D), false(Y).
said(lion, X, Y) :- resolve_day(X, D), \+ lies(lion, D), true(Y).
said(unicorn, X, Y) :- resolve_day(X, D), lies(unicorn, D), false(Y).
said(unicorn, X, Y) :- resolve_day(X, D), \+ lies(unicorn, D), true(Y).

true(true).
true(lies(X, Y)) :- resolve_day(Y, D), lies(X, D).
true(not(X)) :- false(X).
true(and(X, Y)) :- true(X), true(Y).
true(or(X, Y)) :- true(X); true(Y).

false(false).
false(lies(lion, X)) :- resolve_day(X, D), \+ lies(lion, D).
false(lies(unicorn, X)) :- resolve_day(X, D), \+ lies(unicorn, D).
false(not(X)) :- true(X).
false(and(X, Y)) :- false(X); false(Y).
false(or(X, Y)) :- false(X), false(Y).

puzzle47(D) :-
	said(lion, D, lies(lion, before(D))),
	said(unicorn, D, lies(unicorn, before(D))).

puzzle48(D) :-
	said(lion, D, lies(lion, before(D))),
	said(lion, D, lies(lion, after(after(after(D))))).

puzzle49(D) :-
	said(lion, D, lies(lion, before(D))),
	said(lion, D, lies(lion, after(D))).

puzzle50(D) :-
	said(lion, D, and(lies(lion, before(D)), lies(lion, after(D)))).
