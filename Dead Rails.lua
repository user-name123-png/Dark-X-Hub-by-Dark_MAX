-- GUI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🗡️Dark X Hub by Dark_MAX🤏🧠🐓🗡️", "DarkTheme")
----------------------------------- SUBSCRIDE -----------------------------------
local Tab = Window:NewTab("🖐️Welcome🖐️")
local Section = Tab:NewSection("🔥v1.2🔥")
local Section = Tab:NewSection("📌Subscride📌")
Section:NewButton("Subscribe Me(YouTube)", "Subscribe to the YouTube channel Dark_MAX0207.", function()
    setclipboard("https://www.youtube.com/@Dark_MAX0207")
    print("Thank you for subscribing To The YouTube.")
end)
Section:NewButton("Subscribe Me(TikTok)", "Subscribe to the TikTok channel dark_3014.", function()
    setclipboard("https://www.tiktok.com/@dark_3014")
    print("Thank you for subscribing To The TikTok.")
end)
----------------------------------- MENU -----------------------------------
local Tab = Window:NewTab("🛡️MENU🛡️")
-- Basic
local Section = Tab:NewSection("🐓Basic🐓")

----------------------------------- Auto Storage -----------------------------------
local range = 100 -- ระยะเก็บไอเทม (เมตร)
--ระยะดึง
Section:NewSlider("🎒📈Automatic Period🎒📈", "Automatically adjust storage distance", 1000, 100, function(s) -- 500 (MaxValue) | 0 (MinValue)
    range = s
    print("🎒📈Automatic Period🎒📈(" + s + ")")
end)
--Auto Storage
local autoStorageEnabled = false


Section:NewToggle("🎒Auto Storage🎒", "Automatic collection", function(state)
    autoStorageEnabled = state

    if autoStorageEnabled == true then
        print("🎒Auto Storage🎒(open)")
    elseif autoStorageEnabled == false then
        print("🎒Auto Storage🎒(close)")
    end
    
    if state then
        task.spawn(function()
            -- ดูดไอเทม
            local player = game.Players.LocalPlayer
            local character = player.Character or player.CharacterAdded:Wait()
            local hrp = character:WaitForChild("HumanoidRootPart") -- จุดศูนย์กลางตัวละคร

            local itemsFolder = workspace:WaitForChild("RuntimeItems") -- โฟลเดอร์ที่มีไอเทม
            local storeRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("StoreItem")

            -- ฟังก์ชันสำหรับเช็กระยะและเก็บไอเทม
            local function collectItems()
                for _, item in ipairs(itemsFolder:GetChildren()) do
                    if item:IsA("Model") then
                        local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
                        if primaryPart then
                            local distance = (primaryPart.Position - hrp.Position).Magnitude
                            if distance <= range then
                                storeRemote:FireServer(item) -- ส่งไปเก็บ
                            end
                        end
                    end
                end
            end

            -- ให้สคริปต์ทำงานเรื่อย ๆ จนกว่าจะปิด
            while autoStorageEnabled do
                collectItems()
                task.wait() -- เช็กทุก 1 วินาที (ปรับได้)
            end
        end)
    end
end)
----------------------------------- Auto Drop -----------------------------------
local autoStorageEnabled = false

Section:NewToggle("🗑️Auto Drop🗑️", "Automatic drop", function(state)
    autoStorageEnabled = state

    if autoStorageEnabled == true then
        print("🗑️Auto Drop🗑️(open)")
    elseif autoStorageEnabled == false then
        print("🗑️Auto Drop🗑️(close)")
    end

    if state then
        while autoStorageEnabled do
            game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DropItem"):FireServer()
            task.wait()  -- ทิ้งไอเทมทุก 1 วินาที (ปรับได้)
        end
    end
end)
----------------------------------- X-ray -----------------------------------
local ESPEnabled = false -- ค่าตั้งต้นให้ปิดไว้
local itemsFolder = workspace:WaitForChild("RuntimeItems")
local players = game:GetService("Players")

-- ฟังก์ชันสำหรับเพิ่ม Highlight
local function addHighlightEffect(item)
    if not ESPEnabled then return end -- หยุดทำงานถ้า ESP ถูกปิด

    -- สร้างหรือหา Highlight ที่มีอยู่แล้ว
    local highlight = item:FindFirstChild("Highlight") or Instance.new("Highlight")
    highlight.Parent = item
    highlight.OutlineTransparency = 1

    -- ตั้งค่า default สีเหลือง
    highlight.Adornee = item
    highlight.FillColor = Color3.fromRGB(255, 255, 0) -- สีเหลือง

    -- เปลี่ยนสีตามชื่อ
    local redItems = { "Werewolf", "Runner", "RevolverOutlaw", "ShotgunOutlaw", "Vampire", "Wolf" }
    local greenItems = { "Moneybag" }

    if table.find(redItems, item.Name) then
        highlight.FillColor = Color3.fromRGB(255, 0, 0) -- สีแดง
    elseif table.find(greenItems, item.Name) then
        highlight.FillColor = Color3.fromRGB(0, 255, 0) -- สีเขียว
    end
