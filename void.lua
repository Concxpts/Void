-- ISSUES: SPEED DOESN'T UNTOGGLE, CUSTOM LIGHTING CAN'T BE DISABLED

local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Concepts0/Void/experimental/vapelib.lua"))()

local ws = game:GetService("Workspace")
local reps = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local rs = game:GetService("RunService")
local ts = game:GetService("TweenService")

local plr = players.LocalPlayer
local char = plr.Character
local m = plr:GetMouse()
local cam = ws.CurrentCamera

local walkSpeed = 16
local jumpPower = 50

--#region Functions
function AntiAFK()
    local client = game:GetService("VirtualUser")

    plr.Idled:Connect(function()
        client:Button2Down(Vector2.new(0,0),cam.CFrame)
        wait(1)
        client:Button2Up(Vector2.new(0,0),cam.CFrame)
    end)
end

function Speed(t)
    local speedToggled = t

    spawn(function() 
        while speedToggled do wait()
            plr.Character.Humanoid.WalkSpeed = walkSpeed

            if not speedToggled then break end
        end
    end)

    if not speedToggled then plr.Chracter.Humanoid.WalkSpeed = 16 end
end

function SuperJump(t)
    local jumpToggled = t

    spawn(function() 
        while jumpToggled do wait()
            plr.Character.Humanoid.JumpPower = jumpPower

            if not jumpToggled then break end
        end
    end)

    if not jumpToggled then plr.Character.Humanoid.JumpPower = 50 end
end

function InfiniteJump(t)
    local infiniteJumpToggled = t

    local function Action(Object, Function) if Object ~= nil then Function(Object); end end

    game:GetService("UserInputService").InputBegan:connect(function(UserInput)
        if UserInput.UserInputType == Enum.UserInputType.Keyboard and UserInput.KeyCode == Enum.KeyCode.Space and infiniteJumpToggled then
            Action(char.Humanoid, function(self)
                if self:GetState() == Enum.HumanoidStateType.Jumping or self:GetState() == Enum.HumanoidStateType.Freefall then
                    Action(self.Parent.HumanoidRootPart, function(self)
                        self.Velocity = Vector3.new(0, jumpPower, 0);
                    end)
                end
            end)
        end
    end)
end

function Lighting()
    local l = game:GetService("Lighting")
    local tr = ws.Terrain

    local cc = Instance.new("ColorCorrectionEffect")
    local sr = Instance.new("SunRaysEffect")
    local b = Instance.new("BlurEffect")
    local a = Instance.new("Atmosphere")
    local s = Instance.new("Sky")
    local c = Instance.new("Clouds")

    l.Brightness = 1
    l.EnvironmentDiffuseScale = .2
    l.EnvironmentSpecularScale = .82
    sr.Parent = Lighting
    a.Parent = Lighting
    s.Parent = Lighting
    s.SunAngularSize = 5
    b.Size = 3.921
    b.Parent = Lighting
    cc.Parent = Lighting
    cc.Saturation = .092
    c.Parent = Lighting

    tr.WaterTransparency = 1
    tr.WaterReflectance = 1
end

