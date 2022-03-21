local Block = creox.world.block.Block

local Blocks = {}
_G.creox.game.blocks = Blocks

--> Helpful
local function block_builder(name)
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

    minetest.register_alias(name, new_block:name())

    return builder
end

local function build_grass_block(name, color)
    color = color or "#00AA00"
    block_builder(name).texture({
        "grass_top_mask.png^[multiply:".. color,
        "dirt.png",
        "dirt.png^(grass_mask.png^[multiply:".. color ..")",
        "dirt.png^(grass_mask.png^[multiply:".. color ..")",
        "dirt.png^(grass_mask.png^[multiply:".. color ..")",
        "dirt.png^(grass_mask.png^[multiply:".. color ..")"
    }).build()
end

local function build_log_block(name, color)
    color = color or "#FFFFFF"
    local new_log = block_builder(name).texture({
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

local function build_foliage_block(name, id, color)
    color = color or "#00AA00"
    block_builder(name).texture({
        "foliage_".. id ..".png^[multiply:".. color,
        "foliage_".. id ..".png^[multiply:".. color,
        "foliage_".. id ..".png^[multiply:".. color,
        "foliage_".. id ..".png^[multiply:".. color,
        "foliage_".. id ..".png^[multiply:".. color,
        "foliage_".. id ..".png^[multiply:".. color
    }).build()
end

local function build_plant(name, texture, color)
    color = color or "#00AA00"
    local new_plant = block_builder(name)
    new_plant.texture({texture .."^[multiply:".. color})
    new_plant.get():set_property("walkable", false)
    new_plant.get():set_property("buildable_to", true)
    new_plant.get():set_property("paramtype", "light")
    new_plant.get():set_property("sunlight_propagates", true)
    new_plant.get():set_property("drawtype", "plantlike")
    new_plant.build()
end

local function build_ore(name, ore_mask_id, color)
    color = color or "#FFFFFF"
    ore_mask_id = ore_mask_id or 1

    block_builder(name).texture({
        "stone.png^(ore_mask_".. ore_mask_id ..".png^[multiply:".. color ..")"
    }).build()
end

--> Blocks

block_builder("dirt").texture({"dirt.png"}).build()
block_builder("oak_wood_planks").texture({"wood_planks.png^[multiply:#BBCC00"}).build()

build_grass_block("snow_grass", "#FFFFFF")
build_grass_block("autumn_grass", "#FFB800")
build_grass_block("grass", "#00AA00")

build_log_block("oak_log", "#BBCC00")
build_foliage_block("oak_foliage", 1, "#00FC00")

block_builder("stone").texture({"stone.png"}).build()
block_builder("cobblestone").texture({"cobble_stone.png"}).build()
block_builder("mossy_cobblestone").texture({"cobble_stone.png^(moss_mask_1.png^[multiply:#00AA00)"}).build()

build_ore("coal_ore", 2, "#3c3c3c")
build_ore("emerald_ore", 3, "#00AB22")

build_plant("tall_grass", "tall_grass.png", "#00AA00")
build_plant("autumn_tall_grass", "tall_grass.png", "#FFB800")
build_plant("snow_tall_grass", "tall_grass.png", "#FFFFFF")