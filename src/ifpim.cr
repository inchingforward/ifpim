require "kemal"
require "./models/*"
require "db"
require "dotenv"
require "pg"
require "./npcs/*"

rooms = {} of String => Room
socket_room = {} of HTTP::WebSocket => String

config = Dotenv.load

puts "Loading rooms..."

DB.connect config["DB"] do |cnn|
  cnn.query_each "select key, title, description from room" do |rs|
    key, title, desc = rs.read(String, String, String)
    rooms[key] = Room.new(key, title, desc)
  end

  cnn.query_each "select from_room_key, to_room_key, to_room_dir from room_exit" do |rs|
    from_room_key, to_room_key, dir = rs.read(String, String, String)
    rooms[from_room_key].@exits[dir] = RoomExit.new(from_room_key, to_room_key, dir)
  end
end

puts "Loading npcs..."

rooms["lobby"].@npcs << Guardian.new()

puts "Starting ticker..."
spawn do
  loop do
    sleep 2.minutes
    
    rooms.each do |room_key,room|
      room.@npcs.each do |npc|
        message = npc.tick
        if !message.empty?
          socket_room.each do |socket, curr_room_key|
            if room_key == curr_room_key
              socket.send message
            end
          end
        end
      end
    end
  end
end

# Render the given template file using the layout template.
macro layout_render(filename)
  render "src/views/#{{{filename}}}.ecr", "src/views/layout.ecr"
end

get "/" do
  layout_render "index"
end

ws "/ws" do |socket|
  puts "socket: #{socket} connected"

  socket_room[socket] = "lobby"
  socket.send(rooms[socket_room[socket]].as_message)
  
  socket.on_message do |message|
    puts "socket #{socket} message: #{message}"

    curr_room = rooms[socket_room[socket]]
    
    if ["look", "l"].includes?(message)
      socket.send(rooms[socket_room[socket]].as_message)
    elsif ["help", "h", "?"].includes?(message)
      socket.send("TODO: help")
    elsif ["exits", "exit", "ex"].includes?(message)
      socket.send("TODO: list exits")
    elsif curr_room.has_exit?(message)
      socket_room[socket] = curr_room.exit_room(message)
      socket.send(rooms[socket_room[socket]].as_message)
    else
      # Compound messages
      parts = message.split(" ")
      if parts.size > 1
        if ["look", "l"].includes? parts[0]
          # Looking at something in the room
          found = false
          curr_room.@npcs.each do |npc|
            if npc.answers_to parts[1]
              socket.send(npc.look)
              found = true
            end
          end

          if !found
            socket.send("You don't see that here.")
          end
        end
      else
        socket.send("Huh?")
      end
    end
  end

  socket.on_close do
    puts "socket #{socket} closed"
    socket_room.delete(socket)
  end
end

puts "Listening..."

Kemal.run 8013
