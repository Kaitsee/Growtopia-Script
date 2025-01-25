ItemID = 5640 -- ID (Magplant Remote = 5640)
DelayBreaks = 80
DelayPlace = 60


OnTextOverlay("`4Script Is Running")


function Place(x, y, ID)
    SendPacketRaw({
        type = 3,
        int_data = ID,
        intx = x,
        inty = y,
        posx = math.floor(GetLocal().pos.x / 32),
        posy = math.floor(GetLocal().pos.y / 32),
    })
end

function main()
        Place(GetLocal().pos.x / 32 +1, GetLocal().pos.y / 32, ItemID)
        Sleep(DelayPlace)
        Place(GetLocal().pos.x / 32 +2, GetLocal().pos.y / 32, ItemID)
        Sleep(DelayPlace)
        Place(GetLocal().pos.x / 32 +3, GetLocal().pos.y / 32, ItemID)
        Sleep(DelayPlace)
        Place(GetLocal().pos.x / 32 +4, GetLocal().pos.y / 32, ItemID)
        Sleep(DelayPlace)
        Place(GetLocal().pos.x / 32 +5, GetLocal().pos.y / 32, ItemID)
        Sleep(DelayPlace)
        Place(GetLocal().pos.x / 32 +6, GetLocal().pos.y / 32, ItemID)
        Sleep(DelayPlace)
        Place(GetLocal().pos.x / 32 +7, GetLocal().pos.y / 32, ItemID)
        Sleep(DelayPlace)
        Place(GetLocal().pos.x / 32 +1, GetLocal().pos.y / 32, 18)
        Sleep(DelayPlace)
end

while true do
main()
end