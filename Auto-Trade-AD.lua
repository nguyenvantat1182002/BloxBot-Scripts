repeat wait() until game:IsLoaded()

local HttpService = game:GetService'HttpService'
local Players = game:GetService'Players'
local LocalPlayer = Players.LocalPlayer if not LocalPlayer then repeat LocalPlayer = Players.LocalPlayer task.wait() until LocalPlayer end task.wait(1)
local Remotes = game:GetService("ReplicatedStorage").Remotes


function WriteData(request, text)
    local data = HttpService:JSONEncode {
        Request = request,
        Text = text
    }
    writefile(LocalPlayer.Name .. '.json', data)
end


local receivingAccounts = {}

for _, username in ipairs(receivingAccounts) do
    if LocalPlayer.Name == username then
        local inventory = Remotes.GetInventory:InvokeServer()

        if inventory.TradeLimitCounts['Trades'] > 3 then
            break
        else
            continue
        end
    end

    loadstring(game:HttpGet(''))
        
    while true do
        local inventory = Remotes.GetInventory:InvokeServer()
        if inventory.Items['Trait Crystal'] == 0 then
            WriteData('Completed', '')
            return
        end
        
        WriteData('', 'Trade to: ' .. username)

        task.wait(5)
    end
end


loadstring(game:HttpGet(''))

while true do
    local inventory = Remotes.GetInventory:InvokeServer()
    if inventory.TradeLimitCounts['Trades'] < 3 then
        WriteData('Completed', '')
        return
    end

    WriteData('', 'Receiving...')

    task.wait(5)
end
