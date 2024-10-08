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

getgenv().Key = ""

local TRADES_LIMIT = 15
local PLAYERS_IN_LOW_SERVER = 10
local UPDATE_INTERVAL = 5
local TRADE_LIMIT_MIN = 3
local TRADING_LOBBY_ID = 17490500437

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
    local args = {
        [1] = "TradingLobby"
    }
    local servers = Remotes.GetServerList:InvokeServer(unpack(args))

    for area, _ in pairs(servers) do
        for jobId, value in pairs(servers[area]) do
            if value['PlayerCount'] < n then
                TeleportService:TeleportToPlaceInstance(game.PlaceId, jobId, LocalPlayer)
                return
            end
        end
    end
end

function sameServerWith(username)
    local players = Players:GetPlayers()
    for _, value in pairs(players) do
        if value == username then
            return true
        end
    end

    return false
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
        ["AutoJoinTradeHub"] = true,
    }

end

spawn(function()
    loadstring(game:HttpGet("https://nousigi.com/loader.lua"))()
end)

if isHolderPlayer then
    while true do
        if game.PlaceId == TRADING_LOBBY_ID then
            local players = Players:GetPlayers()
            if #players < PLAYERS_IN_LOW_SERVER + 2 then
                break
            end
        
            joinLowServer(PLAYERS_IN_LOW_SERVER)
        end

        task.wait(UPDATE_INTERVAL)
    end
end

local dealine = 0

while true do
    local inventory = Remotes.GetInventory:InvokeServer()
    local currentTradesLimit = TRADES_LIMIT - inventory.TradeLimitCounts['Trades']
    
    if isHolderPlayer then
        if currentTradesLimit > TRADE_LIMIT_MIN then
            if not dealine == 0 and LocalPlayer.PlayerGui.PAGES.CaptchaPage.Visible and os.time() > dealine then
                writeData('Rejoin', '')
                return
            end
            
            if LocalPlayer.PlayerGui.PAGES.CaptchaPage.Visible and dealine == 0 then
                dealine = os.time() + 5
            end

            if not LocalPlayer.PlayerGui.PAGES.CaptchaPage.Visible then
                dealine = 0
            end
            
            writeData('', 'In transaction')
        elseif currentTradesLimit <= TRADE_LIMIT_MIN then
            writeData('Completed', 'Transaction completed')
            return
        end
    else
        local holder = table_[LocalPlayer.Name]
        
        if game.PlaceId == TRADING_LOBBY_ID and sameServerWith(holder) then
            if inventory.Items['Trait Crystal'] == 0 then
                writeData('Completed', 'Transferred to ' .. holder)
                return
            else
                writeData('', 'Trade to ' .. holder)
            end
        else
            writeData('Rejoin', '')
            return
        end
    end
    
    task.wait(UPDATE_INTERVAL)
end
