function Util.Events.Create(name)
    -- If Event already exists, return
    if Util.Events[name] then
        return
    end

    -- Create Event
    Util.Events[name] = {}

    print("Created Event: " .. name)
end

function Util.Events.Invoke(name, ...)
    -- If Event doesn't exist, create it
    if not Util.Events[name] then
        Util.Events.Create(name)
    end

    -- Invoke Events
    for _, callback in pairs(Util.Events[name]) do
        callback(...)
    end
end

function Util.Events.Hook(name, callback)
    -- If Event doesn't exist, create it
    if not Util.Events[name] then
        Util.Events.Create(name)
    end

    -- Hook Event
    table.insert(Util.Events[name], callback)
end

function Util.Events.Unhook(name, callback)
    -- If Event doesn't exist, return
    if not Util.Events[name] then
        return
    end

    -- Unhook Event
    for i, v in pairs(Util.Events[name]) do
        if v == callback then
            table.remove(Util.Events[name], i)
        end
    end
end

function Util.Events.Destroy(name)
    -- If Event doesn't exist, return
    if not Util.Events[name] then
        return
    end

    Util.Events[name] = nil
end
