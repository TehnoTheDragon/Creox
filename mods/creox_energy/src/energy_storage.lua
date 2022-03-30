local EnergyStorage = class.extend("EnergyStorage")
creox.energy.EnergyStorage = EnergyStorage

function EnergyStorage.from_meta(meta)
    local energyStorage = EnergyStorage()
    for index, value in ipairs(meta) do
        energyStorage[index] = value
    end
    return energyStorage
end

function EnergyStorage:init(maxCapacity, maxInput, maxOutput, energy)
    self._max_capacity = (maxCapacity or 0)
    self._max_input = (maxInput or 0)
    self._max_output = (maxOutput or 0)

    self._energy = (energy or 0)
end

function EnergyStorage:to_meta()
    return {
        _max_capacity = self._max_capacity,
        _max_input = self._max_input,
        _max_output = self._max_output,
        _energy = self._energy
    }
end

function EnergyStorage:fix()
    self._energy = self._energy > self._max_capacity and self._max_capacity or self._energy
end

function EnergyStorage:set_max_capacity(value)
    assert(value > 0, "Capacity cannot be nagative number!")
    self._max_capacity = value
    self:fix()
end

function EnergyStorage:set_max_input(value)
    assert(value > 0, "Max Input cannot be nagative number!")
    self._max_input = value
end

function EnergyStorage:set_max_output(value)
    assert(value > 0, "Max Output cannot be nagative number!")
    self._max_output = value
end

function EnergyStorage:set_energy(value)
    self._energy = value
    self:fix()
end

function EnergyStorage:update()
    --> TODO: Logic
end