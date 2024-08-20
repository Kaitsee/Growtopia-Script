---------------------------------------
-- Information
---------------------------------------
founder = "`2Kaitsee"
version = "`^Version 2.3"
ds_name = "`2Kaitsee"
ds_server = "https://discord.com/invite/WnjYR6a4ZP"
systemlog = "`w[`9+`w] `w[`bKaitsee Proxy`w]`o "
systemvar = "`w[`bKaitsee Proxy`w] "
Server = "RGT" -- RGT or CPS

---------------------------------------
-- Settings
---------------------------------------
local autoaccess_status = true
local fastunaccess_status = false
local autochangedl_status = false
local fastchangebgl_status = false
local checkgems_status = true

local spinchecker_status = true
local spin_mode = "Default"

---------------------------------------
-- Basic System
---------------------------------------
function GetInventory(InventoryID)
    local count = 0
    for _, item in pairs(GetInventory()) do
        if item.id == InventoryID then
            count = count + item.count
        end
    end
    return count
end

function PacketRaw10(Raw10ID)
    SendPacketRaw ({
        type = 10,
        int_data = Raw10ID
    })
end

function DropItem(DropID, DropCount)
    if Server == "RGT" then
        SendPacket(2, "action|drop\n|itemID|" .. DropID)
        SendPacket(2, "action|dialog_return\ndialog_name|drop_item\nitemID|" .. DropID .. "|\ncount|" .. DropCount)
        Sleep(100)
    elseif Server == "CPS" then
        OnTextOverlay("`4Coming-Soon")
    end
end

function TrashItem(TrashID, TrashCount)
    if Server == "RGT" then
        SendPacket(2, "action|trash\n|itemID|" .. TrashID)
        SendPacket(2, "action|dialog_return\ndialog_name|trash_item\nitemID|" .. TrashID .. "|\ncount|" .. TrashCount)
        Sleep(100)
    elseif Server == "CPS" then
        OnTextOverlay("`4Coming-Soon")
    end
end

---------------------------------------
-- System Variant List
---------------------------------------
function OnConsoleMessage(text)
    var = {}
    var[0] = "OnConsoleMessage"
    var[1] = text
    var.netid = -1
    SendVarlist(var)
end

function OnTextOverlay(text)
    var = {}
    var[0] = "OnTextOverlay"
    var[1] = text
    var.netid = -1
    SendVarlist(var)
end

function OnTalkBubble(text)
    var = {}
    var[0] = "OnTalkBubble"
    var[1] = GetLocal().netid
    var[2] = text
    var[3] = 0
    var[4] = 0
    var.netid = -1
    SendVarlist(var)
end

function OnParticleEffect(id)
    var = {}
    var[0] = "OnParticleEffect"
    var[1] = id
    var[2] = { GetLocal().pos_x + 10, GetLocal().pos_y + 15}
    var[3] = 0
    var[4] = 0
    var.netid = -1
    SendVarlist(var)
end

--- Block Dialog
function hidealldialog(var)
    if var[0] == "OnDialogRequest" then
        return true
    end
    return false
end

function hidetelephone(var)
    if var[0] == "OnDialogRequest" and var[1]:find("end_dialog|telephone") or var[1]:find("end_dialog|phonecall") then
        return true
    end
    return false
end

function hidedrop(var)
    if var[0]:find("OnDialogRequest") and var[1]:find("end_dialog|drop") then
        return true
    end
    return false
end

function hidetrash(var)
    if var[0]:find("OnDialogRequest") and var[1]:find("end_dialog|trash") then
        return true
    end
    return false
end

---------------------------------------
-- Dialogs List
---------------------------------------
function SelectServer()
if Server == "RGT" then
    Selected_Server = "Real Growtopia (RGT)"
elseif Server == "CPS" then
    Selected_Server = "CreativePS (CPS)"
end
var = {}
var[0] = "OnDialogRequest"
var[1] = [[set_default_color|`o
add_label_with_icon|big|`3Server Options```|left|6128|
add_spacer|small|
add_textbox|`9Select The Server Your Play For Proxy||
add_textbox|`9Currently Selected: `2]] .. Selected_Server .. [[||
add_spacer|small|
add_button|rgt|Changes To Proxy Real Growtopia (RGT)||
add_button|cps|Changes To Proxy CreativePS (CPS)||
add_spacer|small|
add_quick_exit|
end_dialog|selectserver|Okay||
]]

