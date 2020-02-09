# Notes

## Version 1

- A Player can only see the login page unless they have a session
- The login page contains a Guardian
- The Guardian prompts the Player for their name
- Rooms are defined by a table.
  - title
  - description
  - key
- Rooms are connected by Exits.
- Exits are defined by a table.
  - from_room_key
  - to_room_key
  - to_title: North|South|West|East|Up|Down
  - to_description
- Rooms are inhabited by npcs and players.
- Rooms respond to a tick command.
  - Room tick commands get forwarded to NPCs in the room.
- NPCs are object instances.
  - NPCs have their own class.
- NPCs have attributes defined by a table.
  - title
  - description
  - starting room
  - key
- NPCs have behaviors defined by their class.
- NPCs tables are tied to their class by a key.
  - NPCs are controllers.
- NPCs respond to ticks with random behaviors.

## Version X

- The Guardian prompts the Player for their name and secret
- The Player can only see the login page unless they have passed the Guardian

## Questions
