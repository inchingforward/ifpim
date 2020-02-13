-- stubs a couple of rooms just to get things working initially
insert into room values (default, 'lobby', 'The Lobby', 'You are standing in the lobby.  It looks pretty boring.', default, default);
insert into room values (default, 'hall', 'The Hall', 'The hall is even more boring than the lobby.', default, default);

insert into room_exit values (default, 'lobby', 'hall', 'n');
insert into room_exit values (default, 'hall', 'lobby', 's');