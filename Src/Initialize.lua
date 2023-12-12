Util.Events.Hook("Util.Initialize", Util.Events.Hook("onPlayerJoin", Util.Players.Create))
Util.Events.Hook("Util.Initialize", Util.Events.Hook("onPlayerLeave", Util.Players.Destroy))
Util.Events.Hook("Util.Initialize", Util.Events.Hook("onCustomCommand", Util.Commands.Check))
Util.Events.Hook("Util.Initialize", Util.Events.Hook("onTick", Util.Timers.Update))
Util.Events.Hook("Util.Initialize", Util.Events.Hook("onGroupSpawn", Util.Vehicles.Spawn))
Util.Events.Hook("Util.Initialize", Util.Events.Hook("onPlayerLeave", Util.Players.Leave))

function Util.Initialize()
    print("Util.Initialize")
    Util.Events.Invoke("Util.Initialize", nil)

    for i = 1, #plugins do
        plugins[i]:create()
        server.announce(Util.Settings.name, "Loaded plugin: " .. plugins[i].name, -1)
    end

    local playerList = server.getPlayers()
    for i = 1, #playerList do
        local player = playerList[i]
        Util.Players.Create(player["steam_id"], player["name"], player["id"], player["admin"], player["auth"])
    end
    for steam_id, player in pairs(Util.Players.List) do
        print(player.name)
    end
end
