--GUI Gun Grounds FFA
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🗡️Dark X Hub โดย Dark_MAX🤏🧠🐓🗡️", "DarkTheme")

local Tab = Window:NewTab("🏠หน้าหลัก🏠")
local Section = Tab:NewSection("⚔️Gun Grounds FFA⚔️")
local Section = Tab:NewSection("🔥v0.1.4🔥")
local Section = Tab:NewSection("📌ติดตาม📌")
Section:NewButton("Subscribe YouTube ผมซะ", "คัดลอกลิ้งค์หน้าโปรไฟล์ YouTube ช่อง Dark_MAX0207.", function()
    setclipboard("https://www.youtube.com/@Dark_MAX0207")
    print("ขอบคุณที่กดติดตามช่อง YouTube ผม")
end)
Section:NewButton("Subscribe TikTok ผมซะ", "คัดลอกลิ้งค์หน้าโปรไฟล์ TikTok ช่อง dark_3014.", function()
    setclipboard("https://www.tiktok.com/@dark_3014")
    print("ขอบคุณที่กดติดตามช่อง TikTok ผม")
end)

local Tab = Window:NewTab("🛡️เมนู🛡️")
-- Basic
local Section = Tab:NewSection("🐓🧬ตัวช่วยเพิ่มเติม🐓🧬")
-----------------------------------------------------------------------------------
Section:NewButton("🎯Aimbot🎯", "Aimbot โดยการกดคลิกขวา", function()
    local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

local RADIUS = 200
local holdingRightClick = false
local lockedTarget = nil

-- วาดวงกลม
local circle = Drawing.new("Circle")
circle.Radius = RADIUS
circle.Color = Color3.new(0, 0, 0)
circle.Thickness = 1
circle.Visible = true
circle.Filled = false

RunService.RenderStepped:Connect(function()
	circle.Position = Vector2.new(Mouse.X, Mouse.Y)
end)

-- ฟังก์ชันเช็คตำแหน่งบนหน้าจอ
local function isOnScreen(position)
	local vec, onScreen = Workspace.CurrentCamera:WorldToViewportPoint(position)
	return onScreen, Vector2.new(vec.X, vec.Y)
end

-- ฟังก์ชันล็อกเป้าหมาย
local function getClosestTarget()
	local closest = nil
	local closestDistance = math.huge

	local function checkEntity(entity)
		if entity:IsA("Model") and entity:FindFirstChild("HumanoidRootPart") then
			local hrp = entity.HumanoidRootPart
			local onScreen, screenPos = isOnScreen(hrp.Position)
			if onScreen then
				local distance = (Vector2.new(Mouse.X, Mouse.Y) - screenPos).Magnitude
				if distance <= RADIUS and distance < closestDistance then
					closest = entity
					closestDistance = distance
				end
			end
		end
	end

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer and player.Character then
			checkEntity(player.Character)
		end
	end

	for _, entity in ipairs(Workspace:FindFirstChild("__THINGS") and Workspace.__THINGS:FindFirstChild("__ENTITIES"):GetChildren() or {}) do
		checkEntity(entity)
	end

	return closest
end

-- Highlight
local function createHighlight(target)
	if not target or not target:IsA("Model") then return end
	if target:FindFirstChildOfClass("Highlight") then return end

	local highlight = Instance.new("Highlight")
	highlight.Adornee = target
	highlight.FillColor = Color3.new(1, 0, 0)
	highlight.FillTransparency = 0.5
	highlight.OutlineTransparency = 1
	highlight.Parent = target
end

local function highlightAll()
	for _, player in ipairs(Players:GetPlayers()) do
		if player.Character then
			createHighlight(player.Character)
		end
	end

	local entities = Workspace:FindFirstChild("__THINGS") and Workspace.__THINGS:FindFirstChild("__ENTITIES")
	if entities then
		for _, obj in ipairs(entities:GetChildren()) do
			createHighlight(obj)
		end
	end
end

highlightAll()

-- ตรวจจับเมื่อ Character หรือผู้เล่นใหม่เข้ามา
Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		task.wait(1)
		highlightAll()
	end)
end)

for _, player in ipairs(Players:GetPlayers()) do
	player.CharacterAdded:Connect(function()
		task.wait(1)
		highlightAll()
	end)
end

-- ล็อกเป้าเมื่อคลิกขวา
UserInputService.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		holdingRightClick = true
		local target = getClosestTarget()
		if target and target:FindFirstChild("HumanoidRootPart") then
			lockedTarget = target
		end
	end
end)

UserInputService.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton2 then
		holdingRightClick = false
		lockedTarget = nil
	end
end)

-- หันกล้องตามเป้า
RunService.RenderStepped:Connect(function()
	if lockedTarget and lockedTarget:FindFirstChild("HumanoidRootPart") then
		local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
		if hrp then
			hrp.CFrame = CFrame.new(hrp.Position, Vector3.new(lockedTarget.HumanoidRootPart.Position.X, hrp.Position.Y, lockedTarget.HumanoidRootPart.Position.Z))
			Workspace.CurrentCamera.CFrame = CFrame.new(Workspace.CurrentCamera.CFrame.Position, lockedTarget.HumanoidRootPart.Position)
		end
	end
end)

