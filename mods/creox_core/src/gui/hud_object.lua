local HudObject = class.extend("HudObject")
creox.gui.HudObject = HudObject

function HudObject:init(player, element_type)
    self._player = player
    self._id = player:add_hud({
        hud_elem_type = element_type;
    })
    self._values = {}
end

function HudObject:set(key, value)
    self._values[key] = value
    return self
end

function HudObject:uset(key, value)
    self._values[key] = value
    self:update()
    return self
end

function HudObject:update()
    for key, value in pairs(self._values) do
        self._player:hud_change(self._id, key, value)
    end
    return self
end

function HudObject:delete()
    self._player:hud_remove(self._id)
end