function BloxburgAutofarm(t)
    repeat wait() until game:IsLoaded()

    local stats = reps.Stats[plr.Name]
    local dm = require(reps.Modules.DataManager)

    local function fireServer(data)
        local oldI = getfenv(dm.FireServer).i
        
        getfenv(dm.FireServer).i = function() end
        dm:FireServer(data)
        getfenv(dm.FireServer).i = oldI
    end

    local function getOrder(c)
        if not c or (c and not c:FindFirstChild("Order")) then return end

        if stats.Job.Value == "StylezHairdresser" then 
            local style = c.Order:WaitForChild("Style").Value
            local color = c.Order:WaitForChild("Color").Value

            return {style, color}
        elseif stats.Job.Value == "BloxyBurgersCashier" then
            local burger = c.Order:WaitForchild("Burger").Value
            local fries = c.Order:WaitForChild("Fries").Value
            local cola = c.Order:WaitForChild("Cola").Value

            return {burger, fries, cola}
        end
    end

    if (t == 1) then
        if (stats.Job.Value ~= "StylezHairdresser") then
            jobManager:GoToWork("StylezHairdresser")
        end
        
        repeat wait() until stats.Job.Value == "StylezHairdresser"

        ts:Create(plr.Character.HumanoidRootPart, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(868.464783, 13.6776829, 174.983795, -0.999945581, -6.58446098e-08, -0.0104347449, -6.6522297e-08, 1, 6.45977494e-08, 0.0104347449, 6.52883756e-08, -0.999945581)}):Play()
        
        while true do
            local workstations = ws.Environment.Locations.StylezHairStudio.HairdresserWorkstations
            for _,v in next, workstations:GetChildren() do
                if (v.Occupied.Value) then
                    fireServer({Type = "FinishOrder", Workstation = v ,Order = getOrder(v.Occupied.Value)})
                end
            end

            wait()
        end
    elseif(t == 2) then
        if (stats.Job.Value ~= "BloxyBurgersCashier") then
            jobManager:GoToWork("BloxyBurgersCashier")
        end;
        
        repeat wait() until stats.Job.Value == "BloxyBurgersCashier"
        ts:Create(plr.Character.HumanoidRootPart, TweenInfo.new(0.75, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {CFrame = CFrame.new(825.076355, 13.6776829, 276.091309, 0.0133343497, -5.09454665e-08, -0.999910772, 7.34347916e-09, 1, -5.08520621e-08, 0.999910772, -6.66474698e-09, 0.0133343497)}):Play()
        
        while true do
            local workstations = ws.Environment.Locations.BloxyBurgers.CashierWorkstations;
            for _,v in next, workstations:GetChildren() do
                if (v.Occupied.Value) then
                    fireServer({Type = "FinishOrder", Workstation = v, Order = getOrder(v.Occupied.Value)})
                end
            end

            wait()
        end
    end
end
--#endregion

--#region UI
--#region Init
local window = lib:Window("Void",Color3.fromRGB(139, 80, 221),Enum.KeyCode.RightShift)

local S1, S2, S4, S5 = window:Tab("Player"), window:Tab("Server"), window:Tab("ESP"), window:Tab("Script Hub")
--#endregion

--#region Game : Bloxburg
if game.PlaceId == 185655149 then
    local S3 = window:Tab("Bloxburg")
	local handler = require(game:GetService("Players").LocalPlayer.PlayerGui.MainGUI.Scripts.GUIHandler);

    S3:Label("Autofarm")

    S3:Button("Bloxburg Autofarm : Hair Dressing", function()
        BloxburgAutofarm(1)
		handler:AlertBox("Started Hair Dressing Autofarm. To ensure you don't get banned (still could happen), make sure to as many cars as possible and sell them at the end of your shift.", "Autofarm Started", 5);
    end)

    S3:Button("Bloxburg Autofarm : Cashier", function()
        lib:Notification("Autofarm Started", "Cashier autofarm has begun.", "Ok")

        BloxburgAutofarm(2)
		handler:AlertBox("Started Cashier Autofarm. To ensure you don't get banned (still could happen), make sure to as many cars as possible and sell them at the end of your shift.", "Autofarm Started", 5);
    end)
end
--#endregion

--#region Game : Nuclear Bomb Testing Facility
if game.PlaceId == 6153709 then
    local S3 = window:Tab("Nuclear Bomb Testing Facility")
    local nbtfInfiniteAmmoToggled = false

    local weaponList = {
        "UMP-9",
        "MPX",
        "Imaginary Gun",
        "M4 Carbine",
        "AK74",
        "Spy USP",
        "God Gun",
        "USP"
    }

    S3:Label("Weapons")

    -- God Gun
    S3:Button("God Gun", function()
        for _,tool in pairs(plr.Backpack:GetChildren()) do
            for _,weaponName in pairs(weaponList) do
                if tool.Name == weaponName and tool.Name ~= "God Gun" then
                    tool.Name = "God Gun"
                    tool.ToolTip = "Bring the wrath of God to your weapon. Let hell rain down on your enemies."
                    tool.Configuration.ShotCooldown.Value = 0
                    tool.Configuration.RecoilMin.Value = 0
                    tool.Configuration.RecoilMax.Value = 0
                    tool.Configuration.RecoilDecay.Value = 0
                    tool.Configuration.HitDamage.Value = math.huge
                    tool.Configuration.MuzzleFlashSize1.Value = 0
                    tool.Configuration.MuzzleFlashSize0.Value = 0
                    tool.Configuration.TotalRecoilMax.Value = 0
                    tool.Configuration.MaxSpread.Value = 0
                    tool.Configuration.MaxDistance.Value = math.huge
                end
            end
        end

        for _,tool in pairs(plr.Character:GetChildren()) do
            for _,weaponName in pairs(weaponList) do
                if tool.Name == weaponName and tool.Name ~= "God Gun" then
                    tool.Name = "God Gun"
                    tool.ToolTip = "Bring the wrath of God to your weapon. Let hell rain down on your enemies."
                    tool.Configuration.ShotCooldown.Value = 0
                    tool.Configuration.RecoilMin.Value = 0
                    tool.Configuration.RecoilMax.Value = 0
                    tool.Configuration.RecoilDecay.Value = 0
                    tool.Configuration.HitDamage.Value = 999
                    tool.Configuration.MuzzleFlashSize1.Value = 0
                    tool.Configuration.MuzzleFlashSize0.Value = 0
                    tool.Configuration.TotalRecoilMax.Value = 0
                    tool.Configuration.MaxSpread.Value = 0
                    tool.Configuration.MaxDistance.Value = 999999
                end
            end
        end
    end)

    -- Infinite Ammo Toggle
    S3:Toggle("Infinite Ammo", function(v)
        if v then nbtfInfiniteAmmoToggled = true else nbtfInfiniteAmmoToggled = false end

        spawn(function() 
            while nbtfInfiniteAmmoToggled do 
                if nbtfInfiniteAmmoToggled then
                    for _,tool in pairs(plr.Backpack:GetChildren()) do
                        for _,weaponName in pairs(weaponList) do
                            if string.match(tool.Name, weaponName) then
                                tool.Configuration.AmmoReserves.Value = math.huge
                                tool.Configuration.AmmoCapacity.Value = math.huge
                                tool.CurrentAmmo.Value = math.huge
                            end
                        end
                    end

                    for _,tool in pairs(plr.Character:GetChildren()) do
                        for _,weaponName in pairs(weaponList) do
                            if string.match(tool.Name, weaponName) then
                                tool.Configuration.AmmoReserves.Value = math.huge
                                tool.Configuration.AmmoCapacity.Value = math.huge
                                tool.CurrentAmmo.Value = math.huge
                            end
                        end
                    end
                else break end

                wait()
            end      
        end)
    end)
end
--#endregion

--#region Player
S1:Label("General")

S1:Button("Anti-AFK Kick", function() AntiAFK() end)

S1:Toggle("Toggle Badge Notifications",false,function(v)
    if v then
        game:GetService("StarterGui"):SetCore("BadgesNotificationsActive", true)
    else
        game:GetService("StarterGui"):SetCore("BadgesNotificationsActive", false)
    end
end)

S1:Toggle("Toggle Point Notifications",false,function(v)
    if v then
        game:GetService("StarterGui"):SetCore("PointsNotificationsActive", true)
    else
        game:GetService("StarterGui"):SetCore("PointsNotificationsActive", false)
    end
end)

S1:Label("Movement")

S1:Toggle("Speed",false,function(v) Speed(v) end)
S1:Slider("Speed Amount",16,150,0,function(v) walkSpeed = v end)

S1:Toggle("Super Jump",false,function(v) SuperJump(v) end)
S1:Toggle("Infinite Jump",false,function(v) InfiniteJump(v) end)
S1:Slider("Jump Power",50,1000,0,function(v) jumpPower = v end)
--#endregion

--#region Server
S2:Button("Lighting Enhancemnets",function(v) Lighting(v) end)
S2:Button("Rejoin Server", function() game:GetService("TeleportService"):Teleport(game.PlaceId, plr) end)
--#endregion

--#region Script Hub
S5:Label("Essential")
S5:Button("Simple Spy",function() loadstring(game:HttpGet("https://raw.githubusercontent.com/Concepts0/Void/experimental/scripts/simplespy.lua"))() end)
S5:Button("Dark Dex V3",function() if game:GetService'CoreGui':FindFirstChild'Dex'then game:GetService'CoreGui'.Dex:Destroy()end;math.randomseed(tick())local a={}for b=48,57 do table.insert(a,string.char(b))end;for b=65,90 do table.insert(a,string.char(b))end;for b=97,122 do table.insert(a,string.char(b))end;function RandomCharacters(c)if c>0 then return RandomCharacters(c-1)..a[math.random(1,#a)]else return''end end;local d=game:GetObjects('rbxassetid://3567096419')[1]d.Name=RandomCharacters(math.random(5,20))d.Parent=game:GetService('CoreGui')local function e(f,g)local function h(i,j)local k={}local l={script=j}local m={}m.__index=function(n,o)if l[o]==nil then return getfenv()[o]else return l[o]end end;m.__newindex=function(n,o,p)if l[o]==nil then getfenv()[o]=p else l[o]=p end end;setmetatable(k,m)setfenv(i,k)return i end;local function q(j)if j.ClassName=='Script'or j.ClassName=='LocalScript'then spawn(function()h(loadstring(j.Source,'='..j:GetFullName()),j)()end)end;for b,r in pairs(j:GetChildren())do q(r)end end;q(f)end;e(d) end)
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
