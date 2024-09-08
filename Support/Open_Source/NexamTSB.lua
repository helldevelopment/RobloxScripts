
-- I've decided to release the TSB source of nexam since I fully made it and nexity quit
-- You can skid, paste it, or update it whatever you want. I will not care.

-- The Strongest Battle Grounds script base 
-- dear other devs dont use getgenv plz use configuration tables plz 🙏 - jay

-- follow luraph macros too please

-- library


local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/3345-c-a-t-s-u-s/NEVERLOSE-UI-Nightly/main/source.lua"))()
local Notification = Library:Notification()

local DebugPrint = true

if not LPH_OBFUSCATED then
    function LPH_NO_VIRTUALIZE(f) 
        return f 
    end; 
else
    DebugPrint = false
end

if NEXAM_LOADED and LPH_OBFUSCATED then
    Notification:Notify("error", "Double Execution Detected", "Please only execute Nexam once!", 5)
    return
end


getgenv().NEXAM_LOADED = true

-- variables

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = game:GetService("Players").LocalPlayer

local Humanoid = LocalPlayer.Character:WaitForChild("Humanoid")

local NexamConfiguration = {
    Main = {
        Combat = {
            AttackAura = false,
            AutoCombo = false,
        },
        Farm = {
            KillFarm = false,
            AutoUltimate = true,
        },
        -- gib more suggestions
    },
    Player = {
        Character = {
            OverwriteProperties = false,
            WalkSpeed = 50,
            JumpPower = 100,
        },
    },
}

-- functions

local Functions = {}

do
    function Functions.DebugPrint(Message)
        if DebugPrint then
            print("[NEXAM] "..Message) 
        end
    end
    
    function Functions.BestTarget(MaxDistance)
        local Target = nil
        MaxDistance = MaxDistance or math.huge
        local MaxKills = math.huge
        for _, v in pairs(game:GetService("Players"):GetPlayers()) do
            if v ~= LocalPlayer then
                if v.Character and v.Character:FindFirstChild("Humanoid") then
                    if v.Character.Humanoid.Health > 0 and v.Character:FindFirstChild("HumanoidRootPart") then
                        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
                            local Distance = (LocalPlayer.Character.HumanoidRootPart.Position - v.Character.HumanoidRootPart.Position).Magnitude
                            Functions.DebugPrint("Distance for "..v.Name..": "..Distance)
                            if Distance < MaxDistance and v:GetAttribute("Kills") < MaxKills then
                                MaxDistance = Distance
                                Target = v
                                MaxKills = v:GetAttribute("Kills")
                            end
                        else
                            Functions.DebugPrint("Local character humanoid missing bruh")
                        end
                    end
                end 
            end
        end
        return Target
    end
    function Functions.UseAbility(Ability)
        local Tool = LocalPlayer.Backpack:FindFirstChild(Ability)
        local Arguments = {
            [1] = {
                ["Tool"] = Tool,
                ["Goal"] = "Console Move",
                ["ToolName"] = tostring(Ability)
            }
        }
        game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(Arguments))
    end
    function Functions.RandomAbility()
        local Hotbar = LocalPlayer.PlayerGui.Hotbar.Backpack.Hotbar
        local Ablilites = {}
        local NotEmpty = false
        for _,v in pairs(Hotbar:GetChildren()) do
            if v.ClassName ~= "UIListLayout" and v.Visible then
                if v.Base.ToolName.Text ~= "N/A" then
                    if not v.Base:FindFirstChild("Cooldown") then
                        table.insert(Ablilites,v)
                        NotEmpty = true
                    end
                end
            end
        end
        local RandomAbility
        if NotEmpty then
            RandomAbility = Ablilites[math.random(1,#Ablilites)] 
        end
        return RandomAbility
    end
    function Functions.ActivateUltimate()
        local Arguments = {
            [1] = {
                ["MoveDirection"] = Vector3.new(0, 0, 0),
                ["Key"] = Enum.KeyCode.G,
                ["Goal"] = "KeyPress"
            }
        }
        game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(Arguments))
    end
    function Functions.Hit(Release)
        local Arguments = {
            [1] = {
                ["Goal"] = "LeftClick"
            }
        }
        game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(Arguments))
        if Release then
            delay(2,function()
                local Arguments = {
                    [1] = {
                        ["Goal"] = "LeftClickRelease"
                    }
                }
                game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(Arguments)) 
            end)
        end
    end
    function Functions.TeleportToPlayer(player, offset, method) -- i kinda just pasted this from my other projects
        local character = player.Character
        if character and character:FindFirstChild("HumanoidRootPart") then
            if offset == nil then
                LocalPlayer.Character:SetPrimaryPartCFrame(character.HumanoidRootPart.CFrame) 
            elseif offset == true then
                if method == "Behind" then
                    LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(player.Character.HumanoidRootPart.Position - Vector3.new(0,3,0) + player.Character.Head.CFrame.lookVector * -5)) 
                    --LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position - Vector3.new(0,3,0) + player.Character.HumanoidRootPart.CFrame.lookVector * -5)
                elseif method == "Above" then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(player.Character.HumanoidRootPart.Position + Vector3.new(0,5,0))
                else
                    LocalPlayer.Character:SetPrimaryPartCFrame(character.HumanoidRootPart.CFrame) 
                end
            end 
        end
    end
    Functions.DebugPrint("jaysterrz was here")    
