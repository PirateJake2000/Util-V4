Util.Commands.Create("?ping", { "?ping", "?pong" }, function(full_message, user_peer_id, is_admin, is_auth, args)
    print("pong!")
end)

-- Reset vehicle if it exists
Util.Commands.Create("?reset", { "?reset", "?r" }, function(full_message, user_peer_id, is_admin, is_auth, args)
    Util.Players.Get(Util.Players.getSteamID(user_peer_id)):GetVehicle():Reset()
    print("reset vehicle")
end)

-- Example despawn command
Util.Commands.Create("?c", { "?c", "?clean", "?d", "?despawn" }, function(full_message, user_peer_id, is_admin, is_auth, args)
    Util.Players.Get(Util.Players.getSteamID(user_peer_id)):GetVehicle():Despawn()
end)