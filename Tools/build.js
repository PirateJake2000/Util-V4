const fs = require("fs");

// Get the list of files in the "./Src" directory
function getFiles() {
	return fs.readdirSync("./Src"), fs.readdirSync("./Src").length;
}

// Minify the content by removing comments and extra whitespace
function minify(content) {
	content = content.replace(/--.*/g, "");
	content = content.replace(/^\s*[\r\n]/gm, "");
	content = content.replace(/\s+/g, " ");
	return content;
}

// Create the Util object by iterating through the files in the "./Src/library" directory
function createUtil() {
	const srcPath = "./Src/library";
	const files = fs.readdirSync(srcPath);

	let util = "Util = {";

	files.forEach((file) => {
		if (file.endsWith(".lua")) {
			util += `\n\t${file.slice(0, -4)} = {},`;
		}
	});

	util = util.slice(0, -1) + "\n}";

	return util;
}

// Build the main.lua file by combining the content of all .lua files in the "./Src" directory
function build() {
	const files = getAllFiles("./Src");
	let main = "";

	// Add util
	main += createUtil();
	main += "\n\n";

	files.forEach((file) => {
		if (file.endsWith(".lua")) {
			main += `-- ${file}\n`;
			main += minify(fs.readFileSync(file, "utf8"));
			main += "\n";

			console.log(`-> ${file}`);
		}
	});

	fs.writeFileSync("./Out/main.lua", main);
}

// Recursively get all files in a directory
function getAllFiles(dirPath, arrayOfFiles) {
	const files = fs.readdirSync(dirPath);

	arrayOfFiles = arrayOfFiles || [];

	files.forEach((file) => {
		if (fs.statSync(dirPath + "/" + file).isDirectory()) {
			arrayOfFiles = getAllFiles(dirPath + "/" + file, arrayOfFiles);
		} else {
			arrayOfFiles.push(dirPath + "/" + file);
		}
	});

	return arrayOfFiles;
}

console.log(`Build started`);

build();

console.log(
	`Build finished [${
		fs.readFileSync("./Out/main.lua", "utf8").length
	} characters]`
);
