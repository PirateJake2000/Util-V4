---@diagnostic disable: lowercase-global


local uv4 = {
	Settings = {
		name = "[Server]",
	},
	Callbacks = {},
	Commands = {},
	Debug = {},
	Events = {},
	Players = {},
	Timers = {},
	Vehicles = {},
}


function onTick(...) uv4.Events.Invoke("onTick", ...) end

function onCreate(...) uv4.Events.Invoke("onCreate", ...) end

function onDestroy(...) uv4.Events.Invoke("onDestroy", ...) end

function onCustomCommand(...) uv4.Events.Invoke("onCustomCommand", ...) end

function onChatMessage(...) uv4.Events.Invoke("onChatMessage", ...) end

function onPlayerJoin(...) uv4.Events.Invoke("onPlayerJoin", ...) end

function onPlayerSit(...) uv4.Events.Invoke("onPlayerSit", ...) end

function onPlayerUnsit(...) uv4.Events.Invoke("onPlayerUnsit", ...) end

function onCharacterSit(...) uv4.Events.Invoke("onCharacterSit", ...) end

function onCharacterUnsit(...) uv4.Events.Invoke("onCharacterUnsit", ...) end

function onCharacterPickup(...) uv4.Events.Invoke("onCharacterPickup", ...) end

function onCreatureSit(...) uv4.Events.Invoke("onCreatureSit", ...) end

function onCreatureUnsit(...) uv4.Events.Invoke("onCreatureUnsit", ...) end

function onCreaturePickup(...) uv4.Events.Invoke("onCreaturePickup", ...) end

function onEquipmentPickup(...) uv4.Events.Invoke("onEquipmentPickup", ...) end

function onEquipmentDrop(...) uv4.Events.Invoke("onEquipmentDrop", ...) end

function onPlayerRespawn(...) uv4.Events.Invoke("onPlayerRespawn", ...) end

function onPlayerLeave(...) uv4.Events.Invoke("onPlayerLeave", ...) end

function onToggleMap(...) uv4.Events.Invoke("onToggleMap", ...) end

function onPlayerDie(...) uv4.Events.Invoke("onPlayerDie", ...) end

function onGroupSpawn(...) uv4.Events.Invoke("onGroupSpawn", ...) end

function onVehicleSpawn(...) uv4.Events.Invoke("onVehicleSpawn", ...) end

function onVehicleDespawn(...) uv4.Events.Invoke("onVehicleDespawn", ...) end

function onVehicleLoad(...) uv4.Events.Invoke("onVehicleLoad", ...) end

function onVehicleUnload(...) uv4.Events.Invoke("onVehicleUnload", ...) end

function onVehicleTeleport(...) uv4.Events.Invoke("onVehicleTeleport", ...) end

function onObjectLoad(...) uv4.Events.Invoke("onObjectLoad", ...) end

function onObjectUnload(...) uv4.Events.Invoke("onObjectUnload", ...) end

function onButtonPress(...) uv4.Events.Invoke("onButtonPress", ...) end

function onSpawnAddonComponent(...) uv4.Events.Invoke("onSpawnAddonComponent", ...) end

function onVehicleDamaged(...) uv4.Events.Invoke("onVehicleDamaged", ...) end

function httpReply(...) uv4.Events.Invoke("httpReply", ...) end

function onFireExtinguished(...) uv4.Events.Invoke("onFireExtinguished", ...) end

function onForestFireSpawned(...) uv4.Events.Invoke("onForestFireSpawned", ...) end

function onForestFireExtinguished(...) uv4.Events.Invoke("onForestFireExtinguished", ...) end

function onTornado(...) uv4.Events.Invoke("onTornado", ...) end

function onMeteor(...) uv4.Events.Invoke("onMeteor", ...) end

function onTsunami(...) uv4.Events.Invoke("onTsunami", ...) end

function onWhirlpool(...) uv4.Events.Invoke("onWhirlpool", ...) end

function onVolcano(...) uv4.Events.Invoke("onVolcano", ...) end

function onOilSpill(...) uv4.Events.Invoke("onOilSpill", ...) end

