---@diagnostic disable: lowercase-global
-- Util v4 
-- Jake (PirateJake2000) 
-- https://github.com/PirateJake2000/Util-V4
-- Built: 11/12/2023, 22:10:47

function print(str)
    server.announce("[Debug]", str, -1)
end

local u = { Callbacks = {}, Commands = {}, Events = {}, Players = {} }

-- ./Src/Library/Callbacks.lua
function onTick(...) u.Events.Envoke("onTick", ...) end function onCreate(...) u.Events.Envoke("onCreate", ...) end function onDestroy(...) u.Events.Envoke("onDestroy", ...) end function onCustomCommand(...) u.Events.Envoke("onCustomCommand", ...) end function onChatMessage(...) u.Events.Envoke("onChatMessage", ...) end function onPlayerJoin(...) u.Events.Envoke("onPlayerJoin", ...) end function onPlayerSit(...) u.Events.Envoke("onPlayerSit", ...) end function onPlayerUnsit(...) u.Events.Envoke("onPlayerUnsit", ...) end function onCharacterSit(...) u.Events.Envoke("onCharacterSit", ...) end function onCharacterUnsit(...) u.Events.Envoke("onCharacterUnsit", ...) end function onCharacterPickup(...) u.Events.Envoke("onCharacterPickup", ...) end function onCreatureSit(...) u.Events.Envoke("onCreatureSit", ...) end function onCreatureUnsit(...) u.Events.Envoke("onCreatureUnsit", ...) end function onCreaturePickup(...) u.Events.Envoke("onCreaturePickup", ...) end function onEquipmentPickup(...) u.Events.Envoke("onEquipmentPickup", ...) end function onEquipmentDrop(...) u.Events.Envoke("onEquipmentDrop", ...) end function onPlayerRespawn(...) u.Events.Envoke("onPlayerRespawn", ...) end function onPlayerLeave(...) u.Events.Envoke("onPlayerLeave", ...) end function onToggleMap(...) u.Events.Envoke("onToggleMap", ...) end function onPlayerDie(...) u.Events.Envoke("onPlayerDie", ...) end function onGroupSpawn(...) u.Events.Envoke("onGroupSpawn", ...) end function onVehicleSpawn(...) u.Events.Envoke("onVehicleSpawn", ...) end function onVehicleDespawn(...) u.Events.Envoke("onVehicleDespawn", ...) end function onVehicleLoad(...) u.Events.Envoke("onVehicleLoad", ...) end function onVehicleUnload(...) u.Events.Envoke("onVehicleUnload", ...) end function onVehicleTeleport(...) u.Events.Envoke("onVehicleTeleport", ...) end function onObjectLoad(...) u.Events.Envoke("onObjectLoad", ...) end function onObjectUnload(...) u.Events.Envoke("onObjectUnload", ...) end function onButtonPress(...) u.Events.Envoke("onButtonPress", ...) end function onSpawnAddonComponent(...) u.Events.Envoke("onSpawnAddonComponent", ...) end function onVehicleDamaged(...) u.Events.Envoke("onVehicleDamaged", ...) end function httpReply(...) u.Events.Envoke("httpReply", ...) end function onFireExtinguished(...) u.Events.Envoke("onFireExtinguished", ...) end function onForestFireSpawned(...) u.Events.Envoke("onForestFireSpawned", ...) end function onForestFireExtinguished(...) u.Events.Envoke("onForestFireExtinguished", ...) end function onTornado(...) u.Events.Envoke("onTornado", ...) end function onMeteor(...) u.Events.Envoke("onMeteor", ...) end function onTsunami(...) u.Events.Envoke("onTsunami", ...) end function onWhirlpool(...) u.Events.Envoke("onWhirlpool", ...) end function onVolcano(...) u.Events.Envoke("onVolcano", ...) end function onOilSpill(...) u.Events.Envoke("onOilSpill", ...) end 
-- ./Src/Library/Commands.lua
function u.Commands.Check(full_message, user_peer_id, is_admin, is_auth, ...) local args = { ... } for name, command in pairs(u.Commands.List) do for _, alias in pairs(command.aliases) do if args[1] == alias then table.remove(args, 1) command.callback(full_message, user_peer_id, is_admin, is_auth, args) return end end end end function u.Commands.Create(name, aliases, callback) u.Commands.List[name] = { aliases = aliases, callback = callback } end function u.Commands.Destroy(name) u.Commands.List[name] = nil end u.Commands.List = {} 
-- ./Src/Library/Events.lua
function u.Events.Create(name) if u.Events[name] then return end u.Events[name] = {} print("Created Event: " .. name) end function u.Events.Envoke(name, ...) if not u.Events[name] then u.Events.Create(name) end for _, callback in pairs(u.Events[name]) do callback(...) end end function u.Events.Hook(name, callback) if not u.Events[name] then u.Events.Create(name) end table.insert(u.Events[name], callback) end function u.Events.Unhook(name, callback) if not u.Events[name] then return end for i, v in pairs(u.Events[name]) do if v == callback then table.remove(u.Events[name], i) end end end function u.Events.Destroy(name) if not u.Events[name] then return end u.Events[name] = nil end 
-- ./Src/Library/Players.lua
function u.Players.Create(steam_id, name, peer_id, is_admin, is_auth) local player = { steamID = steam_id, name = name, peerID = peer_id, isAdmin = is_admin, isAuth = is_auth, vehicle = {} } u.Players[steam_id] = player end function u.Players.Destroy(steam_id, name, peer_id, is_admin, is_auth) u.Players[steam_id] = nil end 
-- ./Src/main.lua
u.Commands.Create("?ping", { "?ping", "?pong" }, function(full_message, user_peer_id, is_admin, is_auth, args) print("pong!") end) 

u.Events.Hook("onPlayerJoin", u.Players.Create)
u.Events.Hook("onPlayerLeave", u.Players.Destroy)
u.Events.Hook("onCustomCommand", u.Commands.Check)
