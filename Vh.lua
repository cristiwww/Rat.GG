local VenyxLibrary = loadstring(game:HttpGet("https://raw.githubusercontent.com/Documantation12/Universal-Vehicle-Script/main/Library.lua"))()
local Venyx = VenyxLibrary.new("Magi Vehicle Script", 5013109572)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

local Theme = {
	Background = Color3.fromRGB(61, 60, 124), 
	Glow = Color3.fromRGB(60, 63, 221), 
	Accent = Color3.fromRGB(55, 52, 90), 
	LightContrast = Color3.fromRGB(64, 65, 128), 
	DarkContrast = Color3.fromRGB(32, 33, 64),  
	TextColor = Color3.fromRGB(255, 255, 255)
}

for index, value in pairs(Theme) do
	pcall(Venyx.setTheme, Venyx, index, value)
end

--==============================
-- PAGINA VEHICLE (curățată)
--==============================
local vehiclePage = Venyx:addPage("Vehicle", 8356815386)

-- Usage Section
local usageSection = vehiclePage:addSection("Usage")
local velocityEnabled = true
usageSection:addToggle("Keybinds Active", velocityEnabled, function(v) velocityEnabled = v end)

-- Acceleration Section
local speedSection = vehiclePage:addSection("Acceleration")
local velocityMult = 0.025
local velocityEnabledKeyCode = Enum.KeyCode.W
speedSection:addSlider("Multiplier (Thousandths)", 25, 0, 50, function(v) velocityMult = v / 1000 end)
speedSection:addKeybind("Velocity Enabled", velocityEnabledKeyCode, function()
	if not velocityEnabled then return end
	while UserInputService:IsKeyDown(velocityEnabledKeyCode) do
		task.wait(0)
		local Character = LocalPlayer.Character
		if Character then
			local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
			if Humanoid then
				local SeatPart = Humanoid.SeatPart
				if SeatPart and SeatPart:IsA("VehicleSeat") then
					SeatPart.AssemblyLinearVelocity *= Vector3.new(1 + velocityMult, 1, 1 + velocityMult)
				end
			end
		end
		if not velocityEnabled then break end
	end
end, function(v) velocityEnabledKeyCode = v.KeyCode end)

-- Deceleration Section
local decelerateSelection = vehiclePage:addSection("Deceleration")
local qbEnabledKeyCode = Enum.KeyCode.S
local velocityMult2 = 150e-3
decelerateSelection:addSlider("Brake Force (Thousandths)", velocityMult2*1e3, 0, 300, function(v) velocityMult2 = v / 1000 end)
decelerateSelection:addKeybind("Quick Brake Enabled", qbEnabledKeyCode, function()
	if not velocityEnabled then return end
	while UserInputService:IsKeyDown(qbEnabledKeyCode) do
		task.wait(0)
		local Character = LocalPlayer.Character
		if Character then
			local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
			if Humanoid then
				local SeatPart = Humanoid.SeatPart
				if SeatPart and SeatPart:IsA("VehicleSeat") then
					SeatPart.AssemblyLinearVelocity *= Vector3.new(1 - velocityMult2, 1, 1 - velocityMult2)
				end
			end
		end
		if not velocityEnabled then break end
	end
end, function(v) qbEnabledKeyCode = v.KeyCode end)

decelerateSelection:addKeybind("Stop the Vehicle", Enum.KeyCode.P, function()
	if not velocityEnabled then return end
	local Character = LocalPlayer.Character
	if Character then
		local Humanoid = Character:FindFirstChildWhichIsA("Humanoid")
		if Humanoid then
			local SeatPart = Humanoid.SeatPart
			if SeatPart and SeatPart:IsA("VehicleSeat") then
				SeatPart.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
				SeatPart.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
			end
		end
	end
end)

--==============================
-- FUNCȚIE DE ÎNCHIDERE CU [ ]
--==============================
local function CloseGUI()
    Venyx:toggle()
end

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and input.KeyCode == Enum.KeyCode.RightBracket then
        CloseGUI()
    end
end)
