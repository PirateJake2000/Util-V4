function Util.Initialize()
    Util.Events.Invoke("Util.Initialize", nil)

    Util.Events.Hook("onTick", Util.Timers.Update)
    Util.Events.Hook("onPlayerJoin", Util.Players.Create)
    Util.Events.Hook("onGroupSpawn", Util.Vehicles.Spawn)
    Util.Events.Hook("onCustomCommand", Util.Commands.Check)
    Util.Events.Hook("onPlayerLeave", Util.onPlayerLeave)

    -- Load plugins
    for _, v in pairs(plugins) do
        v:create()
    end

    for _, v in pairs(server.getPlayers()) do
        Util.Players.Create(v["steam_id"], v["name"], v["id"], v["admin"], v["auth"])
    end

    -- Load Basic commands
    Util.Commands.Create("plugin List", { "?plugins" }, function(full_message, user_peer_id, is_admin, is_auth, args)
        for i = 1, #plugins do
            server.announce(Util.Settings.name, i .. ": " .. plugins[i].name, -1)
        end
    end)
end
