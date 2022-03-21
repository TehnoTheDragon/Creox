local Player = creox.player.Player

local Formspec = creox.gui.Formspec
local InventoryFormspec = Formspec()

local function set_slot(formspec, x, y, inventory, index)
    formspec:image(x, y, 1, 1, "item_slot.png")
    formspec:list("current_player", inventory, x, y, 1, 1, index)
end

local function build_inventory_formspec()
    InventoryFormspec:set_canvas_size(9.5, 8.5)
    InventoryFormspec:use_real_coordinates()
    InventoryFormspec:custom("bgcolor", "#00000000")
    InventoryFormspec:background9_texture(0, 0, 1, 1, "inventory_background.png", true)
    InventoryFormspec:custom("listcolors", {"#00000000"}, {"#00000000"})

    -- hotslots
    local i = 0
    for x = 1,8 do
        x = x * 1.05
        set_slot(InventoryFormspec, x-0.5, 7, "main", i)
        i = i + 1
    end
    
    -- backpack
    for y = 1,3 do
        y = y * 1.05
        for x = 1,8 do
            x = x * 1.05
            set_slot(InventoryFormspec, x-0.5, 6.7-y, "main", i)
            i = i + 1
        end
    end
    i = 0

    -- hand-craft
    for y = 1,2 do
        y = y * 1.05
        for x = 1,2 do
            x = x * 1.05
            set_slot(InventoryFormspec, x+5-0.25, y-0.5, "craft", i)
            i = i + 1
        end
    end
    set_slot(InventoryFormspec, 8-0.1, 1, "craftpreview", i)
    i = 0
end
build_inventory_formspec()

minetest.register_on_joinplayer(function(playerInstance, last_login)
    local username = playerInstance:get_player_name()
    local player = Player.get_by_username(username)

    player:set_inventory_gui(InventoryFormspec:get())
end)