local Logger = class.extend("Logger")
_G.creox.debug.Logger = Logger

function Logger:init()

end

function Logger:log(...)
    local args = {...}
    if #args > 0 then
        local message = table.concat(args, " ")
        minetest.log("[" .. creox.mod_name() .. "] " .. message)
    end
end