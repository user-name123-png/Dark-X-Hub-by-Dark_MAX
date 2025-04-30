--GUI The Strongest Battlegrounds
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🗡️Dark X Hub โดย Dark_MAX🤏🧠🐓🗡️", "DarkTheme")

local Tab = Window:NewTab("🏠หน้าหลัก🏠")
local Section = Tab:NewSection("⚔️The Strongest Battlegrounds⚔️")
local Section = Tab:NewSection("🔥v0.3.1🔥")
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

Section:NewToggle("✊Auto ตี✊", "ตีธรรมดาอัตโนมัติ", function(state)
    if state then
        local args = { [1] = { ["Goal"] = "LeftClick" } }
        game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))
    else
        local args = { [1] = { ["Goal"] = "LeftClickRelease" } }
        game:GetService("Players").LocalPlayer.Character.Communicate:FireServer(unpack(args))
    end
end)

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

Section:NewKeybind("🔥พาลงนรก🔥", "พา Player ไปตาย", Enum.KeyCode.R, function()
	local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
local originalPosition = humanoidRootPart.CFrame -- จำตำแหน่งเดิม

humanoidRootPart.CFrame = CFrame.new(-27529, 50654, -38183)
task.wait(2)
humanoidRootPart.CFrame = originalPosition
end)

Section:NewKeybind("⚡🕹️Y+555⚡🕹️", "เพิ่มตำแหน่ง Y+555 โดยที่ X,Z ยังคงเดิม", Enum.KeyCode.T, function()
	local player = game.Players.LocalPlayer
    local character = player.Character or player.CharacterAdded:Wait()
    local humanoidRootPart = character:WaitForChild("HumanoidRootPart")
    
    -- เพิ่มค่า Y ขึ้น 114 หน่วย
    humanoidRootPart.CFrame = humanoidRootPart.CFrame + Vector3.new(0, 300, 0)
end)

local Tab = Window:NewTab("🎮ผู้เล่น🎮")

local Section = Tab:NewSection("🎮⚡หมวดหมู่ Player🎮⚡")

-- ฟังก์ชันอัปเดตรายชื่อผู้เล่น
local function getPlayerList()
    local players = {}
    for _, v in pairs(game:GetService("Players"):GetPlayers()) do
        table.insert(players, v.Name)
    end
    return players
end

-- ตัวแปรเก็บผู้เล่นที่เลือก
local PlayerTP
local dropdown = Section:NewDropdown("🕹️เลือก Player🕹️", "เลือก Player ที่อยาก TP ไปหา", getPlayerList(), function(selected)
    PlayerTP = selected
end)

-- อัปเดตรายชื่ออัตโนมัติเมื่อมีผู้เล่นเข้า/ออก
game:GetService("Players").PlayerAdded:Connect(function()
    dropdown:Refresh(getPlayerList())
end)
game:GetService("Players").PlayerRemoving:Connect(function()
    dropdown:Refresh(getPlayerList())
end)

-- ตัวแปรเช็คว่าเปิด Toggle หรือไม่
local toggleState = false

Section:NewToggle("⚡🔁เปิด/ปิด TP ตลอด⚡🔁", "เปิด/ปิด TP ไปหาคนที่เลือก", function(state)
    toggleState = state
    if toggleState then
        print("✅ เริ่ม TP ไปหาผู้เล่นที่เลือก")
        while toggleState do
            local target = game.Players:FindFirstChild(PlayerTP)
            if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
                game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
            else
                print("❌ ไม่พบผู้เล่น หรือผู้เล่นออกจากเกมไปแล้ว")
            end
            task.wait()
        end
    else
        print("❌ หยุด TP")
    end
end)

-- ปุ่ม TP ไปหาผู้เล่นที่เลือก
Section:NewButton("⚡🕹️กดเพื่อ TP⚡🕹️", "กดเพื่อ TP ไปหาคนที่เลือก", function()
    local target = game.Players:FindFirstChild(PlayerTP)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame
    else
        print("❌ ไม่พบผู้เล่น หรือผู้เล่นออกจากเกมไปแล้ว")
    end
end)