var.netid = -1
SendVarlist(var)
end


function proxymenu()

var = {}
var[0] = "OnDialogRequest"
var[1] = [[set_default_color|`o
add_label_with_icon|big|`3Proxy Commands```|left|1790|
add_textbox|]] .. version .. [[||
add_spacer|small|
add_label_with_icon|small|`!Main Features:``|left|9472|
add_smalltext|`2/proxy `9(Shows Commands)|left|
add_smalltext|`2/info `9(Show Information About The Proxy)|left|
add_smalltext|`2/sp or /sproxy (`9Change's Proxy Server)|left|
add_smalltext|`2/options `9(Open Options for All Commands in Proxy)|left|
add_smalltext|`2/fc `9(Forced Closed Proxy)|left|
add_smalltext|`2/bal `9(Counts All Locks in Inventory)|left|
add_smalltext|`2/res `9(Quick Respawn)|left|
add_smalltext|`2 `9()|left|
add_smalltext|`2 `9()|left|
add_smalltext|`2 `9()|left|
add_spacer|small|
add_label_with_icon|small|`!Host Commands Helper```|left|758|
add_smalltext|`2/spin `9(Spin Checker)|left|
add_smalltext|`2 `9()|left|
add_smalltext|`2 `9()|left|
add_smalltext|`2 `9()|left|
add_smalltext|`2 `9()|left|
add_smalltext|`2 `9()|left|
end_dialog|proxymenu|Okay||
]]

var.netid = -1
SendVarlist(var)
end

function options()
-- Auto Access
if autoaccess_status == true then
    autoaccess_checkbox = 1
elseif autoaccess_status == false then
    autoaccess_checkbox = 0
end

if fastunaccess_status == true then
    fastunaccess_checkbox = 1
elseif fastunaccess_status == false then
    fastunaccess_checkbox = 0
end

if autochangedl_status == true then
    autochangedl_checkbox = 1
elseif autochangedl_status == false then
    autochangedl_checkbox = 0
end

if fastchangebgl_status == true then
    fastchangebgl_checkbox = 1
elseif fastchangebgl_status == false then
    fastchangebgl_checkbox = 0
end

if checkgems_status == true then
    checkgems_checkbox = 1
elseif checkgems_status == false then
    checkgems_checkbox = 0
end
var = {}
var[0] = "OnDialogRequest"
var[1] = [[set_default_color|`o
add_label_with_icon|big|`3Options Menu```|left|32|
add_spacer|small|
add_checkbox|autoaccess|`2Enable `9Auto Access|]] .. autoaccess_checkbox .. [[|
add_custom_margin|x:0;y:-30|
add_custom_textbox|`#It Allows You To Automaticaly Accept Any Access From Any Given Locks|size:small|
add_checkbox|fastunaccess|`2Enable `9Fast Un-Access|]] .. fastunaccess_checkbox .. [[|
add_custom_margin|x:0;y:-30|
add_custom_textbox|`#It Allows You To Automaticaly Remove Access When You Wrench Any Locks|size:small|
add_checkbox|autochangedl|`2Enable `9Auto Change World Lock To Diamond Locks|]] .. autochangedl_checkbox .. [[|
add_custom_margin|x:0;y:-30|
add_custom_textbox|`#It Allows You Can Automaticaly Change World Lock to Diamond Locks When Collected World Lock And Have 100 World Locks In Inventory|size:small|
add_checkbox|fastchangebgl|`2Enable `9Fast Change Diamond Locks to Blue Gems Lock|]] .. fastchangebgl_checkbox .. [[|
add_custom_margin|x:0;y:-30|
add_custom_textbox|`#It Allows You To Automaticaly Fast Change Diamond Locks to Blue Gem Locks When Wrench Any Telephone|size:small|
add_checkbox|checkgems|`2Enable `9Check Collected Gems|]] .. checkgems_checkbox .. [[|
add_custom_margin|x:0;y:-30|
add_custom_textbox|`#It Allows You To Check Amounts Of You Collected Gems|size:small|
add_quick_exit|
end_dialog|optiondialog|Discard Changes|Save Changes|


]]
var.netid = -1
SendVarlist(var)
end

function spinchecker()

