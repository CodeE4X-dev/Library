--!strict
-- Improved UI Library with better animations, type checking, and new components

local UserInputService = game:GetService('UserInputService')
local LocalPlayer = game:GetService('Players').LocalPlayer
local TweenService = game:GetService('TweenService')
local HttpService = game:GetService('HttpService')
local CoreGui = game:GetService('CoreGui')
local RunService = game:GetService('RunService')

local Mouse = LocalPlayer:GetMouse()

-- Animation presets for smoother transitions
local ANIMATION_PRESETS = {
    DEFAULT = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    FAST = TweenInfo.new(0.2, Enum.EasingStyle.Quart, Enum.EasingDirection.Out),
    SLOW = TweenInfo.new(0.6, Enum.EasingStyle.Quart, Enum.EasingDirection.InOut),
    SPRING = TweenInfo.new(0.6, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out, 0, false, 0),
    BOUNCE = TweenInfo.new(0.6, Enum.EasingStyle.Bounce, Enum.EasingDirection.Out)
}

-- Type definitions for better type checking
type Connection = {
    Disconnect: (self: Connection) -> ()
}

type Library = {
    connections: {[string]: Connection?},
    Flags: {[string]: any},
    Enabled: boolean,
    slider_drag: boolean,
    core: ScreenGui?,
    dragging: boolean,
    drag_position: Vector2?,
    start_position: UDim2?,
    enabled: boolean,
    
    disconnect: (self: Library) -> (),
    clear: (self: Library) -> (),
    exist: (self: Library) -> boolean?,
    save_flags: (self: Library) -> (),
    load_flags: (self: Library) -> (),
    open: (self: any) -> (),
    close: (self: any) -> (),
    drag: (self: any) -> (),
    visible: (self: any) -> (),
    new: (self: Library) -> any
}

-- Main library object
local Library: Library = {
    connections = {},
    Flags = {},
    Enabled = true,
    slider_drag = false,
    core = nil,
    dragging = false,
    drag_position = nil,
    start_position = nil,
    enabled = false
}

-- Clean up folder if it exists
if isfolder("Frostware") then
    delfolder("Frostware")
end

-- Create folder for saving flags
if not isfolder("Astral hub") then
    makefolder("Astral hub")
end

-- Disconnect all connections
function Library:disconnect()
    for key, connection in pairs(self.connections) do
        if connection then
            connection:Disconnect()
            self.connections[key] = nil
        end
    end
end

-- Clear all UI elements
function Library:clear()
    for _, object in ipairs(CoreGui:GetChildren()) do
        if object.Name == "Astral" then
            object:Destroy()
        end
    end
end

-- Check if library exists
function Library:exist()
    if not self.core then return false end
    if not self.core.Parent then return false end
    return true
end

-- Save flags to file
function Library:save_flags()
    if not self:exist() then return end

    local flags = HttpService:JSONEncode(self.Flags)
    writefile(`Astral hub/{game.GameId}.lua`, flags)
end

-- Load flags from file
function Library:load_flags()
    if not isfile(`Astral hub/{game.GameId}.lua`) then 
        self:save_flags() 
        return 
    end

    local success, flags = pcall(function()
        return HttpService:JSONDecode(readfile(`Astral hub/{game.GameId}.lua`))
    end)

    if success and flags then
        self.Flags = flags
    else
        self:save_flags()
    end
end

-- Load flags on initialization
Library:load_flags()
Library:clear()

-- Open the UI with smooth animation
function Library:open()
    self.Container.Visible = true
    self.Shadow.Visible = true
    self.Mobile.Modal = true

    -- Smoother animation with Quart easing
    TweenService:Create(self.Container, ANIMATION_PRESETS.SLOW, {
        Size = UDim2.new(0, 699, 0, 426)
    }):Play()

    TweenService:Create(self.Shadow, ANIMATION_PRESETS.SLOW, {
        Size = UDim2.new(0, 776, 0, 509)
    }):Play()
end

-- Close the UI with smooth animation
function Library:close()
    TweenService:Create(self.Shadow, ANIMATION_PRESETS.SLOW, {
        Size = UDim2.new(0, 0, 0, 0)
    }):Play()

    local main_tween = TweenService:Create(self.Container, ANIMATION_PRESETS.SLOW, {
        Size = UDim2.new(0, 0, 0, 0)
    })

    main_tween:Play()
    main_tween.Completed:Once(function()
        if self.enabled then
            return
        end

        self.Container.Visible = false
        self.Shadow.Visible = false
        self.Mobile.Modal = false
    end)
end

-- Drag functionality with smoother movement
function Library:drag()
    if not self.drag_position or not self.start_position then
        return
    end
    
    local delta = self.input.Position - self.drag_position
    local position = UDim2.new(
        self.start_position.X.Scale, 
        self.start_position.X.Offset + delta.X, 
        self.start_position.Y.Scale, 
        self.start_position.Y.Offset + delta.Y
    )

    -- Use RunService for smoother dragging
    RunService:BindToRenderStep("DragUI", Enum.RenderPriority.Input.Value, function()
        self.container.Container.Position = position
        self.container.Shadow.Position = position
    end)
end

-- Toggle UI visibility
function Library:visible()
    self.enabled = not self.enabled

    if self.enabled then
        self:open()
    else
        self:close()
    end
end

