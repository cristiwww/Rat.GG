local player = game.Players.LocalPlayer
local killsValue = player:WaitForChild("leaderstats"):WaitForChild("Kills")

-- Cream GUI-ul
local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true
screenGui.ResetOnSpawn = false -- 🔥 foarte important: GUI-ul nu dispare la respawn
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Label pentru kills
local killsLabel = Instance.new("TextLabel")
killsLabel.Size = UDim2.new(0, 200, 0, 50)
killsLabel.Position = UDim2.new(1, -210, 1, -100) -- dreapta jos
killsLabel.BackgroundTransparency = 1
killsLabel.TextScaled = true
killsLabel.Font = Enum.Font.GothamBold
killsLabel.Text = "Kills: 0"
killsLabel.Parent = screenGui

-- Label pentru "made by cristimagi"
local madeBy = Instance.new("TextLabel")
madeBy.Size = UDim2.new(0, 200, 0, 30)
madeBy.Position = UDim2.new(1, -210, 1, -60) -- sub kills
madeBy.BackgroundTransparency = 1
madeBy.TextScaled = true
madeBy.Font = Enum.Font.Gotham
madeBy.Text = "made by cristimagi"
madeBy.TextTransparency = 0.3
madeBy.TextColor3 = Color3.fromRGB(200, 200, 200) -- gri elegant
madeBy.Parent = screenGui

-- Rainbow effect pentru kills
local RunService = game:GetService("RunService")
local hue = 0

RunService.RenderStepped:Connect(function(dt)
    hue = hue + dt * 0.2 -- viteza schimbării
    if hue > 1 then hue = 0 end
    local rainbowColor = Color3.fromHSV(hue, 1, 1)
    killsLabel.TextColor3 = rainbowColor
    killsLabel.TextTransparency = 0.3 -- semi-transparent
end)

-- Update kills automat
killsValue.Changed:Connect(function(newValue)
    killsLabel.Text = "Kills: " .. newValue
end)
