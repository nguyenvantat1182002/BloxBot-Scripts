local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")

local PetEggService = GameEvents:FindFirstChild("PetEggService")
local BuyPetEgg = GameEvents:FindFirstChild("BuyPetEgg")
local Sell_Inventory = GameEvents:FindFirstChild("Sell_Inventory")

local function getCharacter()
	return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function getBackpack()
	return LocalPlayer:WaitForChild("Backpack")
end

local function teleport(pos)
	local char = getCharacter()
	local root = char:FindFirstChild("HumanoidRootPart")
	if root then
		char:SetPrimaryPartCFrame(pos)
	end
end

local function getOwnerFarm()
	for _, farm in ipairs(workspace:WaitForChild("Farm"):GetChildren()) do
		local owner = farm:FindFirstChild("Important") and
		              farm.Important:FindFirstChild("Data") and
		              farm.Important.Data:FindFirstChild("Owner")

		if owner and owner.Value == LocalPlayer.Name then
			return farm
		end
	end
end

local function getArea(base)
	local pivot, size = base:GetPivot(), base.Size
	return math.ceil(pivot.X - size.X / 2),
	       math.ceil(pivot.Z - size.Z / 2),
	       math.floor(pivot.X + size.X / 2),
	       math.floor(pivot.Z + size.Z / 2)
end

local function getRandomFarmPoint()
	local farm = getOwnerFarm()
	if not farm then return Vector3.new(0, 4, 0) end

	local locations = farm:FindFirstChild("Important") and farm.Important:FindFirstChild("Plant_Locations")
	if not locations then return Vector3.new(0, 4, 0) end

	local lands = locations:GetChildren()
	if #lands == 0 then return Vector3.new(0, 4, 0) end

	local chosen = lands[math.random(1, #lands)]
	local x1, z1, x2, z2 = getArea(chosen)
	return Vector3.new(math.random(x1, x2), 4, math.random(z1, z2))
end

local function plantEggs()
	local char = getCharacter()
	for _ = 1, 10, 1 do
		for _, tool in ipairs(getBackpack():GetChildren()) do
			if tool.Name:find("Egg") then
				tool.Parent = char
				PetEggService:FireServer("CreateEgg", getRandomFarmPoint())
			end
		end
	end
end

local function buyEggs()
	for _ = 1, 10 do
		for i = 1, 3 do
			BuyPetEgg:FireServer(i)
		end
	end
end

local function sellInventory()
	teleport(CFrame.new(86, 4, 1))
	Sell_Inventory:FireServer()
end

-- main task
task.spawn(function()
	sellInventory()
	task.wait(0.5)
	buyEggs()
	task.wait(0.5)
	plantEggs()
end)
