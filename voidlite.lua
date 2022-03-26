local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Concepts0/Void/experimental/vapelib.lua"))()

--#region Functions
local ws = game:GetService("Workspace")
local reps = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local rs = game:GetService("RunService")
local ts = game:GetService("TweenService")

local plr = players.LocalPlayer
local cam = ws.CurrentCamera

local walkSpeed = 16
local jumpPower = 50

function AntiAFK()
    local client = game:GetService("VirtualUser")

    plr.Idled:Connect(function()
        client:Button2Down(Vector2.new(0,0),cam.CFrame)
        wait(1)
        client:Button2Up(Vector2.new(0,0),cam.CFrame)
    end)
end

function Speed(toggled)
    local speedToggled = toggled

    spawn(function() 
        while speedToggled do
            plr.Character.Humanoid.WalkSpeed = walkSpeed

            if not speedToggled then break end

            wait()
        end
    end)

    if not speedToggled then plr.Chracter.Humanoid.WalkSpeed = 16 end
end

function SuperJump(toggled)
    local jumpToggled = toggled

    spawn(function() 
        while jumpToggled do
            plr.Character.Humanoid.JumpPower = jumpPower

            if not jumpToggled then break end
            wait()
        end
    end)

    if not jumpToggled then plr.Character.Humanoid.JumpPower = 50 end
end
--#endregion

--#region UI
--#region Init
local window = lib:Window("Void",Color3.fromRGB(139, 80, 221),Enum.KeyCode.RightShift)

local S1, S2, S4, S5 = window:Tab("Player"), window:Tab("Server"), window:Tab("ESP"), window:Tab("Script Hub")
--#endregion

--#region Player
S1:Label("General")

S1:Button("Anti-AFK Kick", function()
    AntiAFK()
end)

S1:Label("Movement")

S1:Toggle("Speed",false,function(v) Speed(v) end)
S1:Slider("Speed Amount",16,150,16,function(v) walkSpeed = v end)

S1:Toggle("Super Jump",false,function(v) SuperJump(v) end)
S1:Slider("Jump Power",50,1000,50,function(v) jumpPower = v end)
--#endregion

--#region Server
S2:Button("Rejoin Server", function() game:GetService("TeleportService"):Teleport(game.PlaceId, plr) end)
--#endregion

--#region Script Hub
S5:Label("Essential")
S5:Button("Simple Spy",function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Concepts0/Void/experimental/scripts/simplespy.lua"))() end)
S5:Button("Dark Dev V4",function() loadstring(game:HttpGetAsync("https://pastebin.com/raw/iuQPQq4M"))() end) 
S5:Label("Hubs")
S5:Button("Solaris",function() loadstring(game:HttpGet('https://solarishub.dev/script.lua',true))() end)
S5:Button("Domain Hub",function() loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexsoftworks/Domain/main/source'),true))() end)
S5:Label("Jailbreak")
S5:Button("Autorob",function() loadstring(game:HttpGet("https://raw.githubusercontent.com/wawsdasdacx/ohascriptnrrewading/main/jbsaxcriptidk1"))() end)
S5:Label("Lumber Tycoon 2")
S5:Button("Ancestor",function() loadstring(game:HttpGetAsync'https://ancestordevelopment.wtf/Ancestor')('Ancestor V3 Winning :D') end)
S5:Button("Dirt",function() loadstring(game:HttpGet("https://dirtgui.xyz/Lt2.lua",true))() end)
S5:Button("Bark",function() loadstring(game:HttpGetAsync'https://cdn.applebee1558.com/bark/bark.lua')('bark > blood :)') end)
S5:Label("Apocalypse Rising")
S5:Button("Tripp",function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Concepts0/Void/experimental/scripts/tripp.lua"))() end)
S5:Label("Bedwars")
S5:Button("Vape",function() loadstring(game:HttpGet("https://raw.githubusercontent.com/7GrandDadPGN/VapeV4ForRoblox/main/NewMainScript.lua", true))() end)
S5:Label("Clone Tycoon 2")
S5:Button("Script",function() task.spawn(loadstring(game:HttpGet("https://paste.ee/r/N0fo7/0")),[[also if it doesn't load look in the console for some warns / errors]]) end)
S5:Label("Simulators")
S5:Button("Mining Simulator",function() loadstring(game:HttpGet(("https://raw.githubusercontent.com/GuentherHade/Roblox/main/Obfuscated.lua"),true))() end)
S5:Button("Pet Simulator X",function() loadstring(game:HttpGet("https://pastebin.com/raw/95HthyJq"))() end)
S5:Label("Phantom Forces")
S5:Button("ehub.fun",function() loadstring(game:HttpGet("https://ehub.fun/raw/script.lua"))() end)
S5:Label("Prison Life")
S5:Button("Admin Commands",function() loadstring(game:HttpGet(('https://raw.githubusercontent.com/XTheMasterX/Scripts/Main/PrisonLife'),true))() end)
--#endregion
--#endregion
