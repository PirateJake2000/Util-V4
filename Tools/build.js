const fs = require("fs");

function getFiles() {
	return fs.readdirSync("./src"), fs.readdirSync("./src").length;
}

function minify(content) {
	content = content.replace(/--.*/g, "");
	content = content.replace(/^\s*[\r\n]/gm, "");
	content = content.replace(/\s+/g, " ");
	return content;
}

function build() {
	const files = fs.readdirSync("./src");
	let main = "";

	files.forEach((file) => {
		if (file.endsWith(".lua")) {
			main += `-- ${file}\n`;
			main += minify(fs.readFileSync(`./Src/${file}`, "utf8"));
			main += "\n";
		}
	});

	fs.writeFileSync("./Out/main.lua", main);
}

let files,
	count = getFiles();

console.log(`Build started`);

build();

console.log(
	`Build finished [${count} file${count > 1 ? "s" : ""}] [${
		fs.readFileSync("./Out/main.lua", "utf8").length
	} characters]`
);
