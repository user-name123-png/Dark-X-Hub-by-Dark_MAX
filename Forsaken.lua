local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- ฟังก์ชันตั้งค่า JumpPower
local function setJumpPower()
	local char = LocalPlayer.Character
	if char and char:FindFirstChildOfClass("Humanoid") then
		char:FindFirstChildOfClass("Humanoid").UseJumpPower = true
		char:FindFirstChildOfClass("Humanoid").JumpPower = 60 -- ปรับค่าตรงนี้ได้
	end
end

-- รอจนกระทั่งตัวละครถูกโหลด แล้วค่อยเซ็ต jump
LocalPlayer.CharacterAdded:Connect(function()
	wait(1) -- รอเล็กน้อยเพื่อให้ Humanoid โหลดเสร็จ
	setJumpPower()
end)

-- ถ้ามีตัวละครอยู่แล้วก็เซ็ตเลย
if LocalPlayer.Character then
	setJumpPower()
end

--GUI Forsaken
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🗡️Dark X Hub โดย Dark_MAX🤏🧠🐓🗡️", "DarkTheme")

local Tab = Window:NewTab("🏠หน้าหลัก🏠")
local Section = Tab:NewSection("⚔️Forsaken⚔️")
local Section = Tab:NewSection("🔥v1.4.3🔥")
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

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local toggleEnabled = false
local connection = nil

Section:NewToggle("🎯Aimbot Killers🎯", "กล้องจะหันไปทาง Killers ตลอดเวลา", function(state)
    toggleEnabled = state

    if toggleEnabled then

        connection = RunService.RenderStepped:Connect(function()
            local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
            if not killersFolder then return end

            local firstKiller = killersFolder:FindFirstChildWhichIsA("Model")
            if firstKiller and firstKiller:FindFirstChild("HumanoidRootPart") then
                local hrp = firstKiller.HumanoidRootPart
                Camera.CFrame = CFrame.new(Camera.CFrame.Position, hrp.Position)
            end
        end)

    else
        if connection then
            connection:Disconnect()
            connection = nil
        end
    end
end)

local NoclipEnabled = false
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

Section:NewToggle("🚪เปิด/ปิด เดินทะลุ🚪", "เปิดหรือปิดการเดินทะลุสิ่งของ", function(state)
    NoclipEnabled = state
    if NoclipEnabled then
    else

        -- คืนค่า CanCollide = true ตอนปิด noclip
        local character = player.Character
        if character then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
        end
    end
end)

