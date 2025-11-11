
local vermLib = {}

function vermLib:CreateWindow(name)
	name = "HaxterHub V6"
	local Hub = Instance.new("ScreenGui")
	local Window = Instance.new("Frame")
	local Container = Instance.new("Frame")
	local Tabs = Instance.new("Folder")
	local MenuFrame = Instance.new("ScrollingFrame")
	local MenuFrameTwo = Instance.new("Frame")
	local UIListLayout_2 = Instance.new("UIListLayout")
	local SettingsFrame = Instance.new("ScrollingFrame")
	local ImageDecor = Instance.new("ImageLabel")
	local ButtonFrame_2 = Instance.new("Frame")
	local UIListLayout_3 = Instance.new("UIListLayout")
	local Button_3 = Instance.new("TextButton")
	local Button_4 = Instance.new("TextButton")
	local UICorner_5 = Instance.new("UICorner")
	local UICorner_6 = Instance.new("UICorner")
	local ButtonIcon_3 = Instance.new("ImageLabel")
    local Main = Instance.new("Frame")
    local usernameLabel = Instance.new("TextLabel")
    local ExecutorName = Instance.new("TextLabel")
    local profilePicture = Instance.new("ImageLabel")
    local GameName = Instance.new("TextLabel")
	local MainScrollingFrame = Instance.new("ScrollingFrame")
	local GameImage_1 = Instance.new("ImageButton")
	local GameImage_2 = Instance.new("ImageButton")
	local GameImage_3 = Instance.new("ImageButton")
	local GameImage_4 = Instance.new("ImageButton")
	local GameImage_5 = Instance.new("ImageButton")
	local GameImage_6 = Instance.new("ImageButton")
    local OpenClose = Instance.new("ImageButton")
    local UIScale = Instance.new("UIScale")
    local ScaleHandlerThing = Instance.new("LocalScript")
    local UICornerOC = Instance.new("UICorner")
	local HaxterHub = Instance.new("TextLabel", Window)
	local players = game:FindFirstChild("Players - Client") or game:GetService("Players") 
	local player = players.LocalPlayer

    local function getExecutor()
        local name
        if identifyexecutor then
            name = identifyexecutor()
        end
        return { Name = name or "Unknown Executor"}
    end
    local function detectExecutor()
        local executorDetails = getExecutor()
        return string.format("%s", executorDetails.Name)
    end
    local executor_Name = detectExecutor()


	Hub.Name = name
	Hub.Parent = game.CoreGui
	Hub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

    OpenClose.Name = "OpenClose"
    OpenClose.Parent = Hub
    OpenClose.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    OpenClose.BorderColor3 = Color3.fromRGB(0, 0, 0)
    OpenClose.BorderSizePixel = 0
    OpenClose.Position = UDim2.new(0, 0, 0.5, 0)
    OpenClose.Size = UDim2.new(0, 45, 0, 45)
	spawn(function()
    OpenClose.Image = "rbxassetid://105386774491726"
    OpenClose.ImageColor3 = Color3.fromRGB(255, 255, 255)
	end)
    UICornerOC.CornerRadius = UDim.new(1, 0)
    UICornerOC.Parent = OpenClose
    
	Window.Name = "Window"
	Window.Parent = Hub
	Window.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Window.BorderSizePixel = 0
	Window.Position = UDim2.new(0.33395347, 0, 0.30018419, 0)
	Window.Size = UDim2.new(0, 668, 0, 420)
	Window.Active = true

	local UIScale = Instance.new("UIScale")
	UIScale.Name = "AutoUIScale"
	UIScale.Scale = 0.8
	UIScale.Parent = Window.Parent

	local UserInputService = game:GetService("UserInputService")
	local player = game.Players.LocalPlayer
	local camera = workspace.CurrentCamera
	
	local camera = workspace.CurrentCamera
	local autoScale = UIScale
	local gui = Window 
	
	local function calcScale(y)
	    if y <= 800 then
	        return 0.45 + (y / 800) * (0.8 - 0.45)
	    elseif y <= 1080 then
	        return 0.8 + ((y - 800) / (1080 - 800)) * (1 - 0.8)
	    elseif y <= 1280 then
	        return 1 + ((y - 1080) / (1280 - 1080)) * (1.5 - 1)
	    else
	        return 1.5
	    end
	end

	
	local function updateScale()
	    autoScale.Scale = calcScale(camera.ViewportSize.Y)
	end
	camera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)
	updateScale()

	local dragging
	local dragInput
	local dragStart
	local startPos
	local isHoveringSlider = false
	
	local function getScale()
	    return autoScale.Scale
	end
	
	local function update(input)
	    if not isHoveringSlider then  
	        local scale = getScale()
	        local delta = (input.Position - dragStart) / scale
	        gui.Position = UDim2.new(
	            startPos.X.Scale,
	            startPos.X.Offset + delta.X,
	            startPos.Y.Scale,
	            startPos.Y.Offset + delta.Y
	        )
	    end
	end
	
	gui.InputBegan:Connect(function(input)
	    if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and not isHoveringSlider then
	        dragging = true
	        dragStart = input.Position
	        startPos = gui.Position
		
	        input.Changed:Connect(function()
	            if input.UserInputState == Enum.UserInputState.End then
	                dragging = false
	            end
	        end)
	    end
	end)
	
	gui.InputChanged:Connect(function(input)
	    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
	        dragInput = input
	    end
	end)
	
	UserInputService.InputChanged:Connect(function(input)
	    if input == dragInput and dragging then
	        update(input)
	    end
	end)

    OpenClose.MouseButton1Click:Connect(function()
        Window.Visible = not Window.Visible
    end)

	local UserInputService = game:GetService("UserInputService")

    local lastPressTime = 0
    local pressCount = 0
    local debounceTime = 0.3
    local isEnabled = false

    UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
        if gameProcessedEvent then return end 
    
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == Enum.KeyCode.C then
            local currentTime = tick()
            
            if currentTime - lastPressTime <= debounceTime then
                pressCount = pressCount + 1
            else
                pressCount = 1 
            end
            
            lastPressTime = currentTime
            
            if pressCount == 2 then
                isEnabled = not isEnabled 
                if isEnabled then
        Window.Visible = not Window.Visible
                else
        Window.Visible = not Window.Visible
                end
                pressCount = 0 
            end
        end
    end)


	local LineSeperation = Instance.new("Frame", Container)
	LineSeperation.LayoutOrder = 0
	LineSeperation.BorderMode = Enum.BorderMode.Outline
	LineSeperation.Interactable = true
	LineSeperation.Name = "LineSeperation"
	LineSeperation.Archivable = true
	LineSeperation.AnchorPoint = Vector2.new(0, 0)
	LineSeperation.BorderSizePixel = 0
	LineSeperation.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
	LineSeperation.Active = false
	LineSeperation.SizeConstraint = Enum.SizeConstraint.RelativeXY
	LineSeperation.ZIndex = 1
	LineSeperation.AutomaticSize = Enum.AutomaticSize.None
	LineSeperation.Size = UDim2.new(0, 1, 0, -351)
	LineSeperation.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
	LineSeperation.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
	LineSeperation.AutoLocalize = true
	LineSeperation.ClipsDescendants = false
	LineSeperation.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineSeperation.Visible = true
	LineSeperation.SelectionOrder = 0
	LineSeperation.Rotation = 0
	LineSeperation.Selectable = false
	LineSeperation.Style = Enum.FrameStyle.Custom
	LineSeperation.Position = UDim2.new(1, 0, 0.101999998, 0)
	LineSeperation.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
	LineSeperation.BackgroundTransparency = 0.5
	LineSeperation.SelectionGroup = false
	LineSeperation.BackgroundColor3 = Color3.fromRGB(97, 53, 206)

	
	local UICorner = Instance.new("UICorner", Window)
	UICorner.Name = "UICorner"
	UICorner.Archivable = true
	UICorner.CornerRadius = UDim.new(0, 20)

	local UIStroke = Instance.new("UIStroke", Window)
	UIStroke.Enabled = true
	UIStroke.Color = Color3.fromRGB(97, 53, 206)
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	UIStroke.Transparency = 0
	UIStroke.Name = "UIStroke"
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke.Archivable = true
	UIStroke.Thickness = 1

	local GameName = Instance.new("TextLabel", Window)
	GameName.LayoutOrder = 0
	GameName.TextWrapped = false
	GameName.LineHeight = 1
	GameName.Active = false
	GameName.Interactable = true
	GameName.TextStrokeTransparency = 1
	GameName.TextTruncate = Enum.TextTruncate.None
	GameName.SizeConstraint = Enum.SizeConstraint.RelativeXY
	GameName.ZIndex = 1
	GameName.BorderSizePixel = 0
	GameName.RichText = false
	GameName.AutoLocalize = true
	GameName.SelectionOrder = 0
	GameName.TextYAlignment = Enum.TextYAlignment.Center
	GameName.TextScaled = false
	GameName.BackgroundColor3 = Color3.fromRGB(97, 53, 206)
	GameName.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	GameName.BorderMode = Enum.BorderMode.Outline
	GameName.TextTransparency = 0
	GameName.OpenTypeFeatures = ""
	GameName.Name = "GameName"
	GameName.AnchorPoint = Vector2.new(0, 0)
	GameName.Archivable = true
	GameName.AutomaticSize = Enum.AutomaticSize.None
	GameName.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
	GameName.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
	GameName.ClipsDescendants = false
	GameName.TextSize = 14
	GameName.Size = UDim2.new(0, 100, 0, 38)
	GameName.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
	GameName.Visible = true
	GameName.TextColor3 = Color3.fromRGB(97, 53, 206)
	GameName.BorderColor3 = Color3.fromRGB(0, 0, 0)
	GameName.Text = "Game:"
	GameName.TextDirection = Enum.TextDirection.Auto
	GameName.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	GameName.Rotation = 0
	GameName.Selectable = false
	GameName.BackgroundTransparency = 1
	GameName.TextXAlignment = Enum.TextXAlignment.Center
	GameName.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
	GameName.MaxVisibleGraphemes = -1
	GameName.SelectionGroup = false
	GameName.Position = UDim2.new(0.839820385, 0, 0.907999992, 4)

    local gameNameText = tostring(game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name)
    
    if #gameNameText > 17 then
        gameNameText = gameNameText:sub(1, 17) .. "..."
    end
    
    GameName.Text = gameNameText

	local FPS = Instance.new("TextLabel", Window)
	FPS.LayoutOrder = 0
	FPS.TextWrapped = false
	FPS.LineHeight = 1
	FPS.Active = false
	FPS.Interactable = true
	FPS.TextStrokeTransparency = 1
	FPS.TextTruncate = Enum.TextTruncate.None
	FPS.SizeConstraint = Enum.SizeConstraint.RelativeXY
	FPS.ZIndex = 1
	FPS.BorderSizePixel = 0
	FPS.RichText = false
	FPS.AutoLocalize = true
	FPS.SelectionOrder = 0
	FPS.TextYAlignment = Enum.TextYAlignment.Center
	FPS.TextScaled = false
	FPS.BackgroundColor3 = Color3.fromRGB(97, 53, 206)
	FPS.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	FPS.BorderMode = Enum.BorderMode.Outline
	FPS.TextTransparency = 0
	FPS.OpenTypeFeatures = ""
	FPS.Name = "FPS"
	FPS.AnchorPoint = Vector2.new(0, 0)
	FPS.Archivable = true
	FPS.AutomaticSize = Enum.AutomaticSize.None
	FPS.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
	FPS.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
	FPS.ClipsDescendants = false
	FPS.TextSize = 14
	FPS.Size = UDim2.new(0, 100, 0, 38)
	FPS.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
	FPS.Visible = true
	FPS.TextColor3 = Color3.fromRGB(97, 53, 206)
	FPS.BorderColor3 = Color3.fromRGB(0, 0, 0)
	FPS.Text = "FPS:"
	FPS.TextDirection = Enum.TextDirection.Auto
	FPS.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	FPS.Rotation = 0
	FPS.Selectable = false
	FPS.BackgroundTransparency = 1
	FPS.TextXAlignment = Enum.TextXAlignment.Center
	FPS.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
	FPS.MaxVisibleGraphemes = -1
	FPS.SelectionGroup = false
	FPS.Position = UDim2.new(0.326347291, 0, 0.907999992, 4)

	local UserInputService = game:GetService("UserInputService")
	local RunService = game:GetService("RunService")
	local lastUpdate = tick()
	local frameCount = 0

	RunService.RenderStepped:Connect(function(frameTime)
	    frameCount = frameCount + 1
	    if tick() - lastUpdate >= 0.3 then
	        local fpsValue = math.round(frameCount / 0.3) 
	        FPS.Text = "FPS: " .. fpsValue
	        lastUpdate = tick() 
	        frameCount = 0 
	    end
	end)

	
	local Discord = Instance.new("TextButton", Window)
	Discord.LayoutOrder = 0
	Discord.TextWrapped = false
	Discord.LineHeight = 1
	Discord.Active = true
	Discord.Interactable = true
	Discord.TextStrokeTransparency = 1
	Discord.TextTruncate = Enum.TextTruncate.None
	Discord.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Discord.ZIndex = 1
	Discord.BorderSizePixel = 0
	Discord.RichText = false
	Discord.AutoLocalize = true
	Discord.Modal = false
	Discord.AutoButtonColor = true
	Discord.Name = "Discord"
	Discord.Archivable = true
	Discord.SelectionOrder = 0
	Discord.TextSize = 20
	Discord.TextYAlignment = Enum.TextYAlignment.Center
	Discord.TextScaled = false
	Discord.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Discord.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
	Discord.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	Discord.ClipsDescendants = false
	Discord.BorderMode = Enum.BorderMode.Outline
	Discord.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Discord.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
	Discord.OpenTypeFeatures = ""
	Discord.AnchorPoint = Vector2.new(0, 0)
	Discord.Visible = true
	Discord.Selectable = true
	Discord.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
	Discord.Selected = false
	Discord.AutomaticSize = Enum.AutomaticSize.None
	Discord.Size = UDim2.new(0, 61, 0, 26)
	Discord.TextDirection = Enum.TextDirection.Auto
	Discord.Position = UDim2.new(0.070000015, 0, 0.812, 0)
	Discord.TextColor3 = Color3.fromRGB(97, 53, 206)
	Discord.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Discord.Text = "Discord"
	Discord.Rotation = 0
	Discord.TextTransparency = 0
	Discord.Style = Enum.ButtonStyle.Custom
	Discord.TextXAlignment = Enum.TextXAlignment.Center
	Discord.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
	Discord.MaxVisibleGraphemes = -1
	Discord.SelectionGroup = false
	Discord.BackgroundTransparency = 0.9


	local UICorner = Instance.new("UICorner", Discord)
	UICorner.Name = "UICorner"
	UICorner.Archivable = true
	UICorner.CornerRadius = UDim.new(0, 8)

	Discord.MouseButton1Click:Connect(function()
    setclipboard("https://discord.gg/zGcnq6pZd9")
	end)

	local DiscordLogo = Instance.new("ImageLabel", Window)
	DiscordLogo.Visible = true
	DiscordLogo.Active = false
	DiscordLogo.Interactable = true
	DiscordLogo.SizeConstraint = Enum.SizeConstraint.RelativeXY
	DiscordLogo.ZIndex = 1
	DiscordLogo.BorderSizePixel = 0
	DiscordLogo.SliceCenter = Rect.new(Vector2.new(0, 0), Vector2.new(0, 0))
	DiscordLogo.ScaleType = Enum.ScaleType.Fit
	DiscordLogo.AutoLocalize = true
	DiscordLogo.SelectionOrder = 0
	DiscordLogo.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	DiscordLogo.ImageTransparency = 0
	DiscordLogo.Selectable = false
	DiscordLogo.AnchorPoint = Vector2.new(0, 0)

	DiscordLogo.TileSize = UDim2.new(1, 0, 1, 0)
	DiscordLogo.ImageRectSize = Vector2.new(500, 500)
	DiscordLogo.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
	DiscordLogo.Name = "DiscordLogo"
	DiscordLogo.AutomaticSize = Enum.AutomaticSize.None
	DiscordLogo.Size = UDim2.new(0, 40, 0, 40)
	DiscordLogo.Archivable = true
	DiscordLogo.BorderMode = Enum.BorderMode.Outline
	DiscordLogo.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
	DiscordLogo.ClipsDescendants = false
	DiscordLogo.BorderColor3 = Color3.fromRGB(0, 0, 0)
	DiscordLogo.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
	DiscordLogo.ImageColor3 = Color3.fromRGB(255, 255, 255)
	DiscordLogo.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
	DiscordLogo.Rotation = 0
	DiscordLogo.ResampleMode = Enum.ResamplerMode.Default
	DiscordLogo.BackgroundTransparency = 1
	DiscordLogo.Position = UDim2.new(0.010479042, 0, 0, 335)
	DiscordLogo.SliceScale = 1
	DiscordLogo.LayoutOrder = 0
	DiscordLogo.SelectionGroup = false
	DiscordLogo.ImageRectOffset = Vector2.new(100, 120)


	local UICorner = Instance.new("UICorner", DiscordLogo)
	UICorner.Name = "UICorner"
	UICorner.Archivable = true
	UICorner.CornerRadius = UDim.new(0, 80)

	local folder = "HaxterFelix/Images"
	local fileName = "discord.png"
	local filePath = folder .. "/" .. fileName
	
	if not isfolder("HaxterFelix") then makefolder("HaxterFelix") end
	if not isfolder(folder) then makefolder(folder) end
	spawn(function()
	if not isfile(filePath) then
	    local url = "https://i.pinimg.com/736x/41/82/54/418254b1df082302b21800b932bfd8fc.jpg"
	    local response = (http_request or request or syn.request)({
	        Url = url,
	        Method = "GET"
	    })
	
	    if response and response.Body then
	        writefile(filePath, response.Body)
	    else
	    end
	else
	end
	end)
	spawn(function()
	DiscordLogo.Image = "rbxassetid://102240541026129"
	end)
	spawn(function()
	local imagePath = getcustomasset(filePath)
	game:GetService("CoreGui")["HaxterHub V6"].Window.DiscordLogo.Image = imagePath
	end)
	local Profile = Instance.new("Frame", Window)
	Profile.LayoutOrder = 0
	Profile.BorderMode = Enum.BorderMode.Outline
	Profile.Interactable = true
	Profile.Name = "Profile"
	Profile.Archivable = true
	Profile.AnchorPoint = Vector2.new(0, 0)
	Profile.BorderSizePixel = 0
	Profile.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
	Profile.Active = false
	Profile.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Profile.ZIndex = 1
	Profile.AutomaticSize = Enum.AutomaticSize.None
	Profile.Size = UDim2.new(0, 123, 0, 51)
	Profile.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
	Profile.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
	Profile.AutoLocalize = true
	Profile.ClipsDescendants = false
	Profile.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Profile.Visible = true
	Profile.SelectionOrder = 0
	Profile.Rotation = 0
	Profile.Selectable = false
	Profile.Style = Enum.FrameStyle.Custom
	Profile.Position = UDim2.new(0.806603789, 0, -0.154, 0)
	Profile.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
	Profile.BackgroundTransparency = 1
	Profile.SelectionGroup = false
	Profile.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

	local ImageLabel = Instance.new("ImageLabel", Profile)
	ImageLabel.Visible = true
	ImageLabel.Active = false
	ImageLabel.Interactable = true
	ImageLabel.SizeConstraint = Enum.SizeConstraint.RelativeXY
	ImageLabel.ZIndex = 1
	ImageLabel.BorderSizePixel = 0
	ImageLabel.SliceCenter = Rect.new(Vector2.new(0, 0), Vector2.new(0, 0))
	ImageLabel.ScaleType = Enum.ScaleType.Fit
	ImageLabel.AutoLocalize = true
	ImageLabel.SelectionOrder = 0
	ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.ImageTransparency = 0
	ImageLabel.Selectable = false
	ImageLabel.AnchorPoint = Vector2.new(0, 0)
	ImageLabel.TileSize = UDim2.new(1, 0, 1, 0)
	ImageLabel.ImageRectSize = Vector2.new(0, 0)
	ImageLabel.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
	ImageLabel.Name = "ImageLabel"
	ImageLabel.AutomaticSize = Enum.AutomaticSize.None
	ImageLabel.Size = UDim2.new(0, 35, 0, 35)
	ImageLabel.Archivable = true
	ImageLabel.BorderMode = Enum.BorderMode.Outline
	ImageLabel.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
	ImageLabel.ClipsDescendants = false
	ImageLabel.BorderColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
	ImageLabel.ImageColor3 = Color3.fromRGB(255, 255, 255)
	ImageLabel.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
	ImageLabel.Rotation = 0
	ImageLabel.ResampleMode = Enum.ResamplerMode.Default
	ImageLabel.BackgroundTransparency = 0.9
	ImageLabel.Position = UDim2.new(-4.238292694, -10, 6.8039999, 95)
	ImageLabel.SliceScale = 1
	ImageLabel.LayoutOrder = 0
	ImageLabel.SelectionGroup = false
	ImageLabel.ImageRectOffset = Vector2.new(0, 0)
	spawn(function()
	ImageLabel.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
	end)

	local UICorner = Instance.new("UICorner", ImageLabel)
	UICorner.Name = "UICorner"
	UICorner.Archivable = true
	UICorner.CornerRadius = UDim.new(0, 80)
	spawn(function()
	ImageLabel.Image = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. player.UserId .. "&width=420&height=420&format=png"
	end)

	local Username = Instance.new("TextLabel", Profile)
	Username.LayoutOrder = 0
	Username.TextWrapped = false
	Username.LineHeight = 1
	Username.Active = false
	Username.Interactable = true
	Username.TextStrokeTransparency = 1
	Username.TextTruncate = Enum.TextTruncate.None
	Username.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Username.ZIndex = 1
	Username.BorderSizePixel = 0
	Username.RichText = false
	Username.AutoLocalize = true
	Username.SelectionOrder = 0
	Username.TextYAlignment = Enum.TextYAlignment.Center
	Username.TextScaled = false
	Username.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Username.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	Username.BorderMode = Enum.BorderMode.Outline
	Username.TextTransparency = 0
	Username.OpenTypeFeatures = ""
	Username.Name = "Username"
	Username.AnchorPoint = Vector2.new(0, 0)
	Username.Archivable = true
	Username.AutomaticSize = Enum.AutomaticSize.None
	Username.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
	Username.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
	Username.ClipsDescendants = false
	Username.TextSize = 14
	Username.Size = UDim2.new(0, 61, 0, 26)
	Username.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
	Username.Visible = true
	Username.TextColor3 = Color3.fromRGB(97, 53, 206)
	Username.BorderColor3 = Color3.fromRGB(255, 255, 255)
	Username.Text = "Username"
	Username.TextDirection = Enum.TextDirection.Auto
	Username.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Username.Rotation = 0
	Username.Selectable = false
	Username.BackgroundTransparency = 0.9
	Username.TextXAlignment = Enum.TextXAlignment.Center
	Username.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
	Username.MaxVisibleGraphemes = -1
	Username.SelectionGroup = false
	Username.Position = UDim2.new(-3.918699265, -10, 6.92199993, 95)

	Username.Text = player.DisplayName

	local UICorner = Instance.new("UICorner", Username)
	UICorner.Name = "UICorner"
	UICorner.Archivable = true
	UICorner.CornerRadius = UDim.new(0, 8)


	local Time = Instance.new("TextLabel", Window)
	Time.LayoutOrder = 0
	Time.TextWrapped = false
	Time.LineHeight = 1
	Time.Active = false
	Time.Interactable = true
	Time.TextStrokeTransparency = 1
	Time.TextTruncate = Enum.TextTruncate.None
	Time.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Time.ZIndex = 1
	Time.BorderSizePixel = 0
	Time.RichText = false
	Time.AutoLocalize = true
	Time.SelectionOrder = 0
	Time.TextYAlignment = Enum.TextYAlignment.Center
	Time.TextScaled = false
	Time.BackgroundColor3 = Color3.fromRGB(97, 53, 206)
	Time.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	Time.BorderMode = Enum.BorderMode.Outline
	Time.TextTransparency = 0
	Time.OpenTypeFeatures = ""
	Time.Name = "Time"
	Time.AnchorPoint = Vector2.new(0, 0)
	Time.Archivable = true
	Time.AutomaticSize = Enum.AutomaticSize.None
	Time.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
	Time.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
	Time.ClipsDescendants = false
	Time.TextSize = 14
	Time.Size = UDim2.new(0, 100, 0, 38)
	Time.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
	Time.Visible = true
	Time.TextColor3 = Color3.fromRGB(97, 53, 206)
	Time.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Time.Text = "Time:"
	Time.TextDirection = Enum.TextDirection.Auto
	Time.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Time.Rotation = 0
	Time.Selectable = false
	Time.BackgroundTransparency = 1
	Time.TextXAlignment = Enum.TextXAlignment.Center
	Time.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
	Time.MaxVisibleGraphemes = -1
	Time.SelectionGroup = false
	Time.Position = UDim2.new(0.166167662, 0, 0.907999992, 3)

	local function getLocalTime()
		local success, result = pcall(function()
		local date = os.date("*t")
		local hour = (date.hour % 12 == 0) and 12 or (date.hour % 12)
		local ampm = (date.hour < 12) and "AM" or "PM"
		local localTime = string.format("%d:%02d:%02d %s", hour, date.min, date.sec, ampm)
		return localTime end)
		if success then
			return result
		else
			return "Unknown"
		end
	end
	coroutine.wrap(function()
	    while true do
	        local localTime = getLocalTime()
	        Time.Text = localTime
	        wait(1)
	    end
	end)()

	local MinimizeUI = Instance.new("TextButton", Window)
	MinimizeUI.LayoutOrder = 0
	MinimizeUI.TextWrapped = false
	MinimizeUI.LineHeight = 1
	MinimizeUI.Active = true
	MinimizeUI.Interactable = true
	MinimizeUI.TextStrokeTransparency = 1
	MinimizeUI.TextTruncate = Enum.TextTruncate.None
	MinimizeUI.SizeConstraint = Enum.SizeConstraint.RelativeXY
	MinimizeUI.ZIndex = 1
	MinimizeUI.BorderSizePixel = 0
	MinimizeUI.RichText = false
	MinimizeUI.AutoLocalize = true
	MinimizeUI.Modal = false
	MinimizeUI.AutoButtonColor = true
	MinimizeUI.Name = "MinimizeUI"
	MinimizeUI.Archivable = true
	MinimizeUI.SelectionOrder = 0
	MinimizeUI.TextSize = 30
	MinimizeUI.TextYAlignment = Enum.TextYAlignment.Center
	MinimizeUI.TextScaled = false
	MinimizeUI.BackgroundColor3 = Color3.fromRGB(255, 230, 85)
	MinimizeUI.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
	MinimizeUI.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	MinimizeUI.ClipsDescendants = false
	MinimizeUI.BorderMode = Enum.BorderMode.Outline
	MinimizeUI.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	MinimizeUI.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
	MinimizeUI.OpenTypeFeatures = ""
	MinimizeUI.AnchorPoint = Vector2.new(0, 0)
	MinimizeUI.Visible = true
	MinimizeUI.Selectable = true
	MinimizeUI.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
	MinimizeUI.Selected = false
	MinimizeUI.AutomaticSize = Enum.AutomaticSize.None
	MinimizeUI.Size = UDim2.new(0, 11, 0, 11)
	MinimizeUI.TextDirection = Enum.TextDirection.Auto
	MinimizeUI.Position = UDim2.new(0.053501334, 0, 0.029, 0)
	MinimizeUI.TextColor3 = Color3.fromRGB(255, 0, 0)
	MinimizeUI.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MinimizeUI.Text = ""
	MinimizeUI.Rotation = 0
	MinimizeUI.TextTransparency = 0
	MinimizeUI.Style = Enum.ButtonStyle.Custom
	MinimizeUI.TextXAlignment = Enum.TextXAlignment.Center
	MinimizeUI.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
	MinimizeUI.MaxVisibleGraphemes = -1
	MinimizeUI.SelectionGroup = false
	MinimizeUI.BackgroundTransparency = 0


	local UICorner = Instance.new("UICorner", MinimizeUI)
	UICorner.Name = "UICorner"
	UICorner.Archivable = true
	UICorner.CornerRadius = UDim.new(0, 40)

	MinimizeUI.MouseButton1Click:Connect(function()
	    MinimizeUI.Parent.Visible = false
	end)

	local DestroyUI = Instance.new("TextButton", Window)
	DestroyUI.LayoutOrder = 0
	DestroyUI.TextWrapped = false
	DestroyUI.LineHeight = 1
	DestroyUI.Active = true
	DestroyUI.Interactable = true
	DestroyUI.TextStrokeTransparency = 1
	DestroyUI.TextTruncate = Enum.TextTruncate.None
	DestroyUI.SizeConstraint = Enum.SizeConstraint.RelativeXY
	DestroyUI.ZIndex = 1
	DestroyUI.BorderSizePixel = 0
	DestroyUI.RichText = false
	DestroyUI.AutoLocalize = true
	DestroyUI.Modal = false
	DestroyUI.AutoButtonColor = true
	DestroyUI.Name = "DestroyUI"
	DestroyUI.Archivable = true
	DestroyUI.SelectionOrder = 0
	DestroyUI.TextSize = 30
	DestroyUI.TextYAlignment = Enum.TextYAlignment.Center
	DestroyUI.TextScaled = false
	DestroyUI.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
	DestroyUI.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
	DestroyUI.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	DestroyUI.ClipsDescendants = false
	DestroyUI.BorderMode = Enum.BorderMode.Outline
	DestroyUI.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	DestroyUI.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
	DestroyUI.OpenTypeFeatures = ""
	DestroyUI.AnchorPoint = Vector2.new(0, 0)
	DestroyUI.Visible = true
	DestroyUI.Selectable = true
	DestroyUI.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
	DestroyUI.Selected = false
	DestroyUI.AutomaticSize = Enum.AutomaticSize.None
	DestroyUI.Size = UDim2.new(0, 11, 0, 11)
	DestroyUI.TextDirection = Enum.TextDirection.Auto
	DestroyUI.Position = UDim2.new(0.028052233, 0, 0.029, 0)
	DestroyUI.TextColor3 = Color3.fromRGB(255, 0, 0)
	DestroyUI.BorderColor3 = Color3.fromRGB(0, 0, 0)
	DestroyUI.Text = ""
	DestroyUI.Rotation = 0
	DestroyUI.TextTransparency = 0
	DestroyUI.Style = Enum.ButtonStyle.Custom
	DestroyUI.TextXAlignment = Enum.TextXAlignment.Center
	DestroyUI.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
	DestroyUI.MaxVisibleGraphemes = -1
	DestroyUI.SelectionGroup = false
	DestroyUI.BackgroundTransparency = 0
	
	
	local UICorner = Instance.new("UICorner", DestroyUI)
	UICorner.Name = "UICorner"
	UICorner.Archivable = true
	UICorner.CornerRadius = UDim.new(0, 40)

	DestroyUI.MouseButton1Click:Connect(function()
	    DestroyUI.Parent.Parent:Destroy()
	end)

	local LineSeperation = Instance.new("Frame", Window)
	LineSeperation.LayoutOrder = 0
	LineSeperation.BorderMode = Enum.BorderMode.Outline
	LineSeperation.Interactable = true
	LineSeperation.Name = "LineSeperation"
	LineSeperation.Archivable = true
	LineSeperation.AnchorPoint = Vector2.new(0, 0)
	LineSeperation.BorderSizePixel = 0
	LineSeperation.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
	LineSeperation.Active = false
	LineSeperation.SizeConstraint = Enum.SizeConstraint.RelativeXY
	LineSeperation.ZIndex = 1
	LineSeperation.AutomaticSize = Enum.AutomaticSize.None
	LineSeperation.Size = UDim2.new(0, 1, 0, -19)
	LineSeperation.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
	LineSeperation.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
	LineSeperation.AutoLocalize = true
	LineSeperation.ClipsDescendants = false
	LineSeperation.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineSeperation.Visible = true
	LineSeperation.SelectionOrder = 0
	LineSeperation.Rotation = 0
	LineSeperation.Selectable = false
	LineSeperation.Style = Enum.FrameStyle.Custom
	LineSeperation.Position = UDim2.new(0.653999984, 121, 1.02499998, -15)
	LineSeperation.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
	LineSeperation.BackgroundTransparency = 0.5
	LineSeperation.SelectionGroup = false
	LineSeperation.BackgroundColor3 = Color3.fromRGB(97, 53, 206)

	local LineSeperation = Instance.new("Frame", Window)
	LineSeperation.LayoutOrder = 0
	LineSeperation.BorderMode = Enum.BorderMode.Outline
	LineSeperation.Interactable = true
	LineSeperation.Name = "LineSeperation"
	LineSeperation.Archivable = true
	LineSeperation.AnchorPoint = Vector2.new(0, 0)
	LineSeperation.BorderSizePixel = 0
	LineSeperation.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
	LineSeperation.Active = false
	LineSeperation.SizeConstraint = Enum.SizeConstraint.RelativeXY
	LineSeperation.ZIndex = 1
	LineSeperation.AutomaticSize = Enum.AutomaticSize.None
	LineSeperation.Size = UDim2.new(0, 1, 0, -19)
	LineSeperation.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
	LineSeperation.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
	LineSeperation.AutoLocalize = true
	LineSeperation.ClipsDescendants = false
	LineSeperation.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineSeperation.Visible = true
	LineSeperation.SelectionOrder = 0
	LineSeperation.Rotation = 0
	LineSeperation.Selectable = false
	LineSeperation.Style = Enum.FrameStyle.Custom
	LineSeperation.Position = UDim2.new(0.653999984, -5, 1.02499998, -15)
	LineSeperation.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
	LineSeperation.BackgroundTransparency = 0.5
	LineSeperation.SelectionGroup = false
	LineSeperation.BackgroundColor3 = Color3.fromRGB(97, 53, 206)

	local LineSeperation = Instance.new("Frame", Window)
	LineSeperation.LayoutOrder = 0
	LineSeperation.BorderMode = Enum.BorderMode.Outline
	LineSeperation.Interactable = true
	LineSeperation.Name = "LineSeperation"
	LineSeperation.Archivable = true
	LineSeperation.AnchorPoint = Vector2.new(0, 0)
	LineSeperation.BorderSizePixel = 0
	LineSeperation.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
	LineSeperation.Active = false
	LineSeperation.SizeConstraint = Enum.SizeConstraint.RelativeXY
	LineSeperation.ZIndex = 1
	LineSeperation.AutomaticSize = Enum.AutomaticSize.None
	LineSeperation.Size = UDim2.new(0, 1, 0, -19)
	LineSeperation.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
	LineSeperation.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
	LineSeperation.AutoLocalize = true
	LineSeperation.ClipsDescendants = false
	LineSeperation.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineSeperation.Visible = true
	LineSeperation.SelectionOrder = 0
	LineSeperation.Rotation = 0
	LineSeperation.Selectable = false
	LineSeperation.Style = Enum.FrameStyle.Custom
	LineSeperation.Position = UDim2.new(0.653999984, -108, 1.02499998, -14)
	LineSeperation.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
	LineSeperation.BackgroundTransparency = 0.5
	LineSeperation.SelectionGroup = false
	LineSeperation.BackgroundColor3 = Color3.fromRGB(97, 53, 206)

	local LineSeperation = Instance.new("Frame", Window)
	LineSeperation.LayoutOrder = 0
	LineSeperation.BorderMode = Enum.BorderMode.Outline
	LineSeperation.Interactable = true
	LineSeperation.Name = "LineSeperation"
	LineSeperation.Archivable = true
	LineSeperation.AnchorPoint = Vector2.new(0, 0)
	LineSeperation.BorderSizePixel = 0
	LineSeperation.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
	LineSeperation.Active = false
	LineSeperation.SizeConstraint = Enum.SizeConstraint.RelativeXY
	LineSeperation.ZIndex = 1
	LineSeperation.AutomaticSize = Enum.AutomaticSize.None
	LineSeperation.Size = UDim2.new(0, 1, 0, -19)
	LineSeperation.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
	LineSeperation.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
	LineSeperation.AutoLocalize = true
	LineSeperation.ClipsDescendants = false
	LineSeperation.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LineSeperation.Visible = true
	LineSeperation.SelectionOrder = 0
	LineSeperation.Rotation = 0
	LineSeperation.Selectable = false
	LineSeperation.Style = Enum.FrameStyle.Custom
	LineSeperation.Position = UDim2.new(0.653999984, -232, 1.02499998, -16)
	LineSeperation.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
	LineSeperation.BackgroundTransparency = 0.5
	LineSeperation.SelectionGroup = false
	LineSeperation.BackgroundColor3 = Color3.fromRGB(97, 53, 206)


	local JobId = Instance.new("TextButton", Window)
	JobId.LayoutOrder = 0
	JobId.TextWrapped = false
	JobId.LineHeight = 1
	JobId.Active = true
	JobId.Interactable = true
	JobId.TextStrokeTransparency = 1
	JobId.TextTruncate = Enum.TextTruncate.None
	JobId.SizeConstraint = Enum.SizeConstraint.RelativeXY
	JobId.ZIndex = 1
	JobId.BorderSizePixel = 0
	JobId.RichText = false
	JobId.AutoLocalize = true
	JobId.Modal = false
	JobId.AutoButtonColor = true
	JobId.Name = "JobId"
	JobId.Archivable = true
	JobId.SelectionOrder = 0
	JobId.TextSize = 14
	JobId.TextYAlignment = Enum.TextYAlignment.Center
	JobId.TextScaled = false
	JobId.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	JobId.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
	JobId.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	JobId.ClipsDescendants = false
	JobId.BorderMode = Enum.BorderMode.Outline
	JobId.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	JobId.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
	JobId.OpenTypeFeatures = ""
	JobId.AnchorPoint = Vector2.new(0, 0)
	JobId.Visible = true
	JobId.Selectable = true
	JobId.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
	JobId.Selected = false
	JobId.AutomaticSize = Enum.AutomaticSize.None
	JobId.Size = UDim2.new(0, 126, 0, 26)
	JobId.TextDirection = Enum.TextDirection.Auto
	JobId.Position = UDim2.new(0.64371258, 1, 0.922999978, 4)
	JobId.TextColor3 = Color3.fromRGB(97, 53, 206)
	JobId.BorderColor3 = Color3.fromRGB(0, 0, 0)
	JobId.Text = "JobId:"
	JobId.Rotation = 0
	JobId.TextTransparency = 0
	JobId.Style = Enum.ButtonStyle.Custom
	JobId.TextXAlignment = Enum.TextXAlignment.Center
	JobId.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
	JobId.MaxVisibleGraphemes = -1
	JobId.SelectionGroup = false
	JobId.BackgroundTransparency = 1

	local jobIdText = tostring(game.JobId)
    
	if #jobIdText > 17 then
		jobIdText = jobIdText:sub(1, 17) .. "..."
	end
	
	JobId.Text = jobIdText
	JobId.MouseButton1Click:Connect(function()
	    setclipboard(game.JobId)
	end)

	local Executor = Instance.new("TextLabel", Window)
	Executor.LayoutOrder = 0
	Executor.TextWrapped = false
	Executor.LineHeight = 1
	Executor.Active = false
	Executor.Interactable = true
	Executor.TextStrokeTransparency = 1
	Executor.TextTruncate = Enum.TextTruncate.None
	Executor.SizeConstraint = Enum.SizeConstraint.RelativeXY
	Executor.ZIndex = 1
	Executor.BorderSizePixel = 0
	Executor.RichText = false
	Executor.AutoLocalize = true
	Executor.SelectionOrder = 0
	Executor.TextYAlignment = Enum.TextYAlignment.Center
	Executor.TextScaled = false
	Executor.BackgroundColor3 = Color3.fromRGB(97, 53, 206)
	Executor.FontFace = Font.new("rbxasset://fonts/families/SourceSansPro.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	Executor.BorderMode = Enum.BorderMode.Outline
	Executor.TextTransparency = 0
	Executor.OpenTypeFeatures = ""
	Executor.Name = "Executor"
	Executor.AnchorPoint = Vector2.new(0, 0)
	Executor.Archivable = true
	Executor.AutomaticSize = Enum.AutomaticSize.None
	Executor.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
	Executor.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
	Executor.ClipsDescendants = false
	Executor.TextSize = 14
	Executor.Size = UDim2.new(0, 100, 0, 38)
	Executor.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
	Executor.Visible = true
	Executor.TextColor3 = Color3.fromRGB(97, 53, 206)
	Executor.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Executor.Text = "Executor: " .. executor_Name
	Executor.TextDirection = Enum.TextDirection.Auto
	Executor.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
	Executor.Rotation = 0
	Executor.Selectable = false
	Executor.BackgroundTransparency = 1
	Executor.TextXAlignment = Enum.TextXAlignment.Center
	Executor.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
	Executor.MaxVisibleGraphemes = -1
	Executor.SelectionGroup = false
	Executor.Position = UDim2.new(0.494011968, 0, 0.907999992, 4)        

	Container.Name = "Container"
	Container.Parent = Window
	Container.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Container.BorderSizePixel = 0
	Container.ClipsDescendants = true
	Container.Position = UDim2.new(0, 155, 0, 50)
	Container.Size = UDim2.new(0, 500, 0, 340)
	Container.Active = true

	local UICorner = Instance.new("UICorner", Container)
	UICorner.Name = "UICorner"
	UICorner.Archivable = true
	UICorner.CornerRadius = UDim.new(0, 20)


	local UIStroke = Instance.new("UIStroke", Container)
	UIStroke.Enabled = true
	UIStroke.Color = Color3.fromRGB(97, 53, 206)
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	UIStroke.Transparency = 0.5
	UIStroke.Name = "UIStroke"
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke.Archivable = true
	UIStroke.Thickness = 1


    local Main = Instance.new("Frame")
    Main.Name = "Main"
	Main.Parent = Container
	Main.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	Main.Visible = true
	Main.Position = UDim2.new(0.024, 0, 0.024, 0)
	Main.Size = UDim2.new(0, 475, 0, 325)
	Main.BorderSizePixel = 0

	local players = game:FindFirstChild("Players - Client") or game:GetService("Players") 
	local player = players.LocalPlayer

    usernameLabel.Text = "Welcome To HaxterHub: " .. player.DisplayName
    usernameLabel.Position = UDim2.new(0.474999994, 0, 0.115, 0)
    usernameLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    usernameLabel.Parent = MainScrollingFrame
    usernameLabel.TextSize = "14"
    usernameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	usernameLabel.Name = "usernameLabel"

    ExecutorName.Text = "Executor: " .. executor_Name
    ExecutorName.Position = UDim2.new(0.474999994, 0, 0.18, 0)
    ExecutorName.AnchorPoint = Vector2.new(0.5, 0.5)
    ExecutorName.Parent = MainScrollingFrame
    ExecutorName.TextSize = "14"
    ExecutorName.TextColor3 = Color3.fromRGB(255, 255, 255)
	ExecutorName.Name = "ExecutorName"


	Tabs.Name = "Tabs"
	Tabs.Parent = Container

	MenuFrame.Name = "MenuFrame"
	MenuFrame.Parent = Window
	MenuFrame.Active = true
	MenuFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MenuFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MenuFrame.Position = UDim2.new(0, 15, 0, 50)
	MenuFrame.Size = UDim2.new(0, 118, 0, 268)
	MenuFrame.ScrollBarThickness = 0
	MenuFrame.Visible = true
	MenuFrame.CanvasSize = UDim2.new(0, 0, 9, 0)


	MenuFrameTwo.Name = "MenuFrameTwo"
	MenuFrameTwo.Parent = MenuFrame
	MenuFrameTwo.Active = true
	MenuFrameTwo.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	MenuFrameTwo.BorderColor3 = Color3.fromRGB(0, 0, 0)
	MenuFrameTwo.Position = UDim2.new(0, 6, 0, 0)
	MenuFrameTwo.Size = UDim2.new(0, 0, 0, 0)
	MenuFrameTwo.Visible = true
	
	local UICorner23 = Instance.new("UICorner", MenuFrame)
	UICorner23.Name = "UICorner"
	UICorner23.Archivable = true
	UICorner23.CornerRadius = UDim.new(0, 20)

	local UIStroke = Instance.new("UIStroke", MenuFrame)
	UIStroke.Enabled = true
	UIStroke.Color = Color3.fromRGB(97, 53, 206)
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	UIStroke.Transparency = 0.5
	UIStroke.Name = "UIStroke"
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke.Archivable = true
	UIStroke.Thickness = 1

    profilePicture.Name = "PlayerPicture"
    profilePicture.Size = UDim2.new(0, 111, 0, 108)
    profilePicture.Position = UDim2.new(0, 0, 0.726, 0)
    profilePicture.BackgroundTransparency = 1
	profilePicture.ImageColor3 = Color3.fromRGB(93, 10, 105)
    profilePicture.Parent = MenuFrame
	spawn(function()
    profilePicture.Image = "http://www.roblox.com/Thumbs/Avatar.ashx?x=150&y=120&userId=" .. player.CharacterAppearanceId
	end)
	UIListLayout_2.Parent = MenuFrameTwo
	UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder

	SettingsFrame.Name = "SettingsFrame"
	SettingsFrame.Parent = Container
	SettingsFrame.Active = true
	SettingsFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
	SettingsFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	SettingsFrame.Position = UDim2.new(0.023746701, 0, 0.0237154141, 0)
	SettingsFrame.Size = UDim2.new(0, 475, 0, 325)
	SettingsFrame.ScrollBarThickness = 0
	SettingsFrame.Visible = false
	SettingsFrame.CanvasSize = UDim2.new(0, 0, 9, 0)

	ButtonFrame_2.Name = "ButtonFrame"
	ButtonFrame_2.Parent = SettingsFrame
	ButtonFrame_2.BackgroundColor3 = Color3.fromRGB(97, 53, 206)
	ButtonFrame_2.BackgroundTransparency = 1.000
	ButtonFrame_2.Size = UDim2.new(1, 0, 0, 50)
	
	UIListLayout_3.Parent = ButtonFrame_2
	UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout_3.Padding = UDim.new(0, 15) 

	Button_3.Name = "Button"
	Button_3.Parent = ButtonFrame_2
	Button_3.BackgroundColor3 = Color3.fromRGB(97, 53, 206)
	Button_3.Position = UDim2.new(0.035911601, 0, 0.244897962, 0)
	Button_3.Size = UDim2.new(0, 435, 0, 27)
	Button_3.Font = Enum.Font.GothamSemibold
	Button_3.Text = "Close HAXTERHUB"
	Button_3.TextColor3 = Color3.fromRGB(255, 255, 255)
	Button_3.TextSize = 14.000
	Button_3.MouseButton1Click:Connect(function()
		Hub:Destroy()
	end)
	UICorner_5.Parent = Button_3

	Button_4.Name = "Button"
	Button_4.Parent = ButtonFrame_2
	Button_4.BackgroundColor3 = Color3.fromRGB(97, 53, 206)
	Button_4.Position = UDim2.new(0.035911601, 0, 0.244897962, 0)
	Button_4.Size = UDim2.new(0, 435, 0, 27)
	Button_4.Font = Enum.Font.GothamSemibold
	Button_4.Text = "My Discord Server"
	Button_4.TextColor3 = Color3.fromRGB(255, 255, 255)
	Button_4.TextSize = 14.000
	Button_4.MouseButton1Click:Connect(function()
		setclipboard("https://discord.gg/EUQHe9Xu")
	end)

	UICorner_6.Parent = Button_4

	HaxterHub.LayoutOrder = 0
	HaxterHub.TextWrapped = false
	HaxterHub.LineHeight = 1
	HaxterHub.Active = false
	HaxterHub.Interactable = true
	HaxterHub.TextStrokeTransparency = 1
	HaxterHub.TextTruncate = Enum.TextTruncate.None
	HaxterHub.SizeConstraint = Enum.SizeConstraint.RelativeXY
	HaxterHub.ZIndex = 1
	HaxterHub.BorderSizePixel = 0
	HaxterHub.RichText = false
	HaxterHub.AutoLocalize = true
	HaxterHub.SelectionOrder = 0
	HaxterHub.TextYAlignment = Enum.TextYAlignment.Center
	HaxterHub.TextScaled = false
	HaxterHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	HaxterHub.FontFace = Font.new("rbxasset://fonts/families/FredokaOne.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	HaxterHub.BorderMode = Enum.BorderMode.Outline
	HaxterHub.TextTransparency = 0
	HaxterHub.OpenTypeFeatures = ""
	HaxterHub.Name = "HaxterHub"
	HaxterHub.AnchorPoint = Vector2.new(0, 0)
	HaxterHub.Archivable = true
	HaxterHub.AutomaticSize = Enum.AutomaticSize.None
	HaxterHub.SelectionBehaviorUp = Enum.SelectionBehavior.Escape
	HaxterHub.SelectionBehaviorDown = Enum.SelectionBehavior.Escape
	HaxterHub.ClipsDescendants = false
	HaxterHub.TextSize = 30
	HaxterHub.Size = UDim2.new(0, 668, 0, 45)
	HaxterHub.SelectionBehaviorLeft = Enum.SelectionBehavior.Escape
	HaxterHub.Visible = true
	HaxterHub.TextColor3 = Color3.fromRGB(97, 53, 206)
	HaxterHub.BorderColor3 = Color3.fromRGB(0, 0, 0)
	HaxterHub.Text = "HaxterHub"
	HaxterHub.TextDirection = Enum.TextDirection.Auto
	HaxterHub.TextStrokeColor3 = Color3.fromRGB(90, 19, 103)
	HaxterHub.Rotation = 0
	HaxterHub.Selectable = false
	HaxterHub.BackgroundTransparency = 1
	HaxterHub.TextXAlignment = Enum.TextXAlignment.Center
	HaxterHub.SelectionBehaviorRight = Enum.SelectionBehavior.Escape
	HaxterHub.MaxVisibleGraphemes = -1
	HaxterHub.SelectionGroup = false
	HaxterHub.Position = UDim2.new(0, 0, 0, 0)



    MainScrollingFrame.Name = "MainScrollingFrame"
    MainScrollingFrame.Size = UDim2.new(0, 475, 0, 325)
    MainScrollingFrame.Parent = Main
    MainScrollingFrame.BackgroundTransparency = 1
	MainScrollingFrame.ScrollBarThickness = 0

	print("made by HaxterFelix")

	



	local vermlibb = {}

	function vermlibb:CreateTab(nameTab, nameThread, author)
		nameTab = nameTab or "Thread"
		nameThread = nameThread or "Thread"
		author = author or Title.Text

		local Tab = Instance.new("ScrollingFrame")
		local UIListLayout = Instance.new("UIListLayout")
		local TabSelectionFrame = Instance.new("Frame")
		local TabName = Instance.new("TextLabel")
		local HubName = Instance.new("TextLabel")
		local SelectTab = Instance.new("TextButton")

		Tab.Name = nameTab
		Tab.Parent = Tabs
		Tab.Active = true
		Tab.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
		Tab.BorderColor3 = Color3.fromRGB(74, 74, 74)
		Tab.Position = UDim2.new(0, 0, 0, 0)
		Tab.Size = UDim2.new(0, 500, 0, 340)
		Tab.ScrollBarThickness = 0
		Tab.BorderSizePixel = 0
		Tab.Visible = false
        Tab.CanvasSize = UDim2.new(0, 0, 0, 0)
		Tab.BackgroundTransparency = 0.9

		UIListLayout.Parent = Tab
		UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout.VerticalAlignment = Enum.VerticalAlignment.Top

		TabSelectionFrame.Name = "TabSelectionFrame"
		TabSelectionFrame.Parent = MenuFrameTwo
		TabSelectionFrame.BackgroundColor3 = Color3.fromRGB(97, 53, 206)
		TabSelectionFrame.BackgroundTransparency = 1.000
		TabSelectionFrame.Size = UDim2.new(1, 0, 0, 24)

		TabName.Name = name
		TabName.Parent = TabSelectionFrame
		TabName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabName.BackgroundTransparency = 1.000
		TabName.Position = UDim2.new(0.035911601, 0, 0.244897962, 0)
		TabName.Size = UDim2.new(0, 105, 0, 18)
		TabName.Font = Enum.Font.SourceSans
		TabName.Text = nameThread
		TabName.TextColor3 = Color3.fromRGB(97, 53, 206)
		TabName.TextSize = 20.000
		TabName.TextXAlignment = Enum.TextXAlignment.Center

		HubName.Name = author
		HubName.Parent = TabSelectionFrame
		HubName.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		HubName.BackgroundTransparency = 1.000
		HubName.Position = UDim2.new(0.035911601, 0, 0.612244904, 0)
		HubName.Size = UDim2.new(0, 339, 0, 10)
		HubName.Font = Enum.Font.SourceSans
		HubName.Text = author
		HubName.TextColor3 = Color3.fromRGB(184, 21, 21)
		HubName.TextSize = 14.000
		HubName.TextXAlignment = Enum.TextXAlignment.Left

		SelectTab.Name = "SelectTab"
		SelectTab.Parent = TabSelectionFrame
		SelectTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		SelectTab.BackgroundTransparency = 1.000
		SelectTab.Position = UDim2.new(0.035911601, 0, 0.244897962, 0)
		SelectTab.Size = UDim2.new(0, 342, 0, 18)
		SelectTab.Font = Enum.Font.SourceSans
		SelectTab.Text = ""
		SelectTab.TextColor3 = Color3.fromRGB(0, 0, 0)
		SelectTab.TextSize = 14.000

		SelectTab.MouseButton1Click:Connect(function()
			SettingsFrame.Visible = false
            Main.Visible = false

			for i,v in pairs(Tabs:GetChildren()) do
				if v.Name ~= nameTab then
					v.Visible = false
				elseif v.Name == nameTab then
					v.Visible = true
				end
			end
		end)

  


	local vermlibbb = {}

	function vermlibbb:CreateButton(name, callback)
		name = name or "Button"
		callback = callback or function() end

		local ButtonFrame = Instance.new("Frame")
		local Container2 = Instance.new("Frame")
		local Button = Instance.new("TextButton")
		local ButtonIcon = Instance.new("ImageLabel")
		local UICorner = Instance.new("UICorner", Container2)
		UICorner.Name = "UICorner"
		UICorner.Archivable = true
		UICorner.CornerRadius = UDim.new(0, 12)
		local UIStroke = Instance.new("UIStroke", Container2)
		UIStroke.Enabled = true
		UIStroke.Color = Color3.fromRGB(97, 53, 206)
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
		UIStroke.Transparency = 0.5
		UIStroke.Name = "UIStroke"
		UIStroke.LineJoinMode = Enum.LineJoinMode.Round
		UIStroke.Archivable = true
		UIStroke.Thickness = 1

		ButtonFrame.Name = "ButtonFrame"
		ButtonFrame.Parent = Tab
		ButtonFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ButtonFrame.BackgroundTransparency = 1.000
		ButtonFrame.Size = UDim2.new(1, 0, 0, 50)

		Container2.Name = "Container"
		Container2.Parent = ButtonFrame
		Container2.BackgroundColor3 = Color3.fromRGB(51, 36, 98)
		Container2.BackgroundTransparency = 0.5
		Container2.Size = UDim2.new(0, 470, 0, 45)
		Container2.Position = UDim2.new(0, 15, 0, 10)

		Button.Name = name
		Button.Parent = Container2
		Button.BackgroundTransparency = 1
		Button.Position = UDim2.new(0, 5, 0, 3)
		Button.Size = UDim2.new(0, 460, 0, 40)
		Button.Font = Enum.Font.GothamSemibold
		Button.TextColor3 = Color3.fromRGB(255, 255, 255)
		Button.TextSize = 14.000
		Button.Text = name
		Button.TextXAlignment = Enum.TextXAlignment.Left

		Button.MouseButton1Click:Connect(callback)

		ButtonIcon.Name = "ButtonIcon"
		ButtonIcon.Parent = Button
		ButtonIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ButtonIcon.BackgroundTransparency = 1.000
		ButtonIcon.Position = UDim2.new(0, 415, 0, 3)
		ButtonIcon.Size = UDim2.new(0, 21, 0, 21)
		spawn(function()
		ButtonIcon.Image = "http://www.roblox.com/asset/?id=12662723759"
		end)
		Tab.CanvasSize = UDim2.new(0, 0, 0, Tab.CanvasSize.Y.Offset + 51)
	end

function vermlibbb:CreateToggle(name, callback)
	name = name or "Toggle"
	callback = callback or function() end

	
	local OuterFrame = Instance.new("Frame")
	OuterFrame.Name = "OuterFrame"
	OuterFrame.Size = UDim2.new(1, 0, 0, 50)
	OuterFrame.BackgroundTransparency = 1
	OuterFrame.Parent = Tab

	
	local Container2 = Instance.new("Frame")
	Container2.Name = "Container"
	Container2.Size = UDim2.new(0, 470, 0, 45)
	Container2.Position = UDim2.new(0, 15, 0, 10)
	Container2.BackgroundColor3 = Color3.fromRGB(51, 36, 98)
	Container2.BackgroundTransparency = 0.5
	Container2.Parent = OuterFrame

	local UICorner = Instance.new("UICorner", Container2)
	UICorner.CornerRadius = UDim.new(0, 12)

	local UIStroke = Instance.new("UIStroke", Container2)
	UIStroke.Color = Color3.fromRGB(97, 53, 206)
	UIStroke.Transparency = 0.5
	UIStroke.Thickness = 1

	
	local ToggleFrame = Instance.new("Frame")
	ToggleFrame.Name = "ToggleFrame"
	ToggleFrame.Size = UDim2.new(0, 80, 0, 30)  
	ToggleFrame.Position = UDim2.new(0, 390, 0, 7)
	ToggleFrame.BackgroundTransparency = 1
	ToggleFrame.Parent = Container2

	local ToggleBG = Instance.new("Frame")
	ToggleBG.Name = "ToggleBG"
	ToggleBG.Parent = ToggleFrame
	ToggleBG.Size = UDim2.new(0, 65, 0, 30)
	ToggleBG.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
	ToggleBG.BackgroundTransparency = 0.3

	local UICornerToggle = Instance.new("UICorner")
	UICornerToggle.CornerRadius = UDim.new(1, 0)
	UICornerToggle.Parent = ToggleBG

	local UIStrokeToggle = Instance.new("UIStroke")
	UIStrokeToggle.Color = Color3.fromRGB(97, 53, 206)
	UIStrokeToggle.Transparency = 0.5
	UIStrokeToggle.Thickness = 1
	UIStrokeToggle.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
	UIStrokeToggle.Parent = ToggleBG

	local ToggleCircle = Instance.new("Frame")
	ToggleCircle.Name = "ToggleCircle"
	ToggleCircle.Parent = ToggleBG
	ToggleCircle.Size = UDim2.new(0, 26, 0, 26)
	ToggleCircle.Position = UDim2.new(0, 2, 0.5, -13)  
	ToggleCircle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)

	local CircleCorner = Instance.new("UICorner")
	CircleCorner.CornerRadius = UDim.new(1, 0)
	CircleCorner.Parent = ToggleCircle

	local ToggleButton = Instance.new("TextButton")
	ToggleButton.Name = "ToggleButton"
	ToggleButton.Parent = ToggleBG
	ToggleButton.Size = UDim2.new(0, 460, 1.29999995, 0)
	ToggleButton.BackgroundTransparency = 1
	ToggleButton.Text = ""
	ToggleButton.Position = UDim2.new(0, -385, 0, -5)  

	local ToggleLabel = Instance.new("TextLabel")
	ToggleLabel.Name = "Label"
	ToggleLabel.Parent = Container2
	ToggleLabel.Size = UDim2.new(0, 300, 0, 30)
	ToggleLabel.Position = UDim2.new(0, 15, 0, 10)
	ToggleLabel.BackgroundTransparency = 1
	ToggleLabel.Font = Enum.Font.Gotham
	ToggleLabel.TextSize = 14
	ToggleLabel.TextColor3 = Color3.fromRGB(160, 160, 160)
	ToggleLabel.TextXAlignment = Enum.TextXAlignment.Left
	ToggleLabel.Text = name

	local tweenService = game:GetService("TweenService")
	local enabled = false

	local function fire()
		enabled = not enabled
		local goal = {}
		if enabled then
			goal.Position = UDim2.new(1, -28, 0.5, -13)  
			ToggleBG.BackgroundColor3 = Color3.fromRGB(51, 36, 98)
		else
			goal.Position = UDim2.new(0, 2, 0.5, -13)    
			ToggleBG.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
		end
		tweenService:Create(ToggleCircle, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), goal):Play()
		pcall(callback, enabled)
	end

	ToggleButton.MouseButton1Click:Connect(fire)

	
	Tab.CanvasSize = UDim2.new(0, 0, 0, Tab.CanvasSize.Y.Offset + 51)
