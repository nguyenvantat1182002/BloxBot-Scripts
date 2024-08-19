repeat task.wait(1) until game:IsLoaded()

local Players = game:GetService'Players'
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    repeat
        LocalPlayer = Players.LocalPlayer
        task.wait(1)
    until LocalPlayer
end
task.wait(1)

local HttpService = game:GetService('HttpService')
local Library = require(game.ReplicatedStorage.Library.Client.Save).Get()


function writeData(request, text)
    local data = HttpService:JSONEncode {
        Request = request,
        Text = text
    }
    writefile(LocalPlayer.Name .. '.json', data)
end


local updateInterval = 30

while true do
    local pets = {}
    for _, v in pairs(Library.Inventory.Pet) do
        table.insert(pets, v.id)
    end

    local petsString = table.concat(pets, ",")
    writeData('', 'Pets: ' .. petsString)

    task.wait(updateInterval)
end
