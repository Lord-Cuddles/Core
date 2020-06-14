local version = "1.0 alpha 3"
term.clear()
term.setCursorPos(1,1)

if not fs.exists("update.lua") then
  -- Download 'update.lua' from GitHub
    local site = http.get(
        "https://raw.githubusercontent.com/Lord-Cuddles/Core/master/update.lua"
    )
  
    if not site then
        -- Failed to connect to GitHub
        return error("Unable to connect to GitHub. Please try again later")
    end
  
    local content = site.readAll()
    site.close()
    local file = fs.open("update.lua", "w")
    file.write(content)
    file.close()
end

if fs.exists("main") then
    shell.run("main")
else
    shell.run("update")
end
