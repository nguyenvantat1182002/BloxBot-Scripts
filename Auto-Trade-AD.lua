repeat wait() until game:IsLoaded()

local Players = game:GetService'Players'
local LocalPlayer = Players.LocalPlayer if not LocalPlayer then repeat LocalPlayer = Players.LocalPlayer task.wait() until LocalPlayer end task.wait(1)
local HttpService = game:GetService'HttpService'
local Remotes = game:GetService("ReplicatedStorage").Remotes
local TeleportService = game:GetService("TeleportService")
local TeleportService = game:GetService("TeleportService")
local TRADES_LIMIT = 15


local receivingAccounts = {}
local firstTime = true

function JoinLowServer(n)
    local players = Players:GetPlayers()
    if #players < n + 2 then
        return
    end

    local args = {
        [1] = "TradingLobby"
    }
    local servers = Remotes.GetServerList:InvokeServer(unpack(args))

    for k, v in pairs(servers) do
        for k, v in pairs(servers[k]) do
            if v['PlayerCount'] < n then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, k, Players.LocalPlayer)
            end
        end
    end
end


function WriteData(request, text)
    local data = HttpService:JSONEncode {
        Request = request,
        Text = text
    }
    writefile(LocalPlayer.Name .. '.json', data)
end


for _, username in ipairs(receivingAccounts) do
    if LocalPlayer.Name == username then
        break
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

while true do
    local inventory = Remotes.GetInventory:InvokeServer()
    local currentTradesLimit = TRADES_LIMIT - inventory.TradeLimitCounts['Trades']
    
    if currentTradesLimit > 3 then
        if firstTime then
            if game.PlaceId == 17490500437 then
                JoinLowServer(n)
            end
            loadstring(game:HttpGet(''))
            firstTime = false
        end
    elseif currentTradesLimit < 3 then
        WriteData('Completed', '')
        return
    end

    WriteData('', 'Receiving...')

    task.wait(5)
end
