--> Global Creox Table
_G.creox = {}
local creox = _G.creox

--> Helpful methods
function creox.mod_name()
    return minetest.get_current_modname()
end

function creox.mod_path(mod_name)
    mod_name = mod_name == nil and creox.mod_name() or mod_name
    return minetest.get_modpath(mod_name)
end

function creox.world_path()
    return minetest.get_worldpath()
end

function creox.dofile(filepath)
    filepath = filepath:gsub("/", "\\")
    return dofile(creox.mod_path() .. "\\" .. filepath)
end

function creox.empty_function()
    return function() end
end

--> Get an insecure environment

local insecure_environment = minetest.request_insecure_environment()
if not insecure_environment then
    minetest.log("Some features of creox_core can be unavailable. add \"" .. creox.mod_name() .. "\" mod to secures.trusted_mods in the settings if you want that everything work properly")
end
IE = insecure_environment

--> Doings stuff with vendors

creox.dofile("vendors/class/class.lua")

--> Load Source

-- src/debug/...
creox.debug = {}
creox.dofile("src/debug/logger.lua")

creox.logger = creox.debug.Logger()

-- src/util/...
creox.util = {}
creox.dofile("src/util/file.lua")

-- src/world/...
creox.world = {}
creox.dofile("src/world/ore_generator.lua")
creox.dofile("src/world/schematic.lua")

-- src/world/block/...
creox.world.block = {}
creox.dofile("src/world/block/block.lua")
creox.dofile("src/world/block/block_entity.lua")

-- src/item/...
creox.item = {}
creox.dofile("src/item/item.lua")

-- src/world/player/...
creox.player = {}
creox.dofile("src/player/player.lua")

-- src/backend/...
creox.backend = {}
creox.dofile("src/backend/mod_storage.lua")
creox.dofile("src/backend/datastore.lua")
creox.dofile("src/backend/command_builder.lua")
creox.dofile("src/backend/privilege.lua")

-- src/math/...
creox.dofile("src/math/vector3.lua")

-- src/gui/...
creox.gui = {}
creox.dofile("src/gui/formspec.lua")

IE = nil
insecure_environment = nil