function uv4.Commands.Check(full_message, user_peer_id, is_admin, is_auth, ...)
	local args = { ... }
	for name, command in pairs(uv4.Commands.List) do for _, alias in pairs(command.aliases) do if args[1] == alias then
				table.remove(args, 1)
				command.callback(full_message, user_peer_id, is_admin, is_auth, args)
				return
			end end end
end

function uv4.Commands.Create(name, aliases, callback) uv4.Commands.List[name] = { aliases = aliases, callback = callback } end

function uv4.Commands.Destroy(name) uv4.Commands.List[name] = nil end

uv4.Commands.List = {}
function print(...)
	local out = ""
	for _, v in pairs({ ... }) do out = out .. tostring(v) .. " " end
	server.announce("[Debug]", out, -1)
end

function error(str) server.announce("[Error]", str, -1) end

function uv4.Events.Create(name)
	if uv4.Events[name] then return end
	uv4.Events[name] = {}
	print("Created Event: " .. name)
end

function uv4.Events.Invoke(name, ...)
	if not uv4.Events[name] then uv4.Events.Create(name) end
	for _, callback in pairs(uv4.Events[name]) do callback(...) end
end

function uv4.Events.Hook(name, callback)
	if not uv4.Events[name] then uv4.Events.Create(name) end
	table.insert(uv4.Events[name], callback)
end

function uv4.Events.Unhook(name, callback)
	if not uv4.Events[name] then return end
	for i, v in pairs(uv4.Events[name]) do if v == callback then table.remove(uv4.Events[name], i) end end
end

function uv4.Events.Destroy(name)
	if not uv4.Events[name] then return end
	uv4.Events[name] = nil
end

function uv4.Players.Create(steam_id, name, peer_id, is_admin, is_auth)
	local player = { name = name, steamID = steam_id, peerID = peer_id, objectID = server.getPlayerCharacterID(peer_id), isAdmin =
	is_admin, isAuth = is_auth, vehicle = nil, AddVehicle = function(self, vehicle)
		print("spawned vehicle")
		self.vehicle = vehicle
	end, RemoveVehicle = function(self) self.vehicle = {} end, GetVehicle = function(self) return self.vehicle or
		error("Player does not have a vehicle") end, Kill = function(self) server.killCharacter(self.objectID) end, Revive = function(
		self) server.reviveCharacter(self.objectID) end, SetData = function(self, hp, is_interactable, is_ai) server
			.setCharacterData(self.objectID, hp, is_interactable, is_ai) end, Message = function(self, message) server
			.announce("[Server]", message, self.peerID) end, Notify = function(self, title, message, notificationType)
		server.notify(self.peerID, title, message, notificationType) end, GetPos = function(self)
		local m, s = server.getPlayerPos(self.peerID)
		return m
	end, SetPos = function(self, newMatrix) server.setPlayerPos(self.peerID, newMatrix) end, }
	uv4.Players.List[steam_id] = player
	return player
end

function uv4.Players.Get(steam_id) return uv4.Players.List[steam_id] or error("Player does not exist") end

function uv4.Players.Destroy(steam_id) uv4.Players.List[steam_id] = nil end

function uv4.Players.getSteamID(peer_id) for steam_id, player in pairs(uv4.Players.List) do if player.peerID == peer_id then return
			steam_id end end end

function uv4.Players.getPeerID(steamID) for steam_id, player in pairs(uv4.Players.List) do if steam_id == steamID then return
			player.peerID end end end

function uv4.Players.Leave(steam_id, name, peer_id, is_admin, is_auth)
	if uv4.Players.Get(steam_id):GetVehicle() ~= {} then uv4.Players.Get(steam_id):GetVehicle():DespawnGroup(true) end
	uv4.Players.Destroy(steam_id)
end

uv4.Players.List = {}
function uv4.Timers.Create(duration, callback)
	local timer = { duration = duration, callback = callback, time = 0 }
	table.insert(uv4.Timers.List, timer)
end

