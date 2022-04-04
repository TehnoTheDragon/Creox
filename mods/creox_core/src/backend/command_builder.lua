local Player = creox.player.Player
local CommandBuilder = {}
creox.backend.CommandBuilder = CommandBuilder

function CommandBuilder.create(command_name)
    local builder = {}
    local _privileges = {}
    local _callback = nil

    function builder.set_callback(callback)
        _callback = function (name, params)
            local player = Player.get_by_username(name)
            local arguments = string.split(params, " ")
            
            local command_meta = {}

            function command_meta.is_sender_online()
                return player ~= nil
            end

            function command_meta.get_player()
                return player
            end

            function command_meta.get_full_parms()
                return params
            end

            function command_meta.get_arg(index)
                return arguments[index]
            end

            return true, callback(command_meta)
        end
        return builder
    end

    function builder.set_privileges(privileges)
        for _, name in pairs(privileges) do
            _privileges[name] = true
        end
        return builder
    end

    function builder.build()
        minetest.register_chatcommand(command_name, {
            privs = _privileges,
            func = _callback
        })
        builder = nil
        _privileges = nil
        _callback = nil
    end

    return builder
end