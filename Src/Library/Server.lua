function Util.Server.Create()
    local server = {


        GetAddonIndex = function(name)
            return server.getAddonIndex(name)
        end
    }

    return server
end
