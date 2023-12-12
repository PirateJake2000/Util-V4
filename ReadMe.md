## Information

This is my 4th Lua framework for Stormworks build and rescue addons, mainly designed to run on servers and provide basic functionality for addons. It is also designed to be easy to use and understand, and to be easily expandable.

## Documentation (Files)

> [!NOTE]
> Header.lua can be used for any code that needs to be ran first, any code put in that file will get put at the top of the main output file, this is useful for things like global functions.

> [!NOTE]
> Main.lua is the main file, this is where you should put all of your code thats not in the Header or Footer files.

> [!NOTE]
> Footer.lua can be used for any code that needs to be ran last, any code put in that file will get put at the bottom of the main output file, this is useful for things like initialization code.

## Documentation (Framework)

Util V4 takes a OOP approach to addon Lua for example:

```lua
local player = Util.Players.Get(Util.Players.getSteamID(peerID)) -- Get the player object using the peerID
player:GetVehicle():Despawn() -- Despawn the players vehicle
```

## Building to a file

> I wrote a custom build script (build.js) this script will build the project to a single file, The script will also minify the code and remove any comments,
> [!important]
> Header and Footer files will not be minified but comments will still be removed. and Util will be renamed to "u"
