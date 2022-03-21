local HudGroup = class.extend("HudGroup")
creox.gui.HudGroup = HudGroup

function HudGroup:init(player)
    self._player = player
    self._hud_objects = {}
end

function HudGroup:create_object(element_type)
    return creox.gui.HudObject(self._player, element_type)
end

function HudGroup:add(key, object)
    self._hud_objects[key] = object
    return self
end

function HudGroup:get(key)
    return self._hud_objects[key]
end

function HudGroup:update()
    for _, object in pairs(self._hud_objects) do
        object:update()
    end
    return self
end

function HudGroup:delete()
    for _, object in pairs(self._hud_objects) do
        object:delete()
    end
    return self
end