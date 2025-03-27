--GUI The Strongest Battlegrounds
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🗡️Dark X Hub โดย Dark_MAX🤏🧠🐓🗡️", "DarkTheme")

local Tab = Window:NewTab("🏠หน้าหลัก🏠")
local Section = Tab:NewSection("⚔️The Strongest Battlegrounds⚔️")
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
local Section = Tab:NewSection("🐓พื้นฐาน🐓")

local debounce = false -- ใช้ตัวแปรกันการกดซ้ำ

Section:NewKeybind("🗑️หยิบถังขยะ🗑️", "กด E เพื่อวาปไปหยิบถังขยะแล้ววาปกลับมาที่เดิม", Enum.KeyCode.E, function()
    if debounce then return end -- ถ้ากำลังทำงานอยู่ให้หยุด
    debounce = true -- ล็อกไม่ให้กดซ้ำ

    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

    local trashFolder = workspace:WaitForChild("Map"):WaitForChild("Trash")

    local function teleportToRandomTrash()
        local trashItems = trashFolder:GetChildren()
        if #trashItems > 0 then
            local randomTrash = trashItems[math.random(1, #trashItems)]
            
            local targetPart
            if randomTrash:IsA("Model") then
                targetPart = randomTrash.PrimaryPart or randomTrash:FindFirstChildWhichIsA("BasePart")
            elseif randomTrash:IsA("BasePart") then
                targetPart = randomTrash
            end
            
            if targetPart then
                local originalPosition = humanoidRootPart.CFrame -- จำตำแหน่งเดิม
                humanoidRootPart.CFrame = targetPart.CFrame + Vector3.new(0, 0, 2.2) -- เทเลพอร์ตไปที่ Trash
                
                wait(0.4)
                
                -- ทำงานหลังจากเทเลพอร์ต
                local args = { [1] = { ["Goal"] = "LeftClick" } }
                game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))

                local args = { [1] = { ["Goal"] = "LeftClickRelease" } }
                game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))

                wait(0.4)

                -- เทเลพอร์ตกลับตำแหน่งเดิม
                humanoidRootPart.CFrame = originalPosition
            end
        end
    end

    teleportToRandomTrash() -- เรียกใช้งาน

    debounce = false -- ปลดล็อกให้กดได้อีกครั้ง
end)


Section:NewButton("🏔️วาปไปบนภูเขา🏔️", "วาปไปยังยอดภูเขา", function()
    --TPไปที่เขา
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

humanoidRootPart.CFrame = CFrame.new(-13, 653, -385)
end)

Section:NewButton("⚡Script วาป⚡", "Script สำหรับวาปไปไหนมาไหน", function()
    local player = game.Players.LocalPlayer
    local mouse = player:GetMouse()
    
    -- ฟังก์ชันสร้าง Tool
    local function createTeleportTool()
        local tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "Equip to Click TP"
    
        -- ฟังก์ชันวาปเมื่อคลิก
        tool.Activated:Connect(function()
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                local pos = mouse.Hit.Position + Vector3.new(0, 2.5, 0)
                character.HumanoidRootPart.CFrame = CFrame.new(pos)
            end
        end)
    
        -- ใส่ Tool เข้า Backpack
        tool.Parent = player.Backpack
    end
    
    -- สร้าง Tool ครั้งแรก
    createTeleportTool()
    
    -- ถ้าผู้เล่นตาย ให้สร้าง Tool ใหม่
    player.CharacterAdded:Connect(function()
        wait(1) -- รอให้ตัวละครโหลด
        createTeleportTool()
    end)
end)

Section:NewButton("💎Script ล่องหน💎", "Script สำหรับกด G เพื่อล่องหน", function()
    --ล่องหน
loadstring(game:HttpGet("https://rawscripts.net/raw/Universal-Script-Invisible-script-20557"))()
end)

Section:NewButton("🔴🔵สกิล Gojo🔴🔵", "ใส่สกิล Gojo ขอไซตามะ", function()
    --สกิล Gojo
local player = game.Players.LocalPlayer

-- ฟังก์ชันโหลดสคริปต์
local function loadScript()
    _G.settings = {
        ["RedStartupId"] = "rbxassetid://1177475221",
        ["RedHitId"] = "rbxassetid://8625377966",
    }
    loadstring(game:HttpGet("https://raw.githubusercontent.com/skibiditoiletfan2007/BaldyToSorcerer/main/Latest.lua"))()
end

-- โหลดครั้งแรก
loadScript()

-- โหลดใหม่เมื่อตาย
player.CharacterAdded:Connect(function()
    wait(1) -- รอให้ตัวละครโหลด
    loadScript()
end)
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