end

function vermlibbb:CreateSlider(name, min, max, initialValue, callback)
	name = name or "Slider"
	min = min or 0
	max = max or 100
	initialValue = initialValue or min
	callback = callback or function() end

	local UIS = game:GetService("UserInputService")
	local TweenService = game:GetService("TweenService")

	local Container2 = Instance.new("Frame")
	local SliderFrame = Instance.new("Frame")
	local SliderButton = Instance.new("TextButton")
	local SliderBack = Instance.new("Frame")
	local UICornerBack = Instance.new("UICorner")
	local UICornerButton = Instance.new("UICorner")
	local SliderPart = Instance.new("Frame")
	local UICornerPart = Instance.new("UICorner")
	local SliderValue = Instance.new("TextLabel")
	local RefreshImage = Instance.new("ImageButton")
	local UICorner = Instance.new("UICorner", Container2)
	UICorner.Name = "UICorner"
	UICorner.Archivable = true
	UICorner.CornerRadius = UDim.new(0, 12)
	local UIStroke = Instance.new("UIStroke", Container2)
	UIStroke.Enabled = true
	UIStroke.Color = Color3.fromRGB(97, 53, 206)
	UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
	UIStroke.Transparency = 0.5
	UIStroke.Name = "UIStroke"
	UIStroke.LineJoinMode = Enum.LineJoinMode.Round
	UIStroke.Archivable = true
	UIStroke.Thickness = 1

	SliderFrame.Name = "SliderFrame"
	SliderFrame.Parent = Tab
	SliderFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SliderFrame.BackgroundTransparency = 1.000
	SliderFrame.Size = UDim2.new(1, 0, 0, 50)

	Container2.Name = "Container"
	Container2.Parent = SliderFrame
	Container2.BackgroundColor3 = Color3.fromRGB(51, 36, 98)
	Container2.BackgroundTransparency = 0.5
	Container2.Size = UDim2.new(0, 470, 0, 45)
	Container2.Position = UDim2.new(0, 15, 0, 10)

	local currentValue = initialValue
	SliderButton.Name = name
	SliderButton.Parent = Container2
	SliderButton.BackgroundColor3 = Color3.fromRGB(97, 53, 206)
	SliderButton.Position = UDim2.new(0, 10, 0, 3)
	SliderButton.Size = UDim2.new(0, 220, 0, 20)
	SliderButton.Font = Enum.Font.GothamSemibold
	SliderButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	SliderButton.TextSize = 16.000
	SliderButton.Text = name
	SliderButton.TextXAlignment = Enum.TextXAlignment.Left
	SliderButton.RichText = true
	SliderButton.BackgroundTransparency = 1

	SliderBack.Name = "SliderBack"
	SliderBack.Parent = Container2
	SliderBack.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
	SliderBack.BorderSizePixel = 0
	SliderBack.Position = UDim2.new(0, 10, 0, 25)
	SliderBack.Size = UDim2.new(0, 450, 0, 15)

	UICornerBack.CornerRadius = UDim.new(0, 8)
	UICornerBack.Parent = SliderBack

	UICornerButton.CornerRadius = UDim.new(0, 8)
	UICornerButton.Parent = SliderButton

	SliderPart.Name = "SliderPart"
	SliderPart.Parent = SliderBack
	SliderPart.BackgroundColor3 = Color3.fromRGB(88, 62, 170)
	SliderPart.BorderSizePixel = 0
	SliderPart.Size = UDim2.new((initialValue - min) / (max - min), 0, 1, 0)
	UICornerPart.CornerRadius = UDim.new(0, 8)
	UICornerPart.Parent = SliderPart

	SliderValue.Name = "SliderValue"
	SliderValue.Parent = Container2
	SliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	SliderValue.BackgroundTransparency = 1.000
	SliderValue.Position = UDim2.new(0, 410, 0, 5)
	SliderValue.Size = UDim2.new(0, 80, 0, 16)
	SliderValue.Font = Enum.Font.Code
	SliderValue.Text = tostring(initialValue)
	SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
	SliderValue.TextSize = 20
	Tab.CanvasSize = UDim2.new(0, 0, 0, Tab.CanvasSize.Y.Offset + 51)

	RefreshImage.Position = UDim2.new(0, 410, 0, 5)
	RefreshImage.Size = UDim2.new(0, 17, 0, 17)
	RefreshImage.Image = "http://www.roblox.com/asset/?id=114684549131119"
	RefreshImage.Parent = Container2
	RefreshImage.BackgroundTransparency = 1

	callback(initialValue)

	
	local function tweenSliderVisualTo(percent)
		local goalSize = UDim2.new(percent, 0, 1, 0)
		local tweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		local tween = TweenService:Create(SliderPart, tweenInfo, { Size = goalSize })
		tween:Play()
	end

	
	local function setSliderValue(value)
		value = math.clamp(value, min, max)
		local percent = (value - min) / (max - min)
		tweenSliderVisualTo(percent)
		SliderValue.Text = tostring(value)
		currentValue = value
		callback(value)
	end

	
	local dragging = false
	local inputObject = nil

	SliderBack.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			inputObject = input
			local position = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
			setSliderValue(math.floor(position * (max - min) + min))
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if dragging then
			if input.UserInputType == Enum.UserInputType.MouseMovement then
				local position = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
				setSliderValue(math.floor(position * (max - min) + min))
			end
			if input.UserInputType == Enum.UserInputType.Touch and input == inputObject then
				local position = math.clamp((input.Position.X - SliderBack.AbsolutePosition.X) / SliderBack.AbsoluteSize.X, 0, 1)
				setSliderValue(math.floor(position * (max - min) + min))
			end
		end
	end)

	UIS.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
			inputObject = nil
		end
	end)

	
	local originalInitialValue = initialValue
	SliderButton.MouseButton1Click:Connect(function()
		setSliderValue(originalInitialValue)
	end)
	RefreshImage.MouseButton1Click:Connect(function()
		setSliderValue(originalInitialValue)
	end)

	local hovering = false
	local scrollingFrame = SliderFrame.Parent
	local scrollingFrame = SliderFrame.Parent

	SliderBack.MouseEnter:Connect(function()
		hovering = true
		isHoveringSlider = true
		if scrollingFrame then
			scrollingFrame.ScrollingEnabled = false
		end
	end)

	SliderBack.MouseLeave:Connect(function()
		hovering = false
		isHoveringSlider = false
		if scrollingFrame then
			scrollingFrame.ScrollingEnabled = true
		end
	end)

	UIS.InputChanged:Connect(function(input)
		if hovering and input.UserInputType == Enum.UserInputType.MouseWheel then
			local delta = input.Position.Z > 0 and 1 or -1
			setSliderValue(currentValue + delta)
		end
	end)

	
	return {
		SetValue = function(v)
			setSliderValue(v)
		end,
		GetValue = function()
			return currentValue
		end,
		Frame = SliderFrame
	}
