local Builder = creox.game.Builder.Block

Builder.block_builder("dirt").texture({"dirt.png"}).build()
Builder.block_builder("iron_block").texture({"metal_texture.png"}).build()
Builder.block_builder("gold_block").texture({"metal_texture.png^[multiply:#FFC900"}).build()
Builder.block_builder("oak_wood_planks").texture({"wood_planks.png^[multiply:#BBCC00"}).build()

Builder.build_grass_block("snow_grass", "#FFFFFF")
Builder.build_grass_block("autumn_grass", "#FFB800")
Builder.build_grass_block("grass", "#00AA00")

Builder.build_log_block("oak_log", "#BBCC00")
Builder.build_foliage_block("oak_foliage", 1, "#00FC00")

Builder.block_builder("stone").texture({"stone.png"}).build()
Builder.block_builder("cobblestone").texture({"cobble_stone.png"}).build()
Builder.block_builder("mossy_cobblestone").texture({"cobble_stone.png^(moss_mask_1.png^[multiply:#00AA00)"}).build()

Builder.build_ore("coal_ore", 2, "#3c3c3c")
Builder.build_ore("emerald_ore", 3, "#00AB22")

Builder.build_plant("tall_grass", "tall_grass.png", "#00AA00")
Builder.build_plant("autumn_tall_grass", "tall_grass.png", "#FFB800")
Builder.build_plant("snow_tall_grass", "tall_grass.png", "#FFFFFF")

Builder.block_builder("solar_panel").texture({
    "metal_texture.png^(solar_panel.png^[multiply:#0099F9)",
    "metal_texture.png",
    "metal_texture.png",
    "metal_texture.png",
    "metal_texture.png",
    "metal_texture.png"
}).build()