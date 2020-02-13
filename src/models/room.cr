class Room
    @exits = {} of String => RoomExit

    def initialize(@key : String, @title : String, @description : String)
    end

    def as_message()
        str = String.build do |str|
            str << "[#{@title}]<br />"
            str << "#{@description}<br />"
            str << "Exits: "
            @exits.each do |_,exit|
                str << exit.@to_room_label << " "
            end
        end
        str
    end
end