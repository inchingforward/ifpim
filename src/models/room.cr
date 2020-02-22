class Room
    @exits = {} of String => RoomExit
    @npcs = [] of NPC

    def initialize(@key : String, @title : String, @description : String)
    end

    def has_exit?(dir)
        return @exits.has_key?(dir)
    end

    def exit_room(dir)
        @exits[dir].@to_room_key
    end

    def as_message()
        str = String.build do |str|
            str << "[#{@title}]<br />"
            str << "#{@description}<br />"

            @npcs.each do |npc|
                presence = npc.presence
                if presence 
                    str << presence << "<br />"
                end
            end

            str << "Exits: "
            @exits.each do |_,exit|
                str << exit.@to_room_dir << " "
            end
        end
        str
    end
end