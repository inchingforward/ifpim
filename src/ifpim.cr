require "kemal"

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

Kemal.run 8013
