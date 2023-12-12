function Util.Commands.Check(full_message, user_peer_id, is_admin, is_auth, ...)
    local args = { ... }

    for name, command in pairs(Util.Commands.List) do
        for _, alias in pairs(command.aliases) do
            if args[1]:lower() == alias:lower() then --lower the arg and alias to make it not caps sensitive
                table.remove(args, 1)
                command.callback(full_message, user_peer_id, is_admin, is_auth, args)
                return
            end
        end
    end
end

function Util.Commands.Create(name, aliases, callback)
    Util.Commands.List[name] = {
        name = name,
        aliases = aliases,
        callback = callback
    }
end

function Util.Commands.Destroy(name)
    Util.Commands.List[name] = nil
end

Util.Commands.List = {}
