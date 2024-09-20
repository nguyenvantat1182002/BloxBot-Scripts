repeat task.wait(1) until game:IsLoaded()

local HttpService = game:GetService'HttpService'
local Players = game:GetService'Players'

local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    repeat
        LocalPlayer = Players.LocalPlayer
        task.wait(1)
    until LocalPlayer
end

function writeData(request, text)
    local data = HttpService:JSONEncode {
        Request = request,
        Text = text
    }
    writefile(LocalPlayer.Name .. '.json', data)
end

task.wait(10)

local args = {
    [1] = "Select",
    [2] = "Roku"
}

game:GetService("ReplicatedStorage").Networking.Units.UnitSelectionEvent:FireServer(unpack(args))

task.wait(10)

writeData('Completed', '')
