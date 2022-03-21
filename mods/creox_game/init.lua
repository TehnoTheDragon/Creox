_G.creox.game = {}

creox.dofile("src/block/blocks.lua")
creox.dofile("src/item/items.lua")

creox.dofile("src/player/player_setup.lua")

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