function uv4.Timers.Update() for i, timer in pairs(uv4.Timers.List) do
		timer.time = timer.time + 1
		if timer.time >= timer.duration then
			timer.callback()
			table.remove(uv4.Timers.List, i)
		end
	end end

uv4.Timers.List = {}
function uv4.Vehicles.Create(group_id, peer_id, x, y, z, groupCost)
	local vehicle = { ownerID = peer_id, groupID = group_id, groupCost = groupCost, groupIDList = server.getVehicleGroup(
	group_id), Reset = function(self)
		server.resetVehicleState(self.groupID)
		print("called resetVehicleState")
	end, Despawn = function(self) server.despawnVehicle(self.groupID, true) end, }
	return vehicle
end

function uv4.Vehicles.Spawn(group_id, peer_id, x, y, z, groupCost)
	print(group_id, peer_id, x, y, z, groupCost, group_id)
	local vehicle = uv4.Vehicles.Create(group_id, peer_id, x, y, z, groupCost)
	local player = uv4.Players.Get(uv4.Players.getSteamID(peer_id))
	player:AddVehicle(vehicle)
	player:Notify("Vehicle Spawned", "Vehicle Spawned", 1)
end

local plugins = {
	{ name = "name",             author = "author",         description = "A short description of your plugin.", create = function() end },
	{ name = "Teleport Command", author = "PirateJake2000", description = "Adds a command to teleport.",         create = function()
		uv4.Commands.Create("teleport", { "?tp" },
			function(full_message, user_peer_id, is_admin, is_auth, args)
				local player = uv4.Players.Get(uv4.Players.getSteamID(user_peer_id))
				local px, py, pz = matrix.position(player:GetPos())
				local x = (args[1])
				local y = (args[2])
				local z = (args[3])
				if (x == "~") then x = px end
				if (y == "~") then y = py end
				if (z == "~") then z = pz end
				player:Message("Teleporting...")
				player:SetPos(matrix.translation(x, y, z))
			end) end },
}


uv4.Events.Hook("uv4.Initialize", uv4.Events.Hook("onPlayerJoin", uv4.Players.Create))
uv4.Events.Hook("uv4.Initialize", uv4.Events.Hook("onPlayerLeave", uv4.Players.Destroy))
uv4.Events.Hook("uv4.Initialize", uv4.Events.Hook("onCustomCommand", uv4.Commands.Check))
uv4.Events.Hook("uv4.Initialize", uv4.Events.Hook("onTick", uv4.Timers.Update))
uv4.Events.Hook("uv4.Initialize", uv4.Events.Hook("onGroupSpawn", uv4.Vehicles.Spawn))
uv4.Events.Hook("uv4.Initialize", uv4.Events.Hook("onPlayerLeave", uv4.Players.Leave))
function uv4.Initialize()
	print("uv4.Initialize")
	uv4.Events.Invoke("uv4.Initialize", nil)
	for i = 1, #plugins do
		plugins[i].create()
		server.announce(uv4.Settings.name, "Loaded plugin: " .. plugins[i].name, -1)
	end
	local playerList = server.getPlayers()
	for i = 1, #playerList do
		local player = playerList[i]
		uv4.Players.Create(player["steam_id"], player["name"], player["id"], player["admin"], player["auth"])
	end
	for steam_id, player in pairs(uv4.Players.List) do print(player.name) end
end

uv4.Commands.Create("?ping", { "?ping", "?pong" },
	function(full_message, user_peer_id, is_admin, is_auth, args) print("pong!") end)
uv4.Commands.Create("?reset", { "?reset", "?r" },
	function(full_message, user_peer_id, is_admin, is_auth, args)
		uv4.Players.Get(uv4.Players.getSteamID(user_peer_id)):GetVehicle():Reset()
		print("reset vehicle")
	end)
uv4.Commands.Create("?c", { "?c", "?clean", "?d", "?despawn" },
	function(full_message, user_peer_id, is_admin, is_auth, args) uv4.Players.Get(uv4.Players.getSteamID(user_peer_id))
			:GetVehicle():Despawn() end)


uv4.Initialize()
