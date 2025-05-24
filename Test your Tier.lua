--GUI Test your Tier
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local savedPosition = nil

local targetBrickColor = BrickColor.new("Neon green")
local targetColor = Color3.fromRGB(231, 255, 78)
local targetMaterial = Enum.Material.Neon

for _, part in ipairs(workspace:GetDescendants()) do
	if part:IsA("BasePart") and part.Name == "Part" then
		if part.BrickColor == targetBrickColor and part.Color == targetColor and part.Material == targetMaterial then
			part.Touched:Connect(function(hit)
				local character = hit.Parent
				local player = Players:GetPlayerFromCharacter(character)
				if player == localPlayer then
					local hrp = character:FindFirstChild("HumanoidRootPart")
					if hrp then
						savedPosition = hrp.Position
					end
				end
			end)
		end
	end
end

-- ตรวจจับ Y < 4 แล้ว TP กลับ
game:GetService("RunService").RenderStepped:Connect(function()
	if savedPosition and localPlayer.Character and localPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local hrp = localPlayer.Character.HumanoidRootPart
		if hrp.Position.Y < 4 then
			hrp.CFrame = CFrame.new(savedPosition)
		end
	end
end)
