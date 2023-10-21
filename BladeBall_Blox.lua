repeat wait() until game:IsLoaded()

local HttpService = game:GetService'HttpService'
local Players = game:GetService'Players'
local RunService = game:GetService'RunService'
local TeleportService = game:GetService'TeleportService'
local LocalPlayer = Players.LocalPlayer if not LocalPlayer then repeat LocalPlayer = Players.LocalPlayer task.wait() until LocalPlayer end task.wait(0.5)
local UserInputService = game:GetService("UserInputService")

-- MAX
local TypeDone = "MAX"

local FPSCap = 8
local decalsyeeted = true
local g = game
local w = g.Workspace
local l = g.Lighting
local t = w.Terrain
local UGS = UserSettings():GetService'UserGameSettings'
local fileName = LocalPlayer.Name .. '.json'
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

function WriteData(request, text)
	local data = HttpService:JSONEncode {
	    Request = request,
	    Text = text
	}
	
	writefile(fileName, data)
end

function CheckDone(Type)
    local level = 1

    if (Type == "MAX" and level == 4000) then
        return true
    end
    
    return false
end


UGS.MasterVolume = 0
RunService:Set3dRenderingEnabled(false)
setfpscap(FPSCap)

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
    e = l:GetChildren()[i]

    if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
        e.Enabled = false
    end
end

WriteData("ExecuteScript", "")
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

    local level = 1

    data = "Level: " .. level

    if CheckDone(TypeDone) then
        break
    end

    WriteData("", data)

    task.wait(60)
end

WriteData("Completed", data)
