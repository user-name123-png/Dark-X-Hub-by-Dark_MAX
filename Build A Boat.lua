--GUI Build A Boat
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("🗡️Dark X Hub โดย Dark_MAX🤏🧠🐓🗡️", getgenv().Configuration.Themes)

local Tab = Window:NewTab("🏠หน้าหลัก🏠")
local Section = Tab:NewSection("⚔️Build A Boat⚔️")
local Section = Tab:NewSection("🔥v0.2.15🔥")
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
local Section = Tab:NewSection("🐓ไก่ตัน🐓")
-----------------------------------------------------------------------------------
Section:NewButton("🐓🗒️ไก่ตัน Script🐓🗒️", "ไก่ตัน Farm", function()
    -- เริ่มบิน
    local UIS = game:GetService("UserInputService")
    local player = game.Players.LocalPlayer
    local char = player.Character or player.CharacterAdded:Wait()
    local hrp = char:WaitForChild("HumanoidRootPart")

    _G.FLYING = true
    local flySpeed = 0
    local bodyGyro = Instance.new("BodyGyro")
    local bodyVel = Instance.new("BodyVelocity")

    bodyGyro.P = 9e4
    bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    bodyGyro.CFrame = hrp.CFrame
    bodyGyro.Parent = hrp

    bodyVel.Velocity = Vector3.zero
    bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    bodyVel.Parent = hrp

    local control = {F = 0, B = 0, L = 0, R = 0}

    UIS.InputBegan:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.W then
            control.F = 1
        elseif input.KeyCode == Enum.KeyCode.S then
            control.B = -1
        elseif input.KeyCode == Enum.KeyCode.A then
            control.L = -1
        elseif input.KeyCode == Enum.KeyCode.D then
            control.R = 1
        end
    end)

    UIS.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.W then
            control.F = 0
        elseif input.KeyCode == Enum.KeyCode.S then
            control.B = 0
        elseif input.KeyCode == Enum.KeyCode.A then
            control.L = 0
        elseif input.KeyCode == Enum.KeyCode.D then
            control.R = 0
        end
    end)

    -- บินแบบ loop
    task.spawn(function()
        while _G.FLYING do
            task.wait()
            local camCF = workspace.CurrentCamera.CFrame
            bodyGyro.CFrame = camCF
            local moveDirection = (camCF.LookVector * (control.F + control.B) + camCF.RightVector * (control.R + control.L)).Unit
            if moveDirection.Magnitude > 0 then
                bodyVel.Velocity = moveDirection * flySpeed
            else
                bodyVel.Velocity = Vector3.zero
            end
        end
        bodyGyro:Destroy()
        bodyVel:Destroy()
    end)

    -- เคลื่อนที่ + เทเลพอร์ต
    local TweenService = game:GetService("TweenService")
    local destination = Vector3.new(-50, 45, 8456)

    -- Step 1: เทเลพอร์ตไปจุดเริ่ม
    hrp.CFrame = CFrame.new(Vector3.new(-50, 45, 1262))

    -- Step 2: เคลื่อนที่ไปยังจุดที่สองด้วยความเร็ว
    local distance = (destination - hrp.Position).Magnitude
    local moveSpeed = 300
    local travelTime = distance / moveSpeed

    local tweenInfo = TweenInfo.new(travelTime, Enum.EasingStyle.Linear)
    local goal = { CFrame = CFrame.new(destination) }
    local tween = TweenService:Create(hrp, tweenInfo, goal)

    tween:Play()

    -- Step 3: หลังเคลื่อนที่เสร็จ -> เทเลพอร์ต + ปิดการบิน
    tween.Completed:Connect(function()
        task.wait()
        hrp.CFrame = CFrame.new(Vector3.new(-55, -359, 9489))
        _G.FLYING = false
    end)
end)
-------------------------------------------------------------------------------
Section:NewToggle("🐓🗒️🔁ไก่ตัน Script แบบวนซ้ำ🐓🗒️🔁", "ไก่ตัน Farm แบบวนซ้ำ", function(state)
    if state then
        -- เริ่มบิน
        local UIS = game:GetService("UserInputService")
        local player = game.Players.LocalPlayer
        local char = player.Character or player.CharacterAdded:Wait()
        local hrp = char:WaitForChild("HumanoidRootPart")

        _G.FLYING = true
        local flySpeed = 0
        local bodyGyro = Instance.new("BodyGyro")
        local bodyVel = Instance.new("BodyVelocity")

        bodyGyro.P = 9e4
        bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
        bodyGyro.CFrame = hrp.CFrame
        bodyGyro.Parent = hrp

        bodyVel.Velocity = Vector3.zero
        bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
        bodyVel.Parent = hrp

        local control = {F = 0, B = 0, L = 0, R = 0}

        UIS.InputBegan:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.W then
                    control.F = 1
            elseif input.KeyCode == Enum.KeyCode.S then
                control.B = -1
            elseif input.KeyCode == Enum.KeyCode.A then
                control.L = -1
            elseif input.KeyCode == Enum.KeyCode.D then
                control.R = 1
            end
        end)

        UIS.InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.W then
                control.F = 0
            elseif input.KeyCode == Enum.KeyCode.S then
                control.B = 0
            elseif input.KeyCode == Enum.KeyCode.A then
                control.L = 0
            elseif input.KeyCode == Enum.KeyCode.D then
                control.R = 0
            end
        end)

        -- บินแบบ loop
        task.spawn(function()
            while _G.FLYING do
                task.wait()
                local camCF = workspace.CurrentCamera.CFrame
                bodyGyro.CFrame = camCF
                local moveDirection = (camCF.LookVector * (control.F + control.B) + camCF.RightVector * (control.R + control.L)).Unit
                if moveDirection.Magnitude > 0 then
                    bodyVel.Velocity = moveDirection * flySpeed
                else
                    bodyVel.Velocity = Vector3.zero
                end
            end
            bodyGyro:Destroy()
            bodyVel:Destroy()
        end)

        -- เคลื่อนที่ + เทเลพอร์ต
        local TweenService = game:GetService("TweenService")
        local destination = Vector3.new(-50, 45, 8456)

        -- Step 1: เทเลพอร์ตไปจุดเริ่ม
        hrp.CFrame = CFrame.new(Vector3.new(-50, 45, 1262))

        -- Step 2: เคลื่อนที่ไปยังจุดที่สองด้วยความเร็ว
        local distance = (destination - hrp.Position).Magnitude
        local moveSpeed = 300
        local travelTime = distance / moveSpeed

        local tweenInfo = TweenInfo.new(travelTime, Enum.EasingStyle.Linear)
        local goal = { CFrame = CFrame.new(destination) }
        local tween = TweenService:Create(hrp, tweenInfo, goal)

        tween:Play()

            -- Step 3: หลังเคลื่อนที่เสร็จ -> เทเลพอร์ต + ปิดการบิน
        tween.Completed:Connect(function()
            task.wait()
            hrp.CFrame = CFrame.new(Vector3.new(-55, -359, 9489))
            _G.FLYING = false
        end)
