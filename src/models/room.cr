class Room
    @exits = {} of String => RoomExit

    def initialize(@key : String, @title : String, @description : String)
    end

    def to_s(io)
        io << "#{@key}: #{@title}, #{@description}, exits: #{@exits}"
    end
end