-- Loop ทำให้ CanCollide = false ตอนเปิด noclip
RunService.Stepped:Connect(function()
    if NoclipEnabled then
        local character = player.Character
        if character then
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

Section:NewButton("🧬สร้าง Highlight🧬", "สร้าง Highlight ทุกตัว", function()
    while task.wait() do
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local Workspace = game:GetService("Workspace")

        -- ฟังก์ชันสร้าง Highlight (ไม่มีขอบ)
        local function createHighlight(instance, color)
            if instance:FindFirstChildOfClass("Highlight") then return end
            local highlight = Instance.new("Highlight")
            highlight.Adornee = instance
            highlight.FillColor = color
            highlight.FillTransparency = 0.5
            highlight.OutlineColor = Color3.new(0, 0, 0)
            highlight.OutlineTransparency = 1 -- ไม่มีขอบ
            highlight.Parent = instance
        end

        -- ฟังก์ชันสร้าง Highlight ให้ทุกอย่าง
        local function applyAllESP()
            -- Killers (แดง)
            for _, obj in ipairs(Workspace.Players.Killers:GetChildren()) do
                if obj:IsA("Model") or obj:IsA("Part") then
                    createHighlight(obj, Color3.new(1, 0, 0))
                end
            end
            -- Survivors (เขียว)
            for _, obj in ipairs(Workspace.Players.Survivors:GetChildren()) do
                if obj:IsA("Model") or obj:IsA("Part") then
                    createHighlight(obj, Color3.new(0, 1, 0))
                end
            end
            -- Spectating (ขาว)
            for _, obj in ipairs(Workspace.Players.Spectating:GetChildren()) do
                if obj:IsA("Model") or obj:IsA("Part") then
                    createHighlight(obj, Color3.new(1, 1, 1))
                end
            end
            -- Generator (น้ำเงิน)
            local mapPath = Workspace:FindFirstChild("Map") and Workspace.Map:FindFirstChild("Ingame") and Workspace.Map.Ingame:FindFirstChild("Map")
            if mapPath then
                for _, obj in ipairs(mapPath:GetDescendants()) do
                    if obj.Name == "Generator" and (obj:IsA("Model") or obj:IsA("Part")) then
                        createHighlight(obj, Color3.new(0, 0.5, 1))
                    end
                end
            end

            -- BloxyCola (น้ำตาลแดง)
            local function highlightBloxyCola(container)
                if container then
                    for _, obj in ipairs(container:GetDescendants()) do
                        if obj.Name == "BloxyCola" and (obj:IsA("Model") or obj:IsA("Part")) then
                            createHighlight(obj, Color3.fromRGB(200, 100, 50))
                        end
                    end
                end
            end

            highlightBloxyCola(Workspace)
            highlightBloxyCola(Workspace:FindFirstChild("Map") and Workspace.Map:FindFirstChild("Ingame"))

            -- Medkit (ฟ้าอ่อน)
            local function highlightMedkit(container)
                if container then
                    for _, obj in ipairs(container:GetDescendants()) do
                        if obj.Name == "Medkit" and (obj:IsA("Model") or obj:IsA("Part")) then
                            createHighlight(obj, Color3.fromRGB(100, 255, 255))
                        end
                    end
                end
            end

            highlightMedkit(Workspace)
            highlightMedkit(Workspace:FindFirstChild("Map") and Workspace.Map:FindFirstChild("Ingame"))
        end

        -- เรียกครั้งแรก
        applyAllESP()

        -- เมื่อ Character ผู้เล่นเกิดใหม่
        LocalPlayer.CharacterAdded:Connect(function()
            task.wait(1)
            applyAllESP()
        end)

        -- เมื่อมีผู้เล่นใหม่เข้ามาเกม
        Players.PlayerAdded:Connect(function(player)
            player.CharacterAdded:Connect(function()
                task.wait(1)
                applyAllESP()
            end)
        end)

        -- ตรวจจับว่า workspace.Map.Ingame.Map ถูกสร้างหรือถูกลบ
        local function watchMapIngame()
            local mapIngameFolder = Workspace:WaitForChild("Map"):WaitForChild("Ingame")

            mapIngameFolder.ChildAdded:Connect(function(child)
                if child.Name == "Map" then
                    task.wait(1)
                    applyAllESP()
                end
            end)

            mapIngameFolder.ChildRemoved:Connect(function(child)
                if child.Name == "Map" then
                    task.wait(1)
                    applyAllESP()
                end
            end)
        end

        -- เริ่มตรวจจับ
        task.spawn(watchMapIngame)
        task.wait(15)
    end
end)

Section:NewButton("❌💨ลบหมอก❌💨", "ปรับ Atmosphere.Density เป็น 0", function()
while task.wait() do
    local Lighting = game:GetService("Lighting")
local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")

-- ถ้าไม่มี Atmosphere ใน Lighting ให้สร้างใหม่
if not atmosphere then
    atmosphere = Instance.new("Atmosphere")
    atmosphere.Parent = Lighting
end

-- ฟังก์ชันตั้งค่า Density = 0
local function enforceZeroDensity()
    atmosphere.Density = 0
end

-- ตั้งค่าเริ่มต้น
enforceZeroDensity()

-- เฝ้าดูการเปลี่ยนแปลง Density ถ้าเปลี่ยนจะปรับกลับเป็น 0
atmosphere:GetPropertyChangedSignal("Density"):Connect(function()
    if atmosphere.Density ~= 0 then
        enforceZeroDensity()
    end
end)
task.wait(15)
end
end)

local Section = Tab:NewSection("⚡TP⚡")

local teleporting = false -- สถานะการทำงาน

Section:NewToggle("⚡🛡️TP ที่พัก⚡🛡️", "เปิดเพื่อ TP ไปยังที่พัก", function(state)
    teleporting = state

    if teleporting then
        task.spawn(function()
            while teleporting do
                local player = game.Players.LocalPlayer
                local character = player.Character or player.CharacterAdded:Wait()
                local hrp = character:WaitForChild("HumanoidRootPart")

                local targetPosition = Vector3.new(-3433, 9, 272)
                hrp.CFrame = CFrame.new(targetPosition)

                task.wait() -- ปรับความถี่ในการเทเลพอร์ต (เช่น ทุกๆ 1 วินาที)
            end
        end)
    else
    end
end)


Section:NewButton("⚡⚙️TP ที่ Generator⚡⚙️", "TP ไปที่ Generator แบบสุ่ม", function()
    local debounce = false -- ใช้สำหรับการล็อกไม่ให้กดซ้ำ

if debounce then return end -- ถ้ากำลังทำงานอยู่ให้หยุด
debounce = true -- ล็อกไม่ให้กดซ้ำ

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

local mapFolder = workspace:WaitForChild("Map"):WaitForChild("Ingame"):WaitForChild("Map")

local function teleportToRandomGenerator()
    local generators = {}
    
    -- เก็บ Generator ที่อยู่ใน map
    for _, obj in ipairs(mapFolder:GetChildren()) do
        if obj.Name == "Generator" and (obj:IsA("Model") or obj:IsA("Part")) then
            table.insert(generators, obj)
        end
    end

    if #generators > 0 then
        -- เลือก Generator แบบสุ่ม
        local randomGenerator = generators[math.random(1, #generators)]
        
        local targetPart
        if randomGenerator:IsA("Model") then
            targetPart = randomGenerator.PrimaryPart or randomGenerator:FindFirstChildWhichIsA("BasePart")
        elseif randomGenerator:IsA("BasePart") then
            targetPart = randomGenerator
        end
        
        if targetPart then
            local originalPosition = humanoidRootPart.CFrame -- จำตำแหน่งเดิม
            humanoidRootPart.CFrame = targetPart.CFrame + Vector3.new(0, 15, 0) -- เทเลพอร์ตไปที่ Generator
        end
    else
        warn("ไม่พบ Generator ใน Map")
    end
end

teleportToRandomGenerator() -- เรียกใช้งานฟังก์ชัน
wait(0.5)

debounce = false -- ปลดล็อกให้สามารถกดซ้ำได้อีกครั้ง
end)

-- ฟังก์ชันอัปเดตรายชื่อผู้เล่นจาก workspace.Players.Survivors
local function getSurvivorList()
    local survivors = {}
    for _, v in pairs(workspace.Players.Survivors:GetChildren()) do
        if v:IsA("Model") then
            table.insert(survivors, v.Name)
        end
    end
    return survivors
end

local Section = Tab:NewSection("⚙️🔄️Auto⚙️🔄️")

local Number = 0

Section:NewButton("⚡⚙️⚡Auto ปั่นไฟ⚡⚙️⚡", "ปั่นไฟให้อัตโนมัติ", function()
while Number < 4 do
local map = workspace:WaitForChild("Map"):WaitForChild("Ingame"):WaitForChild("Map")

for _, obj in ipairs(map:GetDescendants()) do
	if obj.Name == "RE" and obj:IsA("RemoteEvent") then
		obj:FireServer()
	end
end
Number += 1
task.wait(1.5)
end
Number = 0
end)

local Tab = Window:NewTab("🎮ผู้เล่น🎮")

local Section = Tab:NewSection("🎮⚡หมวดหมู่ Player🎮⚡")

-- ตัวแปรเก็บผู้เล่นที่เลือก
local PlayerTP
local dropdown = Section:NewDropdown("🕹️เลือก Survivors🕹️", "เลือก Survivors ที่อยาก TP ไปหา", getSurvivorList(), function(selected)
    PlayerTP = selected
end)

-- อัปเดตรายชื่ออัตโนมัติเมื่อมีการเปลี่ยนใน Survivors
workspace.Players.Survivors.ChildAdded:Connect(function()
    dropdown:Refresh(getSurvivorList())
end)
workspace.Players.Survivors.ChildRemoved:Connect(function()
    dropdown:Refresh(getSurvivorList())
end)

-- ตัวแปรเช็คว่าเปิด Toggle หรือไม่
local toggleState = false

Section:NewToggle("⚡🔁เปิด/ปิด TP ตลอด⚡🔁", "เปิด/ปิด TP ไปหา Survivors ที่เลือก", function(state)
    toggleState = state
    if toggleState then
        while toggleState do
            local target = workspace.Players.Survivors:FindFirstChild(PlayerTP)
            if target and target:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame
            else
            end
            task.wait()
        end
    else
    end
end)

-- ปุ่ม TP ไปหาผู้เล่นที่เลือก
Section:NewButton("⚡🕹️กดเพื่อ TP⚡🕹️", "กดเพื่อ TP ไปหา Survivors ที่เลือก", function()
    local target = workspace.Players.Survivors:FindFirstChild(PlayerTP)
    if target and target:FindFirstChild("HumanoidRootPart") then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame
    else
    end
end)

local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")
local LocalPlayer = Players.LocalPlayer
local Camera = Workspace.CurrentCamera

-- ฟังก์ชันหาผู้เล่นทั้งหมดใน workspace.Players.Killers และ Survivors
local function getPlayerList()
    local list = {}
    for _, team in ipairs({"Killers", "Survivors"}) do
        local folder = Workspace:FindFirstChild("Players") and Workspace.Players:FindFirstChild(team)
        if folder then
            for _, model in ipairs(folder:GetChildren()) do
                if model:IsA("Model") and model:FindFirstChild("Humanoid") then
                    table.insert(list, model.Name)
                end
            end
        end
    end
    return list
end

-- เก็บชื่อที่เลือกจาก dropdown
local PlayerTarget = nil

-- Dropdown UI
local dropdown = Section:NewDropdown("🕹️📸เลือกคนดู🕹️📸", "เลือกผู้เล่นเพื่อ View", getPlayerList(), function(selected)
    PlayerTarget = selected
end)

-- อัปเดตรายชื่ออัตโนมัติเมื่อมีผู้เล่นเข้า/ออก
Players.PlayerAdded:Connect(function()
    dropdown:Refresh(getPlayerList())
end)
Players.PlayerRemoving:Connect(function()
    dropdown:Refresh(getPlayerList())
end)

-- ✅ อัปเดต dropdown อัตโนมัติทุกวินาที
task.spawn(function()
    while true do
        dropdown:Refresh(getPlayerList())
        task.wait(1)
    end
end)

-- Toggle เปิด/ปิดการดู
local toggleState = false
Section:NewToggle("📷เปิด/ปิด View ผู้เล่น📷", "จะสลับกล้องไปที่ผู้เล่นเป้าหมาย", function(state)
    toggleState = state
    if state then

        task.spawn(function()
            while toggleState do
                local function findTargetModel()
                    for _, team in ipairs({"Killers", "Survivors"}) do
                        local folder = Workspace:FindFirstChild("Players") and Workspace.Players:FindFirstChild(team)
                        if folder then
                            for _, model in ipairs(folder:GetChildren()) do
                                if model.Name == PlayerTarget and model:FindFirstChild("Humanoid") then
                                    return model.Humanoid
                                end
                            end
                        end
                    end
                    return nil
                end

                local targetHumanoid = findTargetModel()
                if targetHumanoid then
                    Camera.CameraSubject = targetHumanoid
                else
                    Camera.CameraSubject = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
                end

                task.wait()
            end
        end)

    else
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
            Camera.CameraSubject = LocalPlayer.Character.Humanoid
        end
    end
end)

local Tab = Window:NewTab("⚙️การตั้งค่า⚙️")
--Shortcut Key
local Section = Tab:NewSection("🗝️Key ลัด🗝️")
----------------------------------- Key Code -----------------------------------
Section:NewKeybind("⌨️🗝️Key ลัด⌨️🗝️", "ทางลัดในการ ปิด/เปิด GUI", Enum.KeyCode.K, function()
	Library:ToggleUI()
end)

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local workspace = game:GetService("Workspace")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local toggleEnabled = false
local connection = nil
local waitingForRelease = false

-- ฟังก์ชันหลักที่หมุนกล้องไปยัง Killers
local function startCameraFollow()
    connection = RunService.RenderStepped:Connect(function()
        local killersFolder = workspace:FindFirstChild("Players") and workspace.Players:FindFirstChild("Killers")
        if not killersFolder then return end

        local firstKiller = killersFolder:FindFirstChildWhichIsA("Model")
        if firstKiller and firstKiller:FindFirstChild("HumanoidRootPart") then
            local hrp = firstKiller.HumanoidRootPart
            Camera.CFrame = CFrame.new(Camera.CFrame.Position, hrp.Position)
        end
    end)
end

local function stopCameraFollow()
    if connection then
        connection:Disconnect()
        connection = nil
    end
end

-- ฟังก์ชันตอนกด Keybind (รอให้ปล่อยก่อนเปิด/ปิด)
Section:NewKeybind("🎯ล็อกกล้องไปยัง Killers โดยใช้ Key ลัด🎯", "กด E เพื่อสลับการล็อกกล้อง", Enum.KeyCode.E, function()
    if waitingForRelease then return end
    waitingForRelease = true

    -- รอจนกว่าจะปล่อยปุ่ม E
    local releasedConn
    releasedConn = UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.E then
            releasedConn:Disconnect()
            toggleEnabled = not toggleEnabled

            if toggleEnabled then
                startCameraFollow()
            else
                stopCameraFollow()
            end

            waitingForRelease = false
        end
    end)
end)

local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()

local holdingR = false
local tpLoop = nil

Section:NewKeybind("⚡TP ไปตำแหน่งเมาส์⚡", "กด R เพื่อนเทเลพอร์ตไปที่ตำแหน่งเมาส์", Enum.KeyCode.R, function()
    -- ตรวจจับเมื่อกดปุ่ม R ลง
    holdingR = true

    -- เริ่มลูปเทเลพอร์ต
    tpLoop = task.spawn(function()
        while holdingR do
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                local targetPosition = Mouse.Hit.Position
                LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition + Vector3.new(0, 3, 0)) -- ลอยขึ้นเล็กน้อย
            end
            task.wait(60)
        end
    end)
end)

-- ตรวจจับเมื่อปล่อยปุ่ม R
UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode == Enum.KeyCode.R then
        holdingR = false
    end
end)

