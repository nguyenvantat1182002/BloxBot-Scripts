repeat wait() until game:IsLoaded()

local HttpService = game:GetService'HttpService'
local Players = game:GetService'Players'
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    repeat
        LocalPlayer = Players.LocalPlayer
        task.wait(1)
    until LocalPlayer
end
task.wait(1)


function getGems()
    return LocalPlayer:GetAttribute('Gems') or 0
end

function getLevel()
    return LocalPlayer:GetAttribute('Level') or 1
end

function WriteData(request, text)
    local data = HttpService:JSONEncode {
        Request = request,
        Text = text
    }
    writefile(LocalPlayer.Name .. '.json', data)
end

local updateInterval = 30
local target = 100000

while true do
    local level = getLevel()
    local gems = getGems()
    local s = 'Level: '..tostring(level)..', Gems: '..tostring(gems)

    if gems >= target then
        WriteData('Completed', s)
        return
    end
    
    WriteData('', s)

    task.wait(updateInterval)
end