end

-- ฟังก์ชันสำหรับเพิ่ม Highlight ให้ Humanoid (NPC)
local function applyHighlight(humanoid)
    if not ESPEnabled then return end -- หยุดทำงานถ้า ESP ถูกปิด

    local character = humanoid.Parent
    if not character or players:GetPlayerFromCharacter(character) then return end -- ข้ามถ้าเป็นตัวละครผู้เล่น

    local highlightTarget = character -- กำหนดให้ Highlight ตัวละครโดยปกติ
    if character:IsA("Model") and character:FindFirstChild("Humanoid") then
        if character.Parent and character.Parent.Name == "Horse" then
            highlightTarget = character.Parent -- ถ้า Humanoid อยู่ใน Horse ให้ Highlight ที่ Horse
        end
    end

    local highlight = highlightTarget:FindFirstChild("Highlight") or Instance.new("Highlight")
    highlight.Name = "Highlight"
    highlight.Parent = highlightTarget

    -- กำหนดสี
    highlight.FillColor = highlightTarget.Name == "Horse" and Color3.fromRGB(0, 0, 255) or Color3.fromRGB(255, 0, 0)

    -- ปิดขอบ
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.OutlineTransparency = 1
end

-- ฟังก์ชันเปิด/ปิด ESP
local function toggleESP(state)
    ESPEnabled = state

    if ESPEnabled then
        -- เพิ่ม Highlight ให้ไอเทมทุกอันใน "RuntimeItems"
        for _, item in ipairs(itemsFolder:GetChildren()) do
            if item:IsA("Model") then
                addHighlightEffect(item)
            end
        end

        -- ตรวจจับไอเทมใหม่
        itemsFolder.ChildAdded:Connect(function(item)
            if item:IsA("Model") then
                addHighlightEffect(item)
            end
        end)

        -- เพิ่ม Highlight ให้ทุก Humanoid ในเกม
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("Humanoid") then
                applyHighlight(obj)
            end
        end

        -- ตรวจจับ Humanoid ใหม่
        workspace.DescendantAdded:Connect(function(obj)
            if obj:IsA("Humanoid") then
                applyHighlight(obj)
            end
        end)
    else
        -- ปิด ESP โดยลบ Highlight ออกจากทุกไอเทมและ NPC
        for _, obj in ipairs(workspace:GetDescendants()) do
            local highlight = obj:FindFirstChild("Highlight")
            if highlight then highlight:Destroy() end
        end
    end
end

-- เพิ่มปุ่ม Toggle ลงใน UI
Section:NewToggle("🧬X-Ray🧬", "See through", function(state)
    toggleESP(state)

    if state == true then
        print("🧬X-Ray🧬(open)")
    elseif state == false then
        print("🧬X-Ray🧬(close)")
    end
end)
----------------------------------- VISUAL EFFECTS -----------------------------------
local Tab = Window:NewTab("🌏VISUAL EFFECTS🌏")
--Brightness
local Section = Tab:NewSection("💡Brightness💡")
----------------------------------- Adjust Exposure -----------------------------------
local lighting = game:GetService("Lighting")
local brightnessLevel = 5 -- ค่าความสว่างเริ่มต้น
local autoBrightnessEnabled = false -- ตัวแปรเปิด/ปิดระบบปรับแสง

-- สร้างแถบเลื่อน (Slider) สำหรับปรับค่าความสว่าง
Section:NewSlider("⚡📈Adjust Exposure⚡📈", "Adjust the brightness of the light", 20, 1, function(s)
    print("⚡📈Adjust Exposure⚡📈(" + s + ")")
    
    brightnessLevel = s
    if autoBrightnessEnabled then
        lighting.Brightness = brightnessLevel
    end
end)

