swap(left, right).
swap(right, left).
  
member(X, [X|_]).
member(X, [_|L]) :- member(X, L).

unsafe(state(FARMER, X, X, _)) :- swap(FARMER, X). /* The wolf eats the goat */
unsafe(state(FARMER, _, X, X)) :- swap(FARMER, X). /* The goat eats the cabbage */
                    
move(state(X, X, GOAT, CABBAGE), state(Y, Y, GOAT, CABBAGE)) :- swap(X, Y). /* FARMER and WOLF moved */
move(state(X, WOLF, X, CABBAGE), state(Y, WOLF, Y, CABBAGE)) :- swap(X, Y). /* FARMER and GOAT moved*/
move(state(X, WOLF, GOAT, X), state(Y, WOLF, GOAT, Y)) :- swap(X, Y). /* FARMER and CABBAGE moved*/
move(state(X, WOLF, GOAT, CABBAGE), state(Y, WOLF, GOAT, CABBAGE)) :- swap(X, Y). /* FARMER moved*/

path(GOAL_STATE, START_STATE, L, L1) :-
  move(GOAL_STATE, S1),
  not(unsafe(S1)),
  not(member(S1, L)),
  path(S1, START_STATE, [S1|L], L1), !.

path(START_STATE, START_STATE, T, T) :- !. /* The final state is reached */

write_move(state(X, W, G, C), state(Y, W, G, C)) :-
  !,
  write('The farmer crosses the river from '), write(X), write(' to '), write(Y), nl. 

write_move(state(X, X, G, C), state(Y, Y, G, C)) :- !,
  write('The farmer takes the Wolf from '), write(X), write(' of the river to '), write(Y), nl.
  
write_move(state(X, W, X, C), state(Y, W, Y, C)) :-!,
  write('The farmer takes the Goat from' ), write(X), write(' of the river to '), write(Y), nl.

write_move(state(X, W, G, X), state(Y, W, G, Y)) :- !,
  write('The farmer takes the cabbage from '), write(X), write(' of the river to '), write(Y), nl.

write_path([H1, H2|T]) :- !,
  write_move(H1, H2),
  write_path([H2|T]).

write_path(_).

go :- go(state(left, left, left, left), state(right, right, right, right)).

go(START_STATE, GOAL_STATE) :-
  path(GOAL_STATE, START_STATE, [GOAL_STATE], RESULT_MOVES),
  nl, write('A solution is:'), nl,
  write_path(RESULT_MOVES),
  fail.

go(_, _).

/*
1 ?- go.

A solution is:
The farmer takes the Goat fromleft of the river to right
The farmer crosses the river from right to left
The farmer takes the cabbage from left of the river to right
The farmer takes the Goat fromright of the river to left
The farmer takes the Wolf from left of the river to right
The farmer crosses the river from right to left
The farmer takes the Goat fromleft of the river to right
true.

2 ?- go(state(left, left, left, left), state(left, right, right, right)).

A solution is:
The farmer takes the Goat fromleft of the river to right
The farmer crosses the river from right to left
The farmer takes the cabbage from left of the river to right
The farmer takes the Goat fromright of the river to left
The farmer takes the Wolf from left of the river to right
The farmer crosses the river from right to left
The farmer takes the Goat fromleft of the river to right
The farmer crosses the river from right to left
true.


3 ?- go(state(left, left, left, right), state(right, right, right, right)).

A solution is:
The farmer takes the Wolf from left of the river to right
The farmer crosses the river from right to left
The farmer takes the Goat fromleft of the river to right
true.

4 ?- go(state(left, left, left, left), state(right, right, right, left)).

A solution is:
The farmer takes the Goat fromleft of the river to right
The farmer crosses the river from right to left
The farmer takes the Wolf from left of the river to right
true.

5 ?- go(state(left, left, right, left), state(right, right, right, right)).

A solution is:
The farmer takes the cabbage from left of the river to right
The farmer takes the Goat fromright of the river to left
The farmer takes the Wolf from left of the river to right
The farmer crosses the river from right to left
The farmer takes the Goat fromleft of the river to right
true.

*/


