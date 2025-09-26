local player = game.Players.LocalPlayer
local camera = workspace.CurrentCamera
local userInputService = game:GetService("UserInputService")
 
-- GUI Setup
local screenGui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
screenGui.Name = "FOVSliderGui"
screenGui.ResetOnSpawn = false
 
-- Enable UI drag behavior
local function makeDraggable(frame)
    local dragging = false
    local dragInput, dragStart, startPos
 
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(
            startPos.X.Scale, startPos.X.Offset + delta.X,
            startPos.Y.Scale, startPos.Y.Offset + delta.Y
        )
    end
 
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)
 
    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)
 
    userInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)
end
 
-- Toggle Button
local toggleButton = Instance.new("TextButton", screenGui)
toggleButton.Position = UDim2.new(0.9, -60, 0.05, 0)
toggleButton.Size = UDim2.new(0, 60, 0, 30)
toggleButton.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
toggleButton.TextColor3 = Color3.new(1, 1, 1)
toggleButton.Text = "FOV"
toggleButton.TextScaled = true
makeDraggable(toggleButton)
 
-- FOV Frame
local frame = Instance.new("Frame", screenGui)
frame.Position = UDim2.new(0.35, 0, 0.9, 0)
frame.Size = UDim2.new(0.3, 0, 0.08, 0)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 2
frame.Visible = false
makeDraggable(frame)
 
-- Slider
local slider = Instance.new("TextButton", frame)
slider.Size = UDim2.new(0.05, 0, 1, 0)
slider.Position = UDim2.new((camera.FieldOfView - 1)/119, 0, 0, 0)
slider.BackgroundColor3 = Color3.fromRGB(100, 200, 255)
slider.Text = ""
 
-- FOV Label
local fovLabel = Instance.new("TextLabel", frame)
fovLabel.Size = UDim2.new(1, 0, 0.5, 0)
fovLabel.Position = UDim2.new(0, 0, -1, 0)
fovLabel.BackgroundTransparency = 1
fovLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
fovLabel.TextScaled = true
fovLabel.Text = "FOV: " .. camera.FieldOfView
 
-- Toggle Visibility
toggleButton.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)
 
-- Slider Logic
local draggingSlider = false
local activeInput = nil
 
slider.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        draggingSlider = true
        activeInput = input
    end
end)
 
userInputService.InputEnded:Connect(function(input)
    if input == activeInput then
        draggingSlider = false
        activeInput = nil
    end
end)
 
userInputService.InputChanged:Connect(function(input)
    if draggingSlider and input == activeInput then
        local pos = input.Position.X
        local framePos = frame.AbsolutePosition.X
        local frameSize = frame.AbsoluteSize.X
 
        local relativeX = math.clamp(pos - framePos, 0, frameSize)
        local percent = relativeX / frameSize
        local newFOV = math.floor(1 + (percent * 119))
 
        slider.Position = UDim2.new(percent, -slider.Size.X.Offset / 2, 0, 0)
        camera.FieldOfView = newFOV
        fovLabel.Text = "FOV: " .. newFOV
    end
end)
