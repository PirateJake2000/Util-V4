function Util.Players.Create(steam_id, name, peer_id, is_admin, is_auth)
    local player = {
        name = name,
        steamID = steam_id,
        peerID = peer_id,
        objectID = server.getPlayerCharacterID(peer_id),
        isAdmin = is_admin,
        isAuth = is_auth,
        vehicle = {},

        AddVehicle = function(self, vehicle)
            print("spawned vehicle")
            self.vehicle = vehicle
        end,

        RemoveVehicle = function(self)
            self.vehicle = {}
        end,

        GetVehicle = function(self)
            return self.vehicle
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
            return server.getPlayerCharacterPos(self.peerID)
        end,

        SetPos = function(self, newMatrix)
            server.setPlayerCharacterPos(self.peerID, newMatrix)
        end,
    }

    Util.Players.List[steam_id] = player
    return player
end

function Util.Players.Get(steam_id)
    return Util.Players.List[steam_id]
end

function Util.Players.Destroy(steam_id)
    Util.Players.List[steam_id] = nil
end

function Util.Players.getSteamID(peer_id)
    for steam_id, player in pairs(Util.Players.List) do
        if player.peerID == peer_id then
            return steam_id
        end
    end
end

function Util.Players.getPeerID(steamID)
    for steam_id, player in pairs(Util.Players.List) do
        if steam_id == steamID then
            return player.peerID
        end
    end
end

Util.Players.List = {}
