-- Serviços
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Clipboard = setclipboard or toclipboard

-- Configuração
local CorrectKey = "12345"
local DiscordLink = "https://discord.gg/ejxVFmATBn"
local GetKeyLink = "https://link-target.net/1230188/JkX4L44xHN7x"

-- ScreenGui
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 580, 0, 360)
MainFrame.Position = UDim2.new(0.5, 0, -0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5,0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Active = true

local UICorner = Instance.new("UICorner", MainFrame)
UICorner.CornerRadius = UDim.new(0,28)
local UIStroke = Instance.new("UIStroke", MainFrame)
UIStroke.Thickness = 3
UIStroke.Color = Color3.fromRGB(255,0,255)
UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

local Gradient = Instance.new("UIGradient", MainFrame)
Gradient.Color = ColorSequence.new{
    ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0,255,255))
}
Gradient.Rotation = 45

TweenService:Create(MainFrame, TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), {
    Position = UDim2.new(0.5, 0, 0.5, 0)
}):Play()

-- Title & Subtitle
local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1,0,0,60)
Title.Position = UDim2.new(0,0,0,0)
Title.BackgroundTransparency = 1
Title.Text = "🔑 Sun Hub"
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 32
Title.TextColor3 = Color3.fromRGB(255,255,255)

local Subtitle = Instance.new("TextLabel", MainFrame)
Subtitle.Size = UDim2.new(1,0,0,30)
Subtitle.Position = UDim2.new(0,0,0,50)
Subtitle.BackgroundTransparency = 1
Subtitle.Text = "put your key for get Script"
Subtitle.Font = Enum.Font.Gotham
Subtitle.TextSize = 18
Subtitle.TextColor3 = Color3.fromRGB(200,200,200)

-- KeyBox
local KeyBox = Instance.new("TextBox", MainFrame)
KeyBox.Size = UDim2.new(0.7,0,0,45)
KeyBox.Position = UDim2.new(0.5,0,0.38,0)
KeyBox.AnchorPoint = Vector2.new(0.5,0.5)
KeyBox.PlaceholderText = "Put your Key..."
KeyBox.Text = ""
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 20
KeyBox.TextColor3 = Color3.fromRGB(255,255,255)
KeyBox.BackgroundColor3 = Color3.fromRGB(40,40,40)
KeyBox.BorderSizePixel = 0
local KeyCorner = Instance.new("UICorner", KeyBox)
KeyCorner.CornerRadius = UDim.new(0,16)

-- Função para criar botões
local function CreateButton(sizeX,sizeY,pos,text,callback)
    local Btn = Instance.new("TextButton", MainFrame)
    Btn.Size = UDim2.new(0,sizeX,0,sizeY)
    Btn.Position = pos
    Btn.AnchorPoint = Vector2.new(0.5,0.5)
    Btn.Text = text
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 18
    Btn.TextColor3 = Color3.fromRGB(255,255,255)
    Btn.BackgroundColor3 = Color3.fromRGB(45,45,45)
    Btn.AutoButtonColor = false

    local crn = Instance.new("UICorner", Btn)
    crn.CornerRadius = UDim.new(0,14)

    local gradient = Instance.new("UIGradient", Btn)
    gradient.Color = ColorSequence.new{
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255,0,255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0,255,255))
    }
    gradient.Rotation = 45

    task.spawn(function()
        while Btn.Parent do
            TweenService:Create(gradient, TweenInfo.new(1.5, Enum.EasingStyle.Linear), {Rotation=gradient.Rotation+360}):Play()
            task.wait(1.5)
        end
    end)

    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn,TweenInfo.new(0.2),{BackgroundColor3 = Color3.fromRGB(80,30,80)}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn,TweenInfo.new(0.2),{BackgroundColor3 = Color3.fromRGB(45,45,45)}):Play()
    end)

    Btn.MouseButton1Click:Connect(callback)
end

-- Botões da key
CreateButton(160,55,UDim2.new(0.32,0,0.6,0),"🌐 Get Key",function()
    if Clipboard then Clipboard(GetKeyLink) end
end)

