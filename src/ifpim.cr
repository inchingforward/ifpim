require "kemal"
require "./models/*"
require "db"
require "pg"

# Render the given template file using the layout template.
macro layout_render(filename)
  render "src/views/#{{{filename}}}.ecr", "src/views/layout.ecr"
end

get "/" do
  layout_render "index"
end

ws "/ws" do |socket|
  socket.send "Connected...send a message"
  puts "socket: #{socket} connected"

  socket.on_message do |message|
    puts "socket #{socket} message: #{message}"
    socket.send(message.reverse)
  end

  socket.on_close do
    puts "socket #{socket} closed"
  end
end

rooms = {} of String => Room

DB.connect "postgres://ifpim@localhost:5432/ifpim" do |cnn|
  cnn.query_each "select key, title, description from room" do |rs|
    key, title, desc = rs.read(String, String, String)
    rooms[key] = Room.new(key, title, desc)
    puts "Read room key: #{key}, title: #{title}, desc: #{desc}"
  end

  cnn.query_each "select from_room_key, to_room_key, to_room_label from room_exit" do |rs|
    from_room_key, to_room_key, label = rs.read(String, String, String)
    puts "Read room exit from room: #{from_room_key}, to room: #{to_room_key}, label: #{label}"
    rooms[from_room_key].@exits[label] = RoomExit.new(from_room_key, to_room_key, label)
  end
end


rooms.each do |key, val|
  puts val
end

Kemal.run 8013
