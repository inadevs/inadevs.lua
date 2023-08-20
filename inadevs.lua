if game.PlaceId == 537413528 then
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Inadevs", "DarkTheme")

-- main
local Main = Window:NewTab("Main")
local Mainsection = Main:NewSection("Main")

Mainsection:NewLabel("Made by Inadevs")
Mainsection:NewLabel("Credits: Zeen")

Mainsection:NewButton("discord:", "Copys our discord server into your clipboard.", function()
    setclipboard("https://discord.gg/haurgfpMua")
    game.StarterGui:SetCore("SendNotification", {
    Title = "Inadevs";
    Text = "Discord Copied to Clipboard!";
     
    Duration = 5;
    })
end)

Mainsection:NewButton("youtube:", "Copys our youtube channel into your clipboard.", function()
    setclipboard("https://www.youtube.com/channel/UCQcfRItth2-1ai7h8IW5dCg")
    game.StarterGui:SetCore("SendNotification", {
    Title = "Inadevs";
    Text = "Youtube Copied to Clipboard!";
     
    Duration = 5;
    })
end)

Mainsection:NewButton("roblox group:", "Copys our roblox group into your clipboard.", function()
    setclipboard("https://www.roblox.com/groups/16475875/inadevs#!/about")
    game.StarterGui:SetCore("SendNotification", {
    Title = "Inadevs";
    Text = "Our roblox group has been copied to clipboard!";
     
    Duration = 5;
    })
end)

-- player

local player = Window:NewTab("Player")
local Playersection = player:NewSection("Player")

Playersection:NewSlider("WalkSpeed", "Change youre walkspeed", 500,16, function(s)
    game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = s
end)

Playersection:NewSlider("JumpPower", "Change youre JumpPower", 500,50, function(s)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = s
end)

local Player = game.Players.LocalPlayer
local Mouse = Player:GetMouse()
local UserInputService = game:GetService("UserInputService")

local toggle = false

local function onKeyPress(input)
    if input.KeyCode == Enum.KeyCode.Space and toggle then
        Player.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")
    end
end

UserInputService.InputBegan:Connect(onKeyPress)

local Section = {} 
local function ToggleFunction(state)
    toggle = state
    if toggle then
        print("Toggle On")
    else
        print("Toggle Off")
    end
end

Playersection:NewToggle("Infinity jump", "Jump high!", ToggleFunction)

local Player = game.Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")
local Mouse = Player:GetMouse()
local TeleportEnabled = false

local function Teleport(position)
    -- teleport
    Player.Character:SetPrimaryPartCFrame(CFrame.new(position))
end

local Toggle = Playersection:NewToggle("Enable Teleport", "Toggle Info", function(state)
    TeleportEnabled = state
end)

UserInputService.InputBegan:Connect(function(input)
    if TeleportEnabled and input.UserInputType == Enum.UserInputType.MouseButton1 and UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
        Teleport(Mouse.Hit.Position)
    end
end)

Playersection:NewButton("Anti afk", "Turn on anti afk", function()
for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.Idled)) do
   v:Disable()
end
 game.StarterGui:SetCore("SendNotification", {
    Title = "Inadevs";
    Text = "Anti afk has been enabled!";
     Duration = 5;
    })
end) 

noClipped = false

game:GetService("RunService").Stepped:Connect(function()
   if noClipped then
       pcall(function()
           for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
               if v.ClassName == "Part" or v.ClassName == "MeshPart" then
                   v.CanCollide = false
               end
           end
       end)
   end
end)

Playersection:NewToggle("Noclip", "Turn on and off noclip", function(state)
    if state then
        noClipped = true
        game.StarterGui:SetCore("SendNotification", {
     Title = "Inadevs";
    Text = "Noclip has been enabled!";
     
    Duration = 1;
    })
        print("Toggle On")
    else
        noClipped = false
         game.StarterGui:SetCore("SendNotification", {
     Title = "Inadevs";
    Text = "Noclip has been turned off. Jump 1 time to undo all the noclip.";
     
    Duration = 2;
    })
        print("Toggle Off")
    end
end)

-- build a boat autofarm
local Main = Window:NewTab("Build a boat")
local Boatsection = Main:NewSection("Autofarm")