local UserInputService = game:GetService("UserInputService")

local isTHeld = false

local function autoSpin()
	local Number = 0
	while Number < 4 do
		local map = workspace:WaitForChild("Map"):WaitForChild("Ingame"):WaitForChild("Map")
		for _, obj in ipairs(map:GetDescendants()) do
			if obj.Name == "RE" and obj:IsA("RemoteEvent") then
				obj:FireServer()
			end
		end
		Number += 1
		task.wait(1.5)
	end
end

-- กำหนด Keybind UI
Section:NewKeybind("⚙️ปั่นไฟเมื่อปล่อย T⚙️", "กด T ค้างไว้แล้วปล่อยเพื่อปั่นไฟ", Enum.KeyCode.T, function()
	-- ตรงนี้ปล่อยว่างไว้ เพราะเราจะจัดการแยกด้วย UserInputService
end)

-- จับตอนกด T
UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.T and not gameProcessed then
		isTHeld = true
	end
end)

-- จับตอนปล่อย T
UserInputService.InputEnded:Connect(function(input, gameProcessed)
	if input.KeyCode == Enum.KeyCode.T and not gameProcessed and isTHeld then
		isTHeld = false
		autoSpin()
	end
end)

local UserInputService = game:GetService("UserInputService")
local debounce = false