end
		
	function vermlibbb:CreateBox(name, numberorstring, callback)
		name = name or "Box"
		callback = callback or function() end
		numberorstring = numberorstring or nil
			
		local BoxFrame = Instance.new("Frame")
		local Container2 = Instance.new("Frame")
		local Button_2 = Instance.new("TextButton")
		local UICorner_3 = Instance.new("UICorner")
		local ButtonIcon_2 = Instance.new("ImageLabel")
		local Box = Instance.new("TextBox")
		local UICorner_4 = Instance.new("UICorner")
		local UICorner44 = Instance.new("UICorner", Container2)
		UICorner44.Name = "UICorner"
		UICorner44.Archivable = true
		UICorner44.CornerRadius = UDim.new(0, 12)
		local UIStroke = Instance.new("UIStroke", Container2)
		UIStroke.Enabled = true
		UIStroke.Color = Color3.fromRGB(97, 53, 206)
		UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual
		UIStroke.Transparency = 0.5
		UIStroke.Name = "UIStroke"
		UIStroke.LineJoinMode = Enum.LineJoinMode.Round
		UIStroke.Archivable = true
		UIStroke.Thickness = 1

		BoxFrame.Name = "BoxFrame"
		BoxFrame.Parent = Tab
		BoxFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		BoxFrame.BackgroundTransparency = 1.000
		BoxFrame.Size = UDim2.new(1, 0, 0, 50)

		Container2.Name = "Container"
		Container2.Parent = BoxFrame
		Container2.BackgroundColor3 = Color3.fromRGB(51, 36, 98)
		Container2.BackgroundTransparency = 0.5
		Container2.Size = UDim2.new(0, 470, 0, 45)
		Container2.Position = UDim2.new(0, 15, 0, 10)

		Button_2.Name = name
		Button_2.Parent = Container2
		Button_2.BackgroundColor3 = Color3.fromRGB(88, 62, 170)
		Button_2.Position = UDim2.new(0.035911601, 0, 0.244897962, 0)
		Button_2.Size = UDim2.new(0, 220, 0, 27)
		Button_2.Font = Enum.Font.GothamSemibold
		Button_2.TextColor3 = Color3.fromRGB(255, 255, 255)
		Button_2.TextSize = 16.000
		Button_2.Text = name
			
		Button_2.MouseButton1Click:Connect(function()
			if numberorstring == "number" then
				callback(tonumber(Box.Text))
			elseif numberorstring == "string" then
				callback(tostring(Box.Text))
			elseif numberorstring == nil then
				callback(Box.Text)
			end
		end)
			
		UICorner_3.Parent = Button_2
			
		ButtonIcon_2.Name = "ButtonIcon"
		ButtonIcon_2.Parent = Button_2
		ButtonIcon_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ButtonIcon_2.BackgroundTransparency = 1.000
		ButtonIcon_2.Position = UDim2.new(0.017699115, 0, 0.111111112, 0)
		ButtonIcon_2.Size = UDim2.new(0, 21, 0, 21)
		spawn(function()
		ButtonIcon_2.Image = "http://www.roblox.com/asset/?id=10414217689"
		end)
		Box.Name = "Box"
		Box.Parent = Container2
		Box.BackgroundColor3 = Color3.fromRGB(44, 44, 44)
		Box.Position = UDim2.new(0.522099435, 0, 0.265306115, 0)
		Box.Size = UDim2.new(0, 202, 0, 26)
		Box.Font = Enum.Font.Gotham
		Box.Text = ""
		Box.TextColor3 = Color3.fromRGB(88, 62, 170)
		Box.TextSize = 14.000
		Box.TextScaled = true
		Box.PlaceholderText = "..."
			
			
			
		UICorner_4.Parent = Box
		Tab.CanvasSize = UDim2.new(0, 0, 0, Tab.CanvasSize.Y.Offset + 51)

	end
		function vermlibbb:CreateDropdown2(name, list, callback)
			name = name or "Dropdown"
			list = list or {}
			callback = callback or function() end
		
			local DropdownFrame = Instance.new("Frame")
			local DropdownOption = Instance.new("TextLabel")
			local ToggleDropdown = Instance.new("TextButton")
			local ScrollingFrame = Instance.new("ScrollingFrame")
			local Container2 = Instance.new("Frame")
			local Container3 = Instance.new("Frame")
			local DropdownContainer = Instance.new("ScrollingFrame")
			local UIGridLayout = Instance.new("UIGridLayout")
			local SearchBar = Instance.new("TextBox")
			local UICorner = Instance.new("UICorner", Container2)
			local UIStroke = Instance.new("UIStroke", Container2)
			local UICorner2 = Instance.new("UICorner", Container3)
			local UIStroke2 = Instance.new("UIStroke", Container3)
    		UICorner2.CornerRadius = UDim.new(0, 12)
    		UIStroke2.Color = Color3.fromRGB(97, 53, 206)
   			UIStroke2.Transparency = 0.5
    		UIStroke2.Thickness = 1

    		UICorner.CornerRadius = UDim.new(0, 12)
    		UIStroke.Color = Color3.fromRGB(97, 53, 206)
   			UIStroke.Transparency = 0.5
    		UIStroke.Thickness = 1

			DropdownFrame.Name = "DropdownFrame"
			DropdownFrame.Parent = Tab
			DropdownFrame.BackgroundTransparency = 1
			DropdownFrame.Size = UDim2.new(1, 0, 0, 50)
			
    		Container2.Name = "Container"
    		Container2.Parent = DropdownFrame
    		Container2.BackgroundColor3 = Color3.fromRGB(51, 36, 98)
    		Container2.BackgroundTransparency = 0.5
    		Container2.Size = UDim2.new(0, 470, 0, 45)
    		Container2.Position = UDim2.new(0, 15, 0, 10)

    		Container3.Name = "Container"
    		Container3.Parent = ScrollingFrame
    		Container3.BackgroundColor3 = Color3.fromRGB(51, 36, 98)
    		Container3.BackgroundTransparency = 0.5
    		Container3.Size = UDim2.new(0, 470, 0, 250)
    		Container3.Position = UDim2.new(0, 15, 0, 10)

			DropdownOption.Name = "DropdownOption"
			DropdownOption.Parent = Container2
			DropdownOption.BackgroundTransparency = 1
			DropdownOption.Position = UDim2.new(0, 15, 0, 10)
			DropdownOption.Size = UDim2.new(0, 127, 0, 27)
			DropdownOption.Font = Enum.Font.GothamBold
			DropdownOption.Text = name
			DropdownOption.TextColor3 = Color3.fromRGB(255, 255, 255)
			DropdownOption.TextSize = 14
			DropdownOption.TextXAlignment = Enum.TextXAlignment.Left

			local OptionsCount = Instance.new("TextLabel")
			OptionsCount.Name = "OptionsCount"
			OptionsCount.Parent = Container2
			OptionsCount.BackgroundTransparency = 1
			OptionsCount.Position = UDim2.new(0, 210, 0, 10)
			OptionsCount.Size = UDim2.new(0, 80, 0, 27)
			OptionsCount.Font = Enum.Font.GothamBold
			OptionsCount.Text = "0"
			OptionsCount.TextColor3 = Color3.fromRGB(97, 53, 206)
			OptionsCount.TextSize = 14
			OptionsCount.TextXAlignment = Enum.TextXAlignment.Left
			OptionsCount.TextScaled = true
		
			SearchBar.Name = "SearchBar"
			SearchBar.Parent = Container2
			SearchBar.Position = UDim2.new(0.800000012, -80, 0, 10)
			SearchBar.Size = UDim2.new(0, 200, 0, 30)
			SearchBar.PlaceholderText = "Search..."
			SearchBar.Font = Enum.Font.Gotham
			SearchBar.TextColor3 = Color3.fromRGB(153, 75, 252)
			SearchBar.TextSize = 17
			SearchBar.BackgroundTransparency = 1
			SearchBar.Text = ""
			SearchBar.TextWrapped = true
		
			ToggleDropdown.Name = "ToggleDropdown"
			ToggleDropdown.Parent = Container2
			ToggleDropdown.BackgroundTransparency = 1
			ToggleDropdown.Position = UDim2.new(0.911, 10, 0.387, -2)
			ToggleDropdown.Size = UDim2.new(0, 20, 0, 20)
			ToggleDropdown.Font = Enum.Font.SourceSans
			ToggleDropdown.Text = "V"
			ToggleDropdown.Rotation = 90
			ToggleDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
			ToggleDropdown.TextSize = 14
		
			ScrollingFrame.Name = "ScrollingFrame"
			ScrollingFrame.Parent = Tab
			ScrollingFrame.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
			ScrollingFrame.BorderSizePixel = 0
			ScrollingFrame.Position = UDim2.new(0.0359, 0, 0, 0)
			ScrollingFrame.Size = UDim2.new(1, 0, 0, 260)
			ScrollingFrame.Visible = false
			ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
			ScrollingFrame.ScrollBarThickness = 0
			ScrollingFrame.ClipsDescendants = true
			ScrollingFrame.Transparency = 1
			ScrollingFrame.ScrollingEnabled = false
		
			DropdownContainer.Name = "DropdownContainer"
			DropdownContainer.Parent = Container3
			DropdownContainer.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
			DropdownContainer.BorderSizePixel = 0
			DropdownContainer.Size = UDim2.new(1, 0, 0, 0)
			DropdownContainer.Transparency = 1
		
			UIGridLayout.Parent = DropdownContainer
			UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
			UIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
			UIGridLayout.CellSize = UDim2.new(0, 400, 0, 50)
			UIGridLayout.CellPadding = UDim2.new(0, 50, 0, 0)
			Tab.CanvasSize = UDim2.new(0, 0, 0, Tab.CanvasSize.Y.Offset + 51)

			local function updateDropdownOptions()
				local searchText = SearchBar.Text:lower()
				local visibleOptionCount = 0
			
				for _, option in ipairs(DropdownContainer:GetChildren()) do
					if option:IsA("TextButton") then
						if option.Text:lower():find(searchText) then
							option.Visible = true
							visibleOptionCount = visibleOptionCount + 1
						else
							option.Visible = false
						end
					end
				end
			
				local newHeight = visibleOptionCount * 50
				DropdownContainer.Size = UDim2.new(1, 0, 0, newHeight)
				ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, newHeight)
			
				OptionsCount.Text = tostring(visibleOptionCount)
			end
		
			SearchBar:GetPropertyChangedSignal("Text"):Connect(updateDropdownOptions)
		
			local function buildOption(text)
				local Option = Instance.new("TextButton")
				Option.Name = text
				Option.Parent = DropdownContainer
				Option.BackgroundTransparency = 1
				Option.Size = UDim2.new(0, 200, 0, 50)
				Option.Font = Enum.Font.Gotham
				Option.Text = text
				Option.TextColor3 = Color3.fromRGB(255, 255, 255)
				Option.TextSize = 14
				Option.TextScaled = true
		
				Option.MouseButton1Click:Connect(function()
					DropdownOption.Text = name .. ": " .. text
					callback(text)
					ScrollingFrame.Visible = false
					ToggleDropdown.Rotation = 90
				end)
			end
		
			for _, v in ipairs(list) do
				buildOption(v)
			end
		
    		ToggleDropdown.MouseButton1Click:Connect(function()
    		    ScrollingFrame.Visible = not ScrollingFrame.Visible
    		    ToggleDropdown.Rotation = ScrollingFrame.Visible and 0 or 90
    		    if ScrollingFrame.Visible then
    		        Tab.CanvasSize = UDim2.new(0, 0, 0, Tab.CanvasSize.Y.Offset + 305)
    		    else
    		        Tab.CanvasSize = UDim2.new(0, 0, 0, Tab.CanvasSize.Y.Offset - 305)
    		    end
    		end)

			local object = {}
		
			function object:Refresh(newList)
				newList = newList or {}
		
				for _, child in pairs(DropdownContainer:GetChildren()) do
					if child:IsA("TextButton") then
						child:Destroy()
					end
				end
		
				for _, v in ipairs(newList) do
					buildOption(v)
				end
		
				updateDropdownOptions()
			end
		
			return object
		end

	keybindToggleStates = {}
	
	local dropdownSyncGroups = {}
	local dropdownInstances = {}

