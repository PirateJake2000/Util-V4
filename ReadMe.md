![Util V4](https://github.com/PirateJake2000/Util-V4/assets/79664479/ada75f80-146d-4d2b-a633-21b38e2e6b7a)

## Information

> This is my 4th Lua framework for Stormworks build and rescue addons, mainly designed to run on servers and provide basic functionality for addons. It is also designed to be easy to use and understand, and to be easily expandable.

> Util V4 takes a OOP approach to addon Lua for example:

```lua
local player = Util.Players.Get(Util.Players.getSteamID(peerID)) -- Get the player object using the peerID
player:GetVehicle():Despawn() -- Despawn the players vehicle
```

## Documentation (Files)

> [!NOTE]
> Header.lua can be used for any code that needs to be ran first, any code put in that file will get put at the top of the main output file, this is useful for things like global functions.

> [!NOTE]
> Main.lua is the main file, this is where you should put all of your code thats not in the Header or Footer files.

> [!NOTE]
> Footer.lua can be used for any code that needs to be ran last, any code put in that file will get put at the bottom of the main output file, this is useful for things like initialization code.

## Documentation (Plugins)

> Plugins are how you can add to the Util framework, you can override existing functionality or add new functionality by hooking to a default stormworks callback.
> It may take some time to get used to the plugin system but once you get the hang of it you will be able to do some pretty cool stuff. without all the hassle of having to write your own librarys.

> [!NOTE]
> Plugins are a WIP feature and may not work as expected.

### Getting Started with plugins

> for your first plugin lets start by adding a teleport command, this command will take 3 arguments, X, Y, Z and will teleport the player to the specified location.

> start by creating a new **folder** in the plugins folder, name it "Teleport" or something similar.:
> then create a new file in the folder called "plugin.lua" this will be the main file for the plugin.
> you can now copy the following code into the file:

```lua
local plugin = {
    name = "name",
    author = "author",
    description = "A short description of your plugin.",
    settings = {}, -- You can add settings here (These will be exposed in the configurator), but it's not required.

    create = function()
        -- Your plugin's code goes here. you can hook into events or do whatever you want.
    end
}
```

> Feel free to change the name, author and description to whatever you want, these will **NOT** be displayed in the configurator.

> [!NOTE]
> Anything you put in the settings table will be exposed in the configurator, you can use this to allow users to change settings for your plugin instead of hardcoding all your variables.
> These can be accessed by doing `self.settings.<whatever you called it>`

> Something important to note is that the create function is where your actual code goes, this function is called when Util 4 is created (Bassically on creation of the world).

> Ok lets start by adding a command, this command will be called "teleport" and will take 3 arguments, X, Y, Z. for this we can use the `Util.Commands.Create` function.

```lua
local plugin = {
    name = "Teleport Command",
    author = "PirateJake2000",
    description = "Adds a command to teleport around the world.",
    settings = {},

    create = function()
        Util.Commands.Create("teleport", { "?tp" },
            function(full_message, user_peer_id, is_admin, is_auth, args)

            end)
    end
}
```

> The first argument is the name of the command, the second is a table of aliases, the third is the function that will be called when the command is ran. this will be covered in more detail later.

> Now lets get a reference to the player that ran the command, we can do this by using the `Util.Players.Get` function it is important we remeber that Players.Get takes a steamID while the command provides a peerID we can use `Util.Players.getSteamID` to get steamID from a PeerID.

```lua
local plugin = {
    name = "Teleport Command",
    author = "PirateJake2000",
    description = "Adds a command to teleport.",
    settings = {},

    create = function()
        Util.Commands.Create("teleport", { "?tp" },
            function(full_message, user_peer_id, is_admin, is_auth, args)
                local player = Util.Players.Get(Util.Players.getSteamID(user_peer_id))
            end)
    end
}
```

> Now that we have a reference to the player we can start the real work, Next lets get the arugments provided (x,y,z in this case)

```lua
local plugin = {
    name = "Teleport Command",
    author = "PirateJake2000",
    description = "Adds a command to teleport.",
    settings = {},

    create = function()
        Util.Commands.Create("teleport", { "?tp" },
            function(full_message, user_peer_id, is_admin, is_auth, args)
                local player = Util.Players.Get(Util.Players.getSteamID(user_peer_id))

                local x = (args[1])
                local y = (args[2])
                local z = (args[3])

            end)
    end
}
```

> Almost done! we just need to actually teleport the player, we can do this by using the `player:SetPos` method.

```lua
local plugin = {
    name = "Teleport Command",
    author = "PirateJake2000",
    description = "Adds a command to teleport.",
    settings = {},

    create = function()
        Util.Commands.Create("teleport", { "?tp" },
            function(full_message, user_peer_id, is_admin, is_auth, args)
                local player = Util.Players.Get(Util.Players.getSteamID(user_peer_id))

                local x = (args[1])
                local y = (args[2])
                local z = (args[3])

                player:SetPos(matrix.translation(x, y, z))
            end)
    end
}
```

> And thats it! you have now created your first plugin, you can now test it by running the game and typing `?tp 0 0 0` into the chat.

## Building to a file

> I wrote a custom build script (build.js) this script will build the project to a single file, The script will also minify the code and remove any comments,

> [!TIP]
> Header and Footer files will not be minified but comments will still be removed. and Util will be renamed to "u"

> The final built file will be located in the "Out" folder and if it can be found the build script will automatically update the Mission lua file for you.

> [!NOTE]
> Structure of the Out file:

```

> Credits
> Header
> Main
> Footer

```

```

```
