local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LocalPlayer = Players.LocalPlayer
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")

local BuyPetEgg = GameEvents:FindFirstChild("BuyPetEgg")
local Sell_Inventory = GameEvents:FindFirstChild("Sell_Inventory")

local fileName = LocalPlayer.Name .. '.txt'

local function getCharacter()
	return LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
end

local function teleport(pos)
	local char = getCharacter()
	local root = char:FindFirstChild("HumanoidRootPart")
	if root then
		char:SetPrimaryPartCFrame(pos)
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
	writefile(fileName, 'Completed-gag')
end)
