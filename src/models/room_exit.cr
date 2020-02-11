class RoomExit
    def initialize(@from_room_key : String, @to_room_key : String, @to_room_label : String)
    end

    def to_s(io)
        io << "#{@to_room_label}: #{@to_room_key}"
    end
end
