local plugin = {
    name = "Teleport Command",
    author = "PirateJake2000",
    description = "Adds a command to teleport.",
    settings = {},

    create = function()
        Util.Commands.Create("teleport", { "?tp" },
            function(full_message, user_peer_id, is_admin, is_auth, args)
                local player = Util.Players.Get(Util.Players.getSteamID(user_peer_id))
                local px, py, pz = matrix.position(player:GetPos())

                local x = (args[1])
                local y = (args[2])
                local z = (args[3])

                if (x == "~") then x = px end
                if (y == "~") then y = py end
                if (z == "~") then z = pz end

                player:Message("Teleporting...")
                player:SetPos(matrix.translation(x, y, z))
            end)
    end
}
