# Project3-Prolog

### Quick Start
Download GNU Prolog
Download repository
Find 'traversal.pl' file
Enter:
  'path_to_phone(1,16).
  
### Table of Contents
  - Summary
  - API
  
#### Summary
For this project, we had to write a short program in Prolog that could tell us how to get from one room of a one-story building,
to any other room in that building, by telling us all of the rooms we must go through to get to the destination room. In addition,
there are phones ringing in one or more of the rooms. Our program should tell us how to get to those rooms. If we try to go to a room
in which the phone is not ringing, the program does not produce any output.

#### API

### Room(X)

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

#### This creates the 16 rooms in the prolog database

### door(X,Y)
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

#### This creates the doors in the prolog database. This shows which room is connected to room 7.

### phoneRinging(X)

phoneRinging(5).
phoneRinging(9).
phoneRinging(16).

phoneRinging(5).

#### phoneRinging will return 'yes' if a phone is ringing in that room.

### next_to(Room1,Room2)
next_to(Room1, Room2) :- (door(Room1, Room2); door(Room2, Room1)).

next_to(5,7).

#### next_to will return 'yes' if the rooms are next to each other. It uses door(X,Y) to determine this.

### path_to_phone(Start,End)
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
    
path_to_phone(1,16). 
path_to_phone(1,End).
path_to_phone(Start, 16).
path_to_phone(Start, End).

#### path_to_phone has four procedures, one where the start and destination are given, only start is given, only end is given, 
and one where nothing is ending.

### get_Paths(Start,End)
get_paths(Start, End):-nonvar(Start), nonvar(End),
	forall(find_path(Start, End, R), nL).
  
#### get_paths uses find_path to find all the paths available from Start to End.

### find_Path(Start, End, T)
find_path(Start, Dest, T):-nonvar(Start), nonvar(Dest), var(T),
	T = [],
	move_forward(Start, Dest, T, R),
	move_backward(R, Route, []),
	write(Route).
  
#### find_path uses move_forward and move_backward to find a path.

### move_forward(Start, Start, T, [Start|T]).

move_forward(Start, End, T, R):-
	next_to(Start, Next),
		\+(member(Next, T)),
			move_forward(Next, End, [Start|T], R).
      
#### move_forward will move forward if there is a room next to it that can be moved.

### move_backward([H|T],Z,Acc)
move_backward([], Z, Z).
move_backward([H|T], Z, Acc):-move_backward(T, Z, [H|Acc]).

#### move_backward reverses a room.

#### License
Auburn University

## Author 
Lauren Cravey
