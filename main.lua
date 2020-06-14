
local version = "1.0 alpha 11"

--[[ SETUP - PLACE INITIAL FUNCTIONS BELOW! ]]

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
    --[[
        Available options:
        "fgColour" - Overrides foreground colour
        "bgColour" - Overrides background colour
        "heading" - Changes the written heading
        "footer" - Changes the written footer
        "noClear" - Does not clear the line before printing
        "noLine" - Does not add a new line character to the end
    ]]
    local xSize, ySize = term.getSize()
    local fgOld, bgOld = term.getTextColor(), term.getBackgroundColor()
    if not options then options = {} end
    if options.fgColor then options.fgColour = options.fgColor end
    if options.bgColor then options.bgColour = options.bgColor end
    if not options.fgColour then
        options.fgColour = "silver"
    end
    if not options.bgColour then
        options.bgColour = "darkGreen"
    end
    
    if options.heading == true then
        term.setCursorPos(1,1)
    end
    if options.footer == true then
        term.setCursorPos(1,ySize)
        if not options.fgColour then
            options.fgColour = "darkGrey"
        end
        if not options.bgColour then
            options.bgColour = "black"
        end
    end
    format(options.fgColour or "silver", options.bgColour or "darkGreen")
    if not options.noClear then
        term.clearLine()
    end
    
    local xPos, yPos = term.getCursorPos()
    term.setCursorPos((xSize/2)-(#text/2), yPos)
    if not text then text = "" end
    if options.noLine or options.footer then
        write(text)
    else
        print(text)
    end
    
    if options.heading or options.footer then
        term.setCursorPos(1,2)
        format("default")
    end
    term.setTextColor(fgOld)
    term.setBackgroundColor(bgOld)
end

























alertLevels = {
    green="darkBlue",
    yellow="gold",
    red="darkRed"
}

alertLevel = alertLevels.green

setPalette(codes)
--[[ RUNTIME - PLACE FUNCTIONS ABOVE! ]]

local last = "Primary Controller"
local foot = ""
local tasks = {}
while true do
    midPrint(last, {heading=true, fgColour="silver", bgColour=alertLevel})
    midPrint(foot, {footer=true, noLine=true})
    if shift_held and ctrl_held then
        foot = "Press <shift+ctrl+tab> to update 'startup'"
    elseif ctrl_held then
        foot = "Press <ctrl+tab> to update 'update'"
    elseif shift_held then
        foot = "Press <shift+tab> to update 'main'"
    end
    local event, v1, v2, v3, v4, v5 = os.pullEvent()
    if event == "key" then
        if key == keys.leftShift then
            shift_held = true
        elseif key == keys.leftCtrl then
            ctrl_held = true
        elseif key == keys.leftAlt then
            alt_held = true
        elseif key == keys.tab then
            if shift_held and ctrl_held then
                shell.run("update startup")
            elseif shift_held then
                shell.run("update update")
            elseif ctrl_held then
                shell.run("update")
            end
        elseif key == keys.space then
            break
        end
    elseif event == "key_up" then
        if key == keys.leftShift then
            shift_held = false
        elseif key == keys.leftCtrl then
            ctrl_held = false
        elseif key == keys.leftAlt then
            alt_held = false
        end
    elseif event == "notification" then
        last = v1
    elseif event == "modem_message" then
        -- What should happen if there is a message from a connected PC?
    elseif event == "task_complete" then
        foot = "Task Complete: "..v1
    end
end

--[[ END OF CODE - DO NOT INSERT ANYTHING AFTER THIS! ]]--
os.pullEvent("char")
setPalette(defaultcodes)
term.setTextColor(colours.white)
term.setBackgroundColor(colours.black)
term.clear()
term.setCursorPos(1,1)
