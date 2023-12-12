local plugin = {
    name = "Custom name",
    author = "PirateJake2000",
    description = "Changes the name of the server.",
    settings = {
        name = "big red amongus"
    },

    create = function(self)
        Util.Settings.name = self.settings.name
    end
}
