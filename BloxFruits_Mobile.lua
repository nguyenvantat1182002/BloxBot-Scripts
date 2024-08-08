repeat wait() until game:IsLoaded()
repeat wait() until game.Players
repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
repeat wait() until game:GetService("Players").LocalPlayer:FindFirstChild("DataLoaded")
repeat wait() until game.Players.LocalPlayer:FindFirstChild("PlayerGui")

local HttpService = game:GetService'HttpService'
local Players = game:GetService'Players'
local RunService = game:GetService'RunService'
local TeleportService = game:GetService'TeleportService'
local LocalPlayer = Players.LocalPlayer if not LocalPlayer then repeat LocalPlayer = Players.LocalPlayer task.wait() until LocalPlayer end task.wait(0.5)
local UserInputService = game:GetService("UserInputService")

-- 1K
-- 1K5
-- MELEE
-- GOD
-- CDK
-- CDKSG
local TypeDone = "CDKSG"

local decalsyeeted = true
local g = game
local w = g.Workspace
local l = g.Lighting
local t = w.Terrain
local UGS = UserSettings():GetService'UserGameSettings'
local fileName = LocalPlayer.Name .. '.json'


function WriteData(request, text)
	local data = HttpService:JSONEncode {
	    Request = request,
	    Text = text
	}
	
	writefile(fileName, data)
end

function CheckItem(Item)
    has = false
    for i, v in pairs(game:GetService("ReplicatedStorage").Remotes["CommF_"]:InvokeServer("getInventory")) do
        if v.Name == Item then
            has = true
        end
    end
    for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("Tool") and v.Name == Item then
            has = true
        end
    end
    for i, v in pairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and v.Name == Item then
            has = true
        end
    end
    return has
end

function checkLeopardI()
    local inv = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("getInventory")
    for i, v in pairs(inv) do
        if v.Type == "Blox Fruit" then
            if v.Rarity == 4 and v.Name == "Leopard-Leopard" then
                return "|Leo"
            end
        end
    end
    return ""
end

function checkLeopardU()
	if game:GetService("Players").LocalPlayer.Data.DevilFruit.Value == "Leopard-Leopard" then
		return "|Leo"
	end
	return ""
end

function checkMochi()
	if game:GetService("Players").LocalPlayer.Data.DevilFruit.Value == "Dough-Dough" then
		local Awaked = 0
		local AwakedAbilComF = game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("getAwakenedAbilities")
		if AwakedAbilComF then 
			for i, v in pairs(AwakedAbilComF) do 
				if v["Awakened"] then 
					Awaked = Awaked + 1 
				end 
			end
		end

		FullAwakeCheck = false

		if Awaked == 6 then
			FullAwakeCheck = true
		end

		if FullAwakeCheck then
			return "|MCV2"
		else
			return "|MCV1"
		end
	end

	return ""
end

function checkKitsune()
    local inv = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("getInventory")
    for i, v in pairs(inv) do
        if v.Type == "Blox Fruit" then
            if v.Rarity == 4 and v.Name == "Kitsune-Kitsune" then
                return "|Kit"
            end
        end
    end
    return ""
end

function checkTRex()
    local inv = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("getInventory")
    for i, v in pairs(inv) do
        if v.Type == "Blox Fruit" then
            if v.Rarity == 4 and v.Name == "T-Rex-T-Rex" then
                return "|T-Rex"
            end
        end
    end
    return ""
end

function checkDragon()
    local inv = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("getInventory")
    for i, v in pairs(inv) do
        if v.Type == "Blox Fruit" then
            if v.Name == "Dragon-Dragon" then
                return "|Dragon"
            end
        end
    end
    return ""
end

function checkMammoth()
    local inv = game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommF_"):InvokeServer("getInventory")
    for i, v in pairs(inv) do
        if v.Type == "Blox Fruit" then
            if v.Rarity == 4 and v.Name == "Mammoth-Mammoth" then
                return "|Mammoth"
            end
        end
    end
    return ""
end

function CheckDone(Type)
    local level = LocalPlayer.Data.Level.Value

    if (Type == "1K" and level > 1000) or (Type == "1K5" and level > 1500) then
        return true
    elseif level >= 2550 then
        if Type == "MELEE" then
            return true
        elseif Type == "GOD" and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman", true) == 1 then
            return true
        elseif Type == "CDK" and CheckItem("Cursed Dual Katana") == true then
            return true
        elseif Type == "CDKSG" and CheckItem("Cursed Dual Katana") == true and CheckItem("Soul Guitar") == true then
            return true
        end
    end
    
    return false
end


local updateInterval = 30

while true do
    local level = LocalPlayer.Data.Level.Value
    local data = level
    local done = CheckDone(TypeDone)
    local request = ''

    if done then
        if TypeDone == 'MELEE' then
            data = data .. '|MELEE'
        elseif TypeDone == 'GOD' then
            data = data .. '|GOD'
        elseif TypeDone == 'CDK' then
            data = data .. '|GOD|CDK'
        elseif TypeDone == 'CDKSG' then
            data = data .. '|GOD|CDK|SG'
        end

        request = 'Completed'
    end
    
    data = data .. checkMochi() .. checkLeopardI() .. checkLeopardU() .. checkKitsune() .. checkDragon()
    WriteData(request, data)

    if done then
        return
    end

    task.wait(updateInterval)
end
