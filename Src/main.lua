Util.Commands.Create("?ping", { "?ping", "?pong" }, function(full_message, user_peer_id, is_admin, is_auth, args)
    print("pong!")
end)

-- / Basic functions

function Util.onPlayerLeave(steam_id, name, peer_id, is_admin, is_auth)
    local player = Util.Players.Get(peer_id)
    player:Destroy()
end
