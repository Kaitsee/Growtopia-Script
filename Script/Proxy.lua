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
local setting = {
    autoaccess = true,
    fastunaccess = false,
    autochangedl = false,
    fastchangebgl = false,
    checkgems = true
}

local wrench = {
    status = false,
    mode = "Pull" -- Pull, Kick, Ban
}

local join = {
    status = false,
    mode = "Pull" -- Pull, Kick, Ban
}

local spin = {
    status = true,
    mode = "Default"
}

local spam = {
    status = true,
    text = "Proxy By: `2Kaitsee",
    delay = 4000,
    color = false,
    emote = false,
    pulloff = false
}
---------------------------------------
-- Basic System
---------------------------------------
function Chat(ChatText)
SendPacket(2, "action|input\n|text|" .. ChatText)
end

function GetInventoryCount(InventoryID)
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
if setting.autoaccess == true then
    autoaccess_checkbox = 1
elseif setting.autoaccess == false then
    autoaccess_checkbox = 0
end

if setting.fastunaccess == true then
    fastunaccess_checkbox = 1
elseif setting.fastunaccess == false then
    fastunaccess_checkbox = 0
end

if setting.autochangedl == true then
    autochangedl_checkbox = 1
elseif setting.autochangedl == false then
    autochangedl_checkbox = 0
end

if setting.fastchangebgl == true then
    fastchangebgl_checkbox = 1
elseif setting.fastchangebgl == false then
    fastchangebgl_checkbox = 0
end

if setting.checkgems == true then
    checkgems_checkbox = 1
elseif setting.checkgems == false then
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
if spin.status == true then
    spin_checkbox = 1
    if spin.mode == "Default" then
        spinstatus_1 = "`2Enable"
        spinstatus_2 = "`9Default"
    elseif spin.mode == "Reme" then
        spinstatus_1 = "`2Enable"
        spinstatus_2 = "`9Reme/Peme/Leme"
    elseif spin.mode == "QQ" then
        spinstatus_1 = "`2Enable"
        spinstatus_2 = "`9QQ/Qeme"
    elseif spin.mode == "Casino" then
        spinstatus_1 = "`2Enable"
        spinstatus_2 = "`9Casino"
    end
elseif spin.status == false then
    spin_checkbox = 0
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
add_checkbox|spinstatus|`2Enable `9Spin Checker|]] .. spin_checkbox .. [[|
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

function autospam()
if spam.color == false then
    spamcolor_checkbox = 0
elseif spam.color == true then
    spamcolor_checkbox = 1
end
if spam.emote == false then
    spamemote_checkbox = 0
elseif spam.emote == true then
    spamemote_checkbox = 1
end

if spam.pulloff == false then
    spampulloff_checkbox = 0
elseif spam.pulloff == true then
    spampulloff_checkbox = 1
end

var = {}
var[0] = "OnDialogRequest"
var[1] = [[set_default_color|`o
add_label_with_icon|big|`9Auto Spam Settings```|left|242|
add_spacer|small|
add_custom_margin|x:0;y:0
add_checkbox|spamcolor|`2Enable `9Colored Text|]].. spamcolor_checkbox .. [[|
add_checkbox|spamemote|`9Add Emote Spamming|]].. spamemote_checkbox .. [[|
add_checkbox|spampulloff|`4Disable `9Auto Spam When You Pull Someone|]].. spampulloff_checkbox .. [[|
add_spacer|small|
add_custom_margin|x:0;y:-30|
add_text_input|spamtext|`9Spam Text :|Hello|50|
add_custom_margin|x:8;y:0|
add_custom_textbox|`9Insert Spam Text|size:small|
add_custom_margin|x:-8;y:0|
add_text_input|spamdelay|`9Interval (ms) :|4000|15|
add_custom_margin|x:8;y:0|
add_custom_textbox|`9Minimum Interval is 1000ms. (1000ms = 1 Seconds)|size:small|
add_custom_textbox|`9Auto Spam Currently `4Disable|size:small|
add_spacer|small|
add_quick_exit|
end_dialog|autospam|Discard Changes|Save Changes|
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
            setting.autoaccess = false
        elseif packet:find("autoaccess|1") then
            setting.autoaccess = true
        end

        if packet:find("fastunaccess|0") then
            setting.fastunaccess = false
        elseif packet:find("fastunaccess|1") then
            setting.fastunaccess = true
        end

        if packet:find("autochangedl|0") then
            setting.autochangedl = false
        elseif packet:find("autochangedl|1") then
            setting.autochangedl = true
        end
        
        if packet:find("fastchangebgl|0") then
            setting.fastchangebgl = false
        elseif packet:find("fastchangebgl|1") then
            setting.fastchangebgl = true
        end

        if packet:find("checkgems|0") then
            setting.checkgems = false
        elseif packet:find("checkgems|1") then
            setting.checkgems = true
        end

        --- Batas
        Sleep(1000)
        options()
    end

    --- Spin Checker
    if packet:find("dialog_name|spinchecker") then
        -- Checkbox
        if packet:find("spinstatus|0") then
            spin.status = false
        elseif packet:find("spinstatus|1") then
            spin.status = true
            if packet:find("buttonClicked|spindefault") then
                spin.mode = "Default"
                OnTextOverlay("`9Spin Checker Reset To `2Default")
            elseif packet:find("buttonClicked|spinreme") then
                spin.mode = "Reme"
                OnTextOverlay("`9Spin Checker Mode Set To: `2Reme/Peme/Leme")
            elseif packet:find("buttonClicked|spinqq") then
                spin.mode = "QQ"
                OnTextOverlay("`9Spin Checker Mode Set To: `2QQ/Qeme")
            elseif packet:find("buttonClicked|spincsn") then
                spin.mode = "Casino"
                OnTextOverlay("`9Spin Checker Mode Set To: `2Casino")
            end
        end
        RunThread(function()
            Sleep(1000)
            spinchecker()
        end)
    end

    -- Auto Spam
    if spam.pulloff == true then
        if packet:find("buttonClicked|pull") or packet:find("/pull") and spam.status == true then
            spam.status = false
        end
    end
    
    if packet:find("dialog_name|autospam") then
        if packet:find("spamcolor|0") then
            spam.color = true
        elseif packet:find("spamcolor|1") then
            spam.color = true
        end
        if packet:find("spamemote|0") then
            spam.emote = true
        elseif packet:find("spamemote|1") then
            spam.emote = true
        end
        if packet:find("spampulloff|0") then
            spam.pulloff = true
        elseif packet:find("spampulloff|1") then
            spam.pulloff = true
        end

        spam.text = packet:gsub("spamtext|(.)\n")
        spam.delay = packet:gsub("spamdelay|(%d+)\n")
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
    
    if packet == ("action|input\n|text|/fc") or packet == ("action|input\n|text|/close") then
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

    if packet == ("action|input\n|text|/relog") then
        OnConsoleMessage(systemlog)
        Relog_World = GetLocal().world
        SendPacket(3, "action|quit_to_exit")
        SendPacket(3, "action|join_request\nname|"..Relog_World.."\ninvitedWorld|0")
        return true
    end

    if packet == ("action|input\n|text|/bal") or packet == ("action|input\n|text|/balance") then
        AmountBGL = GetInventoryCount(7188)
        AmountDL = GetInventoryCount(1796)
        AmountWL = GetInventoryCount(242)
        OnConsoleMessage("")
    end

    -- Drops
    if packet:find("action|input\n|text|/cd") then
        amount = packet:gsub("action|input\n|text|/cd ", "")
        RunThread(function()
            bgl_count = GetInventoryCount(7188)
            dl_count = GetInventoryCount(1796)
            wl_count = GetInventoryCount(242)
            total_in_wls = (bgl_count * 10000) + (dl_count * 100) + wl_count

            bgl_to_drop = amount // 10000
            dl_to_drop = amount // 100 % 100
            wl_to_drop = amount % 100

            if amount == "" then
                OnConsoleMessage(systemlog .. "Write Amount")
                OnTextOverlay("`9Write Amount")
            elseif total_in_wls < amount then
                OnConsoleMessage(systemlog .. "Not Enough Locks")
                OnTextOverlay("`9Not Enough Locks")
            else
                AddCallback("Block Drop Dialog", "OnVarlist", hidedrop)
                if dl_count < dl_to_drop then
                    PacketRaw10(7188)
                    if wl_count < wl_to_drop then
                        PacketRaw10(1796)
                        if bgl_to_drop > 0 then
                            DropItem(7188, bgl_to_drop)
                            Sleep(400)
                        end
                        if dl_to_drop > 0 then
                            DropItem(1796, dl_to_drop)
                            Sleep(400)
                        end
                        if wl_to_drop > 0 then
                            DropItem(242, wl_to_drop)
                            Sleep(400)
                        end
                        Sleep(100)
                        OnConsoleMessage(systemlog .. "`9Dropping `2" .. dl_to_drop .. "Dls `9and `2" .. wl_to_drop .. "Wls")
                        OnTextOverlay("`9Dropping `2" .. dl_to_drop .. "Dls `9and `2" .. wl_to_drop .. "Wls")
                        return true
                    else
                        if bgl_to_drop > 0 then
                            DropItem(7188, bgl_to_drop)
                            Sleep(400)
                        end
                        if dl_to_drop > 0 then
                            DropItem(1796, dl_to_drop)
                            Sleep(400)
                        end
                        if wl_to_drop > 0 then
                            DropItem(242, wl_to_drop)
                            Sleep(400)
                        end
                        Sleep(100)
                        OnConsoleMessage(systemlog .. "`9Dropping `2" .. dl_to_drop .. "Dls `9and `2" .. wl_to_drop .. "Wls")
                        OnTextOverlay("`9Dropping `2" .. dl_to_drop .. "Dls `9and `2" .. wl_to_drop .. "Wls")
                        return true
                    end
                elseif wl_count < wl_to_drop then
                    PacketRaw10(1796)
                    if bgl_to_drop > 0 then
                        DropItem(7188, bgl_to_drop)
                        Sleep(400)
                    end
                    if dl_to_drop > 0 then
                        DropItem(1796, dl_to_drop)
                        Sleep(400)
                    end
                    if wl_to_drop > 0 then
                        DropItem(242, wl_to_drop)
                        Sleep(400)
                    end
                    Sleep(100)
                    OnConsoleMessage(systemlog .. "`9Dropping `2" .. dl_to_drop .. "Dls `9and `2" .. wl_to_drop .. "Wls")
                    OnTextOverlay("`9Dropping `2" .. dl_to_drop .. "Dls `9and `2" .. wl_to_drop .. "Wls")
                    return true
                else
                    if bgl_to_drop > 0 then
                        DropItem(7188, bgl_to_drop)
                        Sleep(400)
                    end
                    if dl_to_drop > 0 then
                        DropItem(1796, dl_to_drop)
                        Sleep(400)
                    end
                    if wl_to_drop > 0 then
                        DropItem(242, wl_to_drop)
                        Sleep(400)
                    end
                    Sleep(100)
                    OnConsoleMessage(systemlog .. "`9Dropping `2" .. dl_to_drop .. "Dls `9and `2" .. wl_to_drop .. "Wls")
                    OnTextOverlay("`9Dropping `2" .. dl_to_drop .. "Dls `9and `2" .. wl_to_drop .. "Wls")
                    return true
                end
                RemoveCallback("Block Drop Dialog")
            end
        end)
        return true
    end

    if packet:find("action|input\n|text|/dd") then
        amount = packet:gsub("action|input\n|text|/dd ", "")
        RunThread(function()
            bgl_count = GetInventoryCount(7188)
            dl_count = GetInventoryCount(1796)
            total_in_dls = (bgl_count * 100) + dl_count

            bgl_to_drop = amount // 100 % 100
            dl_to_drop = amount % 100
        
            if amount == "" then
                OnConsoleMessage(systemlog .. "Write Amount")
                OnTextOverlay("`9Write Amount")
            elseif total_in_dls < amount then
                OnConsoleMessage(systemlog .. "Not Enough Diamond Locks")
                OnTextOverlay("`9Not Enough Diamond Locks")
            else
                AddCallback("Block Drop Dialog", "OnVarlist", hidedrop)
                if dl_count < dl_to_drop then
                    PacketRaw10(7188)
                    if bgl_to_drop > 0 then
                        DropItem(7188, bgl_to_drop)
                        Sleep(400)
                    end
                    if dl_to_drop > 0 then
                        DropItem(1796, dl_to_drop)
                        Sleep(400)
                    end
                    OnConsoleMessage(systemlog .. "`9Dropping `2" .. bgl_to_drop .. "Bgls `9and `2" .. dl_to_drop .. "Dls")
                    OnTextOverlay("`9Dropping `2" .. bgl_to_drop .. "Bls `9and `2" .. dl_to_drop .. "Dls")
                    return true
                else
                    if bgl_to_drop > 0 then
                        DropItem(7188, bgl_to_drop)
                        Sleep(400)
                    end
                    if dl_to_drop > 0 then
                        DropItem(1796, dl_to_drop)
                        Sleep(400)
                    end
                    OnConsoleMessage(systemlog .. "`9Dropping `2" .. bgl_to_drop .. "Bgls `9and `2" .. dl_to_drop .. "Dls")
                    OnTextOverlay("`9Dropping `2" .. bgl_to_drop .. "Bls `9and `2" .. dl_to_drop .. "Dls")
                    return true
                end
            end
        end)
        return true
    end


    if packet == ("action|input\n|text|/spin") then
        spinchecker()
        return true
    end

    if packet:find("action|input\n|text|/spam") then
        autospam()
        return true
    end
    if packet == ("action|input\n|text|/cgems") then
        if setting.checkgems == false then
            setting.checkgems = true
            OnConsoleMessage(systemlog .. "Check Collected Gems `2Enabled")
        elseif setting.checkgems == true then
            setting.checkgems = false
            OnConsoleMessage(systemlog .. "Check Collected Gems `4Disabled")
        end
        return true
    end
end

---------------------------------------
-- Proxy System #2 (Variant List)
---------------------------------------
function SystemProxy(var)
    -- Auto Access
    if setting.autoaccess == true then
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
    if setting.fastunaccess == true then
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
    if setting.autochangedl == true then
        if var[0] == "OnConsoleMessage" and var[1]:find("Collected") then
            if GetInventoryCount(242) >= 100 then
                PacketRaw10(242)
                return true
            end
        end
    end

    -- Spam
    if spam.status == true then
        ChatColor = {"`1", "`2", "`3", "`4", "`5", "`6", "`7", "`8", "`9", "`0", "`!", "`@", "`#", "`$", "`^", "`&", "`w", "`o", "`p", "`b", "`q", "`e", "`r", "`t", "`a", "`s", "`c"}
        ChatEmote = {"/smile", "/cry", "/laugh", "/mad", "/wave", "/dance", "/love", "/sleep", "/yes", "/no", "/wink", "/troll", "/cheer", "/sad", "/fp", "/omg", "/shrug", "/furious", "/rolleyes", "/foldarms", "/dab", "/sassy", "/dance2", "/smh", "/march", "/shy", "/grumpy"}
        if spam.color == true then
            if spam.emote == true then
                Chat(ChatColor[math.random(1, #ChatColor)] .. spam.text)
                Sleep(400)
                Chat(ChatEmote[math.random(1, #ChatEmote)])
                Sleep(spam.delay)
            elseif spam.emote == false then
                Chat(ChatColor[math.random(1, #ChatColor)] .. spam.text)
                Sleep(spam.delay)
            else
                Chat(spam.text)
                Sleep(spam.delay)
            end
        elseif spam.color == false then
            if spam.emote == true then
                Chat(spam.text)
                Sleep(400)
                Chat(ChatEmote[math.random(1, #ChatEmote)])
                Sleep(spam.delay)
            elseif spam.emote == false then
                Chat(spam.text)
                Sleep(spam.delay)
            else
                Chat(spam.text)
                Sleep(spam.delay)
            end
        else
            Chat(spam.text)
            Sleep(spam.delay)
        end
    end

    -- Fast Changes BGL When Wrench Any Telephone
    if setting.fastchangebgl == true then
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
    
    -- Error Check Collected Gems
    function CheckGems_Thread()
        while setting.checkgems do
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
    end
end


---------------------------------------
-- Running Proxy System
---------------------------------------
OnConsoleMessage(systemlog .. "Injecting...")
OnTextOverlay("`1I`2n`3j`4e`5c`6t`7i`8n`9g`0..")
Sleep(1000)
AddCallback("System Proxy #1", "OnPacket", SystemPacket)
Sleep(500)
AddCallback("System Proxy #2", "OnVarlist", SystemProxy)
OnConsoleMessage(systemlog .. "Proxy Injected")
OnTextOverlay("`2Successfully Injected")
Sleep(1000)
SelectServer()