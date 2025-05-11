local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer

RunService.Stepped:Connect(function()
    local character = player.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.WalkSpeed < 16 then
            humanoid.WalkSpeed = 16
        end
    end
end)

local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

humanoid:SetAttribute("BaseSpeed", 16)
--------------------------------------------------------------------------------------
-- GUI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🗡️Dark X Hub by Dark_MAX🤏🧠🐓🗡️", getgenv().Configuration.Themes)
----------------------------------- SUBSCRIDE -----------------------------------
local Tab = Window:NewTab("🖐️Welcome🖐️")
local Section = Tab:NewSection("⚔️Deat Rails⚔️")
local Section = Tab:NewSection("🔥v0.2.2🔥")
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
    if not ESPEnabled then return end

    local highlight = item:FindFirstChild("Highlight") or Instance.new("Highlight")
    highlight.Parent = item
    highlight.OutlineTransparency = 1
    highlight.Adornee = item
    highlight.FillColor = Color3.fromRGB(255, 255, 0)

    local redItems = { "Werewolf", "Runner", "RevolverOutlaw", "ShotgunOutlaw", "Vampire", "Wolf" }
    local greenItems = { "Moneybag" }

    if table.find(redItems, item.Name) then
        highlight.FillColor = Color3.fromRGB(255, 0, 0)
    elseif table.find(greenItems, item.Name) then
        highlight.FillColor = Color3.fromRGB(0, 255, 0)
    end
end

-- ฟังก์ชันสำหรับเพิ่ม Highlight ให้ Humanoid (NPC)
local function applyHighlight(humanoid)
    if not ESPEnabled then return end

    local character = humanoid.Parent
    if not character or players:GetPlayerFromCharacter(character) then return end

    local highlightTarget = character
    if character:IsA("Model") and character:FindFirstChild("Humanoid") then
        if character.Parent and character.Parent.Name == "Horse" then
            highlightTarget = character.Parent
        end
    end

    local highlight = highlightTarget:FindFirstChild("Highlight") or Instance.new("Highlight")
    highlight.Name = "Highlight"
    highlight.Parent = highlightTarget
    highlight.FillColor = highlightTarget.Name == "Horse" and Color3.fromRGB(0, 0, 255) or Color3.fromRGB(255, 0, 0)
    highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    highlight.OutlineTransparency = 1
end

-- ฟังก์ชันเปิด/ปิด ESP
local function toggleESP()
        ESPEnabled = not ESPEnabled

        if ESPEnabled then
            print("🧬X-Ray🧬(open)")
            for _, item in ipairs(itemsFolder:GetChildren()) do
                if item:IsA("Model") then
                    addHighlightEffect(item)
                end
            end

            itemsFolder.ChildAdded:Connect(function(item)
                if item:IsA("Model") then
                    addHighlightEffect(item)
                end
            end)

            for _, obj in ipairs(workspace:GetDescendants()) do
                if obj:IsA("Humanoid") then
                    applyHighlight(obj)
                end
            end

            workspace.DescendantAdded:Connect(function(obj)
                if obj:IsA("Humanoid") then
                    applyHighlight(obj)
                end
            end)
        else
            print("🧬X-Ray🧬(close)")
            for _, obj in ipairs(workspace:GetDescendants()) do
                local highlight = obj:FindFirstChild("Highlight")
                if highlight then
                    highlight:Destroy()
                end
            end
        end
    end

