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

local HttpService = game:GetService'HttpService'
local Remotes = game:GetService("ReplicatedStorage").Remotes
local TeleportService = game:GetService("TeleportService")

getgenv().Key = "kf2e032c8ffdb6a1bea81e8f"

local TRADES_LIMIT = 15
local PLAYERS_IN_LOW_SERVER = 10
local UPDATE_INTERVAL = 5
local TRADE_LIMIT_MIN = 3

local receivingAccounts = {}
local table_ = {}


function writeData(request, text)
    local data = HttpService:JSONEncode {
        Request = request,
        Text = text
    }
    writefile(LocalPlayer.Name .. '.json', data)
end

function isHolder(username)
    for _, value in ipairs(receivingAccounts) do
        if value == username then
            return true
        end
    end

    return false
end

function joinLowServer(n)
    local players = Players:GetPlayers()
    if #players < n + 2 then
        return
    end

    local args = {
        [1] = "TradingLobby"
    }
    local servers = Remotes.GetServerList:InvokeServer(unpack(args))

    for area, _ in pairs(servers) do
        for jobId, value in pairs(servers[area]) do
            if value['PlayerCount'] < n then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, jobId, LocalPlayer)
            end
        end
    end
end


local isHolderPlayer = isHolder(LocalPlayer.Name)

if isHolderPlayer then
    getgenv().Config = {
        ["AutoSave"] = true,
        ["AutoTradeItem"] = true,
        ["AutoJoinTradeHub"] = true
    }
else
    getgenv().Config = {
        ["AutoSave"] = true,
        ["AutoTradeItem"] = true,
        ["TradeItem"] = {
            ["Star Rift (Purple)"] = true,
            ["Frost Bind"] = true,
            ["Star Rift (Red)"] = true,
            ["Star Rift (Yellow)"] = true,
            ["Star Rift (Green)"] = true,
            ["VIP (Gift)"] = true,
            ["Star Rift (Blue)"] = true,
            ["Magic Mirror"] = true,
            ["Trait Crystal"] = true,
            ["Shiny Hunter (Gift)"] = true,
            ["Divine Wish"] = true,
            ["Divine Dragon Battlepass (Gift)"] = true,
            ["Skip 10 Levels (Battlepass)"] = true,
            ["Risky Dice"] = true
        },
        ["ReceiverAccount2"] = table_[LocalPlayer.Name],
    }

end

spawn(function()
    loadstring(game:HttpGet("https://nousigi.com/loader.lua"))()
end)

while true do
    local inventory = Remotes.GetInventory:InvokeServer()
    local currentTradesLimit = TRADES_LIMIT - inventory.TradeLimitCounts['Trades']
    
    if isHolderPlayer then
        if currentTradesLimit > TRADE_LIMIT_MIN then
            if game.PlaceId == 17490500437 then
                joinLowServer(PLAYERS_IN_LOW_SERVER)
            end

            WriteData('', 'In transaction')
        elseif currentTradesLimit <= TRADE_LIMIT_MIN then
            WriteData('Completed', 'Transaction completed')
            return
        end
    else
        local holder = table_[LocalPlayer.Name]
        
        if inventory.Items['Trait Crystal'] == 0 then
            WriteData('Completed', 'Transferred to ' .. holder)
            return
        else
            WriteData('', 'Trade to' .. holder)
        end
    end
    
    task.wait(UPDATE_INTERVAL)
end
