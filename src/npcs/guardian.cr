require "./*"

class Guardian < NPC
    @adjectives = Set{"knight", "guardian", "guard"}
    
    def presence
        return "An old knight is here."
    end

    def look
        "Despite his age and white hair, the guardian " \
        "towers over you.  Light armor covers his  " \
        "massive frame.  He stands before the hall, arms crossed, " \
        "eyeing you suspiciously."
    end

    def answers_to(adjective : String)
        return @adjectives.includes? adjective.downcase
    end

    def tick
        [
            "", "",
            "The guardian coughs.",
            "The guardian scratches his nose.",
            "The guardian scratches his head.",
            "The guardian eyes you."
        ].sample(1)[0]
    end
end