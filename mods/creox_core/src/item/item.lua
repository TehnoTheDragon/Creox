local Item = class.extend("Item")
creox.item.Item = Item

function Item:init(registry_name)
    self._registry_name = ("%s:%s"):format(creox.mod_name(), registry_name:lower():gsub(" ", "_"))
    self._max_stack = 64
    self._description = registry_name
    self._texture = "NaN.png"
    self._events = {}
end

function Item:set_max_stack(value)
    assert(value > 0, "Max Stack cannot be less than 1")
    self._max_stack = value
end

function Item:set_texture(texture)
    local _texture = "NaN.png"
    if type(texture) == "string" then
        _texture = texture
    else
        creox.logger:log("Item:set_texture(tile_textures), got unsupported type of tile_textures!")
    end
    self._texture = _texture
end

function Item:id()
    if self.identifier == nil then
        self.identifier = minetest.registered_items[self._registry_name]
    end
    return self.identifier
end

function Item:name()
    return self._registry_name
end

function Item:__tostring()
    return self._registry_name
end

function Item:on_event(event_name, callback)
    self._events[event_name] = callback
end

function Item:register()
    self.instance = minetest.register_craftitem(self._registry_name, {
        description = self._description,
        inventory_image = self._texture,
        stack_max = self._max_stack,

        --wield_scale = {x=2,y=2,z=1}
    })
    self.identifier = minetest.registered_items[self._registry_name]
end