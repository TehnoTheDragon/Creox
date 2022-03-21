local Item = creox.item.Item

local Items = {}
_G.creox.game.items = Items

--> Helpful
local function create_item(name)
    local new_item = Item(name)
    
    local builder = {}

    function builder.max_stack(value)
        new_item:set_max_stack(value)
        return builder
    end

    function builder.texture(texture)
        new_item:set_texture(texture)
        return builder
    end

    function builder.build()
        builder = nil
        new_item:register()
        Items[name] = new_item
    end

    minetest.register_alias(name, new_item:name())

    return builder
end

--> Items
create_item("wood_plank").texture("wood_plank.png").max_stack(16).build()
create_item("wood_stick").texture("wood_stick.png").max_stack(64).build()
create_item("processed_wood_stick").texture("processed_wood_stick.png").max_stack(64).build()
create_item("emerald").texture("faceted_jewelry_1.png").max_stack(16).build()