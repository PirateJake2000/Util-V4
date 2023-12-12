-- Any code put in this file will be executed after any other file in the project. and not get minified (Comments get removed still).
Util.Events.Hook("onPlayerJoin", Util.Players.Create)
Util.Events.Hook("onPlayerLeave", Util.Players.Destroy)
Util.Events.Hook("onCustomCommand", Util.Commands.Check)
Util.Events.Hook("onTick", Util.Timers.Update)
Util.Events.Hook("onGroupSpawn", Util.Vehicles.Spawn)


local playerList = server.getPlayers()
for i = 1, #playerList do
    local player = playerList[i]
    Util.Players.Create(player["steam_id"], player["name"], player["id"], player["admin"], player["auth"])
end
for steam_id, player in pairs(Util.Players.List) do
    print(player.name)
end
