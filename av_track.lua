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


function getLevel()
    local s = ''

    if game.placeId == 16146832113 then
        s = LocalPlayer.PlayerGui.HUD.Main.Level.Level.Text
    else
        s = LocalPlayer.PlayerGui.Hotbar.Main.Level.Level.Text
    end

    local items = s:split(' ')
    local level = items[2]

    return tonumber(level)
end

function WriteData(request, text)
    local data = HttpService:JSONEncode {
        Request = request,
        Text = text
    }
    writefile(LocalPlayer.Name .. '.json', data)
end

local updateInterval = 30
local maximumLevel = 70

task.wait(updateInterval)

while true do
    local level = getLevel()
    local s = 'Level: '..tostring(level)

    if level >= maximumLevel then
        WriteData('Completed', s)
        return
    end
    
    WriteData('', s)

    task.wait(updateInterval)
end