/*
 ___________________________________
|		|				|			|
|		|				|			|
|	h			d		|	c		|
|		|							|
|____  _|______  _______|____  _____|
|		|				|			|
|		|				|			|_______
|	f			e		|		b	 ___а___|
|		|							|
|__  ___|_____  ________|___________|
|		|			|	|
|	i	|		j	|	|
|					  g	|
|___  __|__  _______|___|
|		|		|
|	k		l	|
|_______|_______|
*/

door(a, b).
door(b, c).
door(b, e).
door(c, d).
door(e, d).
door(e, f).
door(e, j).
door(d, h).
door(f, i).
door(f, h).
door(j, g).
door(j, i).
door(j, l).
door(i, k).

windows(a, 0).
windows(b, 1).
windows(c, 1).
windows(d, 0).
windows(e, 0).
windows(f, 1).
windows(g, 0).
windows(h, 3).
windows(i, 1).
windows(j, 1).
windows(k, 2).
windows(l, 1).

reverse([],RES,RES).
reverse([H|T],RES, L):-reverse(T,RES,[H|L]).

getNextRoom(CURRENT_ROOM, MOVES, SKIPPED_ROOMS, RESULT):-(door(RESULT, CURRENT_ROOM);door(CURRENT_ROOM, RESULT)), RESULT \= a, not(member(RESULT, SKIPPED_ROOMS)), not(member(RESULT, MOVES)).

findPath(END_ROOM, END_ROOM, MOVES, _, _, RESULT):-reverse(MOVES, RESULT, []), !.

findPath(CURRENT_ROOM, END_ROOM, MOVES, SKIPPED_ROOMS, CONTINUE, RESULT):-getNextRoom(CURRENT_ROOM, MOVES, SKIPPED_ROOMS, NEXT_ROOM), findPath(NEXT_ROOM, END_ROOM, [NEXT_ROOM|MOVES], SKIPPED_ROOMS,CONTINUE, RESULT), (CONTINUE = true;CONTINUE = false,!).

%5.2 Напечатать список комнат, через которые лежит путь к комнате G, выбранный Прологом.
path2(START_ROOM, END_ROOM):-findPath(START_ROOM, END_ROOM, [], [], false, RESULT), write(RESULT), nl.

%5.3 При входе в комнату X печатать "entering room X".
writeMessage([]).
writeMessage([H|T]):-write('entering room '), write(H), nl, writeMessage(T).

path3(START_ROOM, END_ROOM):-findPath(START_ROOM, END_ROOM, [], [], false, RESULT), writeMessage(RESULT).

%5.4 Посчитать и напечатать количество комнат, через которые надо пройти к G.
path4(START_ROOM, END_ROOM):-findPath(START_ROOM, END_ROOM, [], [], false, RESULT), length(RESULT, SIZE), NUMBER_OF_ROOMS is SIZE - 1, write('Room count: '), write(NUMBER_OF_ROOMS), nl.

%5.5 Пройти к комнате L ,не входя в комнату E.
path5(START_ROOM, END_ROOM):-findPath(START_ROOM, END_ROOM, [], [e], false, RESULT), write(RESULT), nl.
 
%5.6 Найти и напечатать все возможные пути из комнаты А  в комнату L.
path6(START_ROOM, END_ROOM):-findPath(START_ROOM, END_ROOM, [], [], true, RESULT), write(RESULT), nl. 
 
%5.7 В некоторых комнатах есть окна. Например, в комнате H их целых три.  Надо посчитать количество окон в комнатах, через которые лежит путь  к комнате L.
findNumberOfWindows([], TOTAL):-write(TOTAL), !.
findNumberOfWindows([H|T], TOTAL):-windows(H, COUNT), NEW_TOTAL is TOTAL + COUNT, findNumberOfWindows(T, NEW_TOTAL).

getNumberOfWindows(ROOMS):-findNumberOfWindows(ROOMS, 0).
path7(START_ROOM, END_ROOM):-findPath(START_ROOM, END_ROOM, [], [], false, RESULT), write('Window count: '), getNumberOfWindows(RESULT), nl.



