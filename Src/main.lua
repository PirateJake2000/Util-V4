Util.Commands.Create("?ping", { "?ping", "?pong" }, function(full_message, user_peer_id, is_admin, is_auth, args)
    print("pong!")
end)
