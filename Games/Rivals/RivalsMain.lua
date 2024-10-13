local Executor = identifyexecutor()

local Notification = loadstring(game:HttpGet("https://raw.githubusercontent.com/Jxereas/UI-Libraries/main/notification_gui_library.lua", true))()

Notification.new("error", "Error", "Rivals script is patched and detected, please wait until Rivals V2 releases",true,10) -- Args(<string> Type, <string> Heading, <string> Body, <boolean?> AutoRemoveNotif, <number?> AutoRemoveTime, <function?> OnCloseFunction)
--[[

if string.match(Executor, "Synapse") or string.match(Executor, "Wave") or string.match(Executor,"Rebel") or string.match(Executor,"MacSploit") or string.match(Executor,"macsploit is") then
    print("Loading Rivals for PC")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/helldevelopment/RobloxScripts/main/Games/Rivals/RivalsPC.lua"))()
else
    print("Loading Rivals for other devices")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/helldevelopment/RobloxScripts/main/Games/Rivals/RivalsOther.lua"))()
end
--]]