Boatsection:NewButton("Autofarm", "Turns on autofarm", function()
getgenv().TreasureAutoFarm = {
    Enabled = true, -- // Toggle the auto farm on and off
    Teleport = 2, -- // How fast between each teleport between the stages and stuff
    TimeBetweenRuns = 5 -- // How long to wait until it goes to the next run
}

-- // Services
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local Lighting = game:GetService("Lighting")

-- // Vars
local LocalPlayer = Players.LocalPlayer

-- // Goes through all of the stages
local autoFarm = function(currentRun)
    -- // Variables
    local Character = LocalPlayer.Character
    local NormalStages = Workspace.BoatStages.NormalStages

    -- // Go to each stage thing
    for i = 1, 10 do
        local Stage = NormalStages["CaveStage" .. i]
        local DarknessPart = Stage:FindFirstChild("DarknessPart")

        if (DarknessPart) then
            -- // Teleport to next stage
            Character.HumanoidRootPart.CFrame = DarknessPart.CFrame

            -- // Create a temp part under you
            local Part = Instance.new("Part", LocalPlayer.Character)
            Part.Anchored = true
            Part.Transparency = 1
            Part.Position = LocalPlayer.Character.HumanoidRootPart.Position - Vector3.new(0, 6, 0)

            -- // Wait and remove temp part
            wait(getgenv().TreasureAutoFarm.Teleport)
            Part:Destroy()
        end
    end

    -- // Go to end
    repeat wait()
        Character.HumanoidRootPart.CFrame = NormalStages.TheEnd.GoldenChest.Trigger.CFrame
    until Lighting.ClockTime ~= 14

    -- // Wait until you have respawned
    local Respawned = false
    local Connection
    Connection = LocalPlayer.CharacterAdded:Connect(function()
        Respawned = true
        Connection:Disconnect()
    end)

    repeat wait() until Respawned
    wait(getgenv().TreasureAutoFarm.TimeBetweenRuns)
end

-- // Whilst the autofarm is enable, constantly do it
local autoFarmRun = 1
while wait() do
    if (getgenv().TreasureAutoFarm.Enabled) then
        autoFarm(autoFarmRun)
        autoFarmRun = autoFarmRun + 1
    end
end
end)

local Boatsection = Main:NewSection("TP")

Boatsection:NewButton("Library", "Tps you to the library", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(156, -10, 1170)
end)

Boatsection:NewButton("Chest", "Tps you to the chest", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-55, -360, 9410)
end)

Boatsection:NewButton("Blue team", "Tps you to the blue team", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(462, -10, 300)
end)

Boatsection:NewButton("Red team", "Tps you to the red team", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(463, -10, -65)
end)

Boatsection:NewButton("White team", "Tps you to the white team", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-50, -10, -586)
end)

Boatsection:NewButton("Black team", "Tps you to the black team", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-570, -10, -70)
end)

Boatsection:NewButton("Yellow team", "Tps you to the blue team", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-570, -10, 640)
end)

Boatsection:NewButton("Purple team", "Tps you to the blue team", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(461, -10, 647)
end)

Boatsection:NewButton("Green team", "Tps you to the green team", function()
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-570, -10, 295)
end)

local Main = Window:NewTab("misc")
local Guisection = Main:NewSection("misc")

Guisection:NewButton("avatar", "changes youre avatar to a yellow invisible tint", function()
for _, part in ipairs(game.Players.LocalPlayer.Character:GetDescendants()) do
    if part:IsA("BasePart") then
        
        -- Edit the following lines to modify the part's appearance
        part.Material = Enum.Material.ForceField -- Change the material of your body. Google "Roblox materials" to find available materials
        part.Transparency = 0.7 -- Change the transparency of your body. Set to 0 for no transparency.
        part.Color = Color3.fromRGB(221, 245, 5) -- Change the color of the part using RGB values. Google "RGB color picker" to find the RGB values for different colors. | examples: white: 255, 255, 255 | red: 255, 0, 0 | green: 0, 255, 0 | blue: 0, 0, 255
    end
end
end)

local Guisection = Main:NewSection("ingame")

Guisection:NewButton("kick yourself", "this button kicks yourself", function()
game.Players.LocalPlayer:Kick()
end)

local Guisection = Main:NewSection("Toggle GUI")

Guisection:NewKeybind("toggle keybind key:", "changes the keybind key", Enum.KeyCode.F, function()
	Library:ToggleUI()
 
 end)

end 
