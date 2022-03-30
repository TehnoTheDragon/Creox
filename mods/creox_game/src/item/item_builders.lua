local Item = creox.item.Item

local Builder = creox.game.Builder.Item

local Items = {}
_G.creox.game.items = Items

--> Helpful
function Builder.create_item(name)
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