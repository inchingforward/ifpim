# An NPC is a character that can be interacted 
# with in ifpim.  The NPC class contains a 
# set of methods that all npcs should override, 
# returning an empty string if they do not support
# the functionality
class NPC
    # What is displayed when a player enters the 
    # room or looks in the room.  Examples:
    #  A small man is here.
    #  A robed wizard is here, reading a tome.
    #  A small man glances at you as you enter the room.
    # Return an empty string to avoid announcing presence.
    def presence
        return ""
    end

    # What the character responds with when looked at. Return
    # an empty string to ignore being looked at.
    def look
        return "You can't make out anything about them."
    end
    
    # Called when someone in the same room as the npc 
    # says *message*.
    def say(message : String)
        return ""
    end

    # Called when the game ticker ticks.  Use this 
    # to display random behaviors.  Return an empty
    # string for no behavior.
    def tick
        return ""
    end

    # Returns true if the npc matches some adjective.  For example, 
    # an old wizard might answer to "wizard", "mage", etc.  Used
    # when a player is looking at things in a room. 
    def answers_to(adjective : String)
        false
    end
end