_IsInited = false

local Player = class.extend("Player")
local Players = {}
creox.player.player = Player

function Player.get_by_username(username)
    local player = Players[username]
    if not player then
        for _, playerInstance in ipairs(minetest.get_connected_players()) do
            if playerInstance:get_player_name() == username then
                player = Player(playerInstance)
                Players[player:Username()] = player
                break
            end
        end
    end
    return player
end

function Player.get_by_instance(playerInstance)
    local player = Players[playerInstance:get_player_name()]
    if not player then
        player = Player(playerInstance)
        Players[player:Username()] = player
    end
    return player
end

function Player:init(playerInstance)
    self.instance = playerInstance
end

function Player:username()
    return self.instance:get_player_name()
end

function Player:hide_default_hud()
    local flags = self.instance:hud_get_flags()
	flags.healthbar = false
	flags.breathbar = false
	self.instance:hud_set_flags(flags)
end

function Player:show_default_hud()
    local flags = self.instance:hud_get_flags()
	flags.healthbar = true
	flags.breathbar = true
	self.instance:hud_set_flags(flags)
end

function Player:add_hud(hudProperties)
    return self.instance:hud_add(hudProperties)
end

function Player:update_hud(Id, parameterName, value)
    self.instance:hud_change(Id, parameterName, value)
end

function Player:remove_hud(Id)
    self.instance:hud_remove(Id)
end

function Player:set_inventory_gui(gui)
    self.instance:set_inventory_formspec(gui)
end

if not _IsInited then
    _IsInited = true

    minetest.register_on_joinplayer(function(playerInstance, last_login)
        local username = playerInstance:get_player_name()
        local player = Player(playerInstance)
        Players[username] = player
    end)

    minetest.register_on_leaveplayer(function(playerInstance, timed_out)
        local username = playerInstance:get_player_name()
        local player = Player.get_by_username(username)
        Players[username] = nil
    end)
end