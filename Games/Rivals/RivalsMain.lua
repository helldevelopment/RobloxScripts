local Executor = identifyexecutor()

local MessageBox = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/NotificationGUI/main/source.lua"))()


MessageBox.Show({Position = UDim2.new(0.5,0,0.5,0), Text = "sanity.wtf", Description = "Current Rivals script is patched and detected, \n please wait until Rivals V2 releases. \n Join discord.gg/sanitywtf for more information about V2", MessageBoxIcon = "Error", MessageBoxButtons = "OK", Result = function(res)
   if (res == "Yes") then
       MessageBox.Show({MessageBoxButtons = "OK", Description = "Wow, you said Yes! Thank you", Text = "YAYYY!"})
   elseif (res == "No") then
       MessageBox.Show({MessageBoxButtons = "OK", Description = "Ahh, sorry to dissapoint, I'll try better next time!", Text = "Nooooo"})
   end
end})
--[[

if string.match(Executor, "Synapse") or string.match(Executor, "Wave") or string.match(Executor,"Rebel") or string.match(Executor,"MacSploit") or string.match(Executor,"macsploit is") then
    print("Loading Rivals for PC")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/helldevelopment/RobloxScripts/main/Games/Rivals/RivalsPC.lua"))()
else
    print("Loading Rivals for other devices")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/helldevelopment/RobloxScripts/main/Games/Rivals/RivalsOther.lua"))()
end
--]]