local Section = Tab:NewSection("🦴ปรับ Humanoid🦴")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

local loopEnabled = false
local currentWalkSpeed = 25 -- ค่าเริ่มต้นของ Slider
local defaultWalkSpeed = 25

-- สร้าง Slider ปรับความเร็ว
Section:NewSlider("👟📉ความเร็วการเดิน👟📈", "ปรับความเร็วการเดิน", 100, 25, function(value)
    currentWalkSpeed = value
end)

-- Toggle เปิด/ปิด Loop ปรับ WalkSpeed
Section:NewToggle("👟ปิด/เปิดความเร็วเดิน👟", "ปิด/เปิดการปรับความเร็วการเดิน", function(state)
    loopEnabled = state

    if loopEnabled then
        task.spawn(function()
            while loopEnabled do
                local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
                if humanoid then
                    humanoid.WalkSpeed = currentWalkSpeed
                end
                task.wait() -- ปรับทุก 0.5 วินาที
            end
        end)
    else
        local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = defaultWalkSpeed
        end
    end
end)

-- หากตัวละครเกิดใหม่ให้ตั้ง WalkSpeed ใหม่ตาม toggle
LocalPlayer.CharacterAdded:Connect(function(character)
    character:WaitForChild("Humanoid")
    task.wait(0.1)
    if loopEnabled then
        character.Humanoid.WalkSpeed = currentWalkSpeed
    else
        character.Humanoid.WalkSpeed = defaultWalkSpeed
    end
end)

local Tab = Window:NewTab("➕Script เพิ่มเติม➕")

local Section = Tab:NewSection("➕🔥หมวด Script เพิ่มเติม➕🔥")

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

Section:NewButton("🏴‍☠️Script ดีด🏴‍☠️", "Script ดีด Player ที่มาแตะเรา", function()
    loadstring(game:HttpGet(('https://raw.githubusercontent.com/0Ben1/fe/main/obf_5wpM7bBcOPspmX7lQ3m75SrYNWqxZ858ai3tJdEAId6jSI05IOUB224FQ0VSAswH.lua.txt'),true))()
end)

local Tab = Window:NewTab("➕🔴ตัวช่วยเพิ่มเติม➕🔴")

local Section = Tab:NewSection("➕🔴➕ตัวช่วยเพิ่มเติม➕🔴➕")

Section:NewButton("🏔️วาปไปบนภูเขา🏔️", "วาปไปยังยอดภูเขา", function()
    --TPไปที่เขา
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoidRootPart = character:WaitForChild("HumanoidRootPart")

humanoidRootPart.CFrame = CFrame.new(-13, 653, -385)
end)

Section:NewButton("🔎มองทะลุ Player🔎", "เห็นชื่อของ Player และระยะห่างระหว่างเรากับ Player ทุกคนจากระยะไกล", function()
    local Players = game:GetService("Players")

-- Function สำหรับการแสดงชื่อและระยะ
local function addBillboard(player)
    -- รอให้ตัวละครโหลด
    local character = player.Character or player.CharacterAdded:Wait()
    local head = character:WaitForChild("Head")

    -- ตรวจสอบว่า NameTag มีอยู่แล้วหรือไม่ ถ้ามีแล้วให้ลบทิ้งก่อน
    if head:FindFirstChild("NameTag") then
        head:FindFirstChild("NameTag"):Destroy()
    end

    -- สร้าง BillboardGui
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "NameTag"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 150, 0, 40) -- ขนาดเพิ่มขึ้นเล็กน้อย (150x40)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.MaxDistance = math.huge

    -- สร้าง TextLabel สำหรับแสดงชื่อและระยะ
    local textLabel = Instance.new("TextLabel")
    textLabel.Parent = billboard
    textLabel.Size = UDim2.new(1, 0, 1, 0)
    textLabel.BackgroundTransparency = 1
    textLabel.TextColor3 = Color3.new(1, 1, 1) -- สีขาว
    textLabel.TextStrokeTransparency = 0.5 -- เส้นขอบตัวอักษร
    textLabel.TextStrokeColor3 = Color3.new(0, 0, 0) -- เส้นขอบสีดำ
    textLabel.TextScaled = true
    textLabel.Font = Enum.Font.GothamBold

    -- ใส่ BillboardGui ใน Head
    billboard.Parent = head

    -- ฟังก์ชันอัปเดตข้อความแสดงระยะ
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

    -- อัปเดตระยะเป็นระยะ ๆ
    game:GetService("RunService").RenderStepped:Connect(updateDistance)
