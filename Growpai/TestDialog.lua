var = {}
var[0] = "OnDialogRequest"
var[1] = [[set_default_color|`o
add_label_with_icon|big|`9Auto Spam Settings```|left|242|
add_spacer|small|
add_checkbox|spamcolor|`2Enable `9Colored Text|0|
add_checkbox|spamemote|`9Add Emote Spamming|0|
add_checkbox|spampulloff|`4Disable `9Auto Spam When You Pull Someone|
add_spacer|small|
add_custom_margin|x:8;y:-30|
add_text_input|spamtext|`9Spam Text :|Hello|120|
add_custom_textbox|`9Insert Spam Text|size:small|
add_text_input|spamdelay|`9Interval (ms) :|4000|10|
add_custom_textbox|`9Minimum Interval is 1000ms. (1000ms = 1 Seconds)|size:small|
add_custom_textbox|`9Auto Spam Currently `4Disable|size:small|
add_spacer|small|
add_quick_exit|
end_dialog|autospam|Discard Changes|Save Changes|
]]

var.netid = -1
SendVarlist(var)