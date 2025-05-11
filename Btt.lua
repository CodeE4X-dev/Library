local Library = {}

--// Service
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local MarketplaceService = game:GetService("MarketplaceService")
local CoreGui = game:GetService("CoreGui")
local HttpService = game:GetService("HttpService")

--// Variables
local NameID = LocalPlayer.Name
local GameName = MarketplaceService:GetProductInfo(game.PlaceId).Name

--// Utility Functions
local utility = {}

function utility:Tween(instance, properties, duration, ...)
    TweenService:Create(instance, TweenInfo.new(duration, ...), properties):Play()
end

--// Config
local SettingToggle = {}
local Name = "BTConfig.JSON"

pcall(function()
    if not pcall(function() readfile(Name) end) then
        writefile(Name, HttpService:JSONEncode(SettingToggle))
    end
    
    SettingToggle = HttpService:JSONDecode(readfile(Name))
end)

--// Generate a random name for the ScreenGui
local LibName = tostring(math.random(1, 100))..tostring(math.random(1,50))..tostring(math.random(1, 100))

--// Toggle UI Function
function Library:ToggleUI()
    if CoreGui:FindFirstChild(LibName) then
        CoreGui[LibName].Enabled = not CoreGui[LibName].Enabled
    end
end

--// Destroy GUI Function
function Library:DestroyGui()
    if CoreGui:FindFirstChild(LibName) then
        CoreGui[LibName]:Destroy()
    end
end

