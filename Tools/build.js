const fs = require("fs");
const os = require("os");
const config = require("../Config.json");

function processFile(file) {
	let data = fs.readFileSync(file, "utf8");

	if (config.build_removeComments) {
		data = data.replace(/--.*/g, "");
		data = data.replace(/--\[\[([\s\S]*?)\]\]/g, "");
	}

	if (config.build_removeEmptyLines) {
		data = data.replace(/^\s*[\r\n]/gm, "");
	}

	if (config.build_removeEmptySpaces) {
		data = data.replace(/\s+/g, " ");
	}

	return data;
}

function copyToMission() {
	const username = os.userInfo().username;
	const path = `C:/Users/${username}/AppData/Roaming/Stormworks/data/missions/Util v4`;

	if (!fs.existsSync(path)) {
		console.log(`Mission folder not found at ${path}`);
		return;
	}

	fs.copyFileSync("./Out/main.lua", `${path}/script.lua`);

	console.log(`Copied to ${path}`);
}

function build() {
	let files = fs.readdirSync("./src/Library");

	let output = "";

	output += "---@diagnostic disable: lowercase-global\n";

	let util = `local Util = {
		Settings = {
			name = "${config.serverName}",
		},`;

	files.forEach((file) => {
		if (file.endsWith(".lua")) {
			util += `\n\t${file.slice(0, -4)} = {},`;
		}
	});

	output += "\n\n" + util + "\n}\n\n\n";

	for (let i = 0; i < files.length; i++) {
		file = processFile(`./src/Library/${files[i]}`);

		output += file + "\n";
	}

	output += "\n\n";

	// Load plugins
	let plugins = fs.readdirSync("./src/Plugins");
	let pluginString = "local plugins = {\n";

	for (let i = 0; i < plugins.length; i++) {
		let plugin = plugins[i];
		console.log(`Loading plugin ${plugin}`);

		// for each file inside the plugin folder
		let files = fs.readdirSync(`./src/Plugins/${plugin}`);

		for (let j = 0; j < files.length; j++) {
			let file = files[j];

			if (file.endsWith(".lua")) {
				let data = processFile(`./src/Plugins/${plugin}/${file}`);

				// Remove the plugin = text from the file
				pluginString += data.replace(/local plugin = /g, "") + ",\n";
			}
		}
	}

	output += pluginString + "}\n";

	output += "\n\n" + processFile("./Src/Initialize.lua") + "\n";
	output += processFile("./Src/Main.lua") + "\n";

	output += "\n\nUtil.Initialize()";

	output = output.replace(/Util/g, "uv4");

	fs.writeFileSync("./Out/main.lua", output);
}

// Building
console.log("Building started");
build();
copyToMission();
console.log(
	`Build complete [${fs.readFileSync("./Out/main.lua", "utf8").length} chars]`
);
