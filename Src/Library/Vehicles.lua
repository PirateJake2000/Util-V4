---@class UtilVehicle
---@field ownerID integer
---@field groupID integer
---@field groupCost number
---@field vehicleIDList table<integer, integer>
---
---@field Reset fun(self: self)
---@field Despawn fun(self: self)

---@param group_id integer
---@param peer_id integer
---@param x number
---@param y number
---@param z number
---@param groupCost number
---@return UtilVehicle
function Util.Vehicles.Create(group_id, peer_id, x, y, z, groupCost)
    local vehicle = {
        ownerID = peer_id,
        groupID = group_id,
        groupCost = groupCost,

        vehicleIDList = server.getVehicleGroup(group_id), -- note that you'll have to update this everytime a vehicle is spawned/despawned, otherwise you may have outdated vehicle ids here which is no bueno

        -- Methods
        Reset = function(self)
            for _, vehicle_id in pairs(self.vehicleIDList) do
                server.resetVehicleState(vehicle_id)
            end
        end,

        Despawn = function(self)
            server.despawnGroup(self.groupID, true)
        end,
    }

    Util.Vehicles.List[group_id] = vehicle
    return vehicle
end

---@param group_id integer
---@param peer_id integer
---@param x number
---@param y number
---@param z number
---@param groupCost number
---@return UtilVehicle
function Util.Vehicles.Spawn(group_id, peer_id, x, y, z, groupCost)
    print(group_id, peer_id, x, y, z, groupCost, group_id)
    local vehicle = Util.Vehicles.Create(group_id, peer_id, x, y, z, groupCost)
    local player = Util.Players.Get(Util.Players.getSteamID(peer_id))

    player:AddVehicle(vehicle)
    player:Notify("Vehicle Spawned", "Vehicle Spawned", 1)

    return vehicle
end

---@type table<integer, UtilVehicle>
Util.Vehicles.List = {}