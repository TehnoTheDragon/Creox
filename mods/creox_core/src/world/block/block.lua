local Block = class.extend("Block")
creox.world.block.Block = Block

function Block:init(registry_name)
    self._registry_name = ("%s:%s"):format(creox.mod_name(), registry_name:lower():gsub(" ", "_"))
    self._texture = {"NaN.png"}
    
    self._events = {}
    self._properties = {}
end

function Block:set_property(key, value)
    self._properties[key] = value
end

function Block:set_texture(tile_textures)
    local tiles = {"NaN.png"}
    if (type(tiles) == "table") then
        tiles = tile_textures
    elseif (type(tiles) == "string") then
        tiles[1] = tile_textures
    else
        creox.logger:log("Block:set_texture(tile_textures), got unsupported type of tile_textures!")
    end
    self._texture = tiles
end

function Block:id()
    if self.identifier == nil then
        self.identifier = minetest.get_content_id(self._registry_name)
    end
    return self.identifier
end

function Block:name()
    return self._registry_name
end

function Block:__tostring()
    return self._registry_name
end

function Block:on_event(event_name, callback)
    self._events[event_name] = callback
end

function Block:register()
    local definition = {
        description = self._registry_name,
        tiles = self._texture,
    }

    for key, value in pairs(self._properties) do
        definition[key] = value
    end

    for key, value in pairs(self._events) do
        definition[key] = value
    end

    self.node = minetest.register_node(self._registry_name, definition)
    self.identifier = minetest.get_content_id(self._registry_name)
end