end

-- connections

do
    local OldIndex = nil

    --[[ doesnt matter we need support for executors
    OldIndex = hookmetamethod(game, "__index", LPH_NO_VIRTUALIZE(function(Self, Key) -- im not sure if TSB anti cheat is clientsided ( if it exists ) but ima just keep this
        if NexamConfiguration.Player.Character.OverwriteProperties and not checkcaller() and Self == Humanoid and Key:lower() == "walkspeed" then
            return 16
        end
        if NexamConfiguration.Player.Character.OverwriteProperties and not checkcaller() and Self == Humanoid and Key:lower() == "jumppower" then
            return 50
        end
    
        return OldIndex(Self, Key)
    end))
    -]]
    RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function(deltaTime)
        if Humanoid ~= nil then
            if NexamConfiguration.Main.Combat.AttackAura then
                local NearestTarget = Functions.BestTarget(5)
                if NearestTarget ~= nil then
                    local RandomAbility = Functions.RandomAbility()
                    if RandomAbility then
                        Functions.UseAbility(RandomAbility.Base.ToolName.Text)
                    else
                        Functions.Hit(true)
                    end
                end
            end
            if NexamConfiguration.Main.Farm.KillFarm then
                if NexamConfiguration.Main.Farm.AutoUltimate then
                    local UltimateBar = LocalPlayer:GetAttribute("Ultimate")
                    if UltimateBar >= 100 then
                        Functions.ActivateUltimate()
                        print("yes")
                    else
                        print("no")
                    end
                end
                local BestTarget = Functions.BestTarget()
                if BestTarget ~= nil then
                    Functions.TeleportToPlayer(BestTarget)
                    local RandomAbility = Functions.RandomAbility()
                    if RandomAbility then
                        Functions.UseAbility(RandomAbility.Base.ToolName.Text)
                    else
                        Functions.Hit(true)
                    end
                end
            end
        end
    end)) 

    
    RunService.RenderStepped:Connect(LPH_NO_VIRTUALIZE(function(deltaTime)
        Humanoid = LocalPlayer.Character:WaitForChild("Humanoid") 
        if Humanoid ~= nil then
            if NexamConfiguration.Player.Character.OverwriteProperties then
                Humanoid.WalkSpeed = NexamConfiguration.Player.Character.WalkSpeed
                Humanoid.JumpPower = NexamConfiguration.Player.Character.JumpPower 
            end
        end
    end)) 
end


-- ui related shit

do

    Library:Theme("original") -- [ dark , nightly , original ]
    ------------------
    
    local Window = Library:AddWindow("Nexam Hub","The Strongest Battlegrounds | discord.gg/nexamhub")
    
    Notification.MaxNotifications = 6
    
    Window:AddTabLabel('Home')
    
    local MainTab = Window:AddTab('Main','home') -- [ads , list , folder , earth , locked , home , mouse , user]
    local PlayerTab = Window:AddTab('Player','earth')
    local SettingsTab = Window:AddTab('Settings','locked')
    
    local CombatSection = MainTab:AddSection('Combat',"left")

    
    
    CombatSection:AddToggle('Attack Aura',false,function(val)
        NexamConfiguration.Main.Combat.AttackAura = val
    end)

    local FarmSection = MainTab:AddSection('Farm',"right")
    
    FarmSection:AddToggle('Kill Farm',false,function(val)
        NexamConfiguration.Main.Farm.KillFarm = val
    end)

    FarmSection:AddToggle('Auto Ultimate',true,function(val)
        NexamConfiguration.Main.Farm.AutoUltimate = val
    end)

    local CharacterSection = PlayerTab:AddSection('Character',"left")
    
    CharacterSection:AddToggle('Overwrite Properties',false,function(val)
        NexamConfiguration.Player.Character.OverwriteProperties = val
    end)

    CharacterSection:AddSlider('Walkspeed',50,250,50,function(val)
        NexamConfiguration.Player.Character.WalkSpeed = val
    end)

    CharacterSection:AddSlider('Jumppower',50,250,50,function(val)
        NexamConfiguration.Player.Character.JumpPower = val
    end)

    local UISection = SettingsTab:AddSection('UI',"left")

    UISection:AddButton("Unload UI",function()
        Window:Delete()
        Notification:Notify("info","Unloaded!","Unloaded the UI, rejoin and execute again if you want to open it.")
    end)

    UISection:AddButton("Copy Discord",function()
        setclipboard("discord.gg/nexam")
        Notification:Notify("info","Copied!","Copied 'discord.gg/nexam' to your clipboard.")
    end)
end
