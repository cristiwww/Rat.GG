local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
screenGui.IgnoreGuiInset = true -- să acopere tot ecranul
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Frame pe tot ecranul
local overlay = Instance.new("Frame")
overlay.Size = UDim2.new(1, 0, 1, 0) -- full screen
overlay.Position = UDim2.new(0, 0, 0, 0)
overlay.BackgroundTransparency = 0.5 -- 0.5 = semi-transparent
overlay.BorderSizePixel = 0
overlay.Parent = screenGui

-- Rainbow effect
local RunService = game:GetService("RunService")
local hue = 0

RunService.RenderStepped:Connect(function(dt)
    hue = hue + dt * 0.2 -- viteza schimbării
    if hue > 1 then hue = 0 end
    local rainbowColor = Color3.fromHSV(hue, 1, 1)
    overlay.BackgroundColor3 = rainbowColor
end)
