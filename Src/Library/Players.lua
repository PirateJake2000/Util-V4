function Util.Players.Create(steam_id, name, peer_id, is_admin, is_auth)
    local player = {
        name = name,
        steamID = steam_id,
        peerID = peer_id,
        objectID = server.getPlayerCharacterID(peer_id),
        isAdmin = is_admin,
        isAuth = is_auth,
        vehicle = nil,

        -- / Management

        Destroy = function(self)
            if self.vehicle ~= nil then self.vehicle:Destroy() end

            Util.Players.List[self.peerID] = nil
        end,

        --/ Getters and Setters

        SetVehicle = function(self, vehicle)
            self.vehicle = vehicle
        end,

        GetVehicle = function(self)
            return self.vehicle
        end,

        --/ Methods

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
            server.announce(Util.Settings.name, message, self.peerID)
        end,

        Notify = function(self, title, message, notificationType)
            server.notify(self.peerID, title, message, notificationType)
        end,

        GetPos = function(self)
            local m, s = server.getPlayerPos(self.peerID)
            return m
        end,

        SetPos = function(self, newMatrix)
            server.setPlayerPos(self.peerID, newMatrix)
        end,
    }

    Util.Players.List[peer_id] = player
    return player
end

function Util.Players.Get(peer_id)
    return Util.Players.List[peer_id]
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
