local Schematic = class.extend("Schematic")
creox.world.Schematic = Schematic

function Schematic:init(x, y, z)
    self._capacity = x * y * z
    self._data = {}
    self._size = {x = x, y = y, z = z}
    self._yslice_prob = {}
end

function Schematic:get()
    return {
        size = self._size,
        yslice_prob = self._yslice_prob,
        data = self._data,
    }
end

function Schematic:fill(node_name, prob)
    for _ = 1, self._capacity do
        table.insert(self._data, {name = node_name, prob = prob})
    end
end

function Schematic:set(position, node_name, prob)
    local index = position.x + position.y * self._size.x + position.z * self._size.y
    self._data[index] = {name = node_name, prob = prob}
end