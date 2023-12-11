-- Util v4 
-- Jake (PirateJake2000) 
-- https://github.com/PirateJake2000/Util-V4
-- Built: 11/12/2023, 03:10:07


function print(str)
    server.announce("[Debug]", str, -1)
end

local u = { Events = {} }

-- ./Src/Header.lua
function print(str) server.announce("[Debug]", str, -1) end 
-- ./Src/Library/Events.lua
function u.Events.Create(name) local self = {} self.name = name self.callbacks = {} function self:connect(callback) table.insert(self.callbacks, callback) end function self:disconnect(callback) for i, v in ipairs(self.callbacks) do if v == callback then table.remove(self.callbacks, i) end end end function self:fire(...) for i, v in ipairs(self.callbacks) do v(...) end end return self end 
-- ./Src/main.lua

