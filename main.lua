
local version = "1.0 alpha 7"

local c = {
    darkRed = 1,
    red = 2,
    gold = 4,
    yellow = 8,
    darkGreen = 16,
    green = 32,
    cyan = 64,
    aqua = 64, 
    darkCyan = 128,
    darkAqua = 128, 
    darkBlue = 256,
    blue = 512,
    lightPurple = 1024,
    darkPurple = 2048,
    white = 4096,
    silver = 8192,
    gray = 8192,
    grey = 8192,
    darkGrey = 16384,
    darkGray = 16384,
    black = 32768
}

local codes = {
    white=0xAA0000,
    orange=0xFF5555,
    magenta=0xFFAA00,
    lightBlue=0xFFFF55,
    yellow=0x00AA00,
    lime=0x55FF55,
    pink=0x55FFFF,
    grey=0x00AAAA,
    lightGrey=0x0000AA,
    cyan=0x5555FF,
    purple=0xFF55FF,
    blue=0xAA00AA,
    brown=0xFFFFFF,
    green=0xAAAAAA,
    red=0x555555,
    black=0x000000
}

local defaultcodes = {
    white=0xF0F0F0,
    orange=0xF2B233,
    magenta=0xE57FD8,
    lightBlue=0x99B2F2,
    yellow=0xDEDE6C,
    lime=0x7FCC19,
    pink=0xF2B2CC,
    grey=0x4C4C4C,
    lightGrey=0x999999,
    cyan=0x4C99B2,
    purple=0xB266E5,
    blue=0x3366CC,
    brown=0x7F664C,
    green=0x57A64E,
    red=0xCC4C4C,
    black=0x111111
}

function format(fore, back)
    if not fore then
        fore = "default"
    end
    if fore == "default" then
        fore = "white"
        if not back then
            back = "default"
        end
    end
    if back == "default" then
        back = "black"
    end
    term.setTextColor(c[fore] or c["white"])
    term.setBackgroundColor(c[back]or c["black"])
end

function setPalette(getCodes)
    for index, code in pairs(getCodes) do
        term.setPaletteColour(colours[index], getCodes[index])
    end
end

function midPrint(text, options)
    local xSize, ySize = term.getSize()
    if options.heading == true then
        term.setCursorPos(1,1)
        format("black", "orange")
    end
    term.clearLine()
    
    local xPos, yPos = term.getCursorPos()
    term.setCursorPos((xPos/2)-(#text/2)-1, yPos)
    if not text then text = "" end
    if options.write then
        write(text)
    else
        print(text)
    end
    
    if options.heading == true then
        term.setCursorPos(1,2)
        format("default")
    end
end



























setPalette(codes)
midPrint("Hello, World!" {heading=true})


--[[ END OF CODE - DO NOT INSERT ANYTHING AFTER THIS! ]]--
setPalette(defaultcodes)
term.setTextColor(colours.white)
term.setBackgroundColor(colours.black)
term.clear()
term.setCursorPos(1,1)