end

-- เมื่อผู้เล่นถูกเพิ่มเข้ามาในเกม
Players.PlayerAdded:Connect(function(player)
    -- เมื่อ Character ถูกสร้างขึ้น
    player.CharacterAdded:Connect(function()
        addBillboard(player)
    end)
end)

-- สำหรับผู้เล่นที่อยู่ในเกมแล้ว
for _, player in pairs(Players:GetPlayers()) do
    if player.Character then
        addBillboard(player)
    end
    -- รองรับกรณีที่ตัวละครของผู้เล่นยังไม่ถูกสร้าง
    player.CharacterAdded:Connect(function()
        addBillboard(player)
    end)
end
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

Section:NewButton("✊🏴‍☠️อันติไซตามะ✊🏴‍☠️", "สร้าง Highlight กับคนที่เปิดอันติไซตามะสกิล 1", function()
    local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

-- ฟังก์ชันสร้าง Highlight สีแดง
local function createRedHighlight(character)
    -- ถ้ามีอยู่แล้วและเป็นสีแดง ไม่ต้องสร้างใหม่
    local existing = character:FindFirstChildOfClass("Highlight")
    if existing and existing.FillColor == Color3.new(1, 0, 0) then return end

    -- ลบ Highlight อื่น ๆ ที่อาจมีอยู่ก่อน
    if existing then existing:Destroy() end

    local highlight = Instance.new("Highlight")
    highlight.FillColor = Color3.new(1, 0, 0)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 1 -- ไม่มีขอบ
    highlight.Adornee = character
    highlight.Parent = character
end

-- ฟังก์ชันลบ Highlight ถ้าไม่มี Counter
local function removeRedHighlight(character)
    local existing = character:FindFirstChildOfClass("Highlight")
    if existing and existing.FillColor == Color3.new(1, 0, 0) then
        existing:Destroy()
    end
end

-- ฟังก์ชันหลักสำหรับตรวจสอบผู้เล่น
local function checkCharacter(character)
    if character:FindFirstChild("Counter") then
        createRedHighlight(character)
    else
        removeRedHighlight(character)
    end
end

-- เช็คตัวละครของผู้เล่นที่เข้ามาใหม่หรือตาย
local function setupPlayer(player)
    local function onCharacterAdded(char)
        checkCharacter(char)

        -- ติดตามการเปลี่ยนแปลงใน character (เช่นเพิ่มหรือลบ Counter)
        char.ChildAdded:Connect(function(child)
            if child.Name == "Counter" then
                createRedHighlight(char)
            end
        end)
        char.ChildRemoved:Connect(function(child)
            if child.Name == "Counter" then
                removeRedHighlight(char)
            end
        end)
    end

    if player.Character then
        onCharacterAdded(player.Character)
    end
    player.CharacterAdded:Connect(onCharacterAdded)
end

-- ตั้งค่าผู้เล่นปัจจุบัน
for _, player in ipairs(Players:GetPlayers()) do
    setupPlayer(player)
end

-- รองรับผู้เล่นที่เข้าใหม่
Players.PlayerAdded:Connect(setupPlayer)
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
