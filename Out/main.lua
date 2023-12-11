Util = {
	Events = {}
}

-- ./Src/Library/Events.lua
function Util.Events.Create(name) local self = {} self.name = name self.callbacks = {} function self:connect(callback) table.insert(self.callbacks, callback) end function self:disconnect(callback) for i, v in ipairs(self.callbacks) do if v == callback then table.remove(self.callbacks, i) end end end function self:fire(...) for i, v in ipairs(self.callbacks) do v(...) end end return self end 
-- ./Src/main.lua
function onCreate() print("hello world") for i = 1, 10 do print(i) end end onCreate() print("Created") 
