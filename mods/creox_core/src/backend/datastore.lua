local ie = minetest.request_insecure_environment()
if not ie then
    minetest.log("DataStorage cannot work. Please add \"" .. creox.mod_name() .. "\" mod to secures.trusted_mods in the settings otherwise DataStore can not use sqlite3")
end

__DataStorages = {}

local DataStore = class.extend("DataStore")
creox.backend.DataStore = DataStore

function DataStore.GetDataStore(name)
    name = name:gsub(" ", "_")

    local datastore = __DataStorages[name]
    if not datastore then
        datastore = DataStore()
        __DataStorages[name] = datastore
    end
    return datastore
end

function DataStore:init()
    if ie then
        local _sql3 = ie.require("lsqlite3")
        minetest.log(minetest.serialize(_sql3))
        self.sqlite_storage = {}

        if sqlite3 then
            sqlite3 = nil
        end
    else
        self.sqlite_storage = minetest.get_mod_storage()
    end
end

function DataStore:set(key, value)
    self.sqlite_storage:set_string(key, minetest.serialize(value))
end

function DataStore:get(key)
    return minetest.deserialize(self.sqlite_storage:get_string(key))
end