-- เปลี่ยนเป็นปุ่มกด
Section:NewButton("🧬Toggle X-Ray🧬", "Click to toggle ESP highlights", function()
    toggleESP()
    while task.wait(180) do
    toggleESP()
    toggleESP()
    end
end)
--------------------------------------------------------------------------------------
local Section = Tab:NewSection("➕🔥หมวด Script เพิ่มเติม➕🔥")
--------------------------------------------------------------------------------------
Section:NewButton("⚒️Xeno Seat Control⚒️", "นั่งเก้าอี้/บัคม้า บิน", function()
    local Players = game:GetService("Players")
    local UIS = game:GetService("UserInputService")
    local RunService = game:GetService("RunService")
    local Workspace = game:GetService("Workspace")
    local TeleportService = game:GetService("TeleportService")

    local player = Players.LocalPlayer
    local camera = Workspace.CurrentCamera
    local speed = 100
    local isControlling = false
    local isFrozen = false
    local gui
    local visible = true
    local controlButton
    local sliderFrame
    local sliderButton
    local speedLabel

    -- หยุดลอยตัวของ HumanoidRootPart
    local function disableFloat()
        local char = player.Character
        if char then
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                local bv = root:FindFirstChildOfClass("BodyVelocity")
                if bv then bv:Destroy() end
            end
        end
    end

    -- หยุดการเคลื่อนที่ของที่นั่ง
    local function stopSeatMovement()
        local seat = getSeat()
        if seat then
            local bv = seat:FindFirstChild("SeatMover")
            if bv then bv:Destroy() end
        end
    end

    -- หาที่นั่ง
    function getSeat()
        local char = player.Character
        if char and char:FindFirstChildOfClass("Humanoid") then
            return char.Humanoid.SeatPart
        end
    end

    -- ควบคุมการเคลื่อนที่
    function controlSeat()
        if not isControlling then return end
        local seat = getSeat()
        if not seat then return end

        local mousePos = UIS:GetMouseLocation()
        local ray = camera:ViewportPointToRay(mousePos.X, mousePos.Y)
        local dir = ray.Direction.Unit * speed

        local bv = seat:FindFirstChild("SeatMover") or Instance.new("BodyVelocity")
        bv.Name = "SeatMover"
        bv.MaxForce = Vector3.new(1e5, 1e5, 1e5)
        bv.Velocity = dir
        bv.Parent = seat
    end

    -- หมุนที่นั่งให้หันตามเมาส์
    function rotateSeatToMouse()
        if not isControlling then return end
        local seat = getSeat()
        if not seat then return end

        local mousePos = UIS:GetMouseLocation()
        local ray = camera:ViewportPointToRay(mousePos.X, mousePos.Y)
        local origin = ray.Origin
        local direction = ray.Direction * 1000

        local raycastParams = RaycastParams.new()
        raycastParams.FilterDescendantsInstances = {player.Character}
        raycastParams.FilterType = Enum.RaycastFilterType.Blacklist

        local result = Workspace:Raycast(origin, direction, raycastParams)
        if result then
            local targetPosition = result.Position
            local seatPos = seat.Position
            targetPosition = Vector3.new(targetPosition.X, seatPos.Y, targetPosition.Z)

            local newCFrame = CFrame.lookAt(seatPos, targetPosition)
            seat.CFrame = CFrame.new(seatPos) * CFrame.Angles(0, (newCFrame - newCFrame.Position).Rotation:ToEulerAnglesYXZ())
        end
    end

    -- อัพเดตข้อความในปุ่มควบคุม
    function updateControlButtonText()
        if controlButton then
            controlButton.Text = isControlling and "Fly = false" or "Fly = true"
        end
    end

    function updateSliderPosition()
        local percent = (speed - 1) / 999
        sliderButton.Position = UDim2.new(percent, -5, 0.5, -5)
        speedLabel.Text = "Speed: " .. tostring(speed)
    end

    -- ฟังก์ชั่นสร้าง GUI
    function createGui()
        if gui then gui:Destroy() end

        gui = Instance.new("ScreenGui")
        gui.Name = "XenoControlGui"
        gui.ResetOnSpawn = false
        gui.Parent = player:WaitForChild("PlayerGui")

        local frame = Instance.new("Frame", gui)
        frame.Size = UDim2.new(0, 260, 0, 190)
        frame.Position = UDim2.new(0.5, -130, 0.7, 0)
        frame.BackgroundColor3 = Color3.fromRGB(200, 200, 200)
        frame.BorderColor3 = Color3.fromRGB(100, 100, 100)
        frame.BorderSizePixel = 2

        local titleBar = Instance.new("TextLabel", frame)
        titleBar.Size = UDim2.new(0.92, 0, 0, 20)
        titleBar.BackgroundColor3 = Color3.fromRGB(33, 84, 185)
        titleBar.BorderSizePixel = 0
        titleBar.Text = "Xeno Seat Control by:Tochi"
        titleBar.TextColor3 = Color3.new(1, 1, 1)
        titleBar.Font = Enum.Font.Legacy
        titleBar.TextSize = 14

        local closeButton = Instance.new("TextButton", frame)
        closeButton.Size = UDim2.new(0, 22.5, 0, 20)
        closeButton.Position = UDim2.new(1, -22, 0, 0)
        closeButton.BackgroundColor3 = Color3.fromRGB(170, 0, 0)
        closeButton.Text = "X"
        closeButton.Font = Enum.Font.Legacy
        closeButton.TextSize = 14
        closeButton.TextColor3 = Color3.new(1, 1, 1)
        closeButton.BorderSizePixel = 0
        closeButton.MouseButton1Click:Connect(function()
            gui.Enabled = false
            visible = false
        end)

        controlButton = Instance.new("TextButton", frame)
        controlButton.Size = UDim2.new(1, -20, 0, 30)
        controlButton.Position = UDim2.new(0, 10, 0, 30)
        updateControlButtonText()
        controlButton.BackgroundColor3 = Color3.fromRGB(150, 150, 150)
        controlButton.BorderColor3 = Color3.fromRGB(90, 90, 90)
        controlButton.TextColor3 = Color3.new(0, 0, 0)
        controlButton.Font = Enum.Font.Legacy
        controlButton.TextSize = 14
        controlButton.MouseButton1Click:Connect(function()
            isControlling = not isControlling
            updateControlButtonText()
            if not isControlling then
                disableFloat()
                stopSeatMovement()
            end
        end)

        sliderFrame = Instance.new("Frame", frame)
        sliderFrame.Size = UDim2.new(1, -40, 0, 10)
        sliderFrame.Position = UDim2.new(0, 20, 0, 75)
        sliderFrame.BackgroundColor3 = Color3.fromRGB(180, 180, 180)
        sliderFrame.BorderColor3 = Color3.fromRGB(120, 120, 120)

        sliderButton = Instance.new("Frame", sliderFrame)
        sliderButton.Size = UDim2.new(0, 10, 0, 10)
        sliderButton.AnchorPoint = Vector2.new(0.5, 0.5)
        sliderButton.Position = UDim2.new(0, 0, 0.5, 0)
        sliderButton.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
        sliderButton.BorderColor3 = Color3.fromRGB(0, 0, 0)

        speedLabel = Instance.new("TextLabel", frame)
        speedLabel.Size = UDim2.new(1, -20, 0, 20)
        speedLabel.Position = UDim2.new(0, 10, 0, 90)
        speedLabel.BackgroundTransparency = 1
        speedLabel.TextColor3 = Color3.new(0, 0, 0)
        speedLabel.Font = Enum.Font.Legacy
        speedLabel.TextSize = 14
        speedLabel.Text = "Speed: " .. tostring(speed)

        local dragging = false

        sliderFrame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
            end
        end)

        UIS.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = false
            end
        end)

        UIS.InputChanged:Connect(function(input)
            if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                local absPos = sliderFrame.AbsolutePosition.X
                local absSize = sliderFrame.AbsoluteSize.X
                local mouseX = input.Position.X
                local percent = math.clamp((mouseX - absPos) / absSize, 0, 1)
                speed = math.floor(1 + (percent * 999))
                updateSliderPosition()
            end
        end)

        local label = Instance.new("TextLabel", frame)
        label.Size = UDim2.new(1, -20, 0, 30)
        label.Position = UDim2.new(0, 10, 0, 120)
        label.Text = "E ซ่อน GUI | R true/false Fly | Mouse ชี้ทิศทาง"
        label.BackgroundTransparency = 1
        label.TextColor3 = Color3.new(0, 0, 0)
        label.Font = Enum.Font.Legacy
        label.TextSize = 13
        label.TextWrapped = true

        -- เพิ่มปุ่ม Rejoin Server
        local rejoinButton = Instance.new("TextButton", frame)
        rejoinButton.Size = UDim2.new(1, -20, 0, 30)
        rejoinButton.Position = UDim2.new(0, 10, 0, 155)
        rejoinButton.BackgroundColor3 = Color3.fromRGB(120, 200, 120)
        rejoinButton.BorderColor3 = Color3.fromRGB(90, 90, 90)
        rejoinButton.TextColor3 = Color3.new(0, 0, 0)
        rejoinButton.Font = Enum.Font.Legacy
        rejoinButton.TextSize = 14
        rejoinButton.Text = "Rejoin Server"

        rejoinButton.MouseButton1Click:Connect(function()
            -- แจ้งเตือนก่อน
            pcall(function()
                game.StarterGui:SetCore("SendNotification", {
                    Title = "Rejoin Server";
                    Text = "กำลัง Rejoin...";
                    Duration = 3;
                })
            end)

            local placeId = game.PlaceId
            local jobId = game.JobId

            TeleportService:TeleportToPlaceInstance(placeId, jobId, player)

            -- แจ้งหลังโหลด (สำหรับ safety เผื่อใช้ตอนทดสอบ)
            player.CharacterAdded:Once(function()
                pcall(function()
                    game.StarterGui:SetCore("SendNotification", {
                        Title = "Rejoin สำเร็จ!";
                        Text = "คุณ Rejoin Server เรียบร้อยแล้ว";
                        Duration = 5;
                    })
                end)
            end)
        end)

        updateSliderPosition()
    end

    createGui()

    player.CharacterAdded:Connect(function()
        task.wait(1)
        createGui()
    end)

    UIS.InputBegan:Connect(function(input, gpe)
        if not gpe then
            if input.KeyCode == Enum.KeyCode.E then
                visible = not visible
                if gui then gui.Enabled = visible end
            elseif input.KeyCode == Enum.KeyCode.R then
                isControlling = not isControlling
                updateControlButtonText()
                if not isControlling then
                    disableFloat()
                    stopSeatMovement()
                end
            elseif input.KeyCode == Enum.KeyCode.Z then
                -- สลับการแช่แข็งกลางอากาศ
                if isControlling then
                    isFrozen = not isFrozen
                    local seat = getSeat()
                    if seat then
                        if isFrozen then
                            seat.Anchored = true
                        else
                            seat.Anchored = false
                        end
                    end
                end
            end
        end
    end)

    RunService.Heartbeat:Connect(function()
        controlSeat()
        rotateSeatToMouse()
    end)
end)
----------------------------------- VISUAL EFFECTS -----------------------------------
local Tab = Window:NewTab("🌏VISUAL EFFECTS🌏")
--Brightness
local Section = Tab:NewSection("💡Brightness💡")
----------------------------------- Adjust Exposure -----------------------------------
Section:NewButton("🔥🔦ปรับแสง🔥🔦", "ปรับแสงให้สว่างขึ้นเป็น 6", function()
    while task.wait() do
        game:GetService("Lighting").Brightness = 6
        print("✅ Brightness set to 6")
    end
end)
--Fog
----------------------------------- Adjust fog value -----------------------------------
local Section = Tab:NewSection("☁️Fog☁️")

Section:NewButton("🚬ลบหมอก🚬", "ปรับหมอกเป็น 0", function()
    local lighting = game:GetService("Lighting")
    if lighting:FindFirstChild("Atmosphere") then
        lighting.Atmosphere.Density = 0
        print("☁️ Fog disabled (Density = 0)")
    else
        warn("❌ Atmosphere object not found in Lighting")
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
