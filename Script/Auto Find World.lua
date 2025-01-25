local Length = 4 -- Default Script : 4
local UseNumber = false -- Default Script : false
local AutoFindNextWorld = true -- Default Script : true
local LockID = {"242", "1796", "2408", "2950", "4428", "4802", "5260", "7188", "8470", "9640", "10410", "11550", "11586", "11902", "13200", "13636", "14536", "14538"}

function OnTextOverlay(text)
    var = {}
    var[0] = "OnTextOverlay"
    var[1] = text
    var.netid = -1
    SendVarlist(var)
end

function CheckTile(ID)
    local TileCount = 0
    for _, tile in pairs(GetTiles()) do
        if tile.fg == ID or tile.bg == ID then
            TileCount = TileCount + 1
        end
    end
    return TileCount
end

function AutoFindSettings()
if UseNumber == false then
    UseNumber_Checkbox = 0
elseif UseNumber == true then
    UseNumber_Checkbox = 1
end
if AutoFindNextWorld == false then
    AutoFindNextWorld_Checkbox = 0
elseif AutoFindNextWorld == true then
    AutoFindNextWorld_Checkbox = 1
end

var = {}
var[0] = "OnDialogRequest"
var[1] = [[set_default_color|`o
add_label_with_icon|big|`3Find World Settings```|left|32|
add_smalltext|`^Script Version 5.0|
add_spacer|small|
add_checkbox|withnumber|`2Enable `9Find World Use Number|]] .. UseNumber_Checkbox .. [[|
add_custom_margin|x:10;y:-30|
add_custom_textbox|`#If Enable, This Auto Find World With Number|size:small|
add_custom_margin|x:-10;y:10|
add_checkbox|autofindnextworld|`2Enable `9Fast Reroll World|]] .. AutoFindNextWorld_Checkbox .. [[|
add_custom_margin|x:10;y:-30|
add_custom_textbox|`#If Enable, This Auto Start Find Next World If Old World Already Locked Use World Locks|size:small|
add_custom_margin|x:-10;y:10|
add_text_input|length|World Length :|]] .. Length .. [[|3|
add_smalltext|`9Current World Length : ]] .. Length .. [[|
add_quick_exit|
end_dialog|findworld|Cancel|Okay|
]]

var.netid = -1
SendVarlist(var)
end

function FindWorld()
    local IndexWorld = "" -- Don't Changes
    local Chars = {} -- Don't Changes
    if UseNumber == true then
        Chars = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9"}
    elseif UseNumber == false then
        Chars = {"A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"}
    end
    
    for i = 1, Length do
        IndexWorld = IndexWorld .. Chars[math.random(1, #Chars)]
    end
    SendPacket(3, "action|join_request\nname|" .. IndexWorld .. "\ninvitedWorld|0")
    if AutoFindNextWorld == true then
        if CheckTile(242) == 0 then
            RunThread(function()
                Sleep(2000)
                OnTextOverlay("Success Found World Without World Lock")
            end)
        elseif CheckTile(242) == 1 then
            RunThread(function()
                Sleep(4000)
                FindWorld()
            end)
        end
    end
end

function GetDialogValue(type, packet)
    if packet:find("action|dialog_return\ndialog_name|findworld") then
        if packet:find("withnumber|0") then
            UseNumber = false
        elseif packet:find("withnumber|1") then
            UseNumber = true
        end

        if packet:find("autofindnextworld|0") then
            AutoFindNextWorld = false
        elseif packet:find("autofindnextworld|1") then
            AutoFindNextWorld = true
        end

        if tonumber(packet:match("\nlength|(%d+)\n")) > 0 and tonumber(packet:match("\nlength|(%d+)\n")) <= 24 then
            Length = tonumber(packet:match("\nlength|(%d+)\n"))
        elseif tonumber(packet:match("\nlength|(%d+)\n")) > 24 then
            RunThread(function()
                Sleep(1000)
                AutoFindSettings()
                Sleep(500)
                OnTextOverlay("`9World cannot be longer than 24 letters!")
            end)
        end
        RunThread(function()
            Sleep(1000)
            AutoFindSettings()
        end)
    end

    if packet == ("action|input\n|text|/findworld") then
        AutoFindSettings()
        return true
    elseif packet == ("action|input\n|text|//") then
        if Length > 0 and Length <= 24 then
            FindWorld()
        elseif Length == 0 or Length > 24 then
            RunThread(function()
                Sleep(1000)
                AutoFindSettings()
                Sleep(500)
                OnTextOverlay("`9World cannot be longer than 24 letters!")
            end)
        end
        return true
    end
end
AddCallback("GetDialogValue", "OnPacket", GetDialogValue)
AutoFindSettings()