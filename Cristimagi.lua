local SoundEvent = nil :: RemoteEvent

for _, v in pairs(workspace:GetDescendants()) do 
    if v.Name == "AC6_FE_Sounds" then
        SoundEvent = v
        break
    end
end

local Characters = "qwertyuiopasdfghjklzxcvbnm1234567890"
local function GetName()
    local s = ""
    for i = 1, 25 do
        local sel = math.random(1, #Characters)
        s ..= string.sub(Characters, sel, sel)
    end
    return s
end

local Name = GetName()


SoundEvent:FireServer("newSound", Name, workspace, "http://www.roblox.com/asset/?id=73911978485280", 1, 10, true)
SoundEvent:FireServer("playSound", Name)


task.spawn(function()
    while task.wait(0.25) do
        SoundEvent:FireServer("updateSound", Name, "http://www.roblox.com/asset/?id=73911978485280", 1, 10)
    end
end)