---------------------------------
        local VirtualUser = game:GetService('VirtualUser')
    
        game:GetService('Players').LocalPlayer.Idled:Connect(function()
            VirtualUser:CaptureController()
            VirtualUser:ClickButton2(Vector2.new())
        end)
        print("go loop")
---------------------------------
        while task.wait(45) do
            -- เริ่มบิน
            local UIS = game:GetService("UserInputService")
            local player = game.Players.LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:WaitForChild("HumanoidRootPart")

            _G.FLYING = true
            local flySpeed = 0
            local bodyGyro = Instance.new("BodyGyro")
            local bodyVel = Instance.new("BodyVelocity")

            bodyGyro.P = 9e4
            bodyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
            bodyGyro.CFrame = hrp.CFrame
            bodyGyro.Parent = hrp

            bodyVel.Velocity = Vector3.zero
            bodyVel.MaxForce = Vector3.new(9e9, 9e9, 9e9)
            bodyVel.Parent = hrp

            local control = {F = 0, B = 0, L = 0, R = 0}

            UIS.InputBegan:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.W then
                    control.F = 1
                elseif input.KeyCode == Enum.KeyCode.S then
                    control.B = -1
                elseif input.KeyCode == Enum.KeyCode.A then
                    control.L = -1
                elseif input.KeyCode == Enum.KeyCode.D then
                    control.R = 1
                end
            end)

            UIS.InputEnded:Connect(function(input)
                if input.KeyCode == Enum.KeyCode.W then
                    control.F = 0
                elseif input.KeyCode == Enum.KeyCode.S then
                    control.B = 0
                elseif input.KeyCode == Enum.KeyCode.A then
                    control.L = 0
                elseif input.KeyCode == Enum.KeyCode.D then
                    control.R = 0
                end
            end)

            -- บินแบบ loop
            task.spawn(function()
                while _G.FLYING do
                    task.wait()
                    local camCF = workspace.CurrentCamera.CFrame
                    bodyGyro.CFrame = camCF
                    local moveDirection = (camCF.LookVector * (control.F + control.B) + camCF.RightVector * (control.R + control.L)).Unit
                    if moveDirection.Magnitude > 0 then
                        bodyVel.Velocity = moveDirection * flySpeed
                    else
                        bodyVel.Velocity = Vector3.zero
                    end
                end
                bodyGyro:Destroy()
                bodyVel:Destroy()
            end)

            -- เคลื่อนที่ + เทเลพอร์ต
            local TweenService = game:GetService("TweenService")
            local destination = Vector3.new(-50, 45, 8456)

            -- Step 1: เทเลพอร์ตไปจุดเริ่ม
            hrp.CFrame = CFrame.new(Vector3.new(-50, 45, 1262))

            task.wait(2)

            -- Step 2: เคลื่อนที่ไปยังจุดที่สองด้วยความเร็ว
            local distance = (destination - hrp.Position).Magnitude
            local moveSpeed = 300
            local travelTime = distance / moveSpeed

            local tweenInfo = TweenInfo.new(travelTime, Enum.EasingStyle.Linear)
            local goal = { CFrame = CFrame.new(destination) }
            local tween = TweenService:Create(hrp, tweenInfo, goal)

            tween:Play()

            -- Step 3: หลังเคลื่อนที่เสร็จ -> เทเลพอร์ต + ปิดการบิน
            tween.Completed:Connect(function()
                task.wait()
                hrp.CFrame = CFrame.new(Vector3.new(-55, -359, 9489))
                _G.FLYING = false
            end)
        end
    else
        --เข้าร่วมอีกครั้ง
        local TeleportService = game:GetService("TeleportService")
        local Players = game:GetService("Players")

        local player = Players.LocalPlayer

        -- รีจอยกลับไปยังเซิร์ฟเวอร์เดิม
        TeleportService:Teleport(game.PlaceId, player)
    end
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
