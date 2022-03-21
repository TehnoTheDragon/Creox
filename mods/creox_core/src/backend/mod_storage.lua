local ModStorage = class.extend("ModStorage")
creox.backend.ModStorage = ModStorage

function ModStorage:init()
    self.mod_storage = minetest.get_mod_storage()
end

function ModStorage:set(key, value)
    self.mod_storage:set_string(key, minetest.serialize(value))
end

function ModStorage:get(key)
    return minetest.deserialize(self.mod_storage:get_string(key))
end

function ModStorage:mark_private(key)
    self.mod_storage:mark_as_private(key)
end