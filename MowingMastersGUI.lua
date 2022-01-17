local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/AikaV3rm/UiLib/master/Lib.lua')))()

local w = library:CreateWindow("Mowing Masters GUI") -- Creates the window

local b = w:CreateFolder("Main") -- Creates the folder(U will put here your buttons,etc)
local c = w:CreateFolder("Teleports") -- Creates the folder(U will put here your buttons,etc)
local d = w:CreateFolder("Misc") -- Creates the folder(U will put here your buttons,etc)

b:Label("Made by xyba#0001",{
    TextSize = 14; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255); -- Self Explaining
    BgColor = Color3.fromRGB(69,69,69); -- Self Explaining
    
}) 

c:Label("Made by xyba#0001",{
    TextSize = 14; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255); -- Self Explaining
    BgColor = Color3.fromRGB(69,69,69); -- Self Explaining
    
}) 

d:Label("Made by xyba#0001",{
    TextSize = 14; -- Self Explaining
    TextColor = Color3.fromRGB(255,255,255); -- Self Explaining
    BgColor = Color3.fromRGB(69,69,69); -- Self Explaining
    
}) 

b:Button("Get Gamepasses",function()
    getAllGamepasses();
end)

b:Toggle("Auto Farm Grass",function(bool)
    getgenv().AutoLawn = bool

    if bool then
        autoLawn()
    end
end)

b:Toggle("Auto Farm Coins",function(bool)
    getgenv().AutofarmCoins = bool

    if bool then
        AutoCoins()
    end
end)

b:Slider("Sell at:",{
    min = 10; -- min value of the slider
    max = 50000; -- max value of the slider
    precise = true; -- max 2 decimals
},function(value)
    Val = value;
end)



b:Toggle("Auto Sell Grass",function(bool)
    getgenv().AutoSell = bool

    if bool then
        AutoSell(Val)
    end
end)

b:Toggle("Auto Rebirth",function(bool)
    getgenv().AutoRebirth = bool

    if bool then
        AutoRebirth()
    end
end)



c:Button("Spawn",function()
    tpTo(game:GetService("Workspace").Map.Main.Middle.Base["Meshes/Cylinder"].CFrame);
end)

c:Button("Portals",function()
    tpTo(game:GetService("Workspace").Map.Main.Portals.Base["Meshes/Octagon (1)"].CFrame);
end)

c:Button("Shop",function()
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-85, 26, 28)
end)

d:Slider("Walkspeed",{
    min = 10; -- min value of the slider
    max = 200; -- max value of the slider
    precise = true; -- max 2 decimals
},function(value)
    local hum = game:GetService("Players").LocalPlayer.Character.Humanoid
    hum.WalkSpeed = value
end)

d:Slider("Jumppower",{
    min = 10; -- min value of the slider
    max = 200; -- max value of the slider
    precise = true; -- max 2 decimals
},function(value)
    local hum = game:GetService("Players").LocalPlayer.Character.Humanoid
    hum.JumpPower = value
end)


b:DestroyGui()




getgenv().AutofarmCoins = false;
getgenv().AutoLawn = false;
getgenv().AutoRebirth = false;
getgenv().AutoUpgradeBasic = false;
getgenv().AutoSell = false;

local hb = game.RunService.Heartbeat;


function tpTo(NewCFRAME)
	(game:service("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = NewCFRAME;
end;

local tpAgain = false;
function AutoSell(AtAmount)
    spawn(function()
        while AutoSell do
            if (game:GetService("Players").LocalPlayer.Data.Grass.Value >= AtAmount) then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-44, 26, 10)
                wait(2)
                autoLawn();
            end
            wait(6)
        end
    end) 
end

function UpgradeBasic()
	spawn(function()
		while AutoUpgradeBasic do
			local args = {
				[1] = "basic",
				[2] = "Tools"
			}

			game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.ShopService.Upgrade:FireServer(unpack(args))
		wait(3)
		end
	end)
end

function AutoRebirth()
    spawn(function()
        while AutoRebirth do
            game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.RebirthService.Rebirth:FireServer()
            wait(3)
        end
    end)
end

function autoLawn()
	spawn(function()
        if AutoLawn then
            (game:service("Players")).LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(-282.0246887207, 22, 285.26571655273), Vector3.new(-0, -0, -1))
        end
		while AutoLawn do
            local args = {
                [1] = CFrame.new(Vector3.new(-282.0246887207, 22, 285.26571655273), Vector3.new(-0, -0, -1))
            }
            
            game:GetService("ReplicatedStorage").Aero.AeroRemoteServices.MowingService.GrantGrass:FireServer(unpack(args))
            hb:Wait(1);
        end;
	end);
end;

function AutoCoins()
	spawn(function()
		while AutofarmCoins do
			if (game:GetService("Workspace")).Debris:FindFirstChild("Coins") then
				tpTo((game:GetService("Workspace")).Debris.Coins.HumanoidRootPart.CFrame);
			end;
			hb:Wait();
		end;
	end);
end;

function getAllGamepasses()
    local GetPasses = game:GetService("Players").LocalPlayer.Passes;
    GetPasses.DoubleGrass.Value = true;
    GetPasses.VIP.Value = true;
    GetPasses.Blackhole.Value = true;
    GetPasses.DoubleLuck.Value = true;
    GetPasses.TripleHatch.Value = true;
    GetPasses.DoubleCoins.Value = true;
    GetPasses.DoubleHealth.Value = true;
    GetPasses.InfiniteStorage.Value = true;
    GetPasses.DoubleSpeed.Value = true;
    GetPasses.DoubleRebirths.Value = true;
    GetPasses.DoubleDamage.Value = true; 
    game.StarterGui:SetCore("SendNotification", {
        Title = "Mowing Masters GUI";
        Text = "Gamepasses unlocked!";
        Icon = "";
        Duration = 5;
    })
end

--anti afk by Sigmarillion
local vu = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
   vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
   wait(1)
   vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
end)
