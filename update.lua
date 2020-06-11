local version = "1.0 alpha 2"
local args = {...}

if args[1] == "update" then
    dir = "update"
    url = "https://raw.githubusercontent.com/Lord-Cuddles/Core/master/update.lua"
elseif args[1] == "startup" then
    dir = "startup"
    url = "https://raw.githubusercontent.com/Lord-Cuddles/Core/master/startup.lua"
else
    dir = "main"
    url = "https://raw.githubusercontent.com/Lord-Cuddles/Core/master/main.lua"
end

local file_old = fs.open(dir, "r")
local content_old = file_old.readAll()
file_old.close()

local data = http.get(url)
if not data then
    error("Download failed to complete, check URL")
end

local content = data.readAll()
if content == content_old then
    print("Warning: No changes detected between versions")
    print("This is usually a cache issue, try again in 5 minutes")
end

if fs.exists(dir.."_old") then
    fs.delete(dir.."_old")
end

if fs.exists(dir) then
    fs.move(dir, dir.."_old")
end

local content = data.readAll()
local file = fs.open(dir, "w")
file.write(content)
file.close()
print("Complete")
