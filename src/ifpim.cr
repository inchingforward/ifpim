require "kemal"
require "./models/*"
require "db"
require "pg"

rooms = {} of String => Room
socket_room = {} of HTTP::WebSocket => String

puts "Loading rooms..."

DB.connect "postgres://ifpim@localhost:5432/ifpim" do |cnn|
  cnn.query_each "select key, title, description from room" do |rs|
    key, title, desc = rs.read(String, String, String)
    rooms[key] = Room.new(key, title, desc)
  end

  cnn.query_each "select from_room_key, to_room_key, to_room_dir from room_exit" do |rs|
    from_room_key, to_room_key, dir = rs.read(String, String, String)
    rooms[from_room_key].@exits[dir] = RoomExit.new(from_room_key, to_room_key, dir)
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
      socket.send("Huh?")
    end
  end

  socket.on_close do
    puts "socket #{socket} closed"
    socket_room.delete(socket)
  end
end

puts "Listening..."

Kemal.run 8013
