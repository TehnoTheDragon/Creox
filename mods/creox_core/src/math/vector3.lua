local Vector3 = class.extend("Vector3")
_G.Vector3 = Vector3

function Vector3.from_vector(v)
    return Vector3(v.x, v.y, v.z)
end

function Vector3:init(x, y, z)
    self._vector = vector.new(x, y, z)
end

function Vector3:pos()
    return self._vector
end

function Vector3:length()
    return vector.length(self:pos())
end

function Vector3:distance(v)
    return vector.distance(self:pos(), v:pos())
end

function Vector3:round()
    return Vector3.from_vector(vector.round(self:pos()))
end

function Vector3:floor()
    return Vector3.from_vector(vector.floor(self:pos()))
end

function Vector3:normalize()
    return Vector3.from_vector(vector.divide(self:pos(), self:length()))
end

function Vector3:angle(v)
    return vector.angle(self:pos(), v:pos())
end

function Vector3:dot(v)
    return vector.dot(self:pos(), v:pos())
end

function Vector3:cross(v)
    return Vector3.from_vector(vector.cross(self:pos(), v:pos()))
end

function Vector3:copy()
    return Vector3.from_vector(vector.copy(self:pos()))
end

function Vector3:__tostring()
    return ("XYZ: %.f, %.f, %.f"):format(self:pos().x, self:pos().y, self:pos().z)
end

function Vector3:__add(v)
    self._vector = vector.add(self:pos(), v:pos())
    return self
end

function Vector3:__sub(v)
    self._vector = vector.subtract(self:pos(), v:pos())
    return self
end

function Vector3:__mul(v)
    v = type(v) == "number" and v or v.pos == nil and v or v:pos()

    self._vector = vector.multiply(self:pos(), v)
    return self
end

function Vector3:__div(v)
    v = type(v) == "number" and v or v.pos == nil and v or v:pos()

    self._vector = vector.divide(self:pos(), v)
    return self
end