repeat task.wait(1) until game:IsLoaded()

local Players = game:GetService('Players')
local LocalPlayer = Players.LocalPlayer
if not LocalPlayer then
    repeat
        LocalPlayer = Players.LocalPlayer
        task.wait(1)
    until LocalPlayer
end
task.wait(1)

local HttpService = game:GetService('HttpService')
local ReplicatedStorage = game:GetService("ReplicatedStorage")


function getGems()
    local str = LocalPlayer.PlayerGui.HUD.Main.Currencies.Gems.Gems.Text
    local cleaned_str = string.gsub(str, ",", "")
    local number = tonumber(cleaned_str)
    return number
end

function writeData(request, text)
    local data = HttpService:JSONEncode {
        Request = request,
        Text = text
    }
    writefile(LocalPlayer.Name .. '.json', data)
end

function existsInTable(tbl, value)
    for _, v in pairs(tbl) do
        if v == value then
            return true
        end
    end

    return false
end

function getUnits()
    local result = {}
    local units = LocalPlayer.PlayerGui.Windows.Units.Holder.Main.Units:GetChildren()

    for _, value in units do
        if value:IsA("Frame") then
            table.insert(result, value.Holder.Main.UnitName.Text)
        end
    end

    return result
end


task.wait(10)

local codes = {'100MVISITS', '800KLIKES', 'THXFOR1MLIKES'}
for _, value in pairs(codes) do
    local args = {
        [1] = value
    }
    ReplicatedStorage.Networking.CodesEvent:FireServer(unpack(args))
    task.wait(3)
end

local target = 'Song Jinwu'
local args = {
    [1] = "SummonTen",
    [2] = "Special"
}
while true do
    local gems = getGems()
    if gems < 500 then
        break
    end
    
    ReplicatedStorage.Networking.Units.SummonEvent:FireServer(unpack(args))
    task.wait(3)

    local units = getUnits()
    if existsInTable(units, target) then
        break
    end

    task.wait(3)
end

task.wait(10)

local units = getUnits()
local text = ''
if existsInTable(units, target) then
    text = target
else
    text = 'Not found'
end

writeData('Completed', text)

print('Completed')

