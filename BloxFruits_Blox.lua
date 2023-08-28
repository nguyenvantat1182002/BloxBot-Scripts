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
local TypeDone = "1K"

local FPSCap = 10
local decalsyeeted = true
local g = game
local w = g.Workspace
local l = g.Lighting
local t = w.Terrain
local UGS = UserSettings():GetService'UserGameSettings'
local fileName = LocalPlayer.Name .. '.json'

UGS.MasterVolume = 0
RunService:Set3dRenderingEnabled(false)
setfpscap(FPSCap)


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
                return "|Leopard[I]"
            end
        end
    end
    return ""
end

function checkLeopardU()
	if game:GetService("Players").LocalPlayer.Data.DevilFruit.Value == "Leopard-Leopard" then
		return "|Leopard[U]"
	end
	return ""
end

function checkMochi()
	-- kiem tra neu nhu dung trai mochi
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
			return "|Mochi[V2]"
		else
			return "|Mochi[V1]"
		end
	end

	return ""
end

function CheckDone(Type)
    local level = LocalPlayer.Data.Level.Value

	if (Type == "1K" and level > 1000) or (Type == "1K5" and level > 1500) then
		return true
    elseif level >= 2450 then
        if Type == "MELEE" then
            return true
        elseif Type == "GOD" and game:GetService("ReplicatedStorage").Remotes.CommF_:InvokeServer("BuyGodhuman", true) == 1 then
            return true
        elseif Type == "CDK" and CheckItem("Cursed Dual Katana") == true then
            return true
        elseif Type == "CDKSG" and CheckItem("Soul Guitar") == true then
            return true
        end
    end
	
	return false
end

sethiddenproperty(l,"Technology",2)
sethiddenproperty(t,"Decoration",false)
t.WaterWaveSize = 0
t.WaterWaveSpeed = 0
t.WaterReflectance = 0
t.WaterTransparency = 0
l.GlobalShadows = 0
l.FogEnd = 9e9
l.Brightness = 0
settings().Rendering.QualityLevel = "Level01"
for i, v in pairs(w:GetDescendants()) do
    if v:IsA("BasePart") and not v:IsA("MeshPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
    elseif (v:IsA("Decal") or v:IsA("Texture")) and decalsyeeted then
        v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
        v.BlastPressure = 1
        v.BlastRadius = 1
    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false
    elseif v:IsA("MeshPart") and decalsyeeted then
        v.Material = "Plastic"
        v.Reflectance = 0
        v.TextureID = 10385902758728957
    elseif v:IsA("SpecialMesh") and decalsyeeted  then
        v.TextureId=0
    elseif v:IsA("ShirtGraphic") and decalsyeeted then
        v.Graphic=1
    elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
        v[v.ClassName.."Template"]=1
    end
end
for i = 1,#l:GetChildren() do
    e=l:GetChildren()[i]
    if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
        e.Enabled = false
    end
end
w.DescendantAdded:Connect(function(v)
   if v:IsA("BasePart") and not v:IsA("MeshPart") then
        v.Material = "Plastic"
        v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
        v.Transparency = 1
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Lifetime = NumberRange.new(0)
    elseif v:IsA("Explosion") then
        v.BlastPressure = 1
        v.BlastRadius = 1
    elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") or v:IsA("Sparkles") then
        v.Enabled = false
    elseif v:IsA("MeshPart") and decalsyeeted then
        v.Material = "Plastic"
        v.Reflectance = 0
        v.TextureID = 10385902758728957
    elseif v:IsA("SpecialMesh") and decalsyeeted then
        v.TextureId=0
    elseif v:IsA("ShirtGraphic") and decalsyeeted then
        v.ShirtGraphic=1
    elseif (v:IsA("Shirt") or v:IsA("Pants")) and decalsyeeted then
        v[v.ClassName.."Template"]=1
            end
        end)

local errorCode = {
    Enum.ConnectionError.DisconnectErrors.Value,
    Enum.ConnectionError.PlacelaunchOtherError.Value,
    17,
    279,
    266,
    722,
    772,
    272,
    529,
    277,
    769
}

WriteData("ExecuteScript", "Level: " .. LocalPlayer.Data.Level.Value)

task.wait(0.8)

while isfile(fileName) do
    task.wait(3)
end

local data

while true do
    local Code = game:GetService'GuiService':GetErrorCode().Value

    for index, value in ipairs(errorCode) do
        if Code >= value then
            return game:Shutdown()
        end
    end

    data = "Level: " .. LocalPlayer.Data.Level.Value

    if CheckDone(TypeDone) then
        if TypeDone == 'MELEE' then
            data = data .. ' - Info: Melee'
        elseif TypeDone == 'GOD' then
            data = data .. ' - Info: Godhuman'
        elseif TypeDone == 'CDK' then
            data = data .. ' - Info: Godhuman|CDK'
        elseif TypeDone == 'CDKSG' then
            data = data .. ' - Info: Godhuman|CDK|SG'
        end

        break
    end

    WriteData("", data)

    task.wait(60)
end

WriteData("Completed", data .. checkMochi() .. checkLeopardI() .. checkLeopardU())
