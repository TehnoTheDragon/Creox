local Block = class.extend("Block")
creox.world.block.block = Block

function Block:init(registry_name)
    self._registry_name = ("%s:%s"):format(creox.mod_name(), registry_name:lower():gsub(" ", "_"))
    self._texture = {"NaN.png"}
    self._events = {}
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
    self.node = minetest.register_node(self._registry_name, {
        description = self._registry_name,
        tiles = self._texture,
    })
    self.identifier = minetest.get_content_id(self._registry_name)
end