function Util.Vehicles.Create(group_id, peer_id, x, y, z, groupCost)
    local vehicle = {
        ownerID = peer_id,
        groupID = group_id,
        groupCost = groupCost,

        groupIDList = server.getVehicleGroup(group_id),

        -- Methods
        Reset = function(self)
            server.resetVehicleState(self.groupID)
            print("called resetVehicleState")
        end,

        Despawn = function(self)
            server.despawnVehicle(self.groupID, true)
        end,
    }

    return vehicle
end

function Util.Vehicles.Spawn(group_id, peer_id, x, y, z, groupCost)
    print(group_id, peer_id, x, y, z, groupCost, group_id)
    local vehicle = Util.Vehicles.Create(group_id, peer_id, x, y, z, groupCost)
    local player = Util.Players.Get(Util.Players.getSteamID(peer_id))

    player:AddVehicle(vehicle)
    player:Notify("Vehicle Spawned", "Vehicle Spawned", 1)
end
