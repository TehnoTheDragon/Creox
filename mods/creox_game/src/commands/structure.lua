local Privilege = creox.backend.Privilege
local CommandBuilder = creox.backend.CommandBuilder
local File = creox.util.File

local function get_position(command_meta, start_at)
    local x = tonumber(command_meta.get_arg(start_at+0))
    local y = tonumber(command_meta.get_arg(start_at+1))
    local z = tonumber(command_meta.get_arg(start_at+2))

    if (x == nil or y == nil or z == nil) then
        return nil
    end

    return vector.new(x, y, z)
end

local create
local list
local load

Privilege.create("creox_structure", "main command to create structures", true)

CommandBuilder.create("structure")
.set_privileges({"creox_structure"})
.set_callback(function (command_meta)
    local option = command_meta.get_arg(1) or "unknown"

    if option == "create" then
        return create(command_meta)
    elseif option == "list" then
        return list(command_meta)
    elseif option == "load" then
        return load(command_meta)
    end

    return [[use /structure <option(create, list, load)>]]
end)
.build()

create = function (command_meta)
    local position1 = get_position(command_meta, 2)
    local position2 = get_position(command_meta, 5)
    local structure_name = command_meta.get_arg(8)

    if not position1 then
        return "first position is not entered, example: /structure create 0 0 0 10 10 10 example"
    end

    if not position2 then
        return "second position is not entered, example: /structure create 0 0 0 10 10 10 example"
    end

    if not structure_name then
        return "name of structure is not entered, example: /structure create 0 0 0 10 10 10 example"
    end

    return ("structure with name: \"%s\" was saved"):format(structure_name)
end

list = function (command_meta)
    
end

load = function (command_meta)
    
end