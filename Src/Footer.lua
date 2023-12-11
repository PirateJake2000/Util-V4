-- Any code put in this file will be executed after any other file in the project. and not get minified (Comments get removed still).
Util.Events.Hook("onPlayerJoin", Util.Players.Create)
Util.Events.Hook("onPlayerLeave", Util.Players.Destroy)
Util.Events.Hook("onCustomCommand", Util.Commands.Check)
