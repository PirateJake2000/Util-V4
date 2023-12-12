---@param name string
function Util.Events.Create(name)
    -- If Event already exists, return
    if Util.Events.List[name] then
        return
    end

    -- Create Event
    Util.Events.List[name] = {}

    print("Created Event: " .. name)
end

---@param name string
---@param ... any
function Util.Events.Invoke(name, ...)
    -- If Event doesn't exist, create it
    if not Util.Events.List[name] then
        Util.Events.Create(name)
    end

    -- Invoke Events
    for _, callback in pairs(Util.Events.List[name]) do
        callback(...)
    end
end

---@param name string
---@param callback function
function Util.Events.Hook(name, callback)
    -- If Event doesn't exist, create it
    if not Util.Events.List[name] then
        Util.Events.Create(name)
    end

    -- Hook Event
    table.insert(Util.Events.List[name], callback)
end

---@param name string
---@param callback function
function Util.Events.Unhook(name, callback)
    -- If Event doesn't exist, return
    if not Util.Events.List[name] then
        return
    end

    -- Unhook Event
    for i, v in pairs(Util.Events.List[name]) do
        if v == callback then
            table.remove(Util.Events.List[name], i)
        end
    end
end

---@param name string
function Util.Events.Destroy(name)
    -- If Event doesn't exist, return
    if not Util.Events.List[name] then
        return
    end

    Util.Events.List[name] = nil
end

---@type table<string, table<integer, function>>
Util.Events.List = {}