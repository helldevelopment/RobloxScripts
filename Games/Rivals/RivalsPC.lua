local Executor = identifyexecutor()

if string.match(Executor, "Synapse") or string.match(Executor, "Wave") then
    print("Loading Rivals for PC")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/helldevelopment/RobloxScripts/main/Games/Rivals/RivalsMain.lua"))()
else
    print("Loading Rivals for other devices")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/helldevelopment/RobloxScripts/main/Games/Rivals/RivalsOther.lua"))()
end
