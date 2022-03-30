local Formspec = creox.gui.Formspec
local Block = creox.world.block.Block
local BlockEntity = creox.world.block.BlockEntity

local Builder = creox.game.Builder.Block

local Blocks = {}
_G.creox.game.blocks = Blocks

--> Helpful
function Builder.create_tile_entity(block, _function)
    block:on_event("after_place_node", function (position, placer)
        _function(BlockEntity(position))
    end)
end

function Builder.create_right_click_event(block, _function)
    block:on_event("on_rightclick", _function)
end

function Builder.block_builder(name)
    local new_block = Block(name)
    
    local builder = {}

    function builder.texture(texture)
        new_block:set_texture(texture)
        return builder
    end

    function builder.build()
        builder = nil
        new_block:register()
        Blocks[name] = new_block
    end

    function builder.get()
        return new_block
    end

    builder.create_tile_entity = function (_function)
        Builder.create_tile_entity(new_block, _function)
        return builder
    end
    
    builder.create_right_click_event = function (_function)
        Builder.create_right_click_event(new_block, _function)
        return builder
    end

    minetest.register_alias(name, new_block:name())

    return builder
end

function Builder.build_grass_block(name, color)
    color = color or "#00AA00"
    Builder.block_builder(name).texture({
        "grass_top_mask.png^[multiply:".. color,
        "dirt.png",
        "dirt.png^(grass_mask.png^[multiply:".. color ..")",
        "dirt.png^(grass_mask.png^[multiply:".. color ..")",
        "dirt.png^(grass_mask.png^[multiply:".. color ..")",
        "dirt.png^(grass_mask.png^[multiply:".. color ..")"
    }).build()
end

function Builder.build_log_block(name, color)
    color = color or "#FFFFFF"
    local new_log = Builder.block_builder(name).texture({
        "wood_log_top.png^[multiply:".. color,
        "wood_log_top.png^[multiply:".. color,
        "wood_log_side.png^[multiply:".. color,
        "wood_log_side.png^[multiply:".. color,
        "wood_log_side.png^[multiply:".. color,
        "wood_log_side.png^[multiply:".. color
    })
    new_log.get():set_property("paramtype2", "facedir")
    new_log.get():set_property("legacy_facedir_simple", true)
    new_log.get():on_event("on_place", minetest.rotate_node)
    new_log.build()
end

function Builder.build_foliage_block(name, id, color)
    color = color or "#00AA00"
    Builder.block_builder(name).texture({
        "foliage_".. id ..".png^[multiply:".. color,
        "foliage_".. id ..".png^[multiply:".. color,
        "foliage_".. id ..".png^[multiply:".. color,
        "foliage_".. id ..".png^[multiply:".. color,
        "foliage_".. id ..".png^[multiply:".. color,
        "foliage_".. id ..".png^[multiply:".. color
    }).build()
end

function Builder.build_plant(name, texture, color)
    color = color or "#00AA00"
    local new_plant = Builder.block_builder(name)
    new_plant.texture({texture .."^[multiply:".. color})
    new_plant.get():set_property("walkable", false)
    new_plant.get():set_property("buildable_to", true)
    new_plant.get():set_property("paramtype", "light")
    new_plant.get():set_property("sunlight_propagates", true)
    new_plant.get():set_property("drawtype", "plantlike")
    new_plant.build()
end

function Builder.build_ore(name, ore_mask_id, color)
    color = color or "#FFFFFF"
    ore_mask_id = ore_mask_id or 1

    Builder.block_builder(name).texture({
        "stone.png^(ore_mask_".. ore_mask_id ..".png^[multiply:".. color ..")"
    }).build()
end