local function teleportToRandomGenerator()
    if debounce then return end
    debounce = true

    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    local mapFolder = workspace:WaitForChild("Map"):WaitForChild("Ingame"):WaitForChild("Map")

    local generators = {}

    -- รวบรวม Generator
    for _, obj in ipairs(mapFolder:GetChildren()) do
        if obj.Name == "Generator" and (obj:IsA("Model") or obj:IsA("Part")) then
            table.insert(generators, obj)
        end
    end

    if #generators > 0 then
        local randomGenerator = generators[math.random(1, #generators)]
        local targetPart

        if randomGenerator:IsA("Model") then
            targetPart = randomGenerator.PrimaryPart or randomGenerator:FindFirstChildWhichIsA("BasePart")
        elseif randomGenerator:IsA("BasePart") then
            targetPart = randomGenerator
        end

        if targetPart then
            humanoidRootPart.CFrame = targetPart.CFrame + Vector3.new(0, 15, 0)
        end
    else
        warn("ไม่พบ Generator ใน Map")
    end

    task.wait(0.5)
    debounce = false
end

-- เชื่อมกับ Keybind T
Section:NewKeybind("⚡⚙️TP ที่ Generator⚡⚙️", "TP ไปที่ Generator แบบสุ่ม", Enum.KeyCode.H, function()
    -- จะทำงานเมื่อ "กดปุ่ม"
    -- รอจนปล่อยก่อนค่อยรัน TP
    local connection
    connection = UserInputService.InputEnded:Connect(function(input, gameProcessed)
        if input.KeyCode == Enum.KeyCode.H then
            teleportToRandomGenerator()
            connection:Disconnect()
        end
    end)
end)

Section:NewButton("🔁เข้าร่วมอีกครั้ง🔁", "ออกเกมแล้วเข้าใหม่มาในเซิฟเดิม", function()
    --เข้าร่วมอีกครั้ง
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

-- รีจอยกลับไปยังเซิร์ฟเวอร์เดิม
TeleportService:Teleport(game.PlaceId, player)
end)