-- แสดงชื่อและระยะของผู้เล่น
local function addBillboard(player)
	local character = player.Character or player.CharacterAdded:Wait()
	local head = character:WaitForChild("Head")

	if head:FindFirstChild("NameTag") then
		head:FindFirstChild("NameTag"):Destroy()
	end

	local billboard = Instance.new("BillboardGui")
	billboard.Name = "NameTag"
	billboard.Adornee = head
	billboard.Size = UDim2.new(0, 150, 0, 40)
	billboard.StudsOffset = Vector3.new(0, 3, 0)
	billboard.AlwaysOnTop = true
	billboard.MaxDistance = math.huge

	local textLabel = Instance.new("TextLabel")
	textLabel.Parent = billboard
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.BackgroundTransparency = 1
	textLabel.TextColor3 = Color3.new(1, 1, 1)
	textLabel.TextStrokeTransparency = 0.5
	textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
	textLabel.TextScaled = true
	textLabel.Font = Enum.Font.GothamBold

	billboard.Parent = head

	local function updateDistance()
		local localPlayer = Players.LocalPlayer
		if localPlayer and localPlayer.Character and localPlayer.Character:FindFirstChild("Head") then
			local localHead = localPlayer.Character.Head
			local distance = (head.Position - localHead.Position).Magnitude
			textLabel.Text = string.format("%s\n%.2f m", player.Name, distance)
		else
			textLabel.Text = player.Name
		end
	end

	game:GetService("RunService").RenderStepped:Connect(updateDistance)
end

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function()
		addBillboard(player)
	end)
end)

for _, player in pairs(Players:GetPlayers()) do
	if player.Character then
		addBillboard(player)
	end
	player.CharacterAdded:Connect(function()
		addBillboard(player)
	end)
end
end)
-------------------------------------------------------------------------------
Section:NewButton("🧬มองทะลุ🧬", "EPS กับ Player ทุกคน", function()
    local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- Function สำหรับการแสดงชื่อและระยะ
local function addBillboard(player)
    task.spawn(function()
        local character = player.Character or player.CharacterAdded:Wait()

        -- รอจนกว่าจะมี Head จริง ๆ
        local head = character:WaitForChild("Head", 5)
        if not head then return end

        -- ตรวจสอบว่า NameTag มีอยู่แล้วหรือไม่ ถ้ามีแล้วให้ลบทิ้งก่อน
        if head:FindFirstChild("NameTag") then
            head:FindFirstChild("NameTag"):Destroy()
        end

        -- สร้าง BillboardGui
        local billboard = Instance.new("BillboardGui")
        billboard.Name = "NameTag"
        billboard.Adornee = head
        billboard.Size = UDim2.new(0, 150, 0, 40)
        billboard.StudsOffset = Vector3.new(0, 3, 0)
        billboard.AlwaysOnTop = true
        billboard.MaxDistance = math.huge

        -- สร้าง TextLabel สำหรับแสดงชื่อและระยะ
        local textLabel = Instance.new("TextLabel")
        textLabel.Parent = billboard
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.TextColor3 = Color3.new(1, 1, 1)
        textLabel.TextStrokeTransparency = 0.5
        textLabel.TextStrokeColor3 = Color3.new(0, 0, 0)
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.GothamBold

        billboard.Parent = head

        -- อัปเดตระยะ
        RunService.RenderStepped:Connect(function()
            local localPlayer = Players.LocalPlayer
            if localPlayer.Character and localPlayer.Character:FindFirstChild("Head") then
                local distance = (head.Position - localPlayer.Character.Head.Position).Magnitude
                textLabel.Text = string.format("%s\n%.2f m", player.Name, distance)
            end
        end)
    end)
end

-- เช็ค Character ทั้งใหม่และที่มีอยู่
local function setupPlayer(player)
    if player.Character then
        addBillboard(player)
    end
    player.CharacterAdded:Connect(function()
        addBillboard(player)
    end)
end

-- สำหรับผู้เล่นที่อยู่แล้ว
for _, player in ipairs(Players:GetPlayers()) do
    setupPlayer(player)
end

-- สำหรับผู้เล่นใหม่
Players.PlayerAdded:Connect(setupPlayer)
end)
-------------------------------------------------------------------------------
local Tab = Window:NewTab("⚙️การตั้งค่า⚙️")
--Shortcut Key
local Section = Tab:NewSection("🗝️Key ลัด🗝️")
----------------------------------- Key Code -----------------------------------
Section:NewKeybind("⌨️🗝️Key ลัด⌨️🗝️", "ทางลัดในการ ปิด/เปิด GUI", Enum.KeyCode.K, function()
	Library:ToggleUI()
end)
------------------------------------------------------------------------------------------
Section:NewButton("🔁เข้าร่วมอีกครั้ง🔁", "ออกเกมแล้วเข้าใหม่มาในเซิฟเดิม", function()
    --เข้าร่วมอีกครั้ง
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

-- รีจอยกลับไปยังเซิร์ฟเวอร์เดิม
TeleportService:Teleport(game.PlaceId, player)
end)
