create table room (
    id bigserial primary key,
    key text unique not null,
    title text not null,
    description text not null,
    inserted_at timestamp with time zone not null default now(),
    updated_at timestamp with time zone not null default now()  
);

comment on table room is 'An ifpim room.';
comment on column room.key is 'A key used by other tables to refer to this room.';

create table room_exit (
    id bigserial primary key,
    from_room_key text not null references room(key),
    to_room_key text not null references room(key),
    to_room_label text not null
);

comment on table room_exit is 'Exits that connect a FROM room to a TO room.';
comment on column room_exit.from_room_key is 'The key for the room this exit shows in.';
comment on column room_exit.to_room_key is 'The key for the room this exit connects to.';
comment on column room_exit.to_room_label is 'What the player types to get to the TO room: usually n|s|w|e|u|d.';

create table npc (
    id bigserial primary key,
    key text unique not null,
    title text not null,
    description text not null,
    starting_room_key text not null references room(key),
    inserted_at timestamp with time zone not null default now(),
    updated_at timestamp with time zone not null default now()
);

comment on table npc is 'An ifpim Non-Player Character.';
comment on column npc.starting_room_key is 'The room this npc is put in on startup.';