%------------Rooms------------%
room(1).
room(2).
room(3).
room(4).
room(5).
room(6).
room(7).
room(8).
room(9).
room(10).
room(11).
room(12).
room(13).
room(14).
room(1).
room(15).
room(16).

%------------Doors--------------%
door(1,2).
door(1,7).
door(2,8).
door(3,8).
door(4,8).
door(4,9).
door(5,6).
door(5,9).
door(6,9).
door(7,8).
door(7,9).
door(7,10).
door(7,11).
door(7,12).
door(7,13).
door(7,14).
door(14,15).
door(15,16).

%------------Phones--------------%
phoneRinging(5).
phoneRinging(9).
phoneRinging(16).

%------------next_to procedure--------%
next_to(Room1, Room2) :- (door(Room1, Room2); door(Room2, Room1)).

%-----------path_to_phone procedure--------%

%-------Given start and destination--------%
path_to_phone(Start, End):-nonvar(Start), nonvar(End),
	phoneRinging(End),
		get_paths(Start, End),
			fail.

%-------Given Start only----------%
path_to_phone(Start, End):-nonvar(Start), var(End),
	forall(phoneRinging(E), (get_paths(Start, E))),
		fail.

%-------Given destination only-----%
path_to_phone(Start, End):-var(Start), nonvar(End),
	phoneRinging(End),
		forall(room(E), (get_paths(E, End))),
			fail.

%-------Given nothing--------%
path_to_phone(Start, End):-var(Start), var(End),
	forall(phoneRinging(PH), forall(room(Room), (get_paths(Room, PH)))),
		fail.

%------------get_paths----------%
% returns all paths

get_paths(Start, End):-nonvar(Start), nonvar(End),
	forall(find_path(Start, End, R), nL).

%-----------find_path-----------%
% finds one path

find_path(Start, Dest, T):-nonvar(Start), nonvar(Dest), var(T),
	T = [],
	move_forward(Start, Dest, T, R),
	move_backward(R, Route, []),
	write(Route).

%----------move_forward---------%
% Used when starting room and ending room are the same

move_forward(Start, Start, T, [Start|T]).

move_forward(Start, End, T, R):-
	next_to(Start, Next),
		\+(member(Next, T)),
			move_forward(Next, End, [Start|T], R).

%----------move_backward---------%
move_backward([], Z, Z).
move_backward([H|T], Z, Acc):-move_backward(T, Z, [H|Acc]).










