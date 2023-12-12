-- Any code put in this file will be executed before any other file in the project. and not get minified (Comments get removed still).

function print(...)
    local out = ""

    for _, v in pairs({ ... }) do
        out = out .. tostring(v) .. " "
    end

    server.announce("[Debug]", out, -1)
end

function error(str)
    server.announce("[Error]", str, -1)
end
