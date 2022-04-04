_G.creox.game = {
	Builder = { Block = {}, Item = {}, Entity = {} }
}

--> Block

creox.dofile("src/block/block_builders.lua")
creox.dofile("src/block/blocks.lua")

--> Item

creox.dofile("src/item/item_builders.lua")
creox.dofile("src/item/items.lua")

--> Player

creox.dofile("src/player/player_setup.lua")

--> Commands

creox.dofile("src/commands/commands.lua")

--> World Generation

minetest.register_alias("mapgen_stone", creox.game.blocks.stone:name())
minetest.register_alias("mapgen_dirt", creox.game.blocks.dirt:name())
minetest.register_alias("mapgen_dirt_with_grass", creox.game.blocks.grass:name())

minetest.register_biome({
	name = "creox_game:demo",
	node_top = creox.game.blocks.grass:name(),
	depth_top = 1,
	node_filler = creox.game.blocks.dirt:name(),
	depth_filler = 3,

	y_max = 31000,
	y_min = -31000,

	heat_point = 0,
	humidity_point = 0,

	vertical_blend = 4,
})

--> Ore Generation

local OreGenerator = creox.world.OreGenerator

minetest.register_ore(OreGenerator.builder()
.noise(OreGenerator.noise_parameter_builder()
	.offset(0)
	.scale(32)
	.spread(16, 16, 16)
	.seed(75683)
	.octaves(4)
	.persistence(0.0)
	.lacunarity(2.0)
	.types("eased")
	.build())
.ore("coal_ore")
.ore_type("vein")
.cluster_size(64)
.chance(1)
.height(-31000, 31000)
.target("stone")
.max_ore_size(4)
.noise_threshold(0.8)
.build())

--> Test

local Schematic = creox.world.Schematic
local TestSchematic = Schematic(5, 5, 5)
TestSchematic:fill("creox_game:gold_block", 255)

minetest.register_decoration({
	deco_type = "schematic",
	place_on = {"creox_game:grass"},
	sidelen = 16,
	fill_ratio = 0.1,
	biomes = {"creox_game:demo"},
	y_min = 1000,
	y_max = -1000,
	schematic = minetest.register_schematic(TestSchematic:get()),
	flags = "force_placement",
})

minetest.register_decoration({
    deco_type = "simple",
    place_on = {"creox_game:grass"},
    sidelen = 16,
    fill_ratio = 0.1,
    biomes = {"creox_game:demo"},
    y_max = 200,
    y_min = 0,
    decoration = "creox_game:tall_grass",
})