--GUI Forsaken
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🗡️Dark X Hub โดย Dark_MAX🤏🧠🐓🗡️", "DarkTheme")

local Tab = Window:NewTab("🏠หน้าหลัก🏠")
local Section = Tab:NewSection("⚔️Forsaken⚔️")
local Section = Tab:NewSection("🔥v1.1🔥")
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

local NoclipEnabled = false
local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

Section:NewToggle("🚪เดินทะลุ🚪", "เปิดหรือปิดการเดินทะลุสิ่งของ", function(state)
    NoclipEnabled = state
    if NoclipEnabled then
        print("Noclip เปิด")
    else
        print("Noclip ปิด")

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

-- ฟังก์ชันสร้าง Highlight
local function createHighlight(instance, color)
    if instance:FindFirstChildOfClass("Highlight") then return end
    local highlight = Instance.new("Highlight")
    highlight.Adornee = instance
    highlight.FillColor = color
    highlight.FillTransparency = 0.5
    highlight.OutlineColor = Color3.new(0, 0, 0)
    highlight.OutlineTransparency = 0.1
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
task.wait(5)
    end
end)

Section:NewButton("ลบหมอก❌💨", "ปรับ Atmosphere.Density เป็น 0", function()
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
task.wait(5)
end
end)

local Section = Tab:NewSection("⚡TP⚡")

local teleporting = false -- สถานะการทำงาน

Section:NewToggle("⚡🛡️TP ที่พัก⚡🛡️", "เปิดเพื่อ TP ไปยังที่พัก", function(state)
    teleporting = state

    if teleporting then
        print("เริ่มเทเลพอร์ตไปยังที่พัก...")
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
        print("หยุดเทเลพอร์ต")
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
            humanoidRootPart.CFrame = targetPart.CFrame + Vector3.new(3, 10, 0) -- เทเลพอร์ตไปที่ Generator
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
        print("✅ เริ่มติดตาม Survivor")
        while toggleState do
            local target = workspace.Players.Survivors:FindFirstChild(PlayerTP)
            if target and target:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame
            else
                print("❌ ไม่พบ Survivor หรือไม่มี HumanoidRootPart")
            end
            task.wait()
        end
    else
        print("❌ หยุดติดตาม Survivor")
    end
end)

-- ปุ่ม TP ไปหาผู้เล่นที่เลือก
Section:NewButton("⚡🕹️กดเพื่อ TP⚡🕹️", "กดเพื่อ TP ไปหา Survivors ที่เลือก", function()
    local target = workspace.Players.Survivors:FindFirstChild(PlayerTP)
    if target and target:FindFirstChild("HumanoidRootPart") then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.HumanoidRootPart.CFrame
    else
        print("❌ ไม่พบ Survivor หรือไม่มี HumanoidRootPart")
    end
end)

local Tab = Window:NewTab("⚙️การตั้งค่า⚙️")
--Shortcut Key
local Section = Tab:NewSection("🗝️Key ลัด🗝️")
----------------------------------- Key Code -----------------------------------
Section:NewKeybind("⌨️🗝️Key ลัด⌨️🗝️", "ทางลัดในการ ปิด/เปิด GUI", Enum.KeyCode.K, function()
	Library:ToggleUI()
end)

Section:NewButton("🔁เข้าร่วมอีกครั้ง🔁", "ออกเกมแล้วเข้าใหม่มาในเซิฟเดิม", function()
    --เข้าร่วมอีกครั้ง
local TeleportService = game:GetService("TeleportService")
local Players = game:GetService("Players")

local player = Players.LocalPlayer

-- รีจอยกลับไปยังเซิร์ฟเวอร์เดิม
TeleportService:Teleport(game.PlaceId, player)
end)
