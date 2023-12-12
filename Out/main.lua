---@diagnostic disable: lowercase-global
-- Util v4 
-- Jake (PirateJake2000) 
-- https://github.com/PirateJake2000/Util-V4
-- Built: 12/12/2023, 01:18:22

function print(...)
    local out = ""

    for _, v in pairs({ ... }) do
        out = out .. tostring(v) .. " "
    end

    server.announce("[Debug]", out, -1)
end

function error(str)
    server.announce("[Error]", str, -1)
end

local u = { Callbacks = {}, Commands = {}, Events = {}, Players = {}, Timers = {}, Vehicles = {} }

-- ./Src/Library/Callbacks.lua
function onTick(...) u.Events.Envoke("onTick", ...) end function onCreate(...) u.Events.Envoke("onCreate", ...) end function onDestroy(...) u.Events.Envoke("onDestroy", ...) end function onCustomCommand(...) u.Events.Envoke("onCustomCommand", ...) end function onChatMessage(...) u.Events.Envoke("onChatMessage", ...) end function onPlayerJoin(...) u.Events.Envoke("onPlayerJoin", ...) end function onPlayerSit(...) u.Events.Envoke("onPlayerSit", ...) end function onPlayerUnsit(...) u.Events.Envoke("onPlayerUnsit", ...) end function onCharacterSit(...) u.Events.Envoke("onCharacterSit", ...) end function onCharacterUnsit(...) u.Events.Envoke("onCharacterUnsit", ...) end function onCharacterPickup(...) u.Events.Envoke("onCharacterPickup", ...) end function onCreatureSit(...) u.Events.Envoke("onCreatureSit", ...) end function onCreatureUnsit(...) u.Events.Envoke("onCreatureUnsit", ...) end function onCreaturePickup(...) u.Events.Envoke("onCreaturePickup", ...) end function onEquipmentPickup(...) u.Events.Envoke("onEquipmentPickup", ...) end function onEquipmentDrop(...) u.Events.Envoke("onEquipmentDrop", ...) end function onPlayerRespawn(...) u.Events.Envoke("onPlayerRespawn", ...) end function onPlayerLeave(...) u.Events.Envoke("onPlayerLeave", ...) end function onToggleMap(...) u.Events.Envoke("onToggleMap", ...) end function onPlayerDie(...) u.Events.Envoke("onPlayerDie", ...) end function onGroupSpawn(...) u.Events.Envoke("onGroupSpawn", ...) end function onVehicleSpawn(...) u.Events.Envoke("onVehicleSpawn", ...) end function onVehicleDespawn(...) u.Events.Envoke("onVehicleDespawn", ...) end function onVehicleLoad(...) u.Events.Envoke("onVehicleLoad", ...) end function onVehicleUnload(...) u.Events.Envoke("onVehicleUnload", ...) end function onVehicleTeleport(...) u.Events.Envoke("onVehicleTeleport", ...) end function onObjectLoad(...) u.Events.Envoke("onObjectLoad", ...) end function onObjectUnload(...) u.Events.Envoke("onObjectUnload", ...) end function onButtonPress(...) u.Events.Envoke("onButtonPress", ...) end function onSpawnAddonComponent(...) u.Events.Envoke("onSpawnAddonComponent", ...) end function onVehicleDamaged(...) u.Events.Envoke("onVehicleDamaged", ...) end function httpReply(...) u.Events.Envoke("httpReply", ...) end function onFireExtinguished(...) u.Events.Envoke("onFireExtinguished", ...) end function onForestFireSpawned(...) u.Events.Envoke("onForestFireSpawned", ...) end function onForestFireExtinguished(...) u.Events.Envoke("onForestFireExtinguished", ...) end function onTornado(...) u.Events.Envoke("onTornado", ...) end function onMeteor(...) u.Events.Envoke("onMeteor", ...) end function onTsunami(...) u.Events.Envoke("onTsunami", ...) end function onWhirlpool(...) u.Events.Envoke("onWhirlpool", ...) end function onVolcano(...) u.Events.Envoke("onVolcano", ...) end function onOilSpill(...) u.Events.Envoke("onOilSpill", ...) end 
-- ./Src/Library/Commands.lua
function u.Commands.Check(full_message, user_peer_id, is_admin, is_auth, ...) local args = { ... } for name, command in pairs(u.Commands.List) do for _, alias in pairs(command.aliases) do if args[1] == alias then table.remove(args, 1) command.callback(full_message, user_peer_id, is_admin, is_auth, args) return end end end end function u.Commands.Create(name, aliases, callback) u.Commands.List[name] = { aliases = aliases, callback = callback } end function u.Commands.Destroy(name) u.Commands.List[name] = nil end u.Commands.List = {} 
-- ./Src/Library/Events.lua
function u.Events.Create(name) if u.Events[name] then return end u.Events[name] = {} print("Created Event: " .. name) end function u.Events.Envoke(name, ...) if not u.Events[name] then u.Events.Create(name) end for _, callback in pairs(u.Events[name]) do callback(...) end end function u.Events.Hook(name, callback) if not u.Events[name] then u.Events.Create(name) end table.insert(u.Events[name], callback) end function u.Events.Unhook(name, callback) if not u.Events[name] then return end for i, v in pairs(u.Events[name]) do if v == callback then table.remove(u.Events[name], i) end end end function u.Events.Destroy(name) if not u.Events[name] then return end u.Events[name] = nil end 
-- ./Src/Library/Players.lua
function u.Players.Create(steam_id, name, peer_id, is_admin, is_auth) local player = { name = name, steamID = steam_id, peerID = peer_id, objectID = server.getPlayerCharacterID(peer_id), isAdmin = is_admin, isAuth = is_auth, vehicle = nil, AddVehicle = function(self, vehicle) print("spawned vehicle") self.vehicle = vehicle end, RemoveVehicle = function(self) self.vehicle = {} end, GetVehicle = function(self) return self.vehicle or error("Player does not have a vehicle") end, Kill = function(self) server.killCharacter(self.objectID) end, Revive = function(self) server.reviveCharacter(self.objectID) end, SetData = function(self, hp, is_interactable, is_ai) server.setCharacterData(self.objectID, hp, is_interactable, is_ai) end, Message = function(self, message) server.announce("[Server]", message, self.peerID) end, Notify = function(self, title, message, notificationType) server.notify(self.peerID, title, message, notificationType) end, GetPos = function(self) return server.getPlayerCharacterPos(self.peerID) end, SetPos = function(self, newMatrix) server.setPlayerCharacterPos(self.peerID, newMatrix) end, } u.Players.List[steam_id] = player return player end function u.Players.Get(steam_id) return u.Players.List[steam_id] or error("Player does not exist") end function u.Players.Destroy(steam_id) u.Players.List[steam_id] = nil end function u.Players.getSteamID(peer_id) for steam_id, player in pairs(u.Players.List) do if player.peerID == peer_id then return steam_id end end end function u.Players.getPeerID(steamID) for steam_id, player in pairs(u.Players.List) do if steam_id == steamID then return player.peerID end end end function u.Players.Leave(steam_id, name, peer_id, is_admin, is_auth) if u.Players.Get(steam_id):GetVehicle() ~= {} then u.Players.Get(steam_id):GetVehicle():DespawnGroup(true) end u.Players.Destroy(steam_id) end u.Players.List = {} 
-- ./Src/Library/Timers.lua
function u.Timers.Create(duration, callback) local timer = { duration = duration, callback = callback, time = 0 } table.insert(u.Timers.List, timer) end function u.Timers.Update() for i, timer in pairs(u.Timers.List) do timer.time = timer.time + 1 if timer.time >= timer.duration then timer.callback() table.remove(u.Timers.List, i) end end end u.Timers.List = {} 
-- ./Src/Library/Vehicles.lua
function u.Vehicles.Create(group_id, peer_id, x, y, z, groupCost) local vehicle = { ownerID = peer_id, groupID = group_id, groupCost = groupCost, groupIDList = server.getVehicleGroup(group_id), Reset = function(self) server.resetVehicleState(self.groupID) print("called resetVehicleState") end, Despawn = function(self) server.despawnVehicle(self.groupID, true) end, } return vehicle end function u.Vehicles.Spawn(group_id, peer_id, x, y, z, groupCost) print(group_id, peer_id, x, y, z, groupCost, group_id) local vehicle = u.Vehicles.Create(group_id, peer_id, x, y, z, groupCost) local player = u.Players.Get(u.Players.getSteamID(peer_id)) player:AddVehicle(vehicle) player:Notify("Vehicle Spawned", "Vehicle Spawned", 1) end 
-- ./Src/main.lua
u.Commands.Create("?ping", { "?ping", "?pong" }, function(full_message, user_peer_id, is_admin, is_auth, args) print("pong!") end) u.Commands.Create("?reset", { "?reset", "?r" }, function(full_message, user_peer_id, is_admin, is_auth, args) u.Players.Get(u.Players.getSteamID(user_peer_id)):GetVehicle():Reset() print("reset vehicle") end) u.Commands.Create("?c", { "?c", "?clean", "?d", "?despawn" }, function(full_message, user_peer_id, is_admin, is_auth, args) u.Players.Get(u.Players.getSteamID(user_peer_id)):GetVehicle():Despawn() end) 

u.Events.Hook("onPlayerJoin", u.Players.Create)
u.Events.Hook("onPlayerLeave", u.Players.Destroy)
u.Events.Hook("onCustomCommand", u.Commands.Check)
u.Events.Hook("onTick", u.Timers.Update)
u.Events.Hook("onGroupSpawn", u.Vehicles.Spawn)
u.Events.Hook("onPlayerLeave", u.Players.Leave)

local playerList = server.getPlayers()
for i = 1, #playerList do
    local player = playerList[i]
    u.Players.Create(player["steam_id"], player["name"], player["id"], player["admin"], player["auth"])
end
for steam_id, player in pairs(u.Players.List) do
    print(player.name)
end
