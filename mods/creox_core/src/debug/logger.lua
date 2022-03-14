local Logger = class.extend("Logger")
_G.creox.debug.logger = Logger

function Logger:init()

end

function Logger:log(...)
    local message = table.concat({...}, " ")
    minetest.log("[" .. creox.mod_name() .. "]" .. message)
end