--// Create Window Function
function Library:CreateWindow(hubname)
    -- Clean up any existing GUI with the same name
    for _, v in pairs(CoreGui:GetChildren()) do
        if v:IsA("ScreenGui") and v.Name == hubname then
            v:Destroy()
        end
    end

    -- Create ScreenGui
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = LibName
    ScreenGui.Parent = CoreGui
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global
    ScreenGui.ResetOnSpawn = false

    -- Setup hotkey to toggle UI
    UserInputService.InputBegan:Connect(function(input) 
        if input.KeyCode == Enum.KeyCode.LeftControl then
            Library:ToggleUI()
        end
    end)

    -- Create Main Body
    local Body = Instance.new("Frame")
    Body.Name = "Body"
    Body.Parent = ScreenGui
    Body.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    Body.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Body.BorderSizePixel = 0
    Body.Position = UDim2.new(0.258427024, 0, 0.217948765, 0)
    Body.Size = UDim2.new(0, 600, 0, 350)
    Body.ClipsDescendants = true

    local Body_Corner = Instance.new("UICorner")
    Body_Corner.CornerRadius = UDim.new(0, 5)
    Body_Corner.Name = "Body_Corner"
    Body_Corner.Parent = Body

    -- Title
    local Title_Hub = Instance.new("TextLabel")
    Title_Hub.Name = "Title_Hub"
    Title_Hub.Parent = Body
    Title_Hub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Title_Hub.BackgroundTransparency = 1.000
    Title_Hub.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Title_Hub.BorderSizePixel = 0
    Title_Hub.Position = UDim2.new(0, 5, 0, 0)
    Title_Hub.Size = UDim2.new(0, 558, 0, 30)
    Title_Hub.Font = Enum.Font.SourceSansBold
    Title_Hub.Text = hubname .. " - " .. GameName
    Title_Hub.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title_Hub.TextSize = 15.000
    Title_Hub.TextXAlignment = Enum.TextXAlignment.Left

    -- Minimize Button
    local MInimize_Button = Instance.new("TextButton")
    MInimize_Button.Name = "MInimize_Button"
    MInimize_Button.Parent = Body
    MInimize_Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    MInimize_Button.BackgroundTransparency = 1.000
    MInimize_Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
    MInimize_Button.BorderSizePixel = 0
    MInimize_Button.Position = UDim2.new(0, 570, 0, 0)
    MInimize_Button.Rotation = -315
    MInimize_Button.Size = UDim2.new(0, 30, 0, 30)
    MInimize_Button.AutoButtonColor = false
    MInimize_Button.Font = Enum.Font.SourceSans
    MInimize_Button.Text = "+"
    MInimize_Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    MInimize_Button.TextSize = 40.000
    MInimize_Button.TextStrokeColor3 = Color3.fromRGB(255, 255, 255)

    -- Discord Button
    local Discord = Instance.new("TextButton")
    Discord.Name = "Discord"
    Discord.Parent = Body
    Discord.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Discord.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Discord.BorderSizePixel = 0
    Discord.Position = UDim2.new(0, 5, 0, 320)
    Discord.Size = UDim2.new(0, 85, 0, 25)
    Discord.AutoButtonColor = false
    Discord.Font = Enum.Font.SourceSans
    Discord.Text = ""
    Discord.TextColor3 = Color3.fromRGB(0, 0, 0)
    Discord.TextSize = 14.000

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 5)
    UICorner.Parent = Discord

    local Disc_Logo = Instance.new("ImageLabel")
    Disc_Logo.Name = "Disc_Logo"
    Disc_Logo.Parent = Discord
    Disc_Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Disc_Logo.BackgroundTransparency = 1.000
    Disc_Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Disc_Logo.BorderSizePixel = 0
    Disc_Logo.Position = UDim2.new(0, 5, 0, 1)
    Disc_Logo.Size = UDim2.new(0, 23, 0, 23)
    Disc_Logo.Image = "http://www.roblox.com/asset/?id=12058969086"

    local Disc_Title = Instance.new("TextLabel")
    Disc_Title.Name = "Disc_Title"
    Disc_Title.Parent = Discord
    Disc_Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Disc_Title.BackgroundTransparency = 1.000
    Disc_Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Disc_Title.BorderSizePixel = 0
    Disc_Title.Position = UDim2.new(0, 35, 0, 0)
    Disc_Title.Size = UDim2.new(0, 40, 0, 25)
    Disc_Title.Font = Enum.Font.SourceSansSemibold
    Disc_Title.Text = "Discord"
    Disc_Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Disc_Title.TextSize = 14.000
    Disc_Title.TextXAlignment = Enum.TextXAlignment.Left

    -- Discord Button Hover Effect
    Discord.MouseEnter:Connect(function()
        utility:Tween(Discord, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, .15)
        utility:Tween(Disc_Logo, {ImageTransparency = 0.7}, .15)
        utility:Tween(Disc_Title, {TextTransparency = 0.7}, .15)
    end)

    Discord.MouseLeave:Connect(function()
        utility:Tween(Discord, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, .15)
        utility:Tween(Disc_Logo, {ImageTransparency = 0}, .15)
        utility:Tween(Disc_Title, {TextTransparency = 0}, .15)
    end)

    -- Discord Button Click
    Discord.MouseButton1Click:Connect(function()
        if setclipboard then
            setclipboard("https://discord.gg/25ms")
        elseif toclipboard then
            toclipboard("https://discord.gg/25ms")
        end
        
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Discord",
            Text = "Discord copied to your clipboard",
            Button1 = "Okay",
            Duration = 20
        })
    end)

    -- Server Time
    local Server_Time = Instance.new("TextLabel")
    Server_Time.Name = "Server_Time"
    Server_Time.Parent = Body
    Server_Time.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Server_Time.BackgroundTransparency = 1.000
    Server_Time.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Server_Time.BorderSizePixel = 0
    Server_Time.Position = UDim2.new(0, 100, 0, 320)
    Server_Time.Size = UDim2.new(0, 120, 0, 25)
    Server_Time.Font = Enum.Font.SourceSansSemibold
    Server_Time.Text = ""
    Server_Time.TextColor3 = Color3.fromRGB(255, 255, 255)
    Server_Time.TextSize = 14.000
    Server_Time.TextXAlignment = Enum.TextXAlignment.Left

    -- Update Time Function
    local function UpdateTime()
        local GameTime = math.floor(workspace.DistributedGameTime + 0.5)
        local Hour = math.floor(GameTime/(60^2)) % 24
        local Minute = math.floor(GameTime/(60^1)) % 60
        local Second = math.floor(GameTime/(60^0)) % 60
        local FormatTime = string.format("%02d.%02d.%02d", Hour, Minute, Second)
        Server_Time.Text = "Game Time : " .. FormatTime
    end

    -- Start Time Update Loop
    task.spawn(function()
        while true do
            UpdateTime()
            RunService.Heartbeat:Wait()
        end
    end)

    -- Server ID
    local Server_ID = Instance.new("TextLabel")
    Server_ID.Name = "Server_ID"
    Server_ID.Parent = Body
    Server_ID.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Server_ID.BackgroundTransparency = 1.000
    Server_ID.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Server_ID.BorderSizePixel = 0
    Server_ID.Position = UDim2.new(0, 230, 0, 320)
    Server_ID.Size = UDim2.new(0, 365, 0, 25)
    Server_ID.Font = Enum.Font.SourceSansSemibold
    Server_ID.Text = "User : " .. NameID .. "     [CTRL = Hide Gui]"
    Server_ID.TextColor3 = Color3.fromRGB(255, 255, 255)
    Server_ID.TextSize = 14.000
    Server_ID.TextXAlignment = Enum.TextXAlignment.Right

    -- List Tile
    local List_Tile = Instance.new("Frame")
    List_Tile.Name = "List_Tile"
    List_Tile.Parent = Body
    List_Tile.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    List_Tile.BorderColor3 = Color3.fromRGB(0, 0, 0)
    List_Tile.BorderSizePixel = 0
    List_Tile.Position = UDim2.new(0, 0, 0, 30)
    List_Tile.Size = UDim2.new(1, 0, 0, 2)

    local Tile_Gradient = Instance.new("UIGradient")
    Tile_Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
    })
    Tile_Gradient.Name = "Tile_Gradient"
    Tile_Gradient.Parent = List_Tile

    -- Toggle Button
    local Toggle = Instance.new("Frame")
    Toggle.Name = "Toggle"
    Toggle.Parent = ScreenGui
    Toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    Toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Toggle.BorderSizePixel = 0
    Toggle.Position = UDim2.new(0.0160791595, 0, 0.219451368, 0)
    Toggle.Size = UDim2.new(0, 40, 0, 40)

    local toggle_corner = Instance.new("UICorner")
    toggle_corner.Name = "toggle_corner"
    toggle_corner.Parent = Toggle

    local toggle_Image = Instance.new("ImageButton")
    toggle_Image.Name = "toggle_Image"
    toggle_Image.Parent = Toggle
    toggle_Image.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    toggle_Image.BackgroundTransparency = 1.000
    toggle_Image.BorderColor3 = Color3.fromRGB(0, 0, 0)
    toggle_Image.BorderSizePixel = 0
    toggle_Image.Size = UDim2.new(0, 40, 0, 40)
    toggle_Image.Image = "http://www.roblox.com/asset/?id=12021503727"
    toggle_Image.ImageColor3 = Color3.fromRGB(255, 0, 0)

    -- Minimize Button Functionality
    local minimizetog = false
    MInimize_Button.MouseButton1Click:Connect(function()
        if minimizetog then
            utility:Tween(Body, {Size = UDim2.new(0, 600, 0, 350)}, .3)
            utility:Tween(MInimize_Button, {Rotation = -315}, .3)
        else
            utility:Tween(Body, {Size = UDim2.new(0, 600, 0, 32)}, .3)
            utility:Tween(MInimize_Button, {Rotation = 360}, .3)
        end
        minimizetog = not minimizetog
    end)

    -- Toggle Button Functionality
    local togimage = false
    toggle_Image.MouseEnter:Connect(function()
        utility:Tween(Toggle, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, .15)
    end)

    toggle_Image.MouseLeave:Connect(function()
        utility:Tween(Toggle, {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}, .15)
    end)

    toggle_Image.MouseButton1Click:Connect(function()
        togimage = not togimage
        Body.Visible = not togimage
    end)

    -- Dragging Functionality
    local function EnableDragging(frame)
        local dragging = false
        local dragInput, dragStart, startPos
        
        local function update(input)
            local delta = input.Position - dragStart
            frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
        
        frame.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                dragging = true
                dragStart = input.Position
                startPos = frame.Position
                
                input.Changed:Connect(function()
                    if input.UserInputState == Enum.UserInputState.End then
                        dragging = false
                    end
                end)
            end
        end)
        
        frame.InputChanged:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                dragInput = input
            end
        end)
        
        UserInputService.InputChanged:Connect(function(input)
            if input == dragInput and dragging then
                update(input)
            end
        end)
    end
    
    EnableDragging(Body)

    -- Tab Container
    local Tab_Container = Instance.new("Frame")
    Tab_Container.Name = "Tab_Container"
    Tab_Container.Parent = Body
    Tab_Container.BackgroundColor3 = Color3.fromRGB(64, 64, 95)
    Tab_Container.BackgroundTransparency = 1.000
    Tab_Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Tab_Container.BorderSizePixel = 0
    Tab_Container.ClipsDescendants = true
    Tab_Container.Position = UDim2.new(0, 0, 0, 36)
    Tab_Container.Size = UDim2.new(1, 0, 0, 30)

    local Tab_List = Instance.new("Frame")
    Tab_List.Name = "Tab_List"
    Tab_List.Parent = Tab_Container
    Tab_List.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Tab_List.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Tab_List.BorderSizePixel = 0
    Tab_List.Position = UDim2.new(0, 0, 0, 28)
    Tab_List.Size = UDim2.new(1, 0, 0, 2)

    local TabList_Gradient = Instance.new("UIGradient")
    TabList_Gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
    })
    TabList_Gradient.Name = "TabList_Gradient"
    TabList_Gradient.Parent = Tab_List

    local Tab_Scroll = Instance.new("ScrollingFrame")
    Tab_Scroll.Name = "Tab_Scroll"
    Tab_Scroll.Parent = Tab_Container
    Tab_Scroll.Active = true
    Tab_Scroll.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Tab_Scroll.BackgroundTransparency = 1.000
    Tab_Scroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Tab_Scroll.BorderSizePixel = 0
    Tab_Scroll.Position = UDim2.new(0, 10, 0, 0)
    Tab_Scroll.Size = UDim2.new(1, -20, 0, 30)
    Tab_Scroll.CanvasPosition = Vector2.new(0, 0)
    Tab_Scroll.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
    Tab_Scroll.ScrollBarThickness = 0

    local Tab_Scroll_Layout = Instance.new("UIListLayout")
    Tab_Scroll_Layout.Name = "Tab_Scroll_Layout"
    Tab_Scroll_Layout.Parent = Tab_Scroll
    Tab_Scroll_Layout.FillDirection = Enum.FillDirection.Horizontal
    Tab_Scroll_Layout.HorizontalAlignment = Enum.HorizontalAlignment.Left
    Tab_Scroll_Layout.VerticalAlignment = Enum.VerticalAlignment.Top
    Tab_Scroll_Layout.SortOrder = Enum.SortOrder.LayoutOrder
    Tab_Scroll_Layout.Padding = UDim.new(0, 5)

    -- Update Canvas Size
    Tab_Scroll_Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        Tab_Scroll.CanvasSize = UDim2.new(0, Tab_Scroll_Layout.AbsoluteContentSize.X + Tab_Scroll_Layout.Padding.Offset, 0, 0)
    end)

    Tab_Scroll.ChildAdded:Connect(function()
        Tab_Scroll.CanvasSize = UDim2.new(0, Tab_Scroll_Layout.AbsoluteContentSize.X + Tab_Scroll_Layout.Padding.Offset, 0, 0)
    end)

    -- Main Container
    local Main_Container = Instance.new("Frame")
    Main_Container.Name = "Main_Container"
    Main_Container.Parent = Body
    Main_Container.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Main_Container.BackgroundTransparency = 1.000
    Main_Container.BorderSizePixel = 0
    Main_Container.Position = UDim2.new(0, 5, 0, 70)
    Main_Container.Size = UDim2.new(0, 590, 0, 245)

    local ContainerGradients = Instance.new("UIGradient")
    ContainerGradients.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(100, 0, 0)),
        ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(100, 0, 0)),
    })
    ContainerGradients.Name = "ContainerGradients"
    ContainerGradients.Parent = Main_Container

    local Container = Instance.new("Folder")
    Container.Name = "Container"
    Container.Parent = Main_Container

    -- Tabs System
    local Tabs = {}
    local is_first_tab = true
    
    function Tabs:addTab(title_tab)
        -- Tab Button
        local Tab_Items = Instance.new("TextButton")
        Tab_Items.Name = "Tab_Items"
        Tab_Items.Parent = Tab_Scroll
        Tab_Items.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
        Tab_Items.BackgroundTransparency = 1.000
        Tab_Items.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Tab_Items.BorderSizePixel = 0
        Tab_Items.Size = UDim2.new(0, 0, 0, 0)
        Tab_Items.AutoButtonColor = false
        Tab_Items.Font = Enum.Font.SourceSansSemibold
        Tab_Items.TextColor3 = Color3.fromRGB(255, 255, 255)
        Tab_Items.TextSize = 14.000
        Tab_Items.Text = title_tab

        local Tab_Item_Corner = Instance.new("UICorner")
        Tab_Item_Corner.Name = "Tab_Item_Corner"
        Tab_Item_Corner.CornerRadius = UDim.new(0, 4)
        Tab_Item_Corner.Parent = Tab_Items

        utility:Tween(Tab_Items, {Size = UDim2.new(0, 25 + Tab_Items.TextBounds.X, 0, 24)}, .15)

        -- Tab Content
        local ScrollingFrame = Instance.new("ScrollingFrame")
        ScrollingFrame.Name = "ScrollingFrame"
        ScrollingFrame.Parent = Container
        ScrollingFrame.Active = true
        ScrollingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ScrollingFrame.BackgroundTransparency = 1.000
        ScrollingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
        ScrollingFrame.BorderSizePixel = 0
        ScrollingFrame.Position = UDim2.new(0, 0, 0, 0)
        ScrollingFrame.Size = UDim2.new(1, 0, 1, 0)
        ScrollingFrame.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
        ScrollingFrame.ScrollBarThickness = 0
        ScrollingFrame.Visible = false

        local Scrolling_Layout = Instance.new("UIListLayout")
        Scrolling_Layout.Name = "Scrolling_Layout"
        Scrolling_Layout.Parent = ScrollingFrame
        Scrolling_Layout.FillDirection = Enum.FillDirection.Horizontal
        Scrolling_Layout.SortOrder = Enum.SortOrder.LayoutOrder
        Scrolling_Layout.Padding = UDim.new(0, 19)

        -- Update Canvas Size
        Scrolling_Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
            ScrollingFrame.CanvasSize = UDim2.new(0, Scrolling_Layout.AbsoluteContentSize.X, 0, 0)
        end)
    
        ScrollingFrame.ChildAdded:Connect(function()
            ScrollingFrame.CanvasSize = UDim2.new(0, Scrolling_Layout.AbsoluteContentSize.X, 0, 0)
        end)

        -- Show first tab by default
        if is_first_tab then
            is_first_tab = false
            utility:Tween(Tab_Items, {BackgroundTransparency = 0.5}, .3)
            ScrollingFrame.Visible = true
        end

        -- Tab Button Click
        Tab_Items.MouseButton1Click:Connect(function()
            -- Hide all tabs
            for _, v in next, Tab_Scroll:GetChildren() do
                if v:IsA("TextButton") then
                    utility:Tween(v, {BackgroundTransparency = 1.000}, .3)
                end
            end
            
            -- Show selected tab
            utility:Tween(Tab_Items, {BackgroundTransparency = 0.5}, .3)

            for _, v in next, Container:GetChildren() do
                if v.Name == "ScrollingFrame" then
                    v.Visible = false
                end
            end
            
            ScrollingFrame.Visible = true
        end)

        -- Section System
        local Section = {}
        
        function Section:addSection()
            -- Section Container
            local SectionScroll = Instance.new("ScrollingFrame")
            SectionScroll.Name = "SectionScroll"
            SectionScroll.Parent = ScrollingFrame
            SectionScroll.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
            SectionScroll.BackgroundTransparency = 1.000
            SectionScroll.BorderColor3 = Color3.fromRGB(0, 0, 0)
            SectionScroll.BorderSizePixel = 0
            SectionScroll.Size = UDim2.new(0, 285, 0, 245)
            SectionScroll.ScrollBarImageColor3 = Color3.fromRGB(255, 0, 0)
            SectionScroll.ScrollBarThickness = 4

            local UIListLayout_Section = Instance.new("UIListLayout")
            UIListLayout_Section.Parent = SectionScroll
            UIListLayout_Section.HorizontalAlignment = Enum.HorizontalAlignment.Center
            UIListLayout_Section.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout_Section.Padding = UDim.new(0, 6)

            -- Update Canvas Size
            UIListLayout_Section:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                SectionScroll.CanvasSize = UDim2.new(0, 0, 0, 5 + UIListLayout_Section.Padding.Offset + UIListLayout_Section.AbsoluteContentSize.Y)
            end)
            
            SectionScroll.ChildAdded:Connect(function()
                SectionScroll.CanvasSize = UDim2.new(0, 0, 0, 5 + UIListLayout_Section.Padding.Offset + UIListLayout_Section.AbsoluteContentSize.Y)
            end)

            -- Menu System
            local Menus = {}
            
            function Menus:addMenu(title_menu)
                -- Menu Container
                local Section = Instance.new("Frame")
                Section.Name = "Section"
                Section.Parent = SectionScroll
                Section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Section.BackgroundTransparency = 1.000
                Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Section.BorderSizePixel = 0
                Section.Size = UDim2.new(1, 0, 0, 25)

                local Section_Inner = Instance.new("Frame")
                Section_Inner.Name = "Section_Inner"
                Section_Inner.Parent = Section
                Section_Inner.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Section_Inner.BorderColor3 = Color3.fromRGB(0, 0, 0)
                Section_Inner.BorderSizePixel = 0
                Section_Inner.Position = UDim2.new(0, 5, 0, 0)
                Section_Inner.Size = UDim2.new(1, -10, 0, 25)

                local UIGradient_2 = Instance.new("UIGradient")
                UIGradient_2.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 0, 0)),
                    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(20, 20, 20)),
                    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(20, 20, 20)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 0, 0)),
                })
                UIGradient_2.Parent = Section_Inner

                local UIListLayout = Instance.new("UIListLayout")
                UIListLayout.Parent = Section_Inner
                UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayout.Padding = UDim.new(0, 3)

                local UICorner = Instance.new("UICorner")
                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = Section_Inner

                local TextLabel = Instance.new("TextLabel")
                TextLabel.Parent = Section_Inner
                TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextLabel.BackgroundTransparency = 1.000
                TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                TextLabel.BorderSizePixel = 0
                TextLabel.Size = UDim2.new(1, 0, 0, 20)
                TextLabel.Font = Enum.Font.SourceSansSemibold
                TextLabel.Text = title_menu
                TextLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                TextLabel.TextSize = 14.000

                local List = Instance.new("Frame")
                List.Name = "List"
                List.Parent = Section_Inner
                List.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                List.BorderColor3 = Color3.fromRGB(0, 0, 0)
                List.BorderSizePixel = 0
                List.Size = UDim2.new(1, 0, 0, 1)

                local UIGradient = Instance.new("UIGradient")
                UIGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 30)),
                    ColorSequenceKeypoint.new(0.3, Color3.fromRGB(255, 0, 0)),
                    ColorSequenceKeypoint.new(0.7, Color3.fromRGB(255, 0, 0)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(30, 30, 30)),
                })
                UIGradient.Parent = List

                -- Update Section Size
                Section.Size = UDim2.new(1, 0, 0, UIListLayout.AbsoluteContentSize.Y + UIListLayout.Padding.Offset + 5)
                Section_Inner.Size = UDim2.new(1, -10, 0, UIListLayout.AbsoluteContentSize.Y + UIListLayout.Padding.Offset + 5)
                
                UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    Section.Size = UDim2.new(1, 0, 0, UIListLayout.AbsoluteContentSize.Y + UIListLayout.Padding.Offset + 5)
                    Section_Inner.Size = UDim2.new(1, -10, 0, UIListLayout.AbsoluteContentSize.Y + UIListLayout.Padding.Offset + 5)
                end)

                -- Update Section Scroll
                local function SectionScrollChanged()
                    local SCL = UIListLayout.AbsoluteContentSize.Y
                    SectionScroll.CanvasSize = UDim2.new(0, 0, 0, SCL + UIListLayout.Padding.Offset + 5)
                end
                
                local function SectionInnerChanged()
                    Section.Size = UDim2.new(1, 0, 0, UIListLayout.AbsoluteContentSize.Y + UIListLayout.Padding.Offset + 5)
                    Section_Inner.Size = UDim2.new(1, -10, 0, UIListLayout.AbsoluteContentSize.Y + UIListLayout.Padding.Offset + 5)
                end

                SectionScrollChanged()
                SectionInnerChanged()
                
                -- Menu Items
                local Menu_Item = {}
                
                -- Button
                function Menu_Item:addButton(button_tile, callback)
                    callback = callback or function() end

                    local TextButton = Instance.new("TextButton")
                    local UICorner = Instance.new("UICorner")

                    TextButton.Parent = Section_Inner
                    TextButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    TextButton.BorderSizePixel = 0
                    TextButton.Size = UDim2.new(1, -10, 0, 25)
                    TextButton.AutoButtonColor = false
                    TextButton.Font = Enum.Font.SourceSansSemibold
                    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextButton.TextSize = 12.000
                    TextButton.Text = button_tile

                    UICorner.CornerRadius = UDim.new(0, 4)
                    UICorner.Parent = TextButton

                    -- Button Effects
                    TextButton.MouseEnter:Connect(function()
                        utility:Tween(TextButton, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, .15)
                        utility:Tween(TextButton, {TextColor3 = Color3.fromRGB(180, 180, 180)}, .15)
                    end)

                    TextButton.MouseLeave:Connect(function()
                        utility:Tween(TextButton, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, .15)
                        utility:Tween(TextButton, {TextColor3 = Color3.fromRGB(255, 255, 255)}, .15)
                    end)

                    TextButton.MouseButton1Down:Connect(function()
                        utility:Tween(TextButton, {TextColor3 = Color3.fromRGB(0, 255, 0)}, .15)
                        utility:Tween(TextButton, {Size = UDim2.new(1, -25, 0, 15)}, .15)
                    end)

                    TextButton.MouseButton1Up:Connect(function()
                        utility:Tween(TextButton, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 1)
                        utility:Tween(TextButton, {Size = UDim2.new(1, -10, 0, 25)}, .15)
                    end)

                    TextButton.MouseButton1Click:Connect(function()
                        callback()
                    end)
                end

                -- Toggle
                function Menu_Item:addToggle(toggle_title, default, callback)
                    callback = callback or function(Value) end
                    default = default or false

                    local Frame = Instance.new("Frame")
                    local TextLabel = Instance.new("TextLabel")
                    local ImageButton = Instance.new("ImageButton")
                    local UICorner = Instance.new("UICorner")

                    Frame.Parent = Section_Inner
                    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Frame.BorderSizePixel = 0
                    Frame.Size = UDim2.new(1, -10, 0, 25)

                    TextLabel.Parent = Frame
                    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    TextLabel.BackgroundTransparency = 1.000
                    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    TextLabel.BorderSizePixel = 0
                    TextLabel.Position = UDim2.new(0, 5, 0, 0)
                    TextLabel.Size = UDim2.new(1, -30, 0, 25)
                    TextLabel.Font = Enum.Font.SourceSansSemibold
                    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextLabel.TextSize = 12.000
                    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextLabel.Text = toggle_title

                    ImageButton.Parent = Frame
                    ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ImageButton.BackgroundTransparency = 1.000
                    ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    ImageButton.BorderSizePixel = 0
                    ImageButton.Position = UDim2.new(0, 242, 0, 2)
                    ImageButton.Size = UDim2.new(0, 20, 0, 20)
                    ImageButton.Image = "rbxassetid://3926311105"
                    ImageButton.ImageRectOffset = Vector2.new(940, 784)
                    ImageButton.ImageRectSize = Vector2.new(48, 48)

                    UICorner.CornerRadius = UDim.new(0, 4)
                    UICorner.Parent = Frame

                    -- Set default state
                    local CheckToggle = false
                    if default then
                        ImageButton.ImageRectOffset = Vector2.new(4, 836)
                        ImageButton.ImageColor3 = Color3.fromRGB(0, 255, 0)
                        TextLabel.TextColor3 = Color3.fromRGB(0, 255, 0)
                        CheckToggle = true
                        callback(CheckToggle)
                    end

                    -- Toggle Effects
                    ImageButton.MouseEnter:Connect(function()
                        utility:Tween(TextLabel, {TextTransparency = 0.5}, .15)
                        utility:Tween(ImageButton, {ImageTransparency = 0.5}, .15)
                        utility:Tween(Frame, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, .15)
                    end)
    
                    ImageButton.MouseLeave:Connect(function()
                        utility:Tween(TextLabel, {TextTransparency = 0}, .15)
                        utility:Tween(ImageButton, {ImageTransparency = 0}, .15)
                        utility:Tween(Frame, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, .15)
                    end)

                    -- Toggle Click
                    ImageButton.MouseButton1Click:Connect(function()
                        CheckToggle = not CheckToggle
                        
                        if CheckToggle then
                            ImageButton.ImageRectOffset = Vector2.new(4, 836)
                            utility:Tween(ImageButton, {ImageColor3 = Color3.fromRGB(0, 255, 0)}, .3)
                            utility:Tween(TextLabel, {TextColor3 = Color3.fromRGB(0, 255, 0)}, .3)
                        else
                            ImageButton.ImageRectOffset = Vector2.new(940, 784)
                            utility:Tween(ImageButton, {ImageColor3 = Color3.fromRGB(255, 255, 255)}, .3)
                            utility:Tween(TextLabel, {TextColor3 = Color3.fromRGB(255, 255, 255)}, .3)
                        end
                        
                        callback(CheckToggle)
                    end)
                end

                -- Dropdown
                function Menu_Item:addDropdown(dropdown_title, default, list, callback)
                    default = default or ""
                    list = list or {}
                    callback = callback or function(Value) end

                    local Frame = Instance.new("Frame")
                    local UICorner = Instance.new("UICorner")
                    local TextLabel = Instance.new("TextLabel")
                    local ImageButton = Instance.new("ImageButton")

                    Frame.Parent = Section_Inner
                    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Frame.BorderSizePixel = 0
                    Frame.Size = UDim2.new(1, -10, 0, 25)

                    UICorner.CornerRadius = UDim.new(0, 4)
                    UICorner.Parent = Frame

                    TextLabel.Parent = Frame
                    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    TextLabel.BackgroundTransparency = 1.000
                    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    TextLabel.BorderSizePixel = 0
                    TextLabel.Position = UDim2.new(0, 5, 0, 0)
                    TextLabel.Size = UDim2.new(1, -40, 0, 25)
                    TextLabel.Font = Enum.Font.SourceSansSemibold
                    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextLabel.TextSize = 12.000
                    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextLabel.Text = dropdown_title

                    ImageButton.Parent = Frame
                    ImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ImageButton.BackgroundTransparency = 1.000
                    ImageButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    ImageButton.BorderSizePixel = 0
                    ImageButton.Position = UDim2.new(0, 242, 0, 1)
                    ImageButton.Size = UDim2.new(0, 21, 0, 22)
                    ImageButton.Image = "rbxassetid://14834203285"

                    -- Set default value
                    if default and table.find(list, default) then
                        TextLabel.Text = dropdown_title .. ' - ' .. default
                        callback(default)
                    end

                    -- Dropdown Effects
                    ImageButton.MouseEnter:Connect(function()
                        utility:Tween(TextLabel, {TextTransparency = 0.5}, .15)
                        utility:Tween(ImageButton, {ImageTransparency = 0.5}, .15)
                        utility:Tween(Frame, {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}, .15)
                    end)
    
                    ImageButton.MouseLeave:Connect(function()
                        utility:Tween(TextLabel, {TextTransparency = 0}, .15)
                        utility:Tween(ImageButton, {ImageTransparency = 0}, .15)
                        utility:Tween(Frame, {BackgroundColor3 = Color3.fromRGB(40, 40, 40)}, .15)
                    end)

                    -- Dropdown Container
                    local ScrollDown = Instance.new("Frame")
                    local UIListLayout = Instance.new("UIListLayout")
                    local UICorner_2 = Instance.new("UICorner")

                    ScrollDown.Name = "ScrollDown"
                    ScrollDown.Parent = Section_Inner
                    ScrollDown.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    ScrollDown.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    ScrollDown.BorderSizePixel = 0
                    ScrollDown.ClipsDescendants = true
                    ScrollDown.Size = UDim2.new(1, -10, 0, 0)

                    UIListLayout.Parent = ScrollDown
                    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
                    UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
                    UIListLayout.Padding = UDim.new(0, 3)

                    UICorner_2.CornerRadius = UDim.new(0, 4)
                    UICorner_2.Parent = ScrollDown

                    -- Dropdown Toggle
                    local dropdown_toggle = false
                    ImageButton.MouseButton1Click:Connect(function()
                        dropdown_toggle = not dropdown_toggle
                        
                        if dropdown_toggle then
                            utility:Tween(ScrollDown, {Size = UDim2.new(1, -10, 0, UIListLayout.AbsoluteContentSize.Y + 5)}, 0.15)
                            utility:Tween(ImageButton, {ImageColor3 = Color3.fromRGB(0, 255, 0)}, .15)
                            utility:Tween(TextLabel, {TextColor3 = Color3.fromRGB(0, 255, 0)}, .15)
                        else
                            utility:Tween(ScrollDown, {Size = UDim2.new(1, -10, 0, 0)}, 0.15)
                            utility:Tween(ImageButton, {ImageColor3 = Color3.fromRGB(255, 255, 255)}, .15)
                            utility:Tween(TextLabel, {TextColor3 = Color3.fromRGB(255, 255, 255)}, .15)
                        end
                    end)

                    -- Create Dropdown Options
                    for _, v in pairs(list) do
                        local TextButton = Instance.new('TextButton')

                        TextButton.Parent = ScrollDown
                        TextButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                        TextButton.BackgroundTransparency = 1.000
                        TextButton.BorderSizePixel = 0
                        TextButton.Size = UDim2.new(1, 0, 0, 25)
                        TextButton.Position = UDim2.new(0, 5, 0, 0)
                        TextButton.Font = Enum.Font.SourceSansSemibold
                        TextButton.AutoButtonColor = false
                        TextButton.TextSize = 12.000
                        TextButton.Text = v
                        TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    
                        -- Option Effects
                        TextButton.MouseEnter:Connect(function()
                            utility:Tween(TextButton, {TextSize = 9.000}, 0.15)
                            utility:Tween(TextButton, {TextColor3 = Color3.fromRGB(0, 255, 0)}, 0.15)
                        end)
    
                        TextButton.MouseLeave:Connect(function()
                            utility:Tween(TextButton, {TextSize = 12.000}, 0.15)
                            utility:Tween(TextButton, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.15)
                        end)
    
                        -- Option Click
                        TextButton.MouseButton1Click:Connect(function()
                            dropdown_toggle = false
                            TextLabel.Text = dropdown_title .. ' - ' .. v
                            callback(v)
                            utility:Tween(ScrollDown, {Size = UDim2.new(1, -10, 0, 0)}, 0.15)
                            utility:Tween(ImageButton, {ImageColor3 = Color3.fromRGB(255, 255, 255)}, .15)
                            utility:Tween(TextLabel, {TextColor3 = Color3.fromRGB(255, 255, 255)}, .15)
                        end)
                    end

                    -- Dropdown Functions
                    local updatedropfunc = {}
                    
                    function updatedropfunc:Clear()
                        for _, v in pairs(ScrollDown:GetChildren()) do
                            if v:IsA("TextButton") then
                                v:Destroy()
                            end
                        end
                        
                        dropdown_toggle = false
                        TextLabel.Text = dropdown_title
                        utility:Tween(ScrollDown, {Size = UDim2.new(1, -10, 0, 0)}, 0.15)
                    end

                    function updatedropfunc:Refresh(newlist)
                        updatedropfunc:Clear()
                        
                        for _, v in pairs(newlist or {}) do
                            local TextButton = Instance.new('TextButton')
    
                            TextButton.Parent = ScrollDown
                            TextButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                            TextButton.BackgroundTransparency = 1.000
                            TextButton.BorderSizePixel = 0
                            TextButton.Size = UDim2.new(1, 0, 0, 25)
                            TextButton.Position = UDim2.new(0, 5, 0, 0)
                            TextButton.Font = Enum.Font.SourceSansSemibold
                            TextButton.AutoButtonColor = false
                            TextButton.TextSize = 12.000
                            TextButton.Text = v
                            TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
        
                            TextButton.MouseEnter:Connect(function()
                                utility:Tween(TextButton, {TextSize = 9.000}, 0.15)
                                utility:Tween(TextButton, {TextColor3 = Color3.fromRGB(0, 255, 0)}, 0.15)
                            end)
        
                            TextButton.MouseLeave:Connect(function()
                                utility:Tween(TextButton, {TextSize = 12.000}, 0.15)
                                utility:Tween(TextButton, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.15)
                            end)
        
                            TextButton.MouseButton1Click:Connect(function()
                                dropdown_toggle = false
                                TextLabel.Text = dropdown_title .. ' - ' .. v
                                callback(v)
                                utility:Tween(ScrollDown, {Size = UDim2.new(1, -10, 0, 0)}, 0.15)
                                utility:Tween(ImageButton, {ImageColor3 = Color3.fromRGB(255, 255, 255)}, .15)
                                utility:Tween(TextLabel, {TextColor3 = Color3.fromRGB(255, 255, 255)}, .15)
                            end)
                        end
                    end
                    
                    return updatedropfunc
                end

                -- Textbox
                function Menu_Item:addTextbox(text_title, default, callback)
                    callback = callback or function(Value) end
                    
                    local Frame = Instance.new("Frame")
                    local UICorner = Instance.new("UICorner")
                    local TextLabel = Instance.new("TextLabel")
                    local TextBox = Instance.new("TextBox")

                    Frame.Parent = Section_Inner
                    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Frame.BorderSizePixel = 0
                    Frame.Size = UDim2.new(1, -10, 0, 25)

                    UICorner.CornerRadius = UDim.new(0, 4)
                    UICorner.Parent = Frame

                    TextLabel.Parent = Frame
                    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    TextLabel.BackgroundTransparency = 1.000
                    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    TextLabel.BorderSizePixel = 0
                    TextLabel.Position = UDim2.new(0, 5, 0, 0)
                    TextLabel.Size = UDim2.new(0, 150, 0, 25)
                    TextLabel.Font = Enum.Font.SourceSansSemibold
                    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextLabel.TextSize = 12.000
                    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextLabel.Text = text_title

                    TextBox.Parent = Frame
                    TextBox.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
                    TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    TextBox.BorderSizePixel = 0
                    TextBox.Position = UDim2.new(0, 190, 0, 2)
                    TextBox.Size = UDim2.new(0, 70, 0, 20)
                    TextBox.Font = Enum.Font.SourceSansSemibold
                    TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextBox.TextSize = 12.000
                    TextBox.Text = default or "Type Here"
                    TextBox.ClearTextOnFocus = false

                    -- Textbox Focus Lost
                    TextBox.FocusLost:Connect(function(enterPressed)
                        if enterPressed then
                            callback(TextBox.Text)
                            utility:Tween(TextBox, {TextColor3 = Color3.fromRGB(0, 255, 0)}, .1)
                            utility:Tween(TextLabel, {TextColor3 = Color3.fromRGB(0, 255, 0)}, .1)
                            task.wait(.1)
                            utility:Tween(TextBox, {TextColor3 = Color3.fromRGB(255, 255, 255)}, .5)
                            utility:Tween(TextLabel, {TextColor3 = Color3.fromRGB(255, 255, 255)}, .5)
                        end
                    end)
                end

                -- Keybind
                function Menu_Item:addKeybind(keybind_title, preset, callback)
                    callback = callback or function(Value) end
                    preset = preset or {Name = "None"}

                    local Frame = Instance.new("Frame")
                    local UICorner = Instance.new("UICorner")
                    local TextLabel = Instance.new("TextLabel")
                    local TextButton = Instance.new("TextButton")
                    local UICorner_2 = Instance.new("UICorner")

                    Frame.Parent = Section_Inner
                    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Frame.BorderSizePixel = 0
                    Frame.Size = UDim2.new(1, -10, 0, 25)

                    UICorner.CornerRadius = UDim.new(0, 4)
                    UICorner.Parent = Frame

                    TextLabel.Parent = Frame
                    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    TextLabel.BackgroundTransparency = 1.000
                    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    TextLabel.BorderSizePixel = 0
                    TextLabel.Position = UDim2.new(0, 5, 0, 0)
                    TextLabel.Size = UDim2.new(0, 150, 0, 25)
                    TextLabel.Font = Enum.Font.SourceSansSemibold
                    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextLabel.TextSize = 12.000
                    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextLabel.Text = keybind_title

                    TextButton.Parent = Frame
                    TextButton.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
                    TextButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    TextButton.BorderSizePixel = 0
                    TextButton.Position = UDim2.new(0, 190, 0, 3)
                    TextButton.Size = UDim2.new(0, 70, 0, 20)
                    TextButton.AutoButtonColor = false
                    TextButton.Font = Enum.Font.SourceSansSemibold
                    TextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextButton.TextSize = 14.000
                    TextButton.Text = preset.Name

                    UICorner_2.CornerRadius = UDim.new(0, 4)
                    UICorner_2.Parent = TextButton

                    -- Keybind Click
                    TextButton.MouseButton1Click:Connect(function()
                        TextButton.Text = ". . ."
                        
                        local inputWait = UserInputService.InputBegan:Wait()
                        local Key = inputWait.KeyCode.Name
                        
                        if Key == preset.Name then
                            TextButton.Text = Key
                            callback(Key)
                            utility:Tween(TextButton, {TextColor3 = Color3.fromRGB(0, 255, 0)}, .1)
                            utility:Tween(TextLabel, {TextColor3 = Color3.fromRGB(0, 255, 0)}, .1)
                            task.wait(.1)
                            utility:Tween(TextButton, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 1)
                            utility:Tween(TextLabel, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 1)
                        else
                            TextButton.Text255,255)}, 1)
                        else
                            TextButton.Text = "Invalid..."
                            callback()
                            utility:Tween(TextButton, {TextColor3 = Color3.fromRGB(255, 0, 0)}, .1)
                            utility:Tween(TextLabel, {TextColor3 = Color3.fromRGB(255, 0, 0)}, .1)
                            task.wait(.1)
                            utility:Tween(TextButton, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 1)
                            utility:Tween(TextLabel, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 1)
                        end
                    end)
                end

                -- Label
                function Menu_Item:addLabel(label_text)
                    local LabelFunc = {}
                    local TextLabel = Instance.new("TextLabel")

                    TextLabel.Parent = Section_Inner
                    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    TextLabel.BackgroundTransparency = 1.000
                    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    TextLabel.BorderSizePixel = 0
                    TextLabel.Size = UDim2.new(1, -20, 0, 15)
                    TextLabel.Font = Enum.Font.SourceSansSemibold
                    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextLabel.TextSize = 12.000
                    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextLabel.Text = label_text

                    function LabelFunc:Refresh(newLabel)
                        if TextLabel.Text ~= newLabel then
                            TextLabel.Text = newLabel
                        end
                    end
                    
                    return LabelFunc
                end
                
                -- Changelog
                function Menu_Item:addChangelog(changelog_text)
                    local ChangelogFunc = {}
                    local TextLabel = Instance.new("TextLabel")

                    TextLabel.Parent = Section_Inner
                    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    TextLabel.BackgroundTransparency = 1.000
                    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    TextLabel.BorderSizePixel = 0
                    TextLabel.Size = UDim2.new(1, -20, 0, 15)
                    TextLabel.Font = Enum.Font.SourceSansSemibold
                    TextLabel.TextColor3 = Color3.fromRGB(85, 170, 255)
                    TextLabel.TextSize = 12.000
                    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextLabel.Text = changelog_text

                    function ChangelogFunc:Refresh(newChangelog)
                        if TextLabel.Text ~= newChangelog then
                            TextLabel.Text = newChangelog
                        end
                    end
                    
                    return ChangelogFunc
                end

                -- Log
                function Menu_Item:addLog(log_text)
                    local LogFunc = {}
                    local TextLabel = Instance.new("TextLabel")

                    TextLabel.Parent = Section_Inner
                    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    TextLabel.BackgroundTransparency = 1.000
                    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    TextLabel.BorderSizePixel = 0
                    TextLabel.Font = Enum.Font.SourceSansSemibold
                    TextLabel.Text = log_text
                    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
                    TextLabel.TextSize = 12.000
                    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextLabel.TextYAlignment = Enum.TextYAlignment.Top

                    TextLabel.Size = UDim2.new(1, -20, 0, TextLabel.Text:len() + 15)
                    TextLabel:GetPropertyChangedSignal("Text"):Connect(function()
                        TextLabel.Size = UDim2.new(1, -20, 0, TextLabel.Text:len() + 15)
                    end)

                    function LogFunc:Refresh(newLog)
                        if TextLabel.Text ~= newLog then
                            TextLabel.Text = newLog
                        end
                    end
                    
                    return LogFunc
                end
                
                -- Slider (Additional feature)
                function Menu_Item:addSlider(slider_title, default, min, max, callback)
                    callback = callback or function(Value) end
                    default = default or min
                    
                    local Frame = Instance.new("Frame")
                    local UICorner = Instance.new("UICorner")
                    local TextLabel = Instance.new("TextLabel")
                    local SliderFrame = Instance.new("Frame")
                    local SliderInner = Instance.new("Frame")
                    local UICorner_2 = Instance.new("UICorner")
                    local UICorner_3 = Instance.new("UICorner")
                    local ValueLabel = Instance.new("TextLabel")
                    
                    Frame.Parent = Section_Inner
                    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
                    Frame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    Frame.BorderSizePixel = 0
                    Frame.Size = UDim2.new(1, -10, 0, 40)
                    
                    UICorner.CornerRadius = UDim.new(0, 4)
                    UICorner.Parent = Frame
                    
                    TextLabel.Parent = Frame
                    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    TextLabel.BackgroundTransparency = 1.000
                    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    TextLabel.BorderSizePixel = 0
                    TextLabel.Position = UDim2.new(0, 5, 0, 0)
                    TextLabel.Size = UDim2.new(1, -10, 0, 20)
                    TextLabel.Font = Enum.Font.SourceSansSemibold
                    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    TextLabel.TextSize = 12.000
                    TextLabel.TextXAlignment = Enum.TextXAlignment.Left
                    TextLabel.Text = slider_title
                    
                    SliderFrame.Name = "SliderFrame"
                    SliderFrame.Parent = Frame
                    SliderFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
                    SliderFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    SliderFrame.BorderSizePixel = 0
                    SliderFrame.Position = UDim2.new(0, 5, 0, 25)
                    SliderFrame.Size = UDim2.new(1, -10, 0, 10)
                    
                    SliderInner.Name = "SliderInner"
                    SliderInner.Parent = SliderFrame
                    SliderInner.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
                    SliderInner.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    SliderInner.BorderSizePixel = 0
                    SliderInner.Size = UDim2.new(0, 0, 1, 0)
                    
                    UICorner_2.CornerRadius = UDim.new(0, 4)
                    UICorner_2.Parent = SliderFrame
                    
                    UICorner_3.CornerRadius = UDim.new(0, 4)
                    UICorner_3.Parent = SliderInner
                    
                    ValueLabel.Name = "ValueLabel"
                    ValueLabel.Parent = Frame
                    ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ValueLabel.BackgroundTransparency = 1.000
                    ValueLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
                    ValueLabel.BorderSizePixel = 0
                    ValueLabel.Position = UDim2.new(0.85, 0, 0, 0)
                    ValueLabel.Size = UDim2.new(0, 40, 0, 20)
                    ValueLabel.Font = Enum.Font.SourceSansSemibold
                    ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
                    ValueLabel.TextSize = 12.000
                    ValueLabel.Text = tostring(default)
                    
                    -- Set default value
                    local percent = (default - min) / (max - min)
                    SliderInner.Size = UDim2.new(percent, 0, 1, 0)
                    ValueLabel.Text = tostring(default)
                    callback(default)
                    
                    -- Slider functionality
                    local dragging = false
                    
                    SliderFrame.InputBegan:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                        end
                    end)
                    
                    SliderFrame.InputEnded:Connect(function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end)
                    
                    UserInputService.InputChanged:Connect(function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            local mousePos = UserInputService:GetMouseLocation()
                            local framePos = SliderFrame.AbsolutePosition
                            local frameSize = SliderFrame.AbsoluteSize
                            
                            local relativeX = math.clamp((mousePos.X - framePos.X) / frameSize.X, 0, 1)
                            SliderInner.Size = UDim2.new(relativeX, 0, 1, 0)
                            
                            local value = math.floor(min + (relativeX * (max - min)))
                            ValueLabel.Text = tostring(value)
                            callback(value)
                        end
                    end)
                    
                    return {
                        SetValue = function(self, value)
                            value = math.clamp(value, min, max)
                            local percent = (value - min) / (max - min)
                            SliderInner.Size = UDim2.new(percent, 0, 1, 0)
                            ValueLabel.Text = tostring(value)
                            callback(value)
                        end
                    }
                end
                
                return Menu_Item
            end
            return Menus
        end
        return Section
    end
    return Tabs
end

return Library
