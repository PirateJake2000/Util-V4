function Util.Vehicles.Create(vehicle_id, peer_id, x, y, z, groupCost, group_id)
    local vehicle = {
        vehicleID = vehicle_id,
        ownerID = peer_id,
        groupID = group_id,
        groupCost = groupCost,

        groupIDList = server.getVehicleGroup(group_id),

        -- Methods
        ResetVehicleState = function(self)
            server.resetVehicleState(self.vehicleID)
            print("called resetVehicleState")
        end,

        getVehiclePos = function(self)
            return server.getVehiclePos(self.vehicleID)
        end,

        setVehiclePos = function(self, newMatrix)
            server.setVehiclePos(self.vehicleID, newMatrix)
        end,

        setVehiclePosSafe = function(self, newMatrix)
            server.setVehiclePosSafe(self.vehicleID, newMatrix)
        end,

        setGroupPos = function(self, newMatrix)
            server.setGroupPos(self.groupID, newMatrix)
        end,

        setGroupPosSafe = function(self, newMatrix)
            server.setGroupPosSafe(self.groupID, newMatrix)
        end,

        moveVehicle = function(self, newMatrix)
            server.moveVehicle(self.vehicleID, newMatrix)
        end,

        moveGroup = function(self, newMatrix)
            server.moveGroup(self.groupID, newMatrix)
        end,

        getVehicleData = function(self)
            return server.getVehicleData(self.vehicleID)
        end,

        getVehicleComponentData = function(self)
            return server.getVehicleComponents(self.vehicleID)
        end,
    }

    return vehicle
end

function Util.Vehicles.Spawn(vehicle_id, peer_id, x, y, z, groupCost, group_id)
    local vehicle = Util.Vehicles.Create(vehicle_id, peer_id, x, y, z, groupCost, group_id)

    local player = Util.Players.Get(Util.Players.getSteamID(peer_id))
    player:AddVehicle(vehicle)

    Util.Players.Get(Util.Players.getSteamID(peer_id)):Notify("Vehicle Spawned", "Vehicle Spawned", 1)
end
