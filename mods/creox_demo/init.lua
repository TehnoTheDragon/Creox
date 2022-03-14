local Block = creox.world.block.block

local DemoBlock = Block("demo block")
DemoBlock:register()
local demo_block_id = DemoBlock:id()

minetest.register_on_generated(function (minp, maxp, seed)
    local vm, emin, emax = minetest.get_mapgen_object("voxelmanip")
    local area = VoxelArea:new({MinEdge = emin, MaxEdge = emax})

    --> Get Data
    local data = {}
    vm:get_data(data)

    --> Use Data
    for z = minp.z, maxp.z do
        for y = minp.y, maxp.y do
            for x = minp.x, maxp.x do
                local vi = area:index(x, y, z)

                if (y == minp.y) then
                    data[vi] = demo_block_id
                end
            end
        end
    end

    --> Apply & Save Data
    vm:set_data(data)
    minetest.generate_decorations(vm)
    minetest.generate_ores(vm)
    vm:update_liquids()
    vm:calc_lighting()
    vm:write_to_map(true)
    minetest.after(0, function ()
        minetest.fix_light(minp, maxp)
    end)
end)