if spinchecker_status == true then
    spinchecker_checkbox = 1
    if spin_mode == "Default" then
        spinstatus_1 = "`2Enable"
        spinstatus_2 = "`9Default"
    elseif spin_mode == "Reme" then
        spinstatus_1 = "`2Enable"
        spinstatus_2 = "`9Reme/Peme/Leme"
    elseif spin_mode == "QQ" then
        spinstatus_1 = "`2Enable"
        spinstatus_2 = "`9QQ/Qeme"
    elseif spin_mode == "Casino" then
        spinstatus_1 = "`2Enable"
        spinstatus_2 = "`9Casino"
    end
elseif spinchecker_status == false then
    spinchecker_checkbox = 0
    spinstatus_1 = "`4Disable"
    spinstatus_2 = "`9-"
end

var = {}
var[0] = "OnDialogRequest"
var[1] = [[set_default_color|`o
add_label_with_icon|big|`cSpin Commands```|left|758|
add_spacer|small|
add_textbox|Spin Mode Status : ]] .. spinstatus_1 .. [[||
add_textbox|Currently Selected : ]] .. spinstatus_2 .. [[||
add_spacer|small|
add_checkbox|spinstatus|`2Enable `9Spin Checker|]] .. spinchecker_checkbox .. [[|
add_custom_margin|x:8;y:-30|
add_custom_textbox|`#Enable or Disable Spin Checker `9(`2REAL `9or `4FAKE`9)|size:small|
add_custom_margin|x:-8;y:0|
add_spacer|small|
add_button|spindefault|`9Reset To Default Spin Mode|
add_button|spinreme|`9Change Spin Mode Reme/Peme/Leme||
add_button|spinqq|`9Change Spin Mode QQ/Qeme||
add_button|spincsn|`9Change Spin Mode CSN||
add_quick_exit|
end_dialog|spinchecker|Discard Changes|Save Changes|
]]

var.netid = -1
SendVarlist(var)
end

---------------------------------------
-- System Proxy #1
---------------------------------------
function SystemPacket(type, packet)
    --- CheckBox Options
    if packet:find("dialog_name|optiondialog") then
        -- Auto Access
        if packet:find("autoaccess|0") then
            autoaccess_status = false
        elseif packet:find("autoaccess|1") then
            autoaccess_status = true
        end

        if packet:find("fastunaccess|0") then
            fastunaccess_status = false
        elseif packet:find("fastunaccess|1") then
            fastunaccess_status = true
        end

        if packet:find("autochangedl|0") then
            autochangedl_status = false
        elseif packet:find("autochangedl|1") then
            autochangedl_status = true
        end
        
        if packet:find("fastchangebgl|0") then
            fastchangebgl_status = false
        elseif packet:find("fastchangebgl|1") then
            fastchangebgl_status = true
        end

        if packet:find("checkgems|0") then
            checkgems_status = false
        elseif packet:find("checkgems|1") then
            checkgems_status = true
        end

        --- Batas
        Sleep(1000)
        options()
    end

    --- Spin Checker
    if packet:find("dialog_name|spinchecker") then
        -- Checkbox
        if packet:find("spinstatus|0") then
            spinchecker_status = false
        elseif packet:find("spinstatus|1") then
            spinchecker_status = true
            if packet:find("buttonClicked|spindefault") then
                spin_mode = "Default"
                OnTextOverlay("`9Spin Checker Reset To `2Default")
            elseif packet:find("buttonClicked|spinreme") then
                spin_mode = "Reme"
                OnTextOverlay("`9Spin Checker Mode Set To: `2Reme/Peme/Leme")
            elseif packet:find("buttonClicked|spinqq") then
                spin_mode = "QQ"
                OnTextOverlay("`9Spin Checker Mode Set To: `2QQ/Qeme")
            elseif packet:find("buttonClicked|spincsn") then
                spin_mode = "Casino"
                OnTextOverlay("`9Spin Checker Mode Set To: `2Casino")
            end
        end
        RunThread(function()
            Sleep(1000)
            spinchecker()
        end)
    end

    --- Buttons
    if packet:find("dialog_name|selectserver") then
        if packet:find("buttonClicked|rgt") then
            Server = "RGT"
        elseif packet:find("buttonClicked|cps") then
            Server = "CPS"
        end
    end

    --- Slash Commands
    if packet == ("action|input\n|text|/proxy") then
        proxymenu()
        return true
    end
    
    if packet == ("action|input\n|text|/fc") then
        RemoveCallbacks()
        return true
    end

    if packet == ("action|input\n|text|/sproxy") or packet == ("action|input\n|text|/sp") then
        SelectServer()
        return true
    end

    if packet == ("action|input\n|text|/options") then
        options()
        return true
    end

    if packet == ("action|input\n|text|/spin") then
        spinchecker()
        return true
    end

    if packet == ("action|input\n|text|/cgems") then
        if checkgems_status == false then
            checkgems_status = true
            OnConsoleMessage(systemlog .. "Check Collected Gems `2Enabled")
        elseif checkgems_status == true then
            checkgems_status = false
            OnConsoleMessage(systemlog .. "Check Collected Gems `4Disabled")
        end
        return true
    end
