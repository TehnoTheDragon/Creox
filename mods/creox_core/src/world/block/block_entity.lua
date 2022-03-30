local BlockEntity = class.extend("BlockEntity")
creox.world.block.BlockEntity = BlockEntity

function BlockEntity:init(position)
    self._meta = minetest.get_meta(position)
end

function BlockEntity:meta()
    return self._meta
end

function BlockEntity:set(key, value)
    self._meta:set_string(key, minetest.serialize(value))
end

function BlockEntity:get(key)
    return minetest.deserialize(self._meta:get_string(key))
end