function vermlibbb:CreateDropdown(name, list, callback, LinkedDropdowns)
    name = name or "Dropdown"
    list = list or {}
    callback = callback or function() end
    LinkedDropdowns = LinkedDropdowns or {}

    local HttpService = game:GetService("HttpService")
    local UIS = game:GetService("UserInputService")
    local folderPath = "HaxterFelix"
    local favoritesPath = folderPath .. "/Favorites.txt"
    local keybindsPath = folderPath .. "/Keybinds.txt"

    if not isfolder(folderPath) then makefolder(folderPath) end

    local function readJsonFile(path)
        if isfile(path) then
            return HttpService:JSONDecode(readfile(path))
        else
            writefile(path, HttpService:JSONEncode({}))
            return {}
        end
    end

    local favorites = readJsonFile(favoritesPath)
    local keybinds = readJsonFile(keybindsPath)

    local function saveFavorites() writefile(favoritesPath, HttpService:JSONEncode(favorites)) end
    local function saveKeybinds() writefile(keybindsPath, HttpService:JSONEncode(keybinds)) end
    local function isFavorite(label) return table.find(favorites, label) ~= nil end

	local options = {}
	for k, v in pairs(list) do
	    table.insert(options, type(k) == "string" and { Label = k, Value = v } or { Label = v, Value = v })
	end
	
	
	table.sort(options, function(a, b)
	    local aFav = isFavorite(a.Label)
	    local bFav = isFavorite(b.Label)
	    if aFav and not bFav then
	        return true
	    elseif not aFav and bFav then
	        return false
	    else
	        return a.Label:lower() < b.Label:lower()
	    end
	end)


    local DropdownFrame = Instance.new("Frame")
    local Container2 = Instance.new("Frame")
    local DropdownOption = Instance.new("TextLabel")
    local ToggleDropdown = Instance.new("TextButton")
    local ScrollingFrame = Instance.new("Frame")
    local DropdownContainer = Instance.new("Frame")
    local UIGridLayout = Instance.new("UIGridLayout")
    local SearchBar = Instance.new("TextBox")
    local SearchIcon = Instance.new("ImageLabel")
    local OptionsCount = Instance.new("TextLabel")
    local UICorner = Instance.new("UICorner", Container2)
    local UIStroke = Instance.new("UIStroke", Container2)
    local DropdownUICorner = Instance.new("UICorner")
    local DropdownUIStroke = Instance.new("UIStroke")

    local PrevButton = Instance.new("TextButton")
    local NextButton = Instance.new("TextButton")
    local currentPage = 1
    local visibleOptions = 6
    local filteredOptions = {}

    UICorner.CornerRadius = UDim.new(0, 12)
    UIStroke.Color = Color3.fromRGB(97, 53, 206)
    UIStroke.Transparency = 0.5
    UIStroke.Thickness = 1

    DropdownFrame.Name = "DropdownFrame"
    DropdownFrame.Parent = Tab
    DropdownFrame.BackgroundTransparency = 1
    DropdownFrame.Size = UDim2.new(1, 0, 0, 50)

    Container2.Name = "Container"
    Container2.Parent = DropdownFrame
    Container2.BackgroundColor3 = Color3.fromRGB(51, 36, 98)
    Container2.BackgroundTransparency = 0.5
    Container2.Size = UDim2.new(0, 470, 0, 45)
    Container2.Position = UDim2.new(0, 15, 0, 10)

    DropdownOption.Parent = Container2
    DropdownOption.BackgroundTransparency = 1
    DropdownOption.Position = UDim2.new(0.01, 0, 0.245, 0)
    DropdownOption.Size = UDim2.new(0, 127, 0, 27)
    DropdownOption.Font = Enum.Font.GothamBold
    DropdownOption.Text = name
    DropdownOption.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropdownOption.TextScaled = true
    DropdownOption.TextXAlignment = Enum.TextXAlignment.Left

    SearchBar.Parent = Container2
    SearchBar.Position = UDim2.new(1, -137, 0.15, 0)
    SearchBar.Size = UDim2.new(0, 100, 0, 30)
    SearchBar.PlaceholderText = "Search..."
    SearchBar.Font = Enum.Font.Gotham
    SearchBar.TextColor3 = Color3.fromRGB(153, 75, 252)
    SearchBar.TextSize = 20
    SearchBar.Text = ""
    SearchBar.BackgroundTransparency = 1
    SearchBar.ClearTextOnFocus = true

    SearchIcon.Name = "SearchIcon"
    SearchIcon.Parent = Container2
    SearchIcon.Size = UDim2.new(0, 24, 0, 24)
    SearchIcon.Position = UDim2.new(1, -155, 0.21, 0)
    SearchIcon.BackgroundTransparency = 1
	spawn(function()
    SearchIcon.Image = "rbxassetid://18438147776"
	end)
	local selectedButton = nil
	local highlightColor = Color3.fromRGB(51, 36, 98)
	local defaultColor = Color3.fromRGB(60, 60, 60)


    OptionsCount.Parent = ScrollingFrame
    OptionsCount.BackgroundTransparency = 1
    OptionsCount.Position = UDim2.new(0, 155, 0, 10)
    OptionsCount.Size = UDim2.new(0, 200, 0, 40)
    OptionsCount.Font = Enum.Font.GothamBold
    OptionsCount.TextColor3 = Color3.fromRGB(97, 53, 206)
    OptionsCount.Text = "Results: 1/1"
    OptionsCount.TextScaled = true
    OptionsCount.TextXAlignment = Enum.TextXAlignment.Left

    ToggleDropdown.Parent = Container2
    ToggleDropdown.Position = UDim2.new(1, -30, 0.33, 0)
    ToggleDropdown.Size = UDim2.new(0, 17, 0, 12)
    ToggleDropdown.Font = Enum.Font.SourceSans
    ToggleDropdown.Text = "V"
    ToggleDropdown.Rotation = 90
    ToggleDropdown.BackgroundTransparency = 1
    ToggleDropdown.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleDropdown.TextSize = 14

    ScrollingFrame.Parent = Tab
    ScrollingFrame.BackgroundColor3 = Color3.fromRGB(42, 42, 42)
    ScrollingFrame.Position = UDim2.new(0.5, -225, 0, 55)
    ScrollingFrame.Size = UDim2.new(0, 500, 0, 305)
    ScrollingFrame.Visible = false
    ScrollingFrame.Transparency = 1

    DropdownUICorner.CornerRadius = UDim.new(0, 12)
    DropdownUICorner.Parent = DropdownContainer
    DropdownUIStroke.Color = Color3.fromRGB(97, 53, 206)
    DropdownUIStroke.Transparency = 0.5
    DropdownUIStroke.Thickness = 1
    DropdownUIStroke.Parent = DropdownContainer

    DropdownContainer.Parent = ScrollingFrame
    DropdownContainer.BackgroundColor3 = Color3.fromRGB(51, 36, 98)
    DropdownContainer.Size = UDim2.new(0, 470, 0, 300)
    DropdownContainer.Position = UDim2.new(0, 15, 0, 10)
    DropdownContainer.Transparency = 0.5

    UIGridLayout.Parent = DropdownContainer
    UIGridLayout.CellSize = UDim2.new(0, 450, 0, 38)
    UIGridLayout.CellPadding = UDim2.new(0, 0, 0, 5)
    UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIGridLayout.VerticalAlignment = Enum.VerticalAlignment.Bottom
    Tab.CanvasSize = UDim2.new(0, 0, 0, Tab.CanvasSize.Y.Offset + 51)

	local dropdownInstance = {
        name = name,
        DropdownOption = DropdownOption,
        selectedButton = nil,
        LinkedDropdowns = LinkedDropdowns,
        resetToNone = function()
            if dropdownInstance.selectedButton then
                dropdownInstance.selectedButton.BackgroundColor3 = defaultColor
                dropdownInstance.selectedButton = nil
            end
            DropdownOption.Text = name .. ": (none)"
            callback(nil)
        end
    }
    
    dropdownInstances[name] = dropdownInstance
    
	if #LinkedDropdowns > 0 then
        local syncGroupKey = table.concat(LinkedDropdowns, "_") .. "_" .. name
        if not dropdownSyncGroups[syncGroupKey] then
            dropdownSyncGroups[syncGroupKey] = {}
        end
        table.insert(dropdownSyncGroups[syncGroupKey], name)
        
        for _, linkedName in ipairs(LinkedDropdowns) do
            if not table.find(dropdownSyncGroups[syncGroupKey], linkedName) then
                table.insert(dropdownSyncGroups[syncGroupKey], linkedName)
            end
        end
    end

    PrevButton.Text = "<"
    local UICornerPrev = Instance.new("UICorner", PrevButton)
    PrevButton.TextSize = 20

    NextButton.Text = ">"
    local UICornerNext = Instance.new("UICorner", NextButton)
    NextButton.TextSize = 20

    for _, btn in ipairs({ PrevButton, NextButton }) do
        btn.Parent = ScrollingFrame
        btn.Size = UDim2.new(0, 40, 0, 30)
        btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
        btn.TextColor3 = Color3.new(1, 1, 1)
    end

    PrevButton.Position = UDim2.new(0, 30, 0, 15)
    NextButton.Position = UDim2.new(0, 430, 0, 15)
    
    local function syncLinkedDropdowns(currentDropdownName)
        for syncGroupKey, dropdownNames in pairs(dropdownSyncGroups) do
            if table.find(dropdownNames, currentDropdownName) then
                for _, dropdownName in ipairs(dropdownNames) do
                    if dropdownName ~= currentDropdownName and dropdownInstances[dropdownName] then
                        dropdownInstances[dropdownName].resetToNone()
                    end
                end
                break
            end
        end
    end
    
	local buildOption


	local function displayPage(page)
	    for _, child in ipairs(DropdownContainer:GetChildren()) do
	        if child:IsA("Frame") then child:Destroy() end
	    end
	    local totalPages = math.max(1, math.ceil(#filteredOptions / visibleOptions))
	    currentPage = math.clamp(page, 1, totalPages)
	    local startIdx = (currentPage - 1) * visibleOptions + 1
	    local endIdx = math.min(currentPage * visibleOptions, #filteredOptions)
	    for i = startIdx, endIdx do
	        buildOption(filteredOptions[i])
	    end
	    OptionsCount.Text = "Results: " .. currentPage .. "/" .. totalPages
	end


	local function refreshDropdown()
	
	    table.sort(options, function(a, b)
	        local aFav = isFavorite(a.Label)
	        local bFav = isFavorite(b.Label)
	        if aFav ~= bFav then return aFav end
		
	        local aBind = keybinds[a.Label] ~= nil
	        local bBind = keybinds[b.Label] ~= nil
	        if aBind ~= bBind then return aBind end
		
	        return a.Label:lower() < b.Label:lower()
	    end)
	
	    local query = SearchBar.Text:lower()
	    filteredOptions = {}
	    for _, o in ipairs(options) do
	        if o.Label:lower():find(query) then
	            table.insert(filteredOptions, o)
	        end
	    end
	
	
	    local optionCount = math.min(#filteredOptions, visibleOptions)
	    local containerHeight = 90 + ((optionCount - 1) * 40.8)
	    local parentHeight = containerHeight + 5.3
	
	    DropdownContainer.Size = UDim2.new(0, 470, 0, containerHeight)
	    ScrollingFrame.Size = UDim2.new(0, 500, 0, parentHeight)
	
	    currentPage = 1
	    displayPage(currentPage)
	end


	buildOption = function(opt)

        local FrameMain = Instance.new("Frame")
        FrameMain.Parent = DropdownContainer
        FrameMain.Transparency = 1
        local Option = Instance.new("TextButton")
        Option.Name = opt.Label
        Option.Parent = FrameMain
        Option.BackgroundTransparency = 0.3
        Option.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
        Option.Size = UDim2.new(0, 380, 0, 40)
        Option.Font = Enum.Font.Gotham
        Option.Text = "  " .. opt.Label
        Option.TextColor3 = Color3.new(1, 1, 1)
        Option.TextScaled = true
        Option.TextXAlignment = Enum.TextXAlignment.Left
        Option.Transparency = 0.4
        local UICornerOption = Instance.new("UICorner", Option)
        UICornerOption.CornerRadius = UDim.new(0, 12)

        local FavButton = Instance.new("TextButton")
        FavButton.Parent = Option
        FavButton.Size = UDim2.new(0, 36, 1, 0)
        FavButton.Text = isFavorite(opt.Label) and "💜" or "🤍"
        FavButton.Font = Enum.Font.Gotham
        FavButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        FavButton.BackgroundTransparency = 1
        FavButton.Position = UDim2.new(0, 381, 0, 0)
        FavButton.TextSize = 20
        FavButton.MouseButton1Click:Connect(function()
            if isFavorite(opt.Label) then
                table.remove(favorites, table.find(favorites, opt.Label))
                FavButton.Text = "🤍"
            else
                table.insert(favorites, opt.Label)
                FavButton.Text = "💜"
            end
		saveFavorites()
		refreshDropdown()
        end)

		local BindButton = Instance.new("TextButton")
        BindButton.Parent = Option
        BindButton.Size = UDim2.new(0, 50, 1, 0)  
        BindButton.Text = keybinds[opt.Label] or "⌨"
        BindButton.Font = Enum.Font.Gotham
        BindButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        BindButton.BackgroundTransparency = 1
        BindButton.Position = UDim2.new(0, 410, 0, 0)
        BindButton.TextSize = 20
        BindButton.TextWrapped = true  
		BindButton.TextScaled = true

		local awaitingBind = false
		local bindConnection, cancelConnection, overlayGui

		BindButton.MouseButton1Click:Connect(function()
		    if awaitingBind then return end
		    awaitingBind = true
		    BindButton.Text = "..."
		
		    
		    overlayGui = Instance.new("ScreenGui")
		    overlayGui.IgnoreGuiInset = true
		    overlayGui.ResetOnSpawn = false
		    overlayGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
		    pcall(function() overlayGui.Parent = gethui() end)
		
		    local cancelFrame = Instance.new("Frame")
		    cancelFrame.BackgroundTransparency = 1
		    cancelFrame.Size = UDim2.new(1, 0, 1, 0)
		    cancelFrame.Position = UDim2.new(0, 0, 0, 0)
		    cancelFrame.Name = "KeybindCancelFrame"
		    cancelFrame.ZIndex = 999
		    cancelFrame.Parent = overlayGui

		cancelConnection = UIS.InputBegan:Connect(function(input, gpe)
		    if gpe then return end
		
		    
		    if input.UserInputType == Enum.UserInputType.MouseButton1 then
		        awaitingBind = false
			
		        
		        if keybinds[opt.Label] then
		            keybinds[opt.Label] = nil
		            BindButton.Text = "⌨"
		            saveKeybinds()
		        else
		            
		            BindButton.Text = "⌨"
		        end
			
		        
		        if cancelConnection then cancelConnection:Disconnect() end
		        if bindConnection then bindConnection:Disconnect() end
		        if overlayGui then overlayGui:Destroy() end
		        return
		    end
		
		    
		    if input.UserInputType == Enum.UserInputType.Keyboard then
		        local newKey = input.KeyCode.Name
			
		        
		        for label, boundKey in pairs(keybinds) do
		            if boundKey == newKey then
		                keybinds[label] = nil
		                break
		            end
		        end
			
		        keybinds[opt.Label] = newKey
		        BindButton.Text = newKey
		        saveKeybinds()
		        refreshDropdown()
		        awaitingBind = false
			
		        
		        if cancelConnection then cancelConnection:Disconnect() end
		        if bindConnection then bindConnection:Disconnect() end
		        if overlayGui then overlayGui:Destroy() end
		    end
		end)

		end)

	Option.MouseButton1Click:Connect(function()
	    if selectedButton == Option then
	        Option.BackgroundColor3 = defaultColor
	        selectedButton = nil
	        dropdownInstance.selectedButton = nil
	        DropdownOption.Text = name .. ": (none)"
	        callback(nil)
		
	        for key in pairs(keybindToggleStates) do
	            keybindToggleStates[key] = false
	        end
	    else
	        syncLinkedDropdowns(name)
	        
	        DropdownOption.Text = name .. ": " .. opt.Label
	        callback(opt.Value)
		
	        if selectedButton then
	            selectedButton.BackgroundColor3 = defaultColor
	        end
		
	        for key in pairs(keybindToggleStates) do
	            keybindToggleStates[key] = false
	        end
		
			Option.BackgroundColor3 = highlightColor
	        selectedButton = Option
	        dropdownInstance.selectedButton = Option
	    end
	end)

    end

    local function displayPage(page)
        for _, child in ipairs(DropdownContainer:GetChildren()) do
            if child:IsA("Frame") then child:Destroy() end
        end
        local totalPages = math.max(1, math.ceil(#filteredOptions / visibleOptions))
        currentPage = math.clamp(page, 1, totalPages)
        local startIdx = (currentPage - 1) * visibleOptions + 1
        local endIdx = math.min(currentPage * visibleOptions, #filteredOptions)
        for i = startIdx, endIdx do
            buildOption(filteredOptions[i])
        end
        OptionsCount.Text = "Results: " .. currentPage .. "/" .. totalPages
    end

    SearchBar:GetPropertyChangedSignal("Text"):Connect(refreshDropdown)
	
    PrevButton.MouseButton1Click:Connect(function()
        if currentPage > 1 then
            currentPage -= 1
            displayPage(currentPage)
        end
    end)

    NextButton.MouseButton1Click:Connect(function()
        if currentPage < math.ceil(#filteredOptions / visibleOptions) then
            currentPage += 1
            displayPage(currentPage)
        end
    end)
	
    ToggleDropdown.MouseButton1Click:Connect(function()
        ScrollingFrame.Visible = not ScrollingFrame.Visible
        ToggleDropdown.Rotation = ScrollingFrame.Visible and 0 or 90
		        if ScrollingFrame.Visible then
            Tab.CanvasSize = UDim2.new(0, 0, 0, Tab.CanvasSize.Y.Offset + 305)
        else
            Tab.CanvasSize = UDim2.new(0, 0, 0, Tab.CanvasSize.Y.Offset - 305)
        end
        refreshDropdown()
    end)

UIS.InputBegan:Connect(function(input, gpe)
    if gpe or input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    local pressedKey = input.KeyCode.Name

    local matchedLabel = nil
    for label, key in pairs(keybinds) do
        if key == pressedKey then
			for _, opt in ipairs(options) do
                if opt.Label == label then
                    matchedLabel = label
                    break
                end
            end
        end
    end

    if not matchedLabel then return end

    local wasToggled = keybindToggleStates[matchedLabel] or false

    for _, opt in ipairs(options) do
        keybindToggleStates[opt.Label] = false
    end

    local optionButton = nil
    for _, frame in ipairs(DropdownContainer:GetChildren()) do
        if frame:IsA("Frame") then
            local btn = frame:FindFirstChild(matchedLabel)
            if btn and btn:IsA("TextButton") then
                optionButton = btn
                break
            end
        end
    end

    if not wasToggled then
        keybindToggleStates[matchedLabel] = true

        if selectedButton and selectedButton ~= optionButton then
            selectedButton.BackgroundColor3 = defaultColor
        end

        DropdownOption.Text = name .. ": " .. matchedLabel
        for _, opt in ipairs(options) do
            if opt.Label == matchedLabel then
                callback(opt.Value)
                break
            end
        end

        if optionButton then
            optionButton.BackgroundColor3 = highlightColor
            selectedButton = optionButton
        end
    else
        DropdownOption.Text = name .. ": (none)"
        callback(nil)

        if optionButton then
            optionButton.BackgroundColor3 = defaultColor
            if selectedButton == optionButton then
                selectedButton = nil
            end
        end
    end
end)

    refreshDropdown()

	local vermlibbbb = {}

			function vermlibbbb:Refresh(list2)
				list2 = list2 or {}
			
				
				for _, child in pairs(DropdownContainer:GetChildren()) do
					if child:IsA("TextButton") then
						child:Destroy()
					end
				end
			
				
				options = {}
				for k, v in pairs(list2) do
					table.insert(options, type(k) == "string" and { Label = k, Value = v } or { Label = v, Value = v })
				end
			
				
				refreshDropdown()
			end
					

	return vermlibbbb

		end

		return vermlibbb

	end

	return vermlibb
end
return vermLib
