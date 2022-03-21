local noise_0 = {
    offset = 0.25,
    scale = 1.0,
    spread = { x = 128, y = 128, z = 128 },
    seed = 65837953542,
    octaves = 1.0,
    persistence = 0.25,
    lacunarity = 1.0,
}

local noise_1 = {
    offset = 0.25,
    scale = 1.5,
    spread = { x = 160, y = 160, z = 160 },
    seed = 685768947594,
    octaves = 2.0,
    persistence = 0.5,
    lacunarity = 1.5,
}

local noise_2 = {
    offset = 0.5,
    scale = 2.0,
    spread = { x = 192, y = 192, z = 64 },
    seed = 685768947594,
    octaves = 4.0,
    persistence = 1.0,
    lacunarity = 2.0,
}

local function get_height(x, z)
    local base_terrain = 
        minetest.get_perlin(noise_0):get_2d({x = x, y = z}) *
        minetest.get_perlin(noise_1):get_2d({x = x, y = z}) -
        minetest.get_perlin(noise_2):get_2d({x = x, y = z})

    if base_terrain < 0 then
        base_terrain = base_terrain / 8
    else
        base_terrain = base_terrain / 4
    end

    return math.floor(base_terrain * 32)
end

local function get_cave(x, y, z)
    local cave_terrain = 
        minetest.get_perlin(noise_0):get_3d({x = x, y = y, z = z}) +
        minetest.get_perlin(noise_1):get_3d({x = x, y = y, z = z}) +
        minetest.get_perlin(noise_2):get_3d({x = x, y = y, z = z})

    return cave_terrain
end

local function generate(minp, maxp, seed)
    local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})

    --> Get Data
    local data = {}
    vm:get_data(data)

    --> Use Data
    for z = minp.z, maxp.z do
        for y = minp.y, maxp.y do
            for x = minp.x, maxp.x do
                if true then

                    local vi = area:index(x, y, z)

                    local main_height = get_height(x, z)

                    if y == main_height then
                        data[vi] = creox.game.blocks.grass:id()
                    elseif y < main_height then
                        if y > main_height - math.random(3, 5) then
                            data[vi] = creox.game.blocks.dirt:id()
                        else
                            data[vi] = creox.game.blocks.stone:id()
                        end
                    end

                end
            end
        end
    end

    --> Apply & Save Data
    vm:set_data(data)
    --minetest.generate_decorations(vm)
    --minetest.generate_ores(vm)
    --vm:update_liquids()
    vm:calc_lighting()
    vm:write_to_map(true)
    minetest.after(0, function ()
        minetest.fix_light(minp, maxp)
    end)
end

minetest.register_on_generated(function(...)
    generate(...)
end)