end

---------------------------------------
-- Proxy System #2 (Variant List)
---------------------------------------
function SystemVar(var)
    -- Auto Access
    if autoaccess_status == true then
        if var[0] == "OnConsoleMessage" and var[1]:find("wants to add you to a") then
            AddCallback("Block Dialog", "OnVarlist", hidealldialog)
            RunThread(function()
                NetID = GetLocal().netid
                SendPacket(2, "action|wrench\n|netid|" .. NetID)
                Sleep(100)
                SendPacket(2, "action|dialog_return\ndialog_name|popup\nnetID|" .. NetID .. "|\nbuttonClicked|acceptlock")
                Sleep(100)
                SendPacket(2, "action|dialog_return\ndialog_name|acceptaccess")
                Sleep(2000)
                RemoveCallback("Block Dialog")
            end)
            return true
        end
    end

    -- Fast Un-Access When Wrench Any Lock
    if fastunaccess_status == true then
        if var[0] == "OnDialogRequest" and var[1]:find("but I have access on it.") then
            AddCallback("Block Dialog", "OnVarlist", hidealldialog)
            RunThread(function()
                SendPacket(2, "action|dialog_return\ndialog_name|lock_edit\ntilex|" .. var[1]:match("embed_data|tilex|(%d+)|") .. "|\ntiley|" .. var[1]:match("embed_data|tiley|(%d+)|") .. "|")
                Sleep(1000)
                RemoveCallback("Block Dialog")
            end)
            return true
        end
    end

    -- Auto Change Diamond Lock When Lock at 150
    if autochangedl_status == true then
        if var[0] == "OnConsoleMessage" and var[1]:find("Collected") then
            if GetInventory(242) >= 100 then
                PacketRaw10(242)
                return true
            end
        end
    end

    -- Fast Changes BGL When Wrench Any Telephone
    if fastchangebgl_status == true then
        if var[0]:find("OnDialogRequest") and var[1]:find("Dial a number to call somebody in Growtopia") then
            AddCallback("Block Telephone", "OnVarlist", hidetelephone)
            RunThread(function()
                SendPacket(2, "action|dialog_return\ndialog_name|phonecall\ntilex|" .. var[1]:match("embed_data|tilex|(%d+)") .. "|\ntiley|" .. var[1]:match("embed_data|tiley|(%d+)") .. "|\nnum|-34|\nbuttonClicked|chc0")
                Sleep(1000)
                RemoveCallback("Block Telephone")
            end)
            return true
        end
    end

    RunThread(function()
        while checkgems_status do
            if GetLocal().world ~= "EXIT" then
                Local_Gems = GetLocal().gems
                Sleep(1000)
                if Local_Gems ~= GetLocal().gems then
                    RunThread(function()
                        Sleep(500)
                        OnTalkBubble("`9Collected `2+" .. math.floor(GetLocal().gems - Local_Gems) .. " `9Gems (gems)")
                        Local_Gems = GetLocal().gems
                    end)
                end
            end
        end
    end)
end


---------------------------------------
-- Running Proxy System
---------------------------------------
OnConsoleMessage(systemlog .. "Injecting...")
OnTextOverlay("`1I`2n`3j`4e`5c`6t`7i`8n`9g`0..")
Sleep(1000)
AddCallback("System Proxy #1", "OnPacket", SystemPacket)
Sleep(500)
AddCallback("System Proxy #2", "OnVarlist", SystemVar)
OnConsoleMessage(systemlog .. "Proxy Injected")
OnTextOverlay("`2Successfully Injected")
Sleep(1000)
SelectServer()