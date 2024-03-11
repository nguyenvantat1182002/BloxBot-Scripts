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

local function formatNumber(num)
    return tostring(num):reverse():gsub("(%d%d%d)", "%1,"):reverse():gsub("^,", "")
end

local getDiamond = function()
    for i, v in pairs(Library.Inventory.Currency) do
        if v.id == "Diamonds" then
            return v._am
        end
    end
    return 0
end


local updateInterval = 60
local nextUpdate = 0
local previousDiamondCount = getDiamond()

while true do
    if os.time() > nextUpdate then
        local currentDiamondCount = getDiamond()
        local totalDiamondPerMin = math.abs(currentDiamondCount - previousDiamondCount)
        WriteData("", tostring(formatNumber(currentDiamondCount)) .. "/" .. tostring(formatNumber(totalDiamondPerMin)) .. " diamonds")
        
        previousDiamondCount = getDiamond()
        nextUpdate = os.time() + updateInterval
    end

    task.wait(1)
end
