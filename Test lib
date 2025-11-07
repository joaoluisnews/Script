-- FrostyHubLib.lua
-- Biblioteca modular do FrostyHub (API completa)
local FrostyHub = {}
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local MarketplaceService = game:GetService("MarketplaceService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = (type(gethui) == "function" and gethui()) or player:WaitForChild("PlayerGui")

-- Helper: criação rápida de Instâncias
local function I(class, props)
	local obj = Instance.new(class)
	for k, v in pairs(props or {}) do
		if k == "Parent" then
			obj.Parent = v
		else
			obj[k] = v
		end
	end
	return obj
end

-- Internals
local ui = {}
local autoJoinEnabled = false
local hasPremium = false
local currentTab = "AutoJoin"

-- small safe spawn
local function safeSpawn(f) task.spawn(function() pcall(f) end) end

-- Create UI (idempotente)
local function createUI()
	if ui.ScreenGui then return end

	ui.ScreenGui = I("ScreenGui", {
		Name = "FrostyHubGUI",
		ResetOnSpawn = false,
		Parent = playerGui,
	})

	-- Top open button
	ui.TopButton = I("TextButton", {
		Parent = ui.ScreenGui,
		AnchorPoint = Vector2.new(0.5, 0),
		Position = UDim2.new(0.5, 0, 0.02, 0),
		Size = UDim2.new(0.8, 0, 0.07, 0),
		BackgroundColor3 = Color3.fromRGB(37, 104, 170),
		Text = "Click here to open Frosty Hub",
		TextColor3 = Color3.fromRGB(255,255,255),
		Font = Enum.Font.GothamBold,
		TextSize = 18,
	})
	I("UICorner", {Parent = ui.TopButton, CornerRadius = UDim.new(0, 22)})

	-- Main frame
	ui.MainFrame = I("Frame", {
		Parent = ui.ScreenGui,
		AnchorPoint = Vector2.new(0.5, 0.5),
		Position = UDim2.new(0.5, 0, 0.5, 0),
		Size = UDim2.new(0.6, 0, 0.7, 0),
		BackgroundColor3 = Color3.fromRGB(10,10,10),
		Visible = false,
	})
	I("UICorner", {Parent = ui.MainFrame, CornerRadius = UDim.new(0, 18)})

	-- Dragging
	do
		local dragging, dragInput, dragStart, startPos
		local function update(input)
			local delta = input.Position - dragStart
			ui.MainFrame.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
		ui.MainFrame.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				dragging = true
				dragStart = input.Position
				startPos = ui.MainFrame.Position
				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)
		ui.MainFrame.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				dragInput = input
			end
		end)
		UserInputService.InputChanged:Connect(function(input)
			if input == dragInput and dragging then
				update(input)
			end
		end)
	end

	-- Top bar
	local topBar = I("Frame", { Parent = ui.MainFrame, Size = UDim2.new(1,0,0,48), BackgroundTransparency = 1 })
	I("TextLabel", {
		Parent = topBar,
		Position = UDim2.new(0,12,0,8),
		Size = UDim2.new(0.8,-24,1,-16),
		BackgroundTransparency = 1,
		Text = "Frosty Hub | Mirrors aka Kollin",
		TextColor3 = Color3.fromRGB(255,255,255),
		Font = Enum.Font.GothamBold,
		TextSize = 16,
		TextXAlignment = Enum.TextXAlignment.Left,
	})
	local closeBtn = I("TextButton", {
		Parent = topBar,
		AnchorPoint = Vector2.new(1,0.5),
		Position = UDim2.new(1,-12,0.5,0),
		Size = UDim2.new(0,34,0,34),
		BackgroundColor3 = Color3.fromRGB(30,30,30),
		Text = "✕",
		Font = Enum.Font.GothamBold,
		TextSize = 18,
		TextColor3 = Color3.fromRGB(255,255,255),
	})
	I("UICorner", {Parent = closeBtn, CornerRadius = UDim.new(0,16)})

	-- Left bar
	local leftBar = I("Frame", {
		Parent = ui.MainFrame,
		Position = UDim2.new(0,12,0,60),
		Size = UDim2.new(0,220,1,-72),
		BackgroundColor3 = Color3.fromRGB(16,16,16),
	})
	I("UICorner", {Parent = leftBar, CornerRadius = UDim.new(0,14)})
	I("UIListLayout", {Parent = leftBar, Padding = UDim.new(0,12)})

	-- Tabs
	ui.TabAuto = I("TextButton", {
		Parent = leftBar,
		Size = UDim2.new(1,-24,0,48),
		BackgroundColor3 = Color3.fromRGB(60,60,60),
		Text = "Auto Joiner",
		Font = Enum.Font.Gotham,
		TextColor3 = Color3.fromRGB(255,255,255),
		TextSize = 16,
	})
	I("UICorner", {Parent = ui.TabAuto, CornerRadius = UDim.new(0,10)})
	ui.TabMisc = I("TextButton", {
		Parent = leftBar,
		Size = UDim2.new(1,-24,0,48),
		BackgroundColor3 = Color3.fromRGB(34,34,34),
		Text = "Misc",
		Font = Enum.Font.Gotham,
		TextColor3 = Color3.fromRGB(230,230,230),
		TextSize = 16,
	})
	I("UICorner", {Parent = ui.TabMisc, CornerRadius = UDim.new(0,10)})

	-- Profile card
	local bottomInfo = I("Frame", { Parent = leftBar, Size = UDim2.new(1,-24,0,96), BackgroundColor3 = Color3.fromRGB(28,28,28) })
	I("UICorner", {Parent = bottomInfo, CornerRadius = UDim.new(0,14)})

	ui.Avatar = I("ImageLabel", {
		Parent = bottomInfo,
		Position = UDim2.new(0,8,0.5,-28),
		Size = UDim2.new(0,64,0,64),
		BackgroundTransparency = 1,
		Image = "rbxasset://textures/ui/GuiImagePlaceholder.png",
	})
	I("UICorner", {Parent = ui.Avatar, CornerRadius = UDim.new(1,32)})

	ui.NameLabel = I("TextLabel", {
		Parent = bottomInfo,
		Position = UDim2.new(0,80,0.25,0),
		Size = UDim2.new(1,-88,0.6,0),
		BackgroundTransparency = 1,
		Text = player.Name .. "\nFetching game name...",
		TextColor3 = Color3.fromRGB(150,255,160),
		Font = Enum.Font.Gotham,
		TextSize = 14,
		TextXAlignment = Enum.TextXAlignment.Left,
		TextWrapped = true,
	})

	-- Right panel + scroll
	local rightPanel = I("Frame", {
		Parent = ui.MainFrame,
		Position = UDim2.new(0,244,0,60),
		Size = UDim2.new(1,-260,1,-72),
		BackgroundColor3 = Color3.fromRGB(12,12,12),
	})
	I("UICorner", {Parent = rightPanel, CornerRadius = UDim.new(0,14)})

	local scroll = I("ScrollingFrame", {
		Parent = rightPanel,
		Size = UDim2.new(1,-24,1,-24),
		Position = UDim2.new(0,12,0,12),
		BackgroundTransparency = 1,
		ScrollBarThickness = 6,
	})
	I("UIListLayout", {Parent = scroll, Padding = UDim.new(0,12)})

	-- AutoJoin section
	ui.AutoSection = I("Frame", {
		Parent = scroll,
		Size = UDim2.new(1,0,0,260),
		BackgroundColor3 = Color3.fromRGB(18,18,18),
	})
	I("UICorner", {Parent = ui.AutoSection, CornerRadius = UDim.new(0,10)})

	ui.KeyBox = I("TextBox", {
		Parent = ui.AutoSection,
		Position = UDim2.new(0,16,0,40),
		Size = UDim2.new(0.7,0,0,36),
		BackgroundColor3 = Color3.fromRGB(24,24,24),
		PlaceholderText = "Enter License Key...",
		TextColor3 = Color3.fromRGB(255,255,255),
		Font = Enum.Font.Gotham,
		TextSize = 14,
	})
	I("UICorner", {Parent = ui.KeyBox, CornerRadius = UDim.new(0,8)})

	ui.RedeemBtn = I("TextButton", {
		Parent = ui.AutoSection,
		Position = UDim2.new(0.75,0,0,40),
		Size = UDim2.new(0.2,0,0,36),
		BackgroundColor3 = Color3.fromRGB(40,160,80),
		Text = "Redeem",
		TextColor3 = Color3.fromRGB(255,255,255),
		Font = Enum.Font.GothamBold,
		TextSize = 14,
	})
	I("UICorner", {Parent = ui.RedeemBtn, CornerRadius = UDim.new(0,8)})

	-- Toggle
	ui.ToggleBtn = I("TextButton", {
		Parent = ui.AutoSection,
		Position = UDim2.new(0,16,0,100),
		Size = UDim2.new(0,56,0,28),
		BackgroundColor3 = Color3.fromRGB(40,40,40),
		Text = "",
	})
	I("UICorner", {Parent = ui.ToggleBtn, CornerRadius = UDim.new(1,8)})
	ui.ToggleCircle = I("Frame", {
		Parent = ui.ToggleBtn,
		Size = UDim2.new(0,22,0,22),
		Position = UDim2.new(0,4,0.5,-11),
		BackgroundColor3 = Color3.fromRGB(200,200,200),
	})
	I("UICorner", {Parent = ui.ToggleCircle, CornerRadius = UDim.new(1,12)})

	-- Misc placeholder
	ui.MiscSection = I("Frame", {
		Parent = scroll,
		Size = UDim2.new(1,0,0,120),
		BackgroundColor3 = Color3.fromRGB(18,18,18),
		Visible = false,
	})
	I("UICorner", {Parent = ui.MiscSection, CornerRadius = UDim.new(0,10)})
	I("TextLabel", { Parent = ui.MiscSection, Position = UDim2.new(0,16,0,16), BackgroundTransparency = 1, Text = "Misc Section (placeholder)", TextColor3 = Color3.fromRGB(200,200,200), Font = Enum.Font.Gotham, TextSize = 14})

	-- Hook up events
	ui.RedeemBtn.MouseButton1Click:Connect(function()
		local key = ui.KeyBox.Text or ""
		if #key >= 6 then
			hasPremium = true
			ui.RedeemBtn.Text = "Redeemed"
			ui.RedeemBtn.BackgroundColor3 = Color3.fromRGB(80,200,100)
		else
			ui.RedeemBtn.Text = "Invalid"
			ui.RedeemBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
			task.wait(1)
			ui.RedeemBtn.Text = "Redeem"
			ui.RedeemBtn.BackgroundColor3 = Color3.fromRGB(40,160,80)
		end
	end)

	local function setToggleVisual(on)
		if on then
			ui.ToggleCircle:TweenPosition(UDim2.new(1, -26, 0.5, -11), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
			ui.ToggleBtn.BackgroundColor3 = Color3.fromRGB(60,160,80)
		else
			ui.ToggleCircle:TweenPosition(UDim2.new(0, 4, 0.5, -11), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
			ui.ToggleBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
		end
	end

	ui.ToggleBtn.MouseButton1Click:Connect(function()
		autoJoinEnabled = not autoJoinEnabled
		setToggleVisual(autoJoinEnabled)
	end)

	-- Tabs
	local function setTabVisual(name)
		currentTab = name
		if name == "AutoJoin" then
			ui.AutoSection.Visible = true
			ui.MiscSection.Visible = false
			ui.TabAuto.BackgroundColor3 = Color3.fromRGB(60,60,60)
			ui.TabMisc.BackgroundColor3 = Color3.fromRGB(34,34,34)
		else
			ui.AutoSection.Visible = false
			ui.MiscSection.Visible = true
			ui.TabAuto.BackgroundColor3 = Color3.fromRGB(34,34,34)
			ui.TabMisc.BackgroundColor3 = Color3.fromRGB(60,60,60)
		end
	end

	ui.TabAuto.MouseButton1Click:Connect(function() setTabVisual("AutoJoin") end)
	ui.TabMisc.MouseButton1Click:Connect(function() setTabVisual("Misc") end)
	setTabVisual(currentTab)

	-- Avatar fetch (corrigido)
	safeSpawn(function()
		pcall(function()
			local thumbUrl, isReady = Players:GetUserThumbnailAsync(
				player.UserId,
				Enum.ThumbnailType.HeadShot,
				Enum.ThumbnailSize.Size150x150
			)
			if isReady and thumbUrl and type(thumbUrl) == "string" then
				ui.Avatar.Image = thumbUrl
			end
		end)
	end)

	-- Nome do jogo via PlaceId
	safeSpawn(function()
		local ok, info = pcall(function() return MarketplaceService:GetProductInfo(game.PlaceId) end)
		if ok and info and info.Name then
			ui.NameLabel.Text = player.Name .. "\nPlaying " .. info.Name
		else
			ui.NameLabel.Text = player.Name .. "\nPlaying game ID " .. tostring(game.PlaceId)
		end
	end)

	-- Open/close
	local function toggleHub()
		local visible = not ui.MainFrame.Visible
		ui.MainFrame.Visible = visible
		ui.TopButton.Text = visible and "Click here to close Frosty Hub" or "Click here to open Frosty Hub"
		ui.TopButton.BackgroundColor3 = visible and Color3.fromRGB(220,60,60) or Color3.fromRGB(37,104,170)
	end
	ui.TopButton.MouseButton1Click:Connect(toggleHub)
	closeBtn.MouseButton1Click:Connect(toggleHub)

	-- Simulated loop for auto join (non-blocking)
	task.spawn(function()
		while ui.ScreenGui and ui.ScreenGui.Parent do
			if autoJoinEnabled then
				print("[AutoJoin] Searching servers...")
				task.wait(hasPremium and 3 or 6)
			else
				task.wait(0.5)
			end
		end
	end)
end

-- ========== Public API ==========

-- Inicializa a UI (idempotente)
function FrostyHub.Init()
	createUI()
end

-- Abre/fecha o hub (se passar bool, força estado)
function FrostyHub.Toggle(forceState)
	createUI()
	if forceState == nil then
		ui.MainFrame.Visible = not ui.MainFrame.Visible
	else
		ui.MainFrame.Visible = not not forceState
	end
	ui.TopButton.Text = ui.MainFrame.Visible and "Click here to close Frosty Hub" or "Click here to open Frosty Hub"
	ui.TopButton.BackgroundColor3 = ui.MainFrame.Visible and Color3.fromRGB(220,60,60) or Color3.fromRGB(37,104,170)
	return ui.MainFrame.Visible
end

-- Muda aba: "AutoJoin" ou "Misc"
function FrostyHub.SetTab(name)
	createUI()
	if name == "Misc" then
		ui.TabMisc:MouseButton1Click()
		return true
	elseif name == "AutoJoin" then
		ui.TabAuto:MouseButton1Click()
		return true
	end
	return false
end

-- Redeem programático (mesma lógica do botão)
function FrostyHub.RedeemLicense(key)
	createUI()
	key = tostring(key or "")
	if #key >= 6 then
		hasPremium = true
		ui.RedeemBtn.Text = "Redeemed"
		ui.RedeemBtn.BackgroundColor3 = Color3.fromRGB(80,200,100)
		return true
	else
		ui.RedeemBtn.Text = "Invalid"
		ui.RedeemBtn.BackgroundColor3 = Color3.fromRGB(200,60,60)
		task.wait(1)
		if ui.RedeemBtn and ui.RedeemBtn.Parent then
			ui.RedeemBtn.Text = "Redeem"
			ui.RedeemBtn.BackgroundColor3 = Color3.fromRGB(40,160,80)
		end
		return false
	end
end

-- Força premium
function FrostyHub.SetPremium(bool)
	hasPremium = not not bool
end

-- Liga/desliga AutoJoin e atualiza visual
function FrostyHub.SetAutoJoin(state)
	createUI()
	autoJoinEnabled = not not state
	-- atualiza visual
	if ui.ToggleCircle and ui.ToggleBtn then
		if autoJoinEnabled then
			ui.ToggleCircle:TweenPosition(UDim2.new(1, -26, 0.5, -11), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
			ui.ToggleBtn.BackgroundColor3 = Color3.fromRGB(60,160,80)
		else
			ui.ToggleCircle:TweenPosition(UDim2.new(0, 4, 0.5, -11), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.15, true)
			ui.ToggleBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
		end
	end
	return autoJoinEnabled
end

-- Retorna status
function FrostyHub.IsAutoJoinEnabled()
	return autoJoinEnabled
end

-- Retorna lista de funções públicas
function FrostyHub.GetAPIFunctions()
	return {
		"Init",
		"Toggle",
		"SetTab",
		"RedeemLicense",
		"SetPremium",
		"SetAutoJoin",
		"IsAutoJoinEnabled",
		"GetAPIFunctions",
		"Destroy",
	}
end

-- Remove a UI e limpa referências
function FrostyHub.Destroy()
	if ui.ScreenGui and ui.ScreenGui.Parent then
		ui.ScreenGui:Destroy()
	end
	ui = {}
	autoJoinEnabled = false
	hasPremium = false
	currentTab = "AutoJoin"
end

-- Default: não inicializa automaticamente. Retorne a tabela.
return FrostyHub
