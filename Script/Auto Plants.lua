SeedID = 4585 -- Set Seed ID
Delay = 100 -- Not Recommended Below 100
UseMagplant = false -- true = Plants Use Magplant | false = Plants With Collect Seed In Same World
World = ""


function Place(x, y, ID)
SendPacketRaw({
    type = 3,
    int_data = ID,
    int_x = x,
    int_y = y,
    pos_x = math.floor(GetLocal().pos_x / 32),
    pos_y = math.floor(GetLocal().pos_y / 32),
})

end

function CheckItemCount(ItemID)
    local ItemCount = 0
    for _, item in pairs(GetInventory()) do
        if item.id == ItemID then
            ItemCount = ItemCount + item.count
        end
    end
    return ItemCount
end

function GetSeed(ID)
    for _, Obj in pairs(GetObjects()) do
        if Obj.id == ID then
            FindPath(Obj.pos_x, Obj.pos_y)
            Sleep(1000)
        end
    end
end

function AutoPlantSettings()
var = {}
var[0] = "OnDialogRequest"
var[1] = [[set_default_color|`o
add_label_with_icon|big|`3Auto Plants Settings```|left|32|
add_smalltext|`^Script Version 4.0|
add_spacer|small|
add_text_input|delay|Delay (ms) :||5|
add_custom_margin|x:8;y:0|
add_custom_textbox|`9Current Delay : `2]] .. Delay .. [[ `3(Not Recommended Above 100)|size:small|
add_custom_margin|x:-8;y:0|
add_text_input|seedid|Seed ID :||5|
add_custom_margin|x:8;y:0|
add_custom_textbox|`9Current Seed ID : `2]] .. GetIteminfo(SeedID).name .. [[|size:small|
add_custom_margin|x:-8;y:0|
add_url_button||"Pokemon Style Battles in Growtopia" by GroaxJr|noflags|https://tools.bolwl.com|Open Your Browser?|0|0|
add_spacer|small|
add_quick_exit|
end_dialog|autoplants|Discard Changes|Save Changes|
]]

var.netid = -1
SendVarlist(var)
end

function Plants_Thread()
    for x = 0, 100 - 1 do
        for y = 0, 100 - 1 do
            if GetTile(x, y).fg == 0 and GetTile(x, y + 1).fg ~= 0 then
                FindPath(x, y)
                Sleep(Delay)
                Plants(x, y, ID)
                Sleep(Delay)
            end
        end
    end

    for x = 0, 100 - 1 do
        for y = 0, 100 - 1 do
            if GetTile(x, y).fg == 0 and GetTile(x, y + 1).fg ~= 0 then
                Plants_Thread()
                Sleep(Delay)
            end
        end
    end
end

AutoPlantSettings()