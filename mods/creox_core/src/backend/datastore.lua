local __DataStorages = {}
local __IDataStorages = {}

local function path(is_mod_path)
    local path = is_mod_path == true and creox.mod_path(creox.mod_name()) or creox.world_path()
    return is_mod_path == false and path .. "/creox/core/datastore/" or path .. "/datastore/"
end

if IE then
    minetest.mkdir(path(false))
end

local function save_key(name, key, is_mod_path)
    local PATH = path(is_mod_path)..name
    local file = io.open(PATH.."/cache.json", "r")
    local data = file:read("a")
    file:close()

    data = minetest.parse_json(data)
    data[key] = true

    file = io.open(PATH.."/cache.json", "w")
    file:write(minetest.write_json(data))
    file:close()
end

local function remove_key(name, key, is_mod_path)
    local PATH = path(is_mod_path)..name
    local file = io.open(PATH.."/cache.json", "r")
    local data = file:read("a")
    file:close()

    data = minetest.parse_json(data)
    data[key] = nil

    file = io.open(PATH.."/cache.json", "w")
    file:write(minetest.write_json(data))
    file:close()
end

local function set_async(name, key, data, is_mod_path)
    local PATH = path(is_mod_path)..name
    local file = io.open(PATH.."/"..key..".json", "w")
    file:write(minetest.write_json(data))
    file:close()

    if data == nil then
        remove_key(name, key, is_mod_path)
    else
        save_key(name, key, is_mod_path)
    end
end

local function get_async(name, key, is_mod_path)
    local PATH = path(is_mod_path)..name
    local file = io.open(PATH.."/"..key..".json", "r")
    local data = file:read("a")
    file:close()
    return minetest.parse_json(data)
end


local function get_keys(name, is_mod_path)
    local PATH = path(is_mod_path)..name
    local file = io.open(PATH.."/cache.json", "r")
    local data = file:read("a")
    file:close()

    data = minetest.parse_json(data)

    local keys = {}
    for key, value in pairs(data) do
        if value == true then
            table.insert(keys, key)
        end
    end
    return keys
end

local DataStore = class.extend("DataStore")
creox.backend.DataStore = DataStore

function DataStore.GetDataStore(name, save_in_mod)
    name = name:gsub(" ", "_")

    local datastore = __DataStorages[name]
    if not datastore then
        minetest.mkdir(path(save_in_mod)..name)

        local PATH = path(save_in_mod)..name
        local file = io.open(PATH.."/cache.json", "r")
        file:close()

        datastore = DataStore()
        datastore._save_in_mod = save_in_mod == true

        __DataStorages[name] = datastore
        __IDataStorages[datastore] = {
            set_async = function(...) set_async(name, ...) end,
            get_async = function(...) return get_async(name, ...) end,
            get_keys = function(...) return get_keys(name, ...) end,
        }
    end

    return datastore
end

function DataStore:init()
    
end

function DataStore:set(key, data)
    __IDataStorages[self].set_async(key, data, self._save_in_mod)
end

function DataStore:get(key)
    return __IDataStorages[self].get_async(key, self._save_in_mod)
end

function DataStore:get_keys()
    return __IDataStorages[self].get_keys(self._save_in_mod)
end