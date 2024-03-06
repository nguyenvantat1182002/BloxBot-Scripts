local HttpService = game:GetService'HttpService'
local Players = game:GetService'Players'
local LocalPlayer = Players.LocalPlayer if not LocalPlayer then repeat LocalPlayer = Players.LocalPlayer task.wait() until LocalPlayer end task.wait(1)
local Library = require(game.ReplicatedStorage.Library.Client.Save).Get()


function WriteData(request, text)
    local data = HttpService:JSONEncode {
        Request = request,
        Text = text
    }
    
    writefile(LocalPlayer.Name .. '.json', data)
end

local getDiamond = function()
    for i, v in pairs(Library.Inventory.Currency) do
        if v.id == "Diamonds" then
            return v._am
        end
    end
    return 0
end

local updateInterval = 30
local shutdownInterval = 120

local nextUpdate = 0
local nextShutdown = os.time() + shutdownInterval
local previousDiamondCount = getDiamond()

while true do
    local currentDiamondCount = getDiamond()

    if os.time() > nextUpdate then
        WriteData("", tostring(currentDiamondCount) .. " diamonds")
        nextUpdate = os.time() + updateInterval
    end

    if os.time() > nextShutdown then
        if math.abs(currentDiamondCount - previousDiamondCount) < 2000 then
            WriteData("Rejoin", tostring(currentDiamondCount) .. " diamonds")
            return
        end

        nextShutdown = os.time() + shutdownInterval
        previousDiamondCount = getDiamond()
    end

    task.wait(1)
end
