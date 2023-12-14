function Util.Vehicles.Create(group_id, peer_id, x, y, z, groupCost)
    local vehicle = {
        ownerID = peer_id,
        groupID = group_id,
        groupCost = groupCost,
        vehicleIDs = server.getVehicleGroup(group_id),

        --/ Management

        Destroy = function(self)
            self:Despawn()
            Util.Vehicles.List[self.groupID] = nil
        end,

        --/ Methods

        Reset = function(self)
            server.resetVehicleState(self.groupID)
        end,

        Despawn = function(self)
            server.despawnVehicle(self.groupID, true)
        end,

        SetTooltip = function(self, text)
            server.setVehicleTooltip(self.groupID, text)
        end,

        SetEditable = function(self, is_editable)
            server.setVehicleEditable(self.groupID, is_editable)
        end,

        SetInvulnerable = function(self, is_invulnerable)
            server.setVehicleInvulnerable(self.groupID, is_invulnerable)
        end,

        SetShowOnMap = function(self, show_on_map)
            server.setVehicleShowOnMap(self.groupID, show_on_map)
        end,
    }

    return vehicle
end

function Util.Vehicles.Spawn(group_id, peer_id, x, y, z, groupCost)
    local vehicle = Util.Vehicles.Create(group_id, peer_id, x, y, z, groupCost)
    local player = Util.Players.Get(peer_id)

    player:AddVehicle(vehicle)
    player:Notify("Vehicle Spawned", "Vehicle Spawned", 1)
end
