local File = class.extend("File")
creox.util.File = File

function File:init(filepath)
    self.filepath = filepath
    self.file = nil
end

--[[function File:open(mode)
    mode = mode or "r"
    self.file = io.open(self.filepath, mode)
    if self.file == nil then
        creox.logger:log("File cannot be oppened: " .. self.filepath)
    end
end

function File:close()
    if self.file then
        io.close(self.file)
        self.file = nil
    end
end

function File:read()
    local content = nil
    if (self.file) then
        content = self.file:read("*all")
    end
    return content
end]]