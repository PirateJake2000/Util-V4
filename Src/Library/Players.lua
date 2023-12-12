---@class UtilPlayer
---@field name string
---@field steamID integer recommended to convert to string
---@field peerID integer
---@field isAdmin boolean
---@field isAuth boolean
---@field vehicles table<integer, UtilVehicle>
---
---@field AddVehicle fun(self: self, vehicle: UtilVehicle)
---@field RemoveVehicle fun(self: self, vehicle: UtilVehicle
---@field GetVehicles fun(self: self): table<integer, UtilVehicle>
---@field Kill fun(self: self)
---@field Revive fun(self: self)
---@field SetData fun(self: self, hp: number, is_interactable: boolean, is_ai: boolean)
---@field Message fun(self: self, message: string)
---@field Notify fun(self: self, title: string, message: string, notificationType: SWNotifiationTypeEnum)
---@field GetPos fun(self: self): SWMatrix
---@field SetPos fun(self: self, newMatrix: SWMatrix)

---@param steam_id integer
---@param name string
---@param peer_id integer
---@param is_admin boolean
---@param is_auth boolean
---@return UtilPlayer
function Util.Players.Create(steam_id, name, peer_id, is_admin, is_auth)
    local player = {
        name = name,
        steamID = steam_id,
        peerID = peer_id,
        objectID = server.getPlayerCharacterID(peer_id),
        isAdmin = is_admin,
        isAuth = is_auth,
        vehicles = {},

        AddVehicle = function(self, vehicle)
            self.vehicles[vehicle.groupID] = vehicle
        end,

        RemoveVehicle = function(self, vehicle)
            self.vehicles[vehicle.groupID] = nil
        end,

        GetVehicles = function(self)
            return self.vehicles
        end,

        Kill = function(self)
            server.killCharacter(self.objectID)
        end,

        Revive = function(self)
            server.reviveCharacter(self.objectID)
        end,

        SetData = function(self, hp, is_interactable, is_ai)
            server.setCharacterData(self.objectID, hp, is_interactable, is_ai)
        end,

        Message = function(self, message)
            server.announce("[Server]", message, self.peerID)
        end,

        Notify = function(self, title, message, notificationType)
            server.notify(self.peerID, title, message, notificationType)
        end,

        GetPos = function(self)
            return server.getPlayerPos(self.peerID)
        end,

        SetPos = function(self, newMatrix)
            server.setPlayerPos(self.peerID, newMatrix)
        end,
    }

    Util.Players.List[steam_id] = player
    return player
end

---@return UtilPlayer
function Util.Players.Get(steam_id)
    return Util.Players.List[steam_id]
end

---@param steam_id integer
function Util.Players.Destroy(steam_id)
    Util.Players.List[steam_id] = nil
end

---@param peer_id integer
function Util.Players.getSteamID(peer_id)
    for steam_id, player in pairs(Util.Players.List) do
        if player.peerID == peer_id then
            return steam_id
        end
    end
end

---@param steamID integer
function Util.Players.getPeerID(steamID)
    for steam_id, player in pairs(Util.Players.List) do
        if steam_id == steamID then
            return player.peerID
        end
    end
end

---@param steam_id integer
---@param name string
---@param peer_id integer
---@param is_admin boolean
---@param is_auth boolean
function Util.Players.Leave(steam_id, name, peer_id, is_admin, is_auth)
    local player = Util.Players.Get(steam_id)

    for _, vehicle in pairs(player:GetVehicles()) do
        vehicle:Despawn()
    end

    Util.Players.Destroy(steam_id)
end

---@type table<integer, UtilPlayer>
Util.Players.List = {}
