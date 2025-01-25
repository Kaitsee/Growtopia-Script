--Script by Limitz#4889
--dm for questions

local function Place(id, x, y)
  local player = GetLocal()
  local pkt_punch = {
    type = 3,
    int_data = id,
    pos_x = player.pos_x,
    pos_y = player.pos_y,
    int_x = x,
    int_y = y,
  }
  SendPacketRaw(pkt_punch)
end

function count(id)
local c = 0
for _, inv in pairs(GetInventory()) do
if inv.id == id then
c = c + inv.count
end
end
return c
end


function cook1(x, y)
RunThread(function()
    while true do
	SendPacket(2, "action|dialog_return\ndialog_name|homeoven_edit\nx|" ..x.. "|\ny|" ..y.. "|\ncookthis|3472|\nbuttonClicked|low")
	Place(4570, x, y)
	Sleep(300)
	Place(4570, x, y)
	Sleep(300)
	Place(4568, x ,y)
	Sleep(32600)
	Place(4602, x, y)
	Sleep(400)
	Place(4588, x , y)
	Sleep(36700)
	Place(962, x , y)
	Sleep(31000)
	Place(18, x, y)
	Sleep(16000)
	
	end 
end)
end



cook1(GetLocal().pos_x/32 - 2, GetLocal().pos_y/32 - 2)
Sleep(500)
cook1(GetLocal().pos_x/32 - 1, GetLocal().pos_y/32 - 2)
Sleep(500)
cook1(GetLocal().pos_x/32, GetLocal().pos_y/32 - 2)
Sleep(500)
cook1(GetLocal().pos_x/32 + 1, GetLocal().pos_y/32 - 2)
Sleep(500)
cook1(GetLocal().pos_x/32 + 2, GetLocal().pos_y/32 - 2)
Sleep(500)


cook1(GetLocal().pos_x/32 - 2, GetLocal().pos_y/32 - 1)
Sleep(500)
cook1(GetLocal().pos_x/32 - 1, GetLocal().pos_y/32 - 1)
Sleep(500)
cook1(GetLocal().pos_x/32, GetLocal().pos_y/32 - 1)
Sleep(500)
cook1(GetLocal().pos_x/32 + 1, GetLocal().pos_y/32 - 1)
Sleep(500)
cook1(GetLocal().pos_x/32 + 2, GetLocal().pos_y/32 - 1)
Sleep(500)

cook1(GetLocal().pos_x/32 - 2, GetLocal().pos_y/32)
Sleep(500)
cook1(GetLocal().pos_x/32 - 1, GetLocal().pos_y/32)
Sleep(500)
cook1(GetLocal().pos_x/32, GetLocal().pos_y/32)
Sleep(500)
cook1(GetLocal().pos_x/32 + 1, GetLocal().pos_y/32)
Sleep(500)
cook1(GetLocal().pos_x/32 + 2, GetLocal().pos_y/32)
Sleep(500)

cook1(GetLocal().pos_x/32 - 2, GetLocal().pos_y/32 + 1)
Sleep(500)
cook1(GetLocal().pos_x/32 - 1, GetLocal().pos_y/32 + 1)
Sleep(500)
cook1(GetLocal().pos_x/32, GetLocal().pos_y/32 + 1)
Sleep(500)
cook1(GetLocal().pos_x/32 + 1, GetLocal().pos_y/32 + 1)
Sleep(500)
cook1(GetLocal().pos_x/32 + 2, GetLocal().pos_y/32 + 1)
Sleep(500)

cook1(GetLocal().pos_x/32 - 2, GetLocal().pos_y/32 + 2)
Sleep(500)
cook1(GetLocal().pos_x/32 - 1, GetLocal().pos_y/32 + 2)
Sleep(500)
cook1(GetLocal().pos_x/32, GetLocal().pos_y/32 + 2)
Sleep(500)
cook1(GetLocal().pos_x/32 + 1, GetLocal().pos_y/32 + 2)
Sleep(500)
cook1(GetLocal().pos_x/32 + 2, GetLocal().pos_y/32 + 2)
Sleep(500)