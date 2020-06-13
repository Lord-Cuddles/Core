
local version = "1.0 alpha 2"

local c = {
    DARK_RED = 1,
    RED = 2,
    GOLD = 4,
    YELLOW = 8,
    DARK_GREEN = 16,
    GREEN = 32,
    CYAN = 64,
    AQUA = 64, 
    DARK_CYAN = 128,
    DARK_AQUA = 128, 
    DARK_BLUE = 256,
    BLUE = 512,
    LIGHT_PURPLE = 1024,
    DARK_PURPLE = 2048,
    WHITE = 4096,
    GRAY = 8192,
    GREY = 8192,
    DARK_GRAY = 16384,
    DARK_GREY = 16384,
    BLACK = 32768
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

function setPalette(getCodes)
    for index, code in pairs(getCodes) do
        term.setPaletteColour(colours[index], getCodes[index])
    end
end

setPalette(codes)
