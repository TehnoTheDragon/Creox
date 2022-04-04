local Player = creox.player.Player

minetest.register_on_joinplayer(function(playerInstance, last_login)
    --local username = playerInstance:get_player_name()
    --local player = Player.get_by_username(playerInstance)
    
    playerInstance:hud_set_hotbar_image("hotbar_slots.png")
    playerInstance:hud_set_hotbar_selected_image("hotbar_selected_slot.png")
end)