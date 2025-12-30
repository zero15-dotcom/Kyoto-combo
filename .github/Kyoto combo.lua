-- TSB Garou AUTO KYOTO COMBO LOCAL - Pega directo en Delta/Fluxus o GitHub
-- GUI GRANDE MOBILE, Auto Aim, Timings PERFECTOS 2025 - No loadstring

if game.PlaceId ~= 10449761463 then
    game.StarterGui:SetCore("SendNotification", {Title = "❌ Error"; Text = "SOLO The Strongest Battlegrounds!"; Duration = 5})
    return
end

local player = game.Players.LocalPlayer
local UIS = game:GetService("UserInputService")
local VIM = game:GetService("VirtualInputManager")
local RS = game:GetService("RunService")
local cam = workspace.CurrentCamera

local executing = false
local cooldown = false

-- Tools Garou exactos
local flowingTool = "Fist of Flowing Water"
local whirlwindTool = "Lethal Whirlwind Stream"

-- Fire M1
local function m1()
    pcall(function()
        player.Character.Communicate:FireServer({Mobile = true, Goal = "LeftClick"})
    end)
end

-- Fire Move
local function fireMove(toolName)
    local tool = player.Backpack:FindFirstChild(toolName) or player.Character:FindFirstChild(toolName)
    if tool then
        pcall(function()
            player.Character.Communicate:FireServer({Tool = tool, Goal = "Console Move"})
        end)
    end
end

-- Nearest Enemy Auto Aim
local function getNearest()
    local char = player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return nil end
    local root = char.HumanoidRootPart
    local closest, dist = nil, 40
    for _, p in pairs(game.Players:GetPlayers()) do
        if p ~= player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") and p.Character.Humanoid.Health > 0 then
            local d = (root.Position - p.Character.HumanoidRootPart.Position).Magnitude
            if d < dist then
                closest = p
                dist = d
            end
        end
    end
    return closest
end

-- AUTO KYOTO FULL
local function doKyoto()
    if executing or cooldown then return end
    local target = getNearest()
    if not target then
        game.StarterGui:SetCore("SendNotification", {Title = "❌ No Enemy"; Text = "Acércate a un enemigo (<40 studs)"; Duration = 3})
        return
    end
    if not (player.Backpack:FindFirstChild(flowingTool) or player.Character:FindFirstChild(flowingTool)) then
        game.StarterGui:SetCore("SendNotification", {Title = "❌ No Garou"; Text = "Equipa Fist of Flowing Water!"; Duration = 3})
        return
    end

    executing = true
    cooldown = true
    print("🌀 KYOTO AUTO en " .. target.Name)

    -- Auto Aim
    local tRoot = target.Character.HumanoidRootPart
    cam.CFrame = CFrame.lookAt(cam.CFrame.Position, tRoot.Position)

    -- Starter: 4 M1 + Jump Uppercut
    for i = 1, 4 do
        m1()
        wait(0.35)
    end
    VIM:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
    wait(
