function Util.Players.Create(steam_id, name, peer_id, is_admin, is_auth)
    local player = {
        steamID = steam_id,
        name = name,
        peerID = peer_id,
        isAdmin = is_admin,
        isAuth = is_auth,

        vehicle = {}
    }

    Util.Players[steam_id] = player
end

function Util.Players.Destroy(steam_id, name, peer_id, is_admin, is_auth)
    Util.Players[steam_id] = nil
end
