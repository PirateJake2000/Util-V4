---@class UtilCommand
---@field name string
---@field aliases table<integer, string>
---@field callback fun(full_message: string, user_peer_id: integer, is_admin: boolean, is_auth: boolean, args: table<integer, string>)

---@param full_message string
---@param user_peer_id integer
---@param is_admin boolean
---@param is_auth boolean
---@param ... string
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

---@param name string
---@param aliases table<integer, string>
---@param callback function
---@return UtilCommand
function Util.Commands.Create(name, aliases, callback)
    Util.Commands.List[name] = {
        name = name,
        aliases = aliases,
        callback = callback
    }

    return Util.Commands.List[name]
end

---@param name string
function Util.Commands.Destroy(name)
    Util.Commands.List[name] = nil
end

---@type table<string, UtilCommand>
Util.Commands.List = {}