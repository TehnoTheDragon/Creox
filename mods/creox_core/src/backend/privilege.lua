local Privilege = {}
creox.backend.Privilege = Privilege

function Privilege.create(name, description, isDefault)
    minetest.register_privilege(name, {description = description, give_to_singleplayer = isDefault == true})
end

function Privilege.check(player, privileges)
    local promise = {}
    local and_then = creox.empty_function()
    local fail = creox.empty_function()

    function promise.and_then(callback)
        and_then = callback
        return promise
    end

    function promise.fail(callback)
        return promise
    end

    function promise.check()
        local has, missing = minetest.check_player_privs(player, privileges)
        if has then
            and_then()
        else
            fail(missing)
        end
    end

    return promise
end