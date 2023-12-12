Util.Commands.Create("?ping", { "?ping", "?pong" }, function(full_message, user_peer_id, is_admin, is_auth, args)
    print("pong!")
end)

-- Reset vehicle if it exists
Util.Commands.Create("?reset", { "?reset" }, function(full_message, user_peer_id, is_admin, is_auth, args)
    Util.Players.Get(Util.Players.getSteamID(user_peer_id)):GetVehicle():ResetVehicleState()
    print("reset vehicle")
end)