-- Create a new UI instance
function Library:new()
    local container = Instance.new("ScreenGui")
    container.Name = "Astral"
    container.Parent = CoreGui
    container.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    container.ResetOnSpawn = false

    Library.core = container

    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.Parent = container
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Shadow.BackgroundTransparency = 1.000
    Shadow.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.BorderSizePixel = 0
    Shadow.Position = UDim2.new(0.508668244, 0, 0.5, 0)
    Shadow.Size = UDim2.new(0, 776, 0, 509)
    Shadow.ZIndex = 0
    Shadow.Image = "rbxassetid://17290899982"

    local Container = Instance.new("Frame")
    Container.Name = "Container"
    Container.Parent = container
    Container.AnchorPoint = Vector2.new(0.5, 0.5)
    Container.BackgroundColor3 = Color3.fromRGB(19, 20, 24)
    Container.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Container.BorderSizePixel = 0
    Container.ClipsDescendants = true
    Container.Position = UDim2.new(0.5, 0, 0.5, 0)
    Container.Size = UDim2.new(0, 699, 0, 426)

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 20)
    ContainerCorner.Parent = Container

    local Top = Instance.new("ImageLabel")
    Top.Name = "Top"
    Top.Parent = Container
    Top.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Top.BackgroundTransparency = 1.000
    Top.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Top.BorderSizePixel = 0
    Top.Size = UDim2.new(0, 699, 0, 39)
    Top.Image = ""

    local Logo = Instance.new("ImageLabel")
    Logo.Name = "Logo"
    Logo.Parent = Top
    Logo.AnchorPoint = Vector2.new(0.5, 0.5)
    Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Logo.BackgroundTransparency = 1.000
    Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Logo.BorderSizePixel = 0
    Logo.Position = UDim2.new(0.0387367606, 0, 0.5, 0)
    Logo.Size = UDim2.new(0, 30, 0, 25)
    Logo.Image = ""
    
    local TextLabel = Instance.new("TextLabel")
    TextLabel.Parent = Top
    TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
    TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.BackgroundTransparency = 1.000
    TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    TextLabel.BorderSizePixel = 0
    TextLabel.Position = UDim2.new(0.0938254446, 0, 0.496794879, 0)
    TextLabel.Size = UDim2.new(0, 75, 0, 16)
    TextLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
    TextLabel.Text = getgenv().namehub or "Astral Hub"
    TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    TextLabel.TextScaled = true
    TextLabel.TextSize = 14.000
    TextLabel.TextWrapped = true
    TextLabel.TextXAlignment = Enum.TextXAlignment.Left

    local Line = Instance.new("Frame")
    Line.Name = "Line"
    Line.Parent = Container
    Line.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
    Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Line.BorderSizePixel = 0
    Line.Position = UDim2.new(0.296137333, 0, 0.0915492922, 0)
    Line.Size = UDim2.new(0, 2, 0, 387)

    local tabs = Instance.new("ScrollingFrame")
    tabs.Name = "Tabs"
    tabs.Active = true
    tabs.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    tabs.BackgroundTransparency = 1.000
    tabs.BorderColor3 = Color3.fromRGB(0, 0, 0)
    tabs.BorderSizePixel = 0
    tabs.Position = UDim2.new(0, 0, 0.0915492922, 0)
    tabs.Size = UDim2.new(0, 209, 0, 386)
    tabs.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
    tabs.ScrollBarThickness = 0
    tabs.Parent = Container

    local tabslist = Instance.new("UIListLayout")
    tabslist.Parent = tabs
    tabslist.HorizontalAlignment = Enum.HorizontalAlignment.Center
    tabslist.SortOrder = Enum.SortOrder.LayoutOrder
    tabslist.Padding = UDim.new(0, 9)

    local UIPadding = Instance.new("UIPadding")
    UIPadding.Parent = tabs
    UIPadding.PaddingTop = UDim.new(0, 15)

    local tabsCorner = Instance.new("UICorner")
    tabsCorner.Parent = tabs

    -- Improved mobile button with better visuals
    local mobile_button = Instance.new("TextButton")
    mobile_button.Name = "Mobile"
    mobile_button.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
    mobile_button.BorderColor3 = Color3.fromRGB(0, 0, 0)
    mobile_button.BorderSizePixel = 0
    mobile_button.Position = UDim2.new(0.0210955422, 0, 0.91790241, 0)
    mobile_button.Size = UDim2.new(0, 122, 0, 38)
    mobile_button.AutoButtonColor = false
    mobile_button.Modal = true
    mobile_button.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
    mobile_button.Text = ""
    mobile_button.TextColor3 = Color3.fromRGB(0, 0, 0)
    mobile_button.TextSize = 14.000
    mobile_button.Parent = container
    mobile_button.Draggable = true

    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 13)
    UICorner.Parent = mobile_button

    local shadowMobile = Instance.new("ImageLabel")
    shadowMobile.Name = "Shadow"
    shadowMobile.Parent = mobile_button
    shadowMobile.AnchorPoint = Vector2.new(0.5, 0.5)
    shadowMobile.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    shadowMobile.BackgroundTransparency = 1.000
    shadowMobile.BorderColor3 = Color3.fromRGB(0, 0, 0)
    shadowMobile.BorderSizePixel = 0
    shadowMobile.Position = UDim2.new(0.5, 0, 0.5, 0)
    shadowMobile.Size = UDim2.new(0, 144, 0, 58)
    shadowMobile.ZIndex = 0
    shadowMobile.Image = "rbxassetid://17183270335"
    shadowMobile.ImageTransparency = 0.200

    local State = Instance.new("TextLabel")
    State.Name = "State"
    State.Parent = mobile_button
    State.AnchorPoint = Vector2.new(0.5, 0.5)
    State.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    State.BackgroundTransparency = 1.000
    State.BorderColor3 = Color3.fromRGB(0, 0, 0)
    State.BorderSizePixel = 0
    State.Position = UDim2.new(0.646000028, 0, 0.5, 0)
    State.Size = UDim2.new(0, 64, 0, 15)
    State.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
    State.Text = "Show"
    State.TextColor3 = Color3.fromRGB(255, 255, 255)
    State.TextScaled = true
    State.TextSize = 14.000
    State.TextWrapped = true
    State.TextXAlignment = Enum.TextXAlignment.Left

    local Icon = Instance.new("ImageLabel")
    Icon.Name = "Icon"
    Icon.Parent = mobile_button
    Icon.AnchorPoint = Vector2.new(0.5, 0.5)
    Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Icon.BackgroundTransparency = 1.000
    Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
    Icon.BorderSizePixel = 0
    Icon.Position = UDim2.new(0.268000007, 0, 0.5, 0)
    Icon.Size = UDim2.new(0, 15, 0, 15)
    Icon.Image = "rbxassetid://10734975692"

    -- Improved hover effect for mobile button
    mobile_button.MouseEnter:Connect(function()
        TweenService:Create(mobile_button, ANIMATION_PRESETS.FAST, {
            BackgroundColor3 = Color3.fromRGB(37, 38, 43)
        }):Play()
    end)

    mobile_button.MouseLeave:Connect(function()
        TweenService:Create(mobile_button, ANIMATION_PRESETS.FAST, {
            BackgroundColor3 = Color3.fromRGB(27, 28, 33)
        }):Play()
    end)

    -- Improved dragging with smoother transitions
    Container.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Library.dragging = true
            Library.drag_position = input.Position
            Library.start_position = Container.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Library.dragging = false
                    Library.drag_position = nil
                    Library.start_position = nil
                    RunService:UnbindFromRenderStep("DragUI")
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            if Library.dragging then
                Library.drag({
                    input = input,
                    container = container
                })
            end
        end
    end)

    -- Toggle UI with Insert key
    UserInputService.InputBegan:Connect(function(input, process)
        if process then return end

        if not Library:exist() then return end

        if input.KeyCode == Enum.KeyCode.Insert then
            Library.visible(container)
        end
    end)

    -- Toggle UI with mobile button
    mobile_button.MouseButton1Click:Connect(function()
        Library.visible(container)
        
        -- Update button text based on state
        State.Text = Library.enabled and "Hide" or "Show"
    end)

    local Tab = {}

    -- Update sections visibility
    function Tab:update_sections()
        self.left_section.Visible = true
        self.right_section.Visible = true

        for _, object in ipairs(Container:GetChildren()) do
            if not object.Name:find("Section") then
                continue
            end

            if object == self.left_section or object == self.right_section then 
                continue
            end

            object.Visible = false
        end
    end

    -- Open tab with smooth animations
    function Tab:open_tab()
        Tab.update_sections({
            left_section = self.left_section,
            right_section = self.right_section
        })

        -- Smoother animations for tab selection
        TweenService:Create(self.tab.Fill, ANIMATION_PRESETS.DEFAULT, {
            BackgroundTransparency = 0
        }):Play()

        TweenService:Create(self.tab.Glow, ANIMATION_PRESETS.DEFAULT, {
            ImageTransparency = 0
        }):Play()

        TweenService:Create(self.tab.TextLabel, ANIMATION_PRESETS.DEFAULT, {
            TextTransparency = 0
        }):Play()

        TweenService:Create(self.tab.Logo, ANIMATION_PRESETS.DEFAULT, {
            ImageTransparency = 0
        }):Play()

        -- Fade out other tabs
        for _, object in ipairs(tabs:GetChildren()) do
            if object.Name ~= 'Tab' then
                continue
            end

            if object == self.tab then
                continue
            end

            TweenService:Create(object.Fill, ANIMATION_PRESETS.DEFAULT, {
                BackgroundTransparency = 1
            }):Play()

            TweenService:Create(object.Glow, ANIMATION_PRESETS.DEFAULT, {
                ImageTransparency = 1
            }):Play()
    
            TweenService:Create(object.TextLabel, ANIMATION_PRESETS.DEFAULT, {
                TextTransparency = 0.5
            }):Play()
    
            TweenService:Create(object.Logo, ANIMATION_PRESETS.DEFAULT, {
                ImageTransparency = 0.5
            }):Play()
        end
    end

    -- Create a new tab
    function Tab:create_tab()
        local tab = Instance.new("TextButton")
        tab.Name = "Tab"
        tab.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
        tab.BorderColor3 = Color3.fromRGB(0, 0, 0)
        tab.BorderSizePixel = 0
        tab.Size = UDim2.new(0, 174, 0, 40)
        tab.ZIndex = 2
        tab.AutoButtonColor = false
        tab.Font = Enum.Font.SourceSans
        tab.Text = ""
        tab.TextColor3 = Color3.fromRGB(0, 0, 0)
        tab.TextSize = 14.000
        tab.Parent = tabs

        -- Add hover effect to tabs
        tab.MouseEnter:Connect(function()
            if tab:FindFirstChild("Fill") and tab.Fill.BackgroundTransparency == 1 then
                TweenService:Create(tab, ANIMATION_PRESETS.FAST, {
                    BackgroundColor3 = Color3.fromRGB(32, 33, 38)
                }):Play()
            end
        end)

        tab.MouseLeave:Connect(function()
            TweenService:Create(tab, ANIMATION_PRESETS.FAST, {
                BackgroundColor3 = Color3.fromRGB(27, 28, 33)
            }):Play()
        end)

        local tabCorner = Instance.new("UICorner")
        tabCorner.CornerRadius = UDim.new(0, 5)
        tabCorner.Parent = tab

        local TextLabel = Instance.new("TextLabel")
        TextLabel.Parent = tab
        TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
        TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.BackgroundTransparency = 1.000
        TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
        TextLabel.BorderSizePixel = 0
        TextLabel.Position = UDim2.new(0.58965224, 0, 0.5, 0)
        TextLabel.Size = UDim2.new(0, 124, 0, 15)
        TextLabel.ZIndex = 3
        TextLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
        TextLabel.Text = self
        TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TextLabel.TextScaled = true
        TextLabel.TextSize = 14.000
        TextLabel.TextTransparency = 0.300
        TextLabel.TextWrapped = true
        TextLabel.TextXAlignment = Enum.TextXAlignment.Left

        local Logo = Instance.new("ImageLabel")
        Logo.Name = "Logo"
        Logo.Parent = tab
        Logo.AnchorPoint = Vector2.new(0.5, 0.5)
        Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Logo.BackgroundTransparency = 1.000
        Logo.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Logo.BorderSizePixel = 0
        Logo.Position = UDim2.new(0.130999997, 0, 0.5, 0)
        Logo.Size = UDim2.new(0, 17, 0, 17)
        Logo.ZIndex = 3
        Logo.Image = "rbxassetid://17290697757"
        Logo.ImageTransparency = 0.3001

        local Glow = Instance.new("ImageLabel")
        Glow.Name = "Glow"
        Glow.Parent = tab
        Glow.AnchorPoint = Vector2.new(0.5, 0.5)
        Glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Glow.BackgroundTransparency = 1.000
        Glow.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Glow.BorderSizePixel = 0
        Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
        Glow.Size = UDim2.new(0, 190, 0, 53)
        Glow.Image = "rbxassetid://17290723539"
        Glow.ImageTransparency = 1.000

        local Fill = Instance.new("Frame")
        Fill.Name = "Fill"
        Fill.Parent = tab
        Fill.AnchorPoint = Vector2.new(0.5, 0.5)
        Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Fill.BackgroundTransparency = 1.000
        Fill.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Fill.BorderSizePixel = 0
        Fill.Position = UDim2.new(0.5, 0, 0.5, 0)
        Fill.Size = UDim2.new(0, 174, 0, 40)
        Fill.ZIndex = 2
        
        local UICorner_2 = Instance.new("UICorner")
        UICorner_2.CornerRadius = UDim.new(0, 10)
        UICorner_2.Parent = Fill

        local UIGradient = Instance.new("UIGradient")
        UIGradient.Color = ColorSequence.new{
            ColorSequenceKeypoint.new(0.00, Color3.fromRGB(66, 89, 182)), 
            ColorSequenceKeypoint.new(1.00, Color3.fromRGB(37, 57, 137))
        }
        UIGradient.Rotation = 20
        UIGradient.Parent = Fill

        local left_section = Instance.new("ScrollingFrame")
        left_section.Name = "LeftSection"
        left_section.Active = true
        left_section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        left_section.BackgroundTransparency = 1.000
        left_section.BorderColor3 = Color3.fromRGB(0, 0, 0)
        left_section.BorderSizePixel = 0
        left_section.Position = UDim2.new(0.326180249, 0, 0.126760557, 0)
        left_section.Size = UDim2.new(0, 215, 0, 372)
        left_section.AutomaticCanvasSize = Enum.AutomaticSize.Y
        left_section.CanvasSize = UDim2.new(0, 0, 0, 0)
        left_section.ScrollBarImageColor3 = Color3.fromRGB(66, 89, 182)
        left_section.ScrollBarThickness = 3
        left_section.ScrollBarImageTransparency = 0.7

        local leftsectionlist = Instance.new("UIListLayout")
        leftsectionlist.Parent = left_section
        leftsectionlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
        leftsectionlist.SortOrder = Enum.SortOrder.LayoutOrder
        leftsectionlist.Padding = UDim.new(0, 7)

        local right_section = Instance.new("ScrollingFrame")
        right_section.Name = "RightSection"
        right_section.Active = true
        right_section.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        right_section.BackgroundTransparency = 1.000
        right_section.BorderColor3 = Color3.fromRGB(0, 0, 0)
        right_section.BorderSizePixel = 0
        right_section.Position = UDim2.new(0.662374794, 0, 0.126760557, 0)
        right_section.Size = UDim2.new(0, 215, 0, 372)
        right_section.AutomaticCanvasSize = Enum.AutomaticSize.Y
        right_section.CanvasSize = UDim2.new(0, 0, 0, 0)
        right_section.ScrollBarImageColor3 = Color3.fromRGB(66, 89, 182)
        right_section.ScrollBarThickness = 3
        right_section.ScrollBarImageTransparency = 0.7

        local rightsectionlist = Instance.new("UIListLayout")
        rightsectionlist.Parent = right_section
        rightsectionlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
        rightsectionlist.SortOrder = Enum.SortOrder.LayoutOrder
        rightsectionlist.Padding = UDim.new(0, 7)

        if Container:FindFirstChild('RightSection') then
            left_section.Visible = false
            right_section.Visible = false
        else
            Tab.open_tab({
                tab = tab,
                left_section = left_section,
                right_section = right_section
            })
        end

        left_section.Parent = Container
        right_section.Parent = Container

        tab.MouseButton1Click:Connect(function()
            Tab.open_tab({
                tab = tab,
                left_section = left_section,
                right_section = right_section
            })
        end)

        local Module = {}

        -- Create a section title
        function Module:create_title()
            local section = self.section == 'left' and left_section or right_section

            local title = Instance.new("TextLabel")
            title.Name = "Title"
            title.AnchorPoint = Vector2.new(0.5, 0.5)
            title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            title.BackgroundTransparency = 1.000
            title.BorderColor3 = Color3.fromRGB(0, 0, 0)
            title.BorderSizePixel = 0
            title.Position = UDim2.new(0.531395316, 0, 0.139784947, 0)
            title.Size = UDim2.new(0, 201, 0, 15)
            title.ZIndex = 2
            title.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
            title.TextColor3 = Color3.fromRGB(255, 255, 255)
            title.TextScaled = true
            title.TextSize = 14.000
            title.TextWrapped = true
            title.TextXAlignment = Enum.TextXAlignment.Left
            title.Parent = section
            title.Text = self.name
        end

        -- Enable toggle with animation
        function Module:enable_toggle()
            TweenService:Create(self.Checkbox.Fill, ANIMATION_PRESETS.DEFAULT, {
                BackgroundTransparency = 0
            }):Play()

            TweenService:Create(self.Checkbox.Glow, ANIMATION_PRESETS.DEFAULT, {
                ImageTransparency = 0
            }):Play()
        end

        -- Disable toggle with animation
        function Module:disable_toggle()
            TweenService:Create(self.Checkbox.Fill, ANIMATION_PRESETS.DEFAULT, {
                BackgroundTransparency = 1
            }):Play()

            TweenService:Create(self.Checkbox.Glow, ANIMATION_PRESETS.DEFAULT, {
                ImageTransparency = 1
            }):Play()
        end

        -- Update toggle state
        function Module:update_toggle()
            if self.state then
                Module.enable_toggle(self.toggle)
            else
                Module.disable_toggle(self.toggle)
            end
        end

        -- Create a toggle element
        function Module:create_toggle()
            local section = self.section == 'left' and left_section or right_section

            local toggle = Instance.new("TextButton")
            toggle.Name = "Toggle"
            toggle.Parent = section
            toggle.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
            toggle.BorderColor3 = Color3.fromRGB(0, 0, 0)
            toggle.BorderSizePixel = 0
            toggle.Size = UDim2.new(0, 215, 0, 37)
            toggle.AutoButtonColor = false
            toggle.Font = Enum.Font.SourceSans
            toggle.Text = ""
            toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
            toggle.TextSize = 14.000
            
            -- Add hover effect
            toggle.MouseEnter:Connect(function()
                TweenService:Create(toggle, ANIMATION_PRESETS.FAST, {
                    BackgroundColor3 = Color3.fromRGB(32, 33, 38)
                }):Play()
            end)

            toggle.MouseLeave:Connect(function()
                TweenService:Create(toggle, ANIMATION_PRESETS.FAST, {
                    BackgroundColor3 = Color3.fromRGB(27, 28, 33)
                }):Play()
            end)
            
            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 10)
            UICorner.Parent = toggle
    
            local Checkbox = Instance.new("Frame")
            Checkbox.Name = "Checkbox"
            Checkbox.Parent = toggle
            Checkbox.AnchorPoint = Vector2.new(0.5, 0.5)
            Checkbox.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
            Checkbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Checkbox.BorderSizePixel = 0
            Checkbox.Position = UDim2.new(0.915000021, 0, 0.5, 0)
            Checkbox.Size = UDim2.new(0, 17, 0, 17)        

            local UICorner_2 = Instance.new("UICorner")
            UICorner_2.CornerRadius = UDim.new(0, 4)
            UICorner_2.Parent = Checkbox

            local Glow = Instance.new("ImageLabel")
            Glow.Name = "Glow"
            Glow.Parent = Checkbox
            Glow.AnchorPoint = Vector2.new(0.5, 0.5)
            Glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Glow.BackgroundTransparency = 1.000
            Glow.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Glow.BorderSizePixel = 0
            Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
            Glow.Size = UDim2.new(0, 27, 0, 27)
            Glow.Image = "rbxassetid://17290798394"
            Glow.ImageTransparency = 1.000

            local Fill = Instance.new("Frame")
            Fill.Name = "Fill"
            Fill.Parent = Checkbox
            Fill.AnchorPoint = Vector2.new(0.5, 0.5)
            Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Fill.BackgroundTransparency = 1.000
            Fill.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Fill.BorderSizePixel = 0
            Fill.Position = UDim2.new(0.5, 0, 0.5, 0)
            Fill.Size = UDim2.new(0, 17, 0, 17)

            local UICorner_3 = Instance.new("UICorner")
            UICorner_3.CornerRadius = UDim.new(0, 4)
            UICorner_3.Parent = Fill

            local UIGradient = Instance.new("UIGradient")
            UIGradient.Color = ColorSequence.new{
                ColorSequenceKeypoint.new(0.00, Color3.fromRGB(66, 89, 182)), 
                ColorSequenceKeypoint.new(1.00, Color3.fromRGB(37, 57, 137))
            }
            UIGradient.Rotation = 20
            UIGradient.Parent = Fill

            local TextLabel = Instance.new("TextLabel")
            TextLabel.Parent = toggle
            TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BackgroundTransparency = 1.000
            TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.BorderSizePixel = 0
            TextLabel.Position = UDim2.new(0.444953382, 0, 0.5, 0)
            TextLabel.Size = UDim2.new(0, 164, 0, 15)
            TextLabel.ZIndex = 2
            TextLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.TextScaled = true
            TextLabel.TextSize = 14.000
            TextLabel.TextWrapped = true
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left
            TextLabel.Text = self.name

            if not Library.Flags[self.flag] then
                Library.Flags[self.flag] = self.enabled
            end

            self.callback(Library.Flags[self.flag])
            
            Module.update_toggle({
                state = Library.Flags[self.flag],
                toggle = toggle
            })

            toggle.MouseButton1Click:Connect(function()
                Library.Flags[self.flag] = not Library.Flags[self.flag]
                Library.save_flags()

                Module.update_toggle({
                    state = Library.Flags[self.flag],
                    toggle = toggle
                })

                self.callback(Library.Flags[self.flag])
            end)
        end

        -- Update slider value
        function Module:update_slider()
            local result = math.clamp((Mouse.X - self.slider.Box.AbsolutePosition.X) / self.slider.Box.AbsoluteSize.X, 0, 1)

            if not result then
                return
            end

            local number = math.floor(((self.maximum_value - self.minimum_value) * result) + self.minimum_value)
            local slider_size = math.clamp(result, 0.001, 0.999)
            
            self.slider.Box.Fill.UIGradient.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(slider_size, 0),
                NumberSequenceKeypoint.new(math.min(slider_size + 0.001, 1), 1),
                NumberSequenceKeypoint.new(1, 1)
            })
            
            self.slider.Box.Glow.UIGradient.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(slider_size, 0),
                NumberSequenceKeypoint.new(math.min(slider_size + 0.03, 1), 1),
                NumberSequenceKeypoint.new(1, 1)
            })

            Library.Flags[self.flag] = number

            self.slider.Number.Text = number
            self.callback(number)
        end

        -- Slider drag loop
        function Module:slider_loop()
            Library.slider_drag = true
            
            while Library.slider_drag do
                Module.update_slider(self)
                task.wait()
            end
        end

        -- Create a slider element
        function Module:create_slider()
            local section = self.section == 'left' and left_section or right_section

            local slider = Instance.new("TextButton")
            slider.Name = "Slider"
            slider.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
            slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
            slider.BorderSizePixel = 0
            slider.Size = UDim2.new(0, 215, 0, 48)
            slider.AutoButtonColor = false
            slider.Font = Enum.Font.SourceSans
            slider.Text = ""
            slider.TextColor3 = Color3.fromRGB(0, 0, 0)
            slider.TextSize = 14.000
            slider.Parent = section

            -- Add hover effect
            slider.MouseEnter:Connect(function()
                TweenService:Create(slider, ANIMATION_PRESETS.FAST, {
                    BackgroundColor3 = Color3.fromRGB(32, 33, 38)
                }):Play()
            end)

            slider.MouseLeave:Connect(function()
                TweenService:Create(slider, ANIMATION_PRESETS.FAST, {
                    BackgroundColor3 = Color3.fromRGB(27, 28, 33)
                }):Play()
            end)

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 10)
            UICorner.Parent = slider

            local Box = Instance.new("Frame")
            Box.Name = "Box"
            Box.Parent = slider
            Box.AnchorPoint = Vector2.new(0.5, 0.5)
            Box.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
            Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Box.BorderSizePixel = 0
            Box.Position = UDim2.new(0.508023143, 0, 0.708333313, 0)
            Box.Size = UDim2.new(0, 192, 0, 6)

            local UICorner_2 = Instance.new("UICorner")
            UICorner_2.CornerRadius = UDim.new(0, 15)
            UICorner_2.Parent = Box

            local Glow = Instance.new("ImageLabel")
            Glow.Name = "Glow"
            Glow.Parent = Box
            Glow.AnchorPoint = Vector2.new(0.5, 0.5)
            Glow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Glow.BackgroundTransparency = 1.000
            Glow.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Glow.BorderSizePixel = 0
            Glow.Position = UDim2.new(0.5, 0, 0.5, 0)
            Glow.Size = UDim2.new(0, 204, 0, 17)
            Glow.ZIndex = 2
            Glow.Image = "rbxassetid://17381990533"

            local UIGradient = Instance.new("UIGradient")
            UIGradient.Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0.00, 0.00), 
                NumberSequenceKeypoint.new(0.50, 0.00), 
                NumberSequenceKeypoint.new(0.53, 1.00), 
                NumberSequenceKeypoint.new(1.00, 1.00)
            }
            UIGradient.Parent = Glow

            local Fill = Instance.new("ImageLabel")
            Fill.Name = "Fill"
            Fill.Parent = Box
            Fill.AnchorPoint = Vector2.new(0, 0.5)
            Fill.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Fill.BackgroundTransparency = 1.000
            Fill.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Fill.BorderSizePixel = 0
            Fill.Position = UDim2.new(0, 0, 0.5, 0)
            Fill.Size = UDim2.new(0, 192, 0, 6)
            Fill.Image = "rbxassetid://17382033116"

            local UICorner_3 = Instance.new("UICorner")
            UICorner_3.CornerRadius = UDim.new(0, 4)
            UICorner_3.Parent = Fill

            local UIGradient_2 = Instance.new("UIGradient")
            UIGradient_2.Transparency = NumberSequence.new{
                NumberSequenceKeypoint.new(0.00, 0.00), 
                NumberSequenceKeypoint.new(0.50, 0.00), 
                NumberSequenceKeypoint.new(0.50, 1.00), 
                NumberSequenceKeypoint.new(1.00, 1.00)
            }
            UIGradient_2.Parent = Fill
            
            local Hitbox = Instance.new("TextButton")
            Hitbox.Name = "Hitbox"
            Hitbox.Parent = Box
            Hitbox.AnchorPoint = Vector2.new(0.5, 0.5)
            Hitbox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Hitbox.BackgroundTransparency = 1.000
            Hitbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Hitbox.BorderSizePixel = 0
            Hitbox.Position = UDim2.new(0.5, 0, 0.5, 0)
            Hitbox.Size = UDim2.new(0, 200, 0, 13)
            Hitbox.ZIndex = 3
            Hitbox.AutoButtonColor = false
            Hitbox.Font = Enum.Font.SourceSans
            Hitbox.Text = ""
            Hitbox.TextColor3 = Color3.fromRGB(0, 0, 0)
            Hitbox.TextSize = 14.000

            local TextLabel = Instance.new("TextLabel")
            TextLabel.Parent = slider
            TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BackgroundTransparency = 1.000
            TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.BorderSizePixel = 0
            TextLabel.Position = UDim2.new(0.414720833, 0, 0.375, 0)
            TextLabel.Size = UDim2.new(0, 151, 0, 15)
            TextLabel.ZIndex = 2
            TextLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.TextScaled = true
            TextLabel.TextSize = 14.000
            TextLabel.TextWrapped = true
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left

            local Number = Instance.new("TextLabel")
            Number.Name = "Number"
            Number.Parent = slider
            Number.AnchorPoint = Vector2.new(0.5, 0.5)
            Number.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Number.BackgroundTransparency = 1.000
            Number.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Number.BorderSizePixel = 0
            Number.Position = UDim2.new(0.854255736, 0, 0.375, 0)
            Number.Size = UDim2.new(0, 38, 0, 15)
            Number.ZIndex = 2
            Number.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
            Number.TextColor3 = Color3.fromRGB(255, 255, 255)
            Number.TextScaled = true
            Number.TextSize = 14.000
            Number.TextWrapped = true
            Number.TextXAlignment = Enum.TextXAlignment.Right

            TextLabel.Text = self.name
            Number.Text = self.value

            if not Library.Flags[self.flag] then
                Library.Flags[self.flag] = self.value
            end

            slider.Number.Text = Library.Flags[self.flag]
            self.callback(Library.Flags[self.flag])

            -- Initialize slider position based on current value
            local initialValue = (Library.Flags[self.flag] - self.minimum_value) / (self.maximum_value - self.minimum_value)
            local initialSliderSize = math.clamp(initialValue, 0.001, 0.999)
            
            slider.Box.Fill.UIGradient.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(initialSliderSize, 0),
                NumberSequenceKeypoint.new(math.min(initialSliderSize + 0.001, 1), 1),
                NumberSequenceKeypoint.new(1, 1)
            })
            
            slider.Box.Glow.UIGradient.Transparency = NumberSequence.new({
                NumberSequenceKeypoint.new(0, 0),
                NumberSequenceKeypoint.new(initialSliderSize, 0),
                NumberSequenceKeypoint.new(math.min(initialSliderSize + 0.03, 1), 1),
                NumberSequenceKeypoint.new(1, 1)
            })

            slider.Box.Hitbox.MouseButton1Down:Connect(function()
                if Library.slider_drag then
                    return
                end

                Module.slider_loop({
                    slider = slider,
                    flag = self.flag,
                    callback = self.callback,
                    maximum_value = self.maximum_value,
                    minimum_value = self.minimum_value,
                })
            end)
            
            UserInputService.InputEnded:Connect(function(input, process)
                if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                    if Library.slider_drag then
                        Library.slider_drag = false
                        Library.save_flags()
                    end
                end
            end)
        end

        -- Create a dropdown element
        function Module:create_dropdown()
            local section = self.section == 'left' and left_section or right_section
            local list_size = 6
            local open = false

            local option = Instance.new("TextButton")
            option.Name = "Option"
            option.Active = false
            option.AnchorPoint = Vector2.new(0.5, 0.5)
            option.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            option.BackgroundTransparency = 1.000
            option.BorderColor3 = Color3.fromRGB(0, 0, 0)
            option.BorderSizePixel = 0
            option.Position = UDim2.new(0.47283414, 0, 0.309523821, 0)
            option.Selectable = false
            option.Size = UDim2.new(0, 176, 0, 13)
            option.ZIndex = 2
            option.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
            option.TextColor3 = Color3.fromRGB(255, 255, 255)
            option.TextScaled = true
            option.TextSize = 14.000
            option.TextTransparency = 0.500
            option.TextWrapped = true
            option.TextXAlignment = Enum.TextXAlignment.Left

            local dropdown = Instance.new("TextButton")
            dropdown.Parent = section
            dropdown.Name = "Dropdown"
            dropdown.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
            dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
            dropdown.BorderSizePixel = 0
            dropdown.Size = UDim2.new(0, 215, 0, 36)
            dropdown.AutoButtonColor = false
            dropdown.Font = Enum.Font.SourceSans
            dropdown.Text = ""
            dropdown.TextColor3 = Color3.fromRGB(0, 0, 0)
            dropdown.TextSize = 14.000

            -- Add hover effect
            dropdown.MouseEnter:Connect(function()
                if not open then
                    TweenService:Create(dropdown, ANIMATION_PRESETS.FAST, {
                        BackgroundColor3 = Color3.fromRGB(32, 33, 38)
                    }):Play()
                end
            end)

            dropdown.MouseLeave:Connect(function()
                if not open then
                    TweenService:Create(dropdown, ANIMATION_PRESETS.FAST, {
                        BackgroundColor3 = Color3.fromRGB(27, 28, 33)
                    }):Play()
                end
            end)

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 10)
            UICorner.Parent = dropdown

            local UIListLayout = Instance.new("UIListLayout")
            UIListLayout.Parent = dropdown
            UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            
            local UIPadding = Instance.new("UIPadding")
            UIPadding.Parent = dropdown
            UIPadding.PaddingTop = UDim.new(0, 6)
            
            local Box = Instance.new("Frame")
            Box.Name = "Box"
            Box.Parent = dropdown
            Box.AnchorPoint = Vector2.new(0.5, 0)
            Box.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
            Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Box.BorderSizePixel = 0
            Box.Position = UDim2.new(0.5, 0, 0.150000006, 0)
            Box.Size = UDim2.new(0, 202, 0, 25)
            Box.ZIndex = 2

            local UICorner_2 = Instance.new("UICorner")
            UICorner_2.CornerRadius = UDim.new(0, 6)
            UICorner_2.Parent = Box

            local Options = Instance.new("Frame")
            Options.Name = "Options"
            Options.Parent = Box
            Options.AnchorPoint = Vector2.new(0.5, 0)
            Options.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
            Options.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Options.BorderSizePixel = 0
            Options.ClipsDescendants = true
            Options.Position = UDim2.new(0.5, 0, 0.75999999, 0)
            Options.Size = UDim2.new(0, 202, 0, 0)

            local UICorner_3 = Instance.new("UICorner")
            UICorner_3.CornerRadius = UDim.new(0, 6)
            UICorner_3.Parent = Options

            local UIPadding_2 = Instance.new("UIPadding")
            UIPadding_2.Parent = Options
            UIPadding_2.PaddingLeft = UDim.new(0, 15)
            UIPadding_2.PaddingTop = UDim.new(0, 10)

            local UIListLayout_2 = Instance.new("UIListLayout")
            UIListLayout_2.Parent = Options
            UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout_2.Padding = UDim.new(0, 10)

            local TextLabel = Instance.new("TextLabel")
            TextLabel.Parent = Box
            TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BackgroundTransparency = 1.000
            TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.BorderSizePixel = 0
            TextLabel.Position = UDim2.new(0.430000007, 0, 0.5, 0)
            TextLabel.Size = UDim2.new(0, 151, 0, 13)
            TextLabel.ZIndex = 2
            TextLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.TextScaled = true
            TextLabel.TextSize = 14.000
            TextLabel.TextWrapped = true
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left

            local Arrow = Instance.new("ImageLabel")
            Arrow.Name = "Arrow"
            Arrow.Parent = Box
            Arrow.Active = true
            Arrow.AnchorPoint = Vector2.new(0.5, 0.5)
            Arrow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Arrow.BackgroundTransparency = 1.000
            Arrow.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Arrow.BorderSizePixel = 0
            Arrow.Position = UDim2.new(0.920000017, 0, 0.5, 0)
            Arrow.Size = UDim2.new(0, 12, 0, 12)
            Arrow.ZIndex = 2
            Arrow.Image = "rbxassetid://17400678941"

            dropdown.Box.TextLabel.Text = self.name

            local Dropdown = {}

            -- Open dropdown with animation
            function Dropdown:open()
                open = true
                dropdown.Box.TextLabel.Text = Library.Flags[self.flag]

                TweenService:Create(dropdown.Box.Options, ANIMATION_PRESETS.DEFAULT, {
                    Size = UDim2.new(0, 202, 0, list_size)
                }):Play()

                TweenService:Create(dropdown, ANIMATION_PRESETS.DEFAULT, {
                    Size = UDim2.new(0, 215, 0, 30 + list_size),
                    BackgroundColor3 = Color3.fromRGB(32, 33, 38)
                }):Play()

                TweenService:Create(dropdown.Box.Arrow, ANIMATION_PRESETS.DEFAULT, {
                    Rotation = 180
                }):Play()
            end
            
            -- Close dropdown with animation
            function Dropdown:close()
                open = false
                dropdown.Box.TextLabel.Text = self.name
                
                TweenService:Create(dropdown.Box.Options, ANIMATION_PRESETS.DEFAULT, {
                    Size = UDim2.new(0, 202, 0, 0)
                }):Play()

                TweenService:Create(dropdown, ANIMATION_PRESETS.DEFAULT, {
                    Size = UDim2.new(0, 215, 0, 36),
                    BackgroundColor3 = Color3.fromRGB(27, 28, 33)
                }):Play()

                TweenService:Create(dropdown.Box.Arrow, ANIMATION_PRESETS.DEFAULT, {
                    Rotation = 0
                }):Play()
            end

            -- Clear dropdown options
            function Dropdown:clear()
                for _, object in ipairs(dropdown.Box.Options:GetChildren()) do
                    if object.Name ~= 'Option' then
                        continue
                    end

                    object:Destroy()
                end
            end

            -- Select an option with animation
            function Dropdown:select_option()
                TweenService:Create(self.new_option, ANIMATION_PRESETS.DEFAULT, {
                    TextTransparency = 0
                }):Play()

                for _, object in ipairs(dropdown.Box.Options:GetChildren()) do
                    if object.Name ~= 'Option' then
                        continue
                    end

                    if object.Text == Library.Flags[self.flag] then
                        continue
                    end

                    TweenService:Create(object, ANIMATION_PRESETS.DEFAULT, {
                        TextTransparency = 0.5
                    }):Play()
                end

                dropdown.Box.TextLabel.Text = self.new_option.Text
            end

            -- Update dropdown options
            function Dropdown:update()
                Dropdown.clear()
                list_size = 6 -- Reset list size

                for _, value in ipairs(self.options) do
                    list_size += 23

                    local new_option = option:Clone()
                    new_option.Parent = dropdown.Box.Options
                    new_option.Text = value
    
                    if value == Library.Flags[self.flag] then
                        new_option.TextTransparency = 0
                    end
    
                    -- Add hover effect to options
                    new_option.MouseEnter:Connect(function()
                        if new_option.TextTransparency ~= 0 then
                            TweenService:Create(new_option, ANIMATION_PRESETS.FAST, {
                                TextTransparency = 0.3
                            }):Play()
                        end
                    end)

                    new_option.MouseLeave:Connect(function()
                        if new_option.TextTransparency ~= 0 then
                            TweenService:Create(new_option, ANIMATION_PRESETS.FAST, {
                                TextTransparency = 0.5
                            }):Play()
                        end
                    end)

                    new_option.MouseButton1Click:Connect(function()
                        Library.Flags[self.flag] = value
                        
                        if open then
                            dropdown.Box.TextLabel.Text = Library.Flags[self.flag]
                        end
                        self.callback(Library.Flags[self.flag])
                        Library.save_flags()

                        Dropdown.select_option({
                            new_option = new_option,
                            flag = self.flag
                        })
                    end)
                end
            end

            if not Library.Flags[self.flag] then
                Library.Flags[self.flag] = self.option
            end
            
            self.callback(Library.Flags[self.flag])
            Dropdown.update(self)

            dropdown.MouseButton1Click:Connect(function()
                open = not open

                if open then
                    Dropdown.open(self)
                else
                    Dropdown.close(self)
                end
            end)

            return Dropdown
        end

        -- Create a textbox element
        function Module:create_textbox()
            local section = self.section == 'left' and left_section or right_section
            local Textbox = {}
            local textbox = Instance.new("TextButton")
            textbox.Name = "TextBox"
            textbox.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
            textbox.BorderColor3 = Color3.fromRGB(0, 0, 0)
            textbox.BorderSizePixel = 0
            textbox.Size = UDim2.new(0, 215, 0, 36)
            textbox.AutoButtonColor = false
            textbox.Font = Enum.Font.SourceSans
            textbox.Text = ""
            textbox.TextColor3 = Color3.fromRGB(0, 0, 0)
            textbox.TextSize = 14.000                
            textbox.Parent = section

            -- Add hover effect
            textbox.MouseEnter:Connect(function()
                TweenService:Create(textbox, ANIMATION_PRESETS.FAST, {
                    BackgroundColor3 = Color3.fromRGB(32, 33, 38)
                }):Play()
            end)

            textbox.MouseLeave:Connect(function()
                TweenService:Create(textbox, ANIMATION_PRESETS.FAST, {
                    BackgroundColor3 = Color3.fromRGB(27, 28, 33)
                }):Play()
            end)

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 10)
            UICorner.Parent = textbox

            local UIListLayout = Instance.new("UIListLayout")
            UIListLayout.Parent = textbox
            UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

            local UIPadding = Instance.new("UIPadding")
            UIPadding.Parent = textbox
            UIPadding.PaddingTop = UDim.new(0, 6)
            
            local Box = Instance.new("Frame")
            Box.Name = "Box"
            Box.Parent = textbox
            Box.AnchorPoint = Vector2.new(0.5, 0)
            Box.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
            Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Box.BorderSizePixel = 0
            Box.Position = UDim2.new(0.5, 0, 0.150000006, 0)
            Box.Size = UDim2.new(0, 202, 0, 25)
            Box.ZIndex = 2

            local UICorner_2 = Instance.new("UICorner")
            UICorner_2.CornerRadius = UDim.new(0, 6)
            UICorner_2.Parent = Box

            local TextHolder = Instance.new("TextBox")
            TextHolder.Name = "TextHolder"
            TextHolder.Parent = Box
            TextHolder.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
            TextHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextHolder.BorderSizePixel = 0
            TextHolder.Position = UDim2.new(0.0445544571, 0, 0.239999995, 0)
            TextHolder.Size = UDim2.new(0, 182, 0, 13)
            TextHolder.ZIndex = 2
            TextHolder.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
            TextHolder.Text = ""
            TextHolder.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextHolder.TextSize = 14.000
            TextHolder.TextXAlignment = Enum.TextXAlignment.Left
            textbox.Box.TextHolder.PlaceholderText = self.name

            -- Add focus effects
            TextHolder.Focused:Connect(function()
                TweenService:Create(Box, ANIMATION_PRESETS.FAST, {
                    BackgroundColor3 = Color3.fromRGB(27, 28, 33)
                }):Play()
            end)

            TextHolder.FocusLost:Connect(function()
                TweenService:Create(Box, ANIMATION_PRESETS.FAST, {
                    BackgroundColor3 = Color3.fromRGB(22, 23, 27)
                }):Play()
                
                self.callback(TextHolder.Text)
                Library.Flags[self.flag] = TextHolder.Text
                Library.save_flags()
            end)

            if not Library.Flags[self.flag] then
                Library.Flags[self.flag] = self.value
            else
                textbox.Box.TextHolder.Text = Library.Flags[self.flag]
            end

            self.callback(Library.Flags[self.flag])

            function Textbox:update(text)
                textbox.Box.TextHolder.Text = text
                Library.Flags[self.flag] = text
                self.callback(text)
            end

            return Textbox
        end

        -- Create a keybind element
        function Module:create_keybind()
            local section = self.section == 'left' and left_section or right_section
            local keybind = Instance.new("TextButton")
            keybind.Name = "Keybind"
            keybind.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
            keybind.BorderColor3 = Color3.fromRGB(0, 0, 0)
            keybind.BorderSizePixel = 0
            keybind.Position = UDim2.new(-0.0186046511, 0, 0.440860212, 0)
            keybind.Size = UDim2.new(0, 215, 0, 37)
            keybind.AutoButtonColor = false
            keybind.Font = Enum.Font.SourceSans
            keybind.Text = ""
            keybind.TextColor3 = Color3.fromRGB(0, 0, 0)
            keybind.TextSize = 14.000
            keybind.Parent = section

            -- Add hover effect
            keybind.MouseEnter:Connect(function()
                TweenService:Create(keybind, ANIMATION_PRESETS.FAST, {
                    BackgroundColor3 = Color3.fromRGB(32, 33, 38)
                }):Play()
            end)

            keybind.MouseLeave:Connect(function()
                TweenService:Create(keybind, ANIMATION_PRESETS.FAST, {
                    BackgroundColor3 = Color3.fromRGB(27, 28, 33)
                }):Play()
            end)

            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 10)
            UICorner.Parent = keybind
            
            local TextLabel = Instance.new("TextLabel")
            TextLabel.Parent = keybind
            TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BackgroundTransparency = 1.000
            TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.BorderSizePixel = 0
            TextLabel.Position = UDim2.new(0.424475819, 0, 0.5, 0)
            TextLabel.Size = UDim2.new(0, 155, 0, 15)
            TextLabel.ZIndex = 2
            TextLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.TextScaled = true
            TextLabel.TextSize = 14.000
            TextLabel.TextWrapped = true
            TextLabel.TextXAlignment = Enum.TextXAlignment.Left

            local Box = Instance.new("Frame")
            Box.Name = "Box"
            Box.Parent = keybind
            Box.AnchorPoint = Vector2.new(0.5, 0.5)
            Box.BackgroundColor3 = Color3.fromRGB(22, 23, 27)
            Box.BorderColor3 = Color3.fromRGB(0, 0, 0)
            Box.BorderSizePixel = 0
            Box.Position = UDim2.new(0.875459313, 0, 0.472972959, 0)
            Box.Size = UDim2.new(0, 27, 0, 21)

            local UICorner_2 = Instance.new("UICorner")
            UICorner_2.CornerRadius = UDim.new(0, 4)
            UICorner_2.Parent = Box
            
            local TextLabel_2 = Instance.new("TextLabel")
            TextLabel_2.Parent = Box
            TextLabel_2.AnchorPoint = Vector2.new(0.5, 0.5)
            TextLabel_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_2.BackgroundTransparency = 1.000
            TextLabel_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel_2.BorderSizePixel = 0
            TextLabel_2.Position = UDim2.new(0.630466938, 0, 0.5, 0)
            TextLabel_2.Size = UDim2.new(0, 29, 0, 15)
            TextLabel_2.ZIndex = 2
            TextLabel_2.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
            TextLabel_2.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel_2.TextScaled = true
            TextLabel_2.TextSize = 14.000
            TextLabel_2.TextWrapped = true

            keybind.TextLabel.Text = self.name
            keybind.Box.TextLabel.Text = self.keycode.Name

            if not Library.Flags[self.flag] then
                Library.Flags[self.flag] = self.keycode.Name
            end

            keybind.MouseButton1Click:Connect(function()
                keybind.Box.TextLabel.Text = '...'
                
                -- Pulse animation while waiting for input
                local pulseAnimation = TweenService:Create(Box, ANIMATION_PRESETS.SLOW, {
                    BackgroundColor3 = Color3.fromRGB(66, 89, 182)
                })
                pulseAnimation:Play()
                
                local a, b = UserInputService.InputBegan:Wait()
                
                -- Reset color
                TweenService:Create(Box, ANIMATION_PRESETS.FAST, {
                    BackgroundColor3 = Color3.fromRGB(22, 23, 27)
                }):Play()
                
                if a.KeyCode.Name ~= 'Unknown' then
                    keybind.Box.TextLabel.Text = a.KeyCode.Name
                    Library.Flags[self.flag] = a.KeyCode.Name
                    Library.save_flags()
                end
            end)

            UserInputService.InputBegan:Connect(function(current, pressed)
                if not pressed then
                    if current.KeyCode.Name == Library.Flags[self.flag] then
                        self.callback(Library.Flags[self.flag])
                    end
                end
            end)
        end

        -- NEW: Create a button element
        function Module:create_button()
            local section = self.section == 'left' and left_section or right_section
            
            local button = Instance.new("TextButton")
            button.Name = "Button"
            button.BackgroundColor3 = Color3.fromRGB(27, 28, 33)
            button.BorderColor3 = Color3.fromRGB(0, 0, 0)
            button.BorderSizePixel = 0
            button.Size = UDim2.new(0, 215, 0, 37)
            button.AutoButtonColor = false
            button.Font = Enum.Font.SourceSans
            button.Text = ""
            button.TextColor3 = Color3.fromRGB(0, 0, 0)
            button.TextSize = 14.000
            button.Parent = section
            
            local UICorner = Instance.new("UICorner")
            UICorner.CornerRadius = UDim.new(0, 10)
            UICorner.Parent = button
            
            local TextLabel = Instance.new("TextLabel")
            TextLabel.Parent = button
            TextLabel.AnchorPoint = Vector2.new(0.5, 0.5)
            TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.BackgroundTransparency = 1.000
            TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
            TextLabel.BorderSizePixel = 0
            TextLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
            TextLabel.Size = UDim2.new(0, 195, 0, 15)
            TextLabel.ZIndex = 2
            TextLabel.FontFace = Font.new("rbxasset://fonts/families/Montserrat.json", Enum.FontWeight.SemiBold)
            TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
            TextLabel.TextScaled = true
            TextLabel.TextSize = 14.000
            TextLabel.TextWrapped = true
            TextLabel.Text = self.name
            
            -- Add hover and click effects
            button.MouseEnter:Connect(function()
                TweenService:Create(button, ANIMATION_PRESETS.FAST, {
                    BackgroundColor3 = Color3.fromRGB(32, 33, 38)
                }):Play()
            end)
            
            button.MouseLeave:Connect(function()
                TweenService:Create(button, ANIMATION_PRESETS.FAST, {
                    BackgroundColor3 = Color3.fromRGB(27, 28, 33)
                }):Play()
            end)
            
            button.MouseButton1Down:Connect(function()
                -- Click animation
                TweenService:Create(button, ANIMATION_PRESETS.FAST, {
                    BackgroundColor3 = Color3.fromRGB(66, 89, 182)
                }):Play()
                
                TweenService:Create(TextLabel, ANIMATION_PRESETS.FAST, {
                    TextColor3 = Color3.fromRGB(255, 255, 255)
                }):Play()
            end)
            
            button.MouseButton1Up:Connect(function()
                -- Release animation
                TweenService:Create(button, ANIMATION_PRESETS.FAST, {
                    BackgroundColor3 = Color3.fromRGB(32, 33, 38)
                }):Play()
                
                TweenService:Create(TextLabel, ANIMATION_PRESETS.FAST, {
                    TextColor3 = Color3.fromRGB(255, 255, 255)
                }):Play()
                
                -- Execute callback
                self.callback()
            end)
            
            -- Create ripple effect on click
            button.MouseButton1Click:Connect(function()
                local ripple = Instance.new("Frame")
                ripple.Name = "Ripple"
                ripple.Parent = button
                ripple.AnchorPoint = Vector2.new(0.5, 0.5)
                ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ripple.BackgroundTransparency = 0.8
                ripple.BorderSizePixel = 0
                ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
                ripple.Size = UDim2.new(0, 0, 0, 0)
                ripple.ZIndex = 1
                
                local UICorner_ripple = Instance.new("UICorner")
                UICorner_ripple.CornerRadius = UDim.new(1, 0)
                UICorner_ripple.Parent = ripple
                
                local mouse_pos = UserInputService:GetMouseLocation()
                local button_pos = button.AbsolutePosition
                local button_size = button.AbsoluteSize
                
                ripple.Position = UDim2.new(0, mouse_pos.X - button_pos.X, 0, mouse_pos.Y - button_pos.Y)
                
                -- Animate ripple
                local ripple_tween = TweenService:Create(ripple, ANIMATION_PRESETS.SLOW, {
                    Size = UDim2.new(0, 250, 0, 250),
                    BackgroundTransparency = 1
                })
                
                ripple_tween:Play()
                ripple_tween.Completed:Connect(function()
                    ripple:Destroy()
                end)
            end)
            
            local Button = {}
            
            function Button:update(text)
                TextLabel.Text = text
            end
            
            function Button:disable()
                button.AutoButtonColor = false
                button.Active = false
                
                TweenService:Create(button, ANIMATION_PRESETS.FAST, {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 45),
                    BackgroundTransparency = 0.3
                }):Play()
                
                TweenService:Create(TextLabel, ANIMATION_PRESETS.FAST, {
                    TextColor3 = Color3.fromRGB(150, 150, 150)
                }):Play()
            end
            
            function Button:enable()
                button.AutoButtonColor = true
                button.Active = true
                
                TweenService:Create(button, ANIMATION_PRESETS.FAST, {
                    BackgroundColor3 = Color3.fromRGB(27, 28, 33),
                    BackgroundTransparency = 0
                }):Play()
                
                TweenService:Create(TextLabel, ANIMATION_PRESETS.FAST, {
                    TextColor3 = Color3.fromRGB(255, 255, 255)
                }):Play()
            end
            
            return Button
        end
        
        return Module
    end
    return Tab
end

return Library
