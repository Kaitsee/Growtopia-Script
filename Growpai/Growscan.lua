function OnConsoleMessage(text)
var = {
        [0] = "OnConsoleMessage",
        [1] = text,
        netid = -1
    }
SendVarlist(var)
end

function OnTextOverlay(text)
var = {
        [0] = "OnTextOverlay",
        [1] = text,
        netid = -1
    }
SendVarlist(var)
end

function round(n)
    return n % 1 >= 0.5 and math.ceil(n) or math.floor(n)
end

function Growscan()
var = {}
var[0] = "OnDialogRequest"
var[1] = [[[[set_default_color|`o
add_label_with_icon|big|`cGrowscan 9000```|left|6016|
add_spacer|small|
add_textbox|`wThis amazing block can show the stats for the whole world!||
add_spacer|small|
add_textbox|`wWhich stats would you like to view?|left|
add_button|tilesworld|World Blocks|noflags|0|0|
add_button|objectsworld|Floating Items|noflags|0|0|
add_button|fruitsworld|Tree Fruits|noflags|0|0|
add_spacer|small|
add_quick_exit|
end_dialog|growscan|Cancel||
]]

var.netid = -1
SendVarlist(var)
end

function GS_Tiles()
    store = {}
    for _, tile in pairs(GetTiles()) do
        if store[tile.fg] == nil then
            store[tile.fg] = { id = tile.fg, count = 1 }
        else
            store[tile.fg].count = store[tile.fg].count + 1
        end

        if store[tile.bg] == nil then
            store[tile.bg] = { id = tile.bg, count = 1 }
        else
            store[tile.bg].count = store[tile.bg].count + 1
        end
    end

    WorldTiles = "add_spacer|small|"
    for _, tile in pairs(store) do
        TilesID = math.floor(tile.id)
        TilesCount = round(tile.count)
        WorldTiles =
            WorldTiles ..
            "\nadd_label_with_icon|small|" ..
            GetIteminfo(TilesID).name .. "`0: " .. TilesCount .. "|left|" .. math.floor(tile.id) .. "|"
        WorldTilesIndex = WorldTiles .. "\n"
    end
var = {}
var[0] = "OnDialogRequest"
var[1] = [[[[set_default_color|`o
add_label_with_icon|big|`cGrowscan 9000```|left|6016|
]] .. WorldTilesIndex .. [[
add_spacer|small|
add_quick_exit|
end_dialog|growscans|Cancel|Back|
]]

var.netid = -1
SendVarlist(var)
end

function GS_Objects()
    store = {}
    for _, Object in pairs(GetObjects()) do
        if store[Object.id] == nil then
            store[Object.id] = { id = Object.id, count = 1 }
        else
            store[Object.id].count = store[Object.id].count + 1
        end
    end


    WorldObjects = "add_spacer|small|"
    for _, Object in pairs(store) do
        ObjectsID = math.floor(Object.id)
        ObjectsCount = round(Object.count)
        WorldObjects =
            WorldObjects ..
            "\nadd_label_with_icon|small|" ..
            GetIteminfo(ObjectsID).name .. "`0: " .. ObjectsCount .. "|left|" .. math.floor(Object.id) .. "|"
        WorldObjectsIndex = WorldObjects .. "\n"
    end
var = {}
var[0] = "OnDialogRequest"
var[1] = [[[[set_default_color|`o
add_label_with_icon|big|`cGrowscan 9000```|left|6016|
]] .. WorldObjectsIndex .. [[
add_spacer|small|
add_quick_exit|
end_dialog|growscans|Cancel|Back|
]]

var.netid = -1
SendVarlist(var)
end

function GS_Fruits()
var = {}
var[0] = "OnDialogRequest"
var[1] = [[[[set_default_color|`o
add_label_with_icon|big|`cGrowscan 9000```|left|6016|
]] .. fruitsworlds .. [[
add_spacer|small|
add_quick_exit|
end_dialog|growscans|Cancel|Back|
]]

var.netid = -1
SendVarlist(var)
end

function Growscan_Thread(type, packet)
    if packet == ("action|input\n|text|/gs") or packet == ("action|input\n|text|/growscan") then
        Growscan()
        return true
    end
    if packet:find("action|dialog_return\ndialog_name|growscans") then
        Growscan()
        return true
    end
    if packet:find("buttonClicked|tilesworld") then
        RunThread(function()
            Sleep(500)
            OnTextOverlay("`cScanning Placed Blocks")
            Sleep(2000)
            GS_Tiles()
        end)
        return true
    elseif packet:find("buttonClicked|objectsworld") then
        RunThread(function()
            Sleep(500)
            OnTextOverlay("`cScanning Floating Items")
            Sleep(2000)
            GS_Objects()
        end)
        return true
    elseif packet:find("buttonClicked|fruitsworld") then
        RunThread(function()
            Sleep(500)
            OnConsoleMessage("`cComing-Soon")
            OnTextOverlay("`cComing-Soon")
        end)
        return true
    end
end

AddCallback("Growscan", "OnPacket", Growscan_Thread)
Growscan()
