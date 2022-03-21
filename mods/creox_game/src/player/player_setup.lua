local Player = creox.player.Player

local nodes_over = {}

local function setup_node_helper(player)
    nodes_over[player:username()] = player:add_hud({
        hud_elem_type = "text",
        position = {x = 0.5, y = 0.5},
        offset = {x = 16, y = 10},
        text = "",
        number = 0xffffff,
        scale = {x = 1, y = 1},
        alignment = {x = 1, y = -1},
        z_index = 100,
    })
end

minetest.register_on_joinplayer(function(playerInstance, last_login)
    local username = playerInstance:get_player_name()
    local player = Player.get_by_username(username)

    player:set_physics_override({
        gravity = 1.02,
        speed = 1.1
    })

    setup_node_helper(player)
end)

minetest.register_globalstep(function(dtime)
    for _, playerInstance in pairs(minetest.get_connected_players()) do
        local player = Player.get_by_instance(playerInstance)
        local username = player:username()

        local node_over_label_id = nodes_over[username]
        if node_over_label_id then
            coroutine.wrap(function ()
                local direction = playerInstance:get_look_dir()*5
                local origin = playerInstance:get_pos()+vector.new(0, playerInstance:get_properties().eye_height, 0)
                local ray = Raycast(origin, origin+direction, false, false)
                
                local text = ""

                for pointed_thing in ray do
                    if pointed_thing then
                        local node = minetest.get_node(minetest.get_pointed_thing_position(pointed_thing, pointed_thing.above))
                        text = node.name
                        if text == "air" then
                            text = ""
                        else
                            break
                        end
                    end
                end

                player:update_hud(node_over_label_id, "text", text)
            end)()
        else
            setup_node_helper(player)
        end
    end
end)

minetest.register_on_leaveplayer(function(playerInstance, timed_out)
    nodes_over[playerInstance:get_player_name()] = nil
end)

creox.dofile("src/player/hotbar_gui.lua")
creox.dofile("src/player/inventory_gui.lua")