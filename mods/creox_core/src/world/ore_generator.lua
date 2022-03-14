local OreGenerator = {}
creox.world.ore_generator = OreGenerator

---wrapper of `minetest.register_ore(ore_definition)`
---@param params string ore definition
function OreGenerator.register_ore_generation(params)
    minetest.register_ore(params)
end

function OreGenerator.noise_parameter_builder()
    local builder = {}
    local params = {
        offset = 0.25,
		scale = 0.5,
		spread = { x = 64, y = 64, z = 64 },
		seed = 123456,
		octaves = 1.0,
		persistence = 0.0,
		lacunarity = 2.0,
    }

    ---Offset, It's like seed
    ---@param value number offset
    function builder.offset(value)
        params.offset = value
        return builder
    end

    ---Seed, It's like seed
    ---@param value number seed
    function builder.seed(value)
        params.seed = value
        return builder
    end

    ---Map Scaling
    ---@param value number scale
    function builder.scale(value)
        params.scale = value
        return builder
    end

    ---Map Spreading
    ---@param x number
    ---@param y number
    ---@param z number
    function builder.spread(x, y, z)
        params.spread = { x = x, y = y, z = z }
        return builder
    end

    ---Map Details
    ---@param value number octaves
    function builder.octaves(value)
        params.octaves = value
        return builder
    end

    ---Persistence, TODO: Add more details
    ---@param value number persistence
    function builder.persistence(value)
        params.persistence = value
        return builder
    end

    ---Lacunarity, TODO: Add more details
    ---@param value number lacunarity
    function builder.lacunarity(value)
        params.lacunarity = value
        return builder
    end

    ---Type of noise
    ---@param value string (defaults, eased, noeased, absvalue)
    function builder.types(value)
        params.lacunarity = value
        return builder
    end

    function builder.build()
        builder = nil
        return params
    end

    return builder
end

function OreGenerator.builder()
    local builder = {}
    local params = {
        ore_type = "scatter",
        ore = "air",
        wherein = {},

        clust_scarcity = 8 * 8 * 8,
        clust_num_ores = 9,
        clust_size = 3,

        y_min = -31000,
        y_max = 31000,

        noise_params = OreGenerator.noise_parameter_builder().build(),
        noise_threshold = 0.0,
    }

    --- What method we will use to spawn ore?
    --- -------------------------------------
	--- - Scatter: spread ores around
	--- - Sheet: TODO
    --- - Puff: TODO
    --- - Blob: TODO
    --- - Vein: TODO
    --- - Stratum: TODO
    ---@param value string
    function builder.ore_type(value)
        params.ore_type = value:lower()
        return builder
    end

    --- What block we will use as ore?
    --- ------------------------------
    --- If you left second argument empty, then your current mod name will used insted of
    ---@param value string registry name of block or just a name
    ---@param modname string optional
    function builder.ore(value, modname)
        modname = creox.mod_name()
        params.ore = ("%s:%s"):format(modname, value)
        return builder
    end

    --- Where we will put your ore?
    ---@param value string registry name of block or just a name
    ---@param modname string optional
    function builder.target(value, modname)
        modname = creox.mod_name()
        table.insert(params.wherein, ("%s:%s"):format(modname, value))
        return builder
    end

    --- Frequency & Chance
    ---@param value integer
    function builder.chance(value)
        params.clust_scarcity = value
        return builder
    end

    --- How many ores can be spawned in one cluster?
    ---@param value integer
    function builder.max_ore_size(value)
        params.clust_num_ores = value
        return builder
    end

    --- Cluster Size
    ---@param value integer
    function builder.cluster_size(value)
        params.clust_size = value
        return builder
    end

    --- What minimum & maximum height where can spawn your ore?
    ---@param minY integer (-31000, 31000)
    ---@param maxY integer (-31000, 31000)
    function builder.height(minY, maxY)
        if (minY > maxY) then
            creox.logger:log("[Ore Generator Builder]: minimum height should not be greater than maximum height!")
        end
        params.y_min = minY
        params.y_max = maxY
        return builder
    end

    --- Limit spawn (0 - no limit, 1 - disable spawn)
    ---@param value number
    function builder.noise_threshold(value)
        params.noise_threshold = value
        return builder
    end

    --- Table of noise parameters
    ---@param value table
    function builder.noise(value)
        params.noise_params = value
        return builder
    end

    function builder.build()
        builder = nil
        return params
    end

    return builder
end