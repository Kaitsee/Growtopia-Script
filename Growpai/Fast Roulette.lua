-- Fast Roulette By: Kaitsee
-- Discord: @Kaitsee_
-- Server Community: Coming Soon
-- This Script Its Free

SendVarlist({
    [0] = "OnAddNotification",
    [1] = "interface/atomic_button.rttex",
    [2] = "`3`0>> `^Noted By Owner Script `0<<\n`3Script Created By: `cKaitsee\n`2This Script Its Totally Free\n`3Discord: `c@Kaitsee_",
    [3] = "audio/hub_open.wav",
    [4] = 0,
    netid = -1,
})

SendVarlist({
    [0] = "OnConsoleMessage",
    [1] = "\n`0>> `^Noted By Owner Script `0<<\n`3Script Created By: `cKaitsee\n`2This Script Its Totally Free\n`3Discord: `c@Kaitsee_",
    netid = -1,
})

function FastRoulette(var)
    if var[0] == "OnTalkBubble" and var[3] ~= -1 and var[2]:find("spun the wheel and got") then
        SendVarlist({
            [0] = "OnTalkBubble",
            [1] = var[1],
            [2] = var[2],
            [3] = -1,
            netid = -1,
        })
        return true
    end

    if var[0] == "OnConsoleMessage" and var[1]:find("spun the wheel and got") then
        SendVarlist({
            [0] = "OnConsoleMessage",
            [1] = var[1],
            netid = -1,
        })
        return true
    end
end
AddCallback("FastRoulette", "OnVarlist", FastRoulette)