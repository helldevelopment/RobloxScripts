local Executor = identifyexecutor()

if string.match(Executor, "Synapse") or string.match(Executor, "Wave") or string.match(Executor,"Rebel") or string.match(Executor,"MacSploit") or string.match(Executor,"Macsploit") then
    print("Loading Rivals for PC")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/helldevelopment/RobloxScripts/main/Games/Rivals/RivalsPC.lua"))()
else
    print("Loading Rivals for other devices")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/helldevelopment/RobloxScripts/main/Games/Rivals/RivalsOther.lua"))()
end