-- สร้าง Toggle สำหรับเปิด/ปิดการปรับแสงอัตโนมัติ
Section:NewToggle("🔥🔦Auto Brightness🔥🔦", "Enable or disable automatic brightness adjustment", function(state)
    autoBrightnessEnabled = state

    if autoStorageEnabled == true then
        print("🔥🔦Auto Brightness🔥🔦(open)")
    elseif autoStorageEnabled == false then
        print("🔥🔦Auto Brightness🔥🔦(close)")
    end

    if autoBrightnessEnabled then
        -- เปิดใช้งานการปรับแสงอัตโนมัติ
        lighting.Brightness = brightnessLevel
    else
        -- รีเซ็ตเป็นค่าเริ่มต้น
        lighting.Brightness = 1
    end
end)
--Fog
local Section = Tab:NewSection("Fog")
----------------------------------- Adjust fog value -----------------------------------
local lighting = game:GetService("Lighting")
local fogDensity = 0 -- ค่าเริ่มต้นความหนาของหมอก
local autoFogEnabled = false -- สถานะการเปิด/ปิดการใช้งานหมอก

-- แถบเลื่อนปรับค่าความหนาของหมอก (Density)
Section:NewSlider("🚬📈Fog Density🚬📈", "Adjust the fog density", 20, 0, function(s)
    print("🚬📈Fog Density🚬📈(" + s + ")")

    fogDensity = s / 100 -- แปลงค่าให้เป็นช่วง 0 ถึง 1
    if autoFogEnabled then
        lighting.Atmosphere.Density = fogDensity -- ปรับความหนาของหมอกตามค่าในแถบเลื่อน
    end
end)

-- ปุ่ม Toggle สำหรับเปิด/ปิดการใช้งานหมอก
Section:NewToggle("🚬Enable Fog🚬", "Enable or disable fog", function(state)
    autoFogEnabled = state

    if autoStorageEnabled == true then
        print("🚬Enable Fog🚬(open)")
    elseif autoStorageEnabled == false then
        print("🚬Enable Fog🚬(close)")
    end

    if autoFogEnabled then
        lighting.Atmosphere.Density = fogDensity -- ตั้งค่าความหนาของหมอกเมื่อเปิดใช้งาน
    else
        lighting.Atmosphere.Density = 0.4 -- ถ้าปิดหมอก, หมอกจะหายไป
    end
end)
----------------------------------- SETTINGS -----------------------------------
local Tab = Window:NewTab("⚙️SETTINGS⚙️")
--Shortcut Key
local Section = Tab:NewSection("🗝️Shortcut Key🗝️")
----------------------------------- Key Code -----------------------------------
Section:NewKeybind("⌨️🗝️Key Code⌨️🗝️", "Shortcut to close/open GUI", Enum.KeyCode.K, function()
    print("Turn Off/On The Gui")
	Library:ToggleUI()
end)
----------------------------------- Shortcut Key Auto Collect Items -----------------------------------
Section:NewKeybind("🎒🗝️Shortcut Key Auto Collect Items🎒🗝️", "Automatic Storage Shortcut Key", Enum.KeyCode.R, function()
    --ดูดitems
    local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local hrp = character:WaitForChild("HumanoidRootPart") -- จุดศูนย์กลางตัวละคร

    local itemsFolder = workspace:WaitForChild("RuntimeItems") -- โฟลเดอร์ที่มีไอเทม
    local storeRemote = game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("StoreItem")

    local range = 2500 -- ระยะเก็บไอเทม (เมตร)
    
    print("🎒🗝️Collect Things🎒🗝️")

    -- ฟังก์ชันสำหรับเช็กระยะและเก็บไอเทม
    local function collectItems()
        for _, item in ipairs(itemsFolder:GetChildren()) do
            if item:IsA("Model") then
                local primaryPart = item.PrimaryPart or item:FindFirstChildWhichIsA("BasePart")
                if primaryPart then
                    local distance = (primaryPart.Position - hrp.Position).Magnitude
                    if distance <= range then
                        storeRemote:FireServer(item) -- ส่งไปเก็บ
                    end
                end
            end
        end
    end

    collectItems()
    task.wait() -- เช็กทุก 1 วินาที (ปรับได้)
end)
----------------------------------- Shortcut Key Auto Automatically Discards All Items -----------------------------------
Section:NewKeybind("🗑️🗝️Shortcut Key Auto Automatically Discards All Items🗑️🗝️", "All of the things", Enum.KeyCode.T, function()
    local Number = 0
    
    print("🗑️🗝️Throw Away Everything🗑️🗝️")

    while Number < 10 do  -- แก้เงื่อนไขให้ทำงานจนกว่าจะถึง 10
        game:GetService("ReplicatedStorage"):WaitForChild("Remotes"):WaitForChild("DropItem"):FireServer()
        task.wait()  -- ทิ้งไอเทมทุก 1 วินาที (สามารถเปลี่ยนค่าได้)
        Number = Number + 1  -- เพิ่มค่าของ Number
    end
end)