CreateButton(160,55,UDim2.new(0.68,0,0.6,0),"✅ Redeem Key",function()
    if KeyBox.Text == CorrectKey then
        -- Fecha a UI de key
        ScreenGui:Destroy()

        -- Abre o Rayfield Hub direto
        local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

        local ScriptCount = 0
        local RecentAdditions = { "Scripts" }

        local Window = Rayfield:CreateWindow({
            Name = "Sun Hub",
            LoadingTitle = "Launching Sun Hub...",
            LoadingSubtitle = "by iove Lany",
            ConfigurationSaving = {
                Enabled = true,
                FolderName = "Sun Hub",
                FileName = "Config"
            },
            KeySystem = false
        })

        local Tabs = {}
        local InfoTab = Window:CreateTab("📌 Info")
        InfoTab:CreateParagraph({ Title = "👑 Creator", Content = "iove Lany" })
        local TotalScriptParagraph = InfoTab:CreateParagraph({
            Title = "📦 Total Scripts",
            Content = "Counting..."
        })
        InfoTab:CreateParagraph({
            Title = "🆕 Recently Added",
            Content = table.concat(RecentAdditions, "\n")
        })
        InfoTab:CreateButton({
            Name = "🔗 Copy Discord Invite",
            Callback = function()
                setclipboard("https://discord.gg/mXcWtfxTQe")
                Rayfield:Notify({ Title = "Copied!", Content = "Discord invite copied.", Duration = 3 })
            end
        })

        Tabs["Universal(soon)"] = Window:CreateTab("Universal")
        function AddScript(tab, name, url)
            ScriptCount += 1
            if not Tabs[tab] then Tabs[tab] = Window:CreateTab(tab) end
            Tabs[tab]:CreateButton({
                Name = name,
                Callback = function()
                    Rayfield:Notify({ Title = "Sun Hub - "..tab, Content = "Running "..name, Duration = 3 })
                    loadstring(game:HttpGet(url))()
                end
            })
        end

        AddScript("99 night in the forest", "Xenith Hub", "https://api.luarmor.net/files/v4/loaders/d7be76c234d46ce6770101fded39760c.lua")
        
AddScript("99 night in the forest", "pulse hub", "https://raw.githubusercontent.com/Chavels123/Loader/refs/heads/main/loader.lua")

AddScript("99 night in the forest", "clavnnX", "https://raw.githubusercontent.com/scclav/sc/refs/heads/main/kk")

AddScript("99 night in the forest", "sapphire hub", "https://pastefy.app/z1F9h812/raw")

AddScript("99 night in the forest", "varlox hub", "https://raw.githubusercontent.com/DiosDi/VexonHub/refs/heads/main/VexonHub")


AddScript("grow a garden", "zap hub", "https://zaphub.xyz/Exec")

AddScript("grow a garden", "frost hub", "https://init.frostbyte.lol")

AddScript("grow a garden", "Moondiety", "https://raw.githubusercontent.com/m00ndiety/Moondiety/refs/heads/main/Loader")

AddScript("grow a garden", "forge hub", "https://raw.githubusercontent.com/Skzuppy/forge-hub/main/loader.lua")

AddScript("grow a garden", "Xenith hub", "https://api.luarmor.net/files/v4/loaders/d7be76c234d46ce6770101fded39760c.lua")


AddScript("Steal a brainrot", "mondiety", "https://raw.githubusercontent.com/m00ndiety/Moondiety/refs/heads/main/Loader")

AddScript("Steal a brainrot", "koronis", "https://raw.githubusercontent.com/nf-36/Koronis/refs/heads/main/Scripts/hub.lua")

AddScript("Steal a brainrot", "rift", "https://rifton.top/loader.lua")

AddScript("Steal a brainrot", "xenith", "https://api.luarmor.net/files/v4/loaders/d7be76c234d46ce6770101fded39760c.lua")

AddScript("Steal a brainrot", "mondiety", "https://raw.githubusercontent.com/m00ndiety/Moondiety/refs/heads/main/Loader")

AddScript("Steal a brainrot", "koronis", "https://raw.githubusercontent.com/nf-36/Koronis/refs/heads/main/Scripts/hub.lua")

AddScript("Steal a brainrot", "rift", "https://rifton.top/loader.lua")

AddScript("Steal a brainrot", "xenith", "https://api.luarmor.net/files/v4/loaders/d7be76c234d46ce6770101fded39760c.lua")

AddScript("Fisch", "blackhub", "https://raw.githubusercontent.com/Skibidiking123/Fisch1/refs/heads/main/FischMain")

AddScript("Anime Eternal", "noir hub", "https://raw.githubusercontent.com/Oproxide/BESTSCRIPTSPOSSIBLE/ref/head/main/the.lua")

AddScript("Anime Eternal", "gehlee", "https://raw.githubusercontent.com/OhhMyGehlee/sh/refs/heads/main/a")

AddScript("Anime Eternal", "nexor hub", "https://raw.githubusercontent.com/NexorHub/Games/refs/heads/main/Universal/Scripts.lua")

AddScript("99 night in the forest", "mad buk", "https://raw.githubusercontent.com/Nobody6969696969/Madbuk/refs/heads/main/loader.lua")

AddScript("ink game", "Moondiety", "https://raw.githubusercontent.com/m00ndiety/Moondiety/refs/heads/main/Loader")

AddScript("ink game", "xenith", "https://api.luarmor.net/files/v4/loaders/d7be76c234d46ce6770101fded39760c.lua")

AddScript("ink game", "lumin hub", "https://lumin-hub.lol/loader.lua")

AddScript("ink game", "meowl", "https://pastefy.app/aydQLtib/raw")

        TotalScriptParagraph:Set({
            Title = "📦 Total Scripts",
            Content = tostring(ScriptCount).." scripts loaded."
        })

    else
        -- Feedback de erro
        TweenService:Create(MainFrame,TweenInfo.new(0.3),{BackgroundColor3=Color3.fromRGB(180,40,40)}):Play()
        task.wait(0.4)
        TweenService:Create(MainFrame,TweenInfo.new(0.3),{BackgroundColor3=Color3.fromRGB(25,25,25)}):Play()
        KeyBox.Text = ""
        KeyBox.PlaceholderText = "❌ Incorrect key!"
    end
end)

CreateButton(240,55,UDim2.new(0.5,0,0.8,0),"💬 Copy Discord",function()
    if Clipboard then Clipboard(DiscordLink) end
end)

-- Dragging
local dragging, dragInput, dragStartPos, frameStartPos
local function StartDrag(input)
    dragging = true
    dragStartPos = input.Position
    frameStartPos = MainFrame.Position
    input.Changed:Connect(function()
        if input.UserInputState == Enum.UserInputState.End then dragging = false end
    end)
end
local function UpdateDrag(input)
    if dragging then
        local delta = input.Position - dragStartPos
        MainFrame.Position = UDim2.new(
            frameStartPos.X.Scale, frameStartPos.X.Offset + delta.X,
            frameStartPos.Y.Scale, frameStartPos.Y.Offset + delta.Y
        )
    end
end
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        StartDrag(input)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)
RunService.RenderStepped:Connect(function()
    if dragInput then UpdateDrag(dragInput) end
end)
