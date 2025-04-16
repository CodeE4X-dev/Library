--[[
    Enhanced Advanced UI Library for Roblox
    Features:
    - Draggable windows
    - Custom tab icons with assetid support
    - Multiple tabs and sections
    - Animated elements with tweens
    - Customizable themes
    - Comprehensive UI elements
    - ImageDesc module for displaying images with descriptions
]]

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local RunService = game:GetService("RunService")
local TextService = game:GetService("TextService")
local ContentProvider = game:GetService("ContentProvider")

local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

local Library = {
    Theme = {
        BackgroundColor = Color3.fromRGB(20, 20, 30),
        SectionColor = Color3.fromRGB(25, 25, 35),
        TextColor = Color3.fromRGB(255, 255, 255),
        AccentColor = Color3.fromRGB(0, 132, 255),
        OutlineColor = Color3.fromRGB(40, 40, 55),
        InfoColor = Color3.fromRGB(130, 130, 130),
        ToggleOffColor = Color3.fromRGB(60, 60, 75),
        ToggleOnColor = Color3.fromRGB(0, 132, 255),
        HoverColor = Color3.fromRGB(35, 35, 45),
        ErrorColor = Color3.fromRGB(255, 75, 75),
        SuccessColor = Color3.fromRGB(75, 255, 75),
    },
    Flags = {},
    OpenedFrames = {},
    ToggleAnimation = nil,
    Icons = {
        -- Default icons for common tabs
        Home = "rbxassetid://7733960981",
        Settings = "rbxassetid://7734053495",
        Players = "rbxassetid://7733774602",
        Combat = "rbxassetid://7733911388",
        Visuals = "rbxassetid://7733799185",
        Misc = "rbxassetid://7734010505",
    }
}

-- Utility Functions
local Utility = {}

function Utility:Create(instanceType, properties, children)
    local instance = Instance.new(instanceType)
    
    for property, value in pairs(properties or {}) do
        instance[property] = value
    end
    
    for _, child in ipairs(children or {}) do
        child.Parent = instance
    end
    
    return instance
end

function Utility:Tween(instance, properties, duration, style, direction)
    style = style or Enum.EasingStyle.Quad
    direction = direction or Enum.EasingDirection.Out
    
    local tween = TweenService:Create(
        instance,
        TweenInfo.new(duration, style, direction),
        properties
    )
    
    tween:Play()
    
    return tween
end

function Utility:MakeDraggable(frame, handle)
    handle = handle or frame
    
    local dragging = false
    local dragInput, mousePos, framePos
    
    handle.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            mousePos = input.Position
            framePos = frame.Position
            
            -- Highlight effect when dragging
            Utility:Tween(handle, {BackgroundColor3 = Library.Theme.AccentColor}, 0.2)
            
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                    -- Restore original color
                    Utility:Tween(handle, {BackgroundColor3 = Library.Theme.SectionColor}, 0.2)
                end
            end)
        end
    end)
    
    handle.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement then
            dragInput = input
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            Utility:Tween(frame, {Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X, framePos.Y.Scale, framePos.Y.Offset + delta.Y)}, 0.1)
        end
    end)
end

function Utility:Ripple(button)
    local ripple = Utility:Create("Frame", {
        Name = "Ripple",
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = Color3.fromRGB(255, 255, 255),
        BackgroundTransparency = 0.7,
        Position = UDim2.fromOffset(Mouse.X - button.AbsolutePosition.X, Mouse.Y - button.AbsolutePosition.Y),
        Size = UDim2.fromOffset(0, 0),
        ZIndex = button.ZIndex + 1,
        Parent = button
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(1, 0)
        })
    })
    
    local size = math.max(button.AbsoluteSize.X, button.AbsoluteSize.Y) * 2
    Utility:Tween(ripple, {Size = UDim2.fromOffset(size, size), BackgroundTransparency = 1}, 0.5)
    
    task.spawn(function()
        task.wait(0.5)
        ripple:Destroy()
    end)
end

function Utility:PreloadImage(imageId)
    local success, result = pcall(function()
        return ContentProvider:PreloadAsync({imageId})
    end)
    
    return success
end

function Utility:ValidateImageId(imageId)
    if typeof(imageId) ~= "string" then
        return false
    end
    
    if not imageId:match("^rbxassetid://") then
        imageId = "rbxassetid://" .. imageId
    end
    
    return Utility:PreloadImage(imageId), imageId
end

function Utility:FormatNumber(number)
    local formatted = tostring(number)
    local k
    
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if k == 0 then break end
    end
    
    return formatted
end

function Utility:CleanText(text)
    return text:gsub("<[^>]+>", "")
end

-- Main Library Functions
function Library:CreateWindow(title, options)
    title = title or "Enhanced UI Library"
    options = options or {}
    options.Size = options.Size or UDim2.new(0, 650, 0, 450)
    options.Position = options.Position or UDim2.new(0.5, -325, 0.5, -225)
    options.Theme = options.Theme or Library.Theme
    
    -- Update theme if provided
    if options.Theme then
        for key, value in pairs(options.Theme) do
            Library.Theme[key] = value
        end
    end
    
    -- Create ScreenGui
    local ScreenGui = Utility:Create("ScreenGui", {
        Name = "EnhancedUI",
        Parent = game.CoreGui,
        ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
        ResetOnSpawn = false
    })
    
    -- Create Main Frame
    local MainFrame = Utility:Create("Frame", {
        Name = "MainFrame",
        BackgroundColor3 = Library.Theme.BackgroundColor,
        BorderSizePixel = 0,
        Position = options.Position,
        Size = options.Size,
        Parent = ScreenGui
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(0, 8)
        }),
        Utility:Create("Frame", {
            Name = "Shadow",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, -15, 0, -15),
            Size = UDim2.new(1, 30, 1, 30),
            ZIndex = 0
        }, {
            Utility:Create("ImageLabel", {
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(1, 0, 1, 0),
                Image = "rbxassetid://6014261993",
                ImageColor3 = Color3.fromRGB(0, 0, 0),
                ImageTransparency = 0.5,
                ScaleType = Enum.ScaleType.Slice,
                SliceCenter = Rect.new(49, 49, 450, 450),
                ZIndex = 0
            })
        })
    })
    
    -- Create Title Bar
    local TitleBar = Utility:Create("Frame", {
        Name = "TitleBar",
        BackgroundColor3 = Library.Theme.SectionColor,
        BorderSizePixel = 0,
        Size = UDim2.new(1, 0, 0, 40),
        Parent = MainFrame
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(0, 8)
        }),
        Utility:Create("TextLabel", {
            Name = "Title",
            BackgroundTransparency = 1,
            Position = UDim2.new(0, 15, 0, 0),
            Size = UDim2.new(1, -30, 1, 0),
            Font = Enum.Font.GothamBold,
            Text = title,
            TextColor3 = Library.Theme.TextColor,
            TextSize = 18,
            TextXAlignment = Enum.TextXAlignment.Left
        }),
        Utility:Create("TextButton", {
            Name = "CloseButton",
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -40, 0, 0),
            Size = UDim2.new(0, 40, 1, 0),
            Font = Enum.Font.GothamBold,
            Text = "×",
            TextColor3 = Library.Theme.TextColor,
            TextSize = 24
        })
    })
    
    -- Create Tab Container
    local TabContainer = Utility:Create("Frame", {
        Name = "TabContainer",
        BackgroundColor3 = Library.Theme.SectionColor,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 10, 0, 50),
        Size = UDim2.new(0, 160, 1, -60),
        Parent = MainFrame
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(0, 8)
        }),
        Utility:Create("ScrollingFrame", {
            Name = "TabList",
            Active = true,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 10),
            Size = UDim2.new(1, 0, 1, -20),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Library.Theme.AccentColor
        }, {
            Utility:Create("UIListLayout", {
                Padding = UDim.new(0, 5),
                SortOrder = Enum.SortOrder.LayoutOrder
            })
        })
    })
    
    -- Create Content Container
    local ContentContainer = Utility:Create("Frame", {
        Name = "ContentContainer",
        BackgroundColor3 = Library.Theme.SectionColor,
        BorderSizePixel = 0,
        Position = UDim2.new(0, 180, 0, 50),
        Size = UDim2.new(1, -190, 1, -60),
        Parent = MainFrame
    }, {
        Utility:Create("UICorner", {
            CornerRadius = UDim.new(0, 8)
        })
    })
    
    -- Make window draggable
    Utility:MakeDraggable(MainFrame, TitleBar)
    
    -- Close button functionality
    TitleBar.CloseButton.MouseButton1Click:Connect(function()
        Utility:Tween(MainFrame, {Size = UDim2.new(0, MainFrame.Size.X.Offset, 0, 0)}, 0.3)
        task.wait(0.3)
        ScreenGui:Destroy()
    end)
    
    -- Hover effects for close button
    TitleBar.CloseButton.MouseEnter:Connect(function()
        Utility:Tween(TitleBar.CloseButton, {TextColor3 = Color3.fromRGB(255, 100, 100)}, 0.2)
    end)
    
    TitleBar.CloseButton.MouseLeave:Connect(function()
        Utility:Tween(TitleBar.CloseButton, {TextColor3 = Library.Theme.TextColor}, 0.2)
    end)
    
    -- Window object
    local Window = {
        ScreenGui = ScreenGui,
        MainFrame = MainFrame,
        TabContainer = TabContainer,
        ContentContainer = ContentContainer,
        Tabs = {}
    }
    
    -- Create Tab function
    function Window:CreateTab(name, options)
        name = name or "Tab"
        options = options or {}
        options.Icon = options.Icon or nil
        
        local iconId = nil
        
        -- Process icon if provided
        if options.Icon then
            local success, processedId = Utility:ValidateImageId(options.Icon)
            if success then
                iconId = processedId
            elseif Library.Icons[options.Icon] then
                iconId = Library.Icons[options.Icon]
            end
        end
        
        -- Create Tab Button
        local TabButton = Utility:Create("TextButton", {
            Name = name.."Tab",
            BackgroundColor3 = Library.Theme.BackgroundColor,
            BorderSizePixel = 0,
            Size = UDim2.new(1, -10, 0, 40),
            Position = UDim2.new(0, 5, 0, 0),
            Font = Enum.Font.GothamSemibold,
            Text = iconId and "   " .. name or name,
            TextColor3 = Library.Theme.TextColor,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = TabContainer.TabList
        }, {
            Utility:Create("UICorner", {
                CornerRadius = UDim.new(0, 6)
            })
        })
        
        -- Add icon if provided
        if iconId then
            local Icon = Utility:Create("ImageLabel", {
                Name = "Icon",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 10, 0.5, -8),
                Size = UDim2.new(0, 16, 0, 16),
                Image = iconId,
                ImageColor3 = Library.Theme.TextColor,
                Parent = TabButton
            })
            
            -- Update text position
            TabButton.TextXAlignment = Enum.TextXAlignment.Left
            TabButton.Text = "      " .. name
        end
        
        -- Create Tab Content
        local TabContent = Utility:Create("ScrollingFrame", {
            Name = name.."Content",
            Active = true,
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Position = UDim2.new(0, 0, 0, 0),
            Size = UDim2.new(1, 0, 1, 0),
            CanvasSize = UDim2.new(0, 0, 0, 0),
            ScrollBarThickness = 3,
            ScrollBarImageColor3 = Library.Theme.AccentColor,
            Visible = false,
            Parent = ContentContainer
        }, {
            Utility:Create("UIListLayout", {
                Padding = UDim.new(0, 10),
                SortOrder = Enum.SortOrder.LayoutOrder,
                HorizontalAlignment = Enum.HorizontalAlignment.Center
            }),
            Utility:Create("UIPadding", {
                PaddingTop = UDim.new(0, 10),
                PaddingBottom = UDim.new(0, 10),
                PaddingLeft = UDim.new(0, 10),
                PaddingRight = UDim.new(0, 10)
            })
        })
        
        -- Update canvas size when elements are added
        TabContent.ChildAdded:Connect(function()
            TabContent.CanvasSize = UDim2.new(0, 0, 0, TabContent.UIListLayout.AbsoluteContentSize.Y + 20)
        end)
        
        -- Tab button functionality
        TabButton.MouseButton1Click:Connect(function()
            -- Hide all tab contents
            for _, tab in pairs(Window.Tabs) do
                tab.Content.Visible = false
                Utility:Tween(tab.Button, {BackgroundColor3 = Library.Theme.BackgroundColor}, 0.2)
                
                -- Update icon color if exists
                local icon = tab.Button:FindFirstChild("Icon")
                if icon then
                    Utility:Tween(icon, {ImageColor3 = Library.Theme.TextColor}, 0.2)
                end
            end
            
            -- Show selected tab content
            TabContent.Visible = true
            Utility:Tween(TabButton, {BackgroundColor3 = Library.Theme.AccentColor}, 0.2)
            
            -- Update icon color if exists
            local icon = TabButton:FindFirstChild("Icon")
            if icon then
                Utility:Tween(icon, {ImageColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
            end
            
            -- Ripple effect
            Utility:Ripple(TabButton)
        end)
        
        -- Hover effects
        TabButton.MouseEnter:Connect(function()
            if not TabContent.Visible then
                Utility:Tween(TabButton, {BackgroundColor3 = Library.Theme.HoverColor}, 0.2)
            end
        end)
        
        TabButton.MouseLeave:Connect(function()
            if not TabContent.Visible then
                Utility:Tween(TabButton, {BackgroundColor3 = Library.Theme.BackgroundColor}, 0.2)
            end
        end)
        
        -- Update TabList canvas size
        TabContainer.TabList.CanvasSize = UDim2.new(0, 0, 0, TabContainer.TabList.UIListLayout.AbsoluteContentSize.Y + 10)
        
        -- Select first tab by default
        if #Window.Tabs == 0 then
            TabContent.Visible = true
            TabButton.BackgroundColor3 = Library.Theme.AccentColor
            
            -- Update icon color if exists
            local icon = TabButton:FindFirstChild("Icon")
            if icon then
                icon.ImageColor3 = Color3.fromRGB(255, 255, 255)
            end
        end
        
        -- Tab object
        local Tab = {
            Button = TabButton,
            Content = TabContent
        }
        
        table.insert(Window.Tabs, Tab)
        
        -- Create Section function
        function Tab:CreateSection(name)
            name = name or "Section"
            
            -- Create Section Frame
            local SectionFrame = Utility:Create("Frame", {
                Name = name.."Section",
                BackgroundColor3 = Library.Theme.BackgroundColor,
                BorderSizePixel = 0,
                Size = UDim2.new(1, -20, 0, 40),
                AutomaticSize = Enum.AutomaticSize.Y,
                Parent = TabContent
            }, {
                Utility:Create("UICorner", {
                    CornerRadius = UDim.new(0, 6)
                }),
                Utility:Create("TextLabel", {
                    Name = "SectionTitle",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 10, 0, 0),
                    Size = UDim2.new(1, -20, 0, 30),
                    Font = Enum.Font.GothamSemibold,
                    Text = name,
                    TextColor3 = Library.Theme.TextColor,
                    TextSize = 16,
                    TextXAlignment = Enum.TextXAlignment.Left
                }),
                Utility:Create("Frame", {
                    Name = "SectionContent",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, 30),
                    Size = UDim2.new(1, 0, 0, 0),
                    AutomaticSize = Enum.AutomaticSize.Y,
                }, {
                    Utility:Create("UIListLayout", {
                        Padding = UDim.new(0, 8),
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        HorizontalAlignment = Enum.HorizontalAlignment.Center
                    }),
                    Utility:Create("UIPadding", {
                        PaddingTop = UDim.new(0, 5),
                        PaddingBottom = UDim.new(0, 10),
                        PaddingLeft = UDim.new(0, 10),
                        PaddingRight = UDim.new(0, 10)
                    })
                })
            })
            
            -- Update section size when elements are added
            SectionFrame.SectionContent.ChildAdded:Connect(function()
                SectionFrame.Size = UDim2.new(1, -20, 0, SectionFrame.SectionContent.UIListLayout.AbsoluteContentSize.Y + 40)
            end)
            
            -- Section object
            local Section = {
                Frame = SectionFrame,
                Content = SectionFrame.SectionContent
            }
            
            -- Create Button function
            function Section:CreateButton(options)
                options = options or {}
                options.Name = options.Name or "Button"
                options.Callback = options.Callback or function() end
                options.Icon = options.Icon or nil
                
                local iconId = nil
                
                -- Process icon if provided
                if options.Icon then
                    local success, processedId = Utility:ValidateImageId(options.Icon)
                    if success then
                        iconId = processedId
                    elseif Library.Icons[options.Icon] then
                        iconId = Library.Icons[options.Icon]
                    end
                end
                
                -- Create Button
                local Button = Utility:Create("TextButton", {
                    Name = options.Name.."Button",
                    BackgroundColor3 = Library.Theme.SectionColor,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 35),
                    Font = Enum.Font.GothamSemibold,
                    Text = iconId and "   " .. options.Name or options.Name,
                    TextColor3 = Library.Theme.TextColor,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Center,
                    Parent = Section.Content
                }, {
                    Utility:Create("UICorner", {
                        CornerRadius = UDim.new(0, 6)
                    })
                })
                
                -- Add icon if provided
                if iconId then
                    local Icon = Utility:Create("ImageLabel", {
                        Name = "Icon",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0.5, -8),
                        Size = UDim2.new(0, 16, 0, 16),
                        Image = iconId,
                        ImageColor3 = Library.Theme.TextColor,
                        Parent = Button
                    })
                    
                    -- Update text position
                    Button.TextXAlignment = Enum.TextXAlignment.Center
                end
                
                -- Button functionality
                Button.MouseButton1Click:Connect(function()
                    Utility:Ripple(Button)
                    
                    -- Call callback in protected mode to catch errors
                    local success, err = pcall(options.Callback)
                    if not success then
                        warn("Button callback error: " .. tostring(err))
                    end
                end)
                
                -- Hover effects
                Button.MouseEnter:Connect(function()
                    Utility:Tween(Button, {BackgroundColor3 = Library.Theme.HoverColor}, 0.2)
                end)
                
                Button.MouseLeave:Connect(function()
                    Utility:Tween(Button, {BackgroundColor3 = Library.Theme.SectionColor}, 0.2)
                end)
                
                return Button
            end
            
            -- Create Toggle function
            function Section:CreateToggle(options)
                options = options or {}
                options.Name = options.Name or "Toggle"
                options.Default = options.Default or false
                options.Flag = options.Flag or options.Name
                options.Callback = options.Callback or function() end
                
                -- Create Toggle
                local Toggle = Utility:Create("Frame", {
                    Name = options.Name.."Toggle",
                    BackgroundColor3 = Library.Theme.SectionColor,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 35),
                    Parent = Section.Content
                }, {
                    Utility:Create("UICorner", {
                        CornerRadius = UDim.new(0, 6)
                    }),
                    Utility:Create("TextLabel", {
                        Name = "Title",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(1, -60, 1, 0),
                        Font = Enum.Font.GothamSemibold,
                        Text = options.Name,
                        TextColor3 = Library.Theme.TextColor,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                })
                
                -- Create Toggle Button
                local ToggleButton = Utility:Create("Frame", {
                    Name = "ToggleButton",
                    BackgroundColor3 = options.Default and Library.Theme.ToggleOnColor or Library.Theme.ToggleOffColor,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -50, 0.5, -10),
                    Size = UDim2.new(0, 40, 0, 20),
                    Parent = Toggle
                }, {
                    Utility:Create("UICorner", {
                        CornerRadius = UDim.new(1, 0)
                    })
                })
                
                -- Create Toggle Indicator
                local ToggleIndicator = Utility:Create("Frame", {
                    Name = "Indicator",
                    BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                    BorderSizePixel = 0,
                    Position = options.Default and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8),
                    Size = UDim2.new(0, 16, 0, 16),
                    Parent = ToggleButton
                }, {
                    Utility:Create("UICorner", {
                        CornerRadius = UDim.new(1, 0)
                    })
                })
                
                -- Set initial state
                Library.Flags[options.Flag] = options.Default
                
                -- Toggle functionality
                local function UpdateToggle()
                    Library.Flags[options.Flag] = not Library.Flags[options.Flag]
                    
                    if Library.Flags[options.Flag] then
                        Utility:Tween(ToggleButton, {BackgroundColor3 = Library.Theme.ToggleOnColor}, 0.2)
                        Utility:Tween(ToggleIndicator, {Position = UDim2.new(1, -18, 0.5, -8)}, 0.2)
                    else
                        Utility:Tween(ToggleButton, {BackgroundColor3 = Library.Theme.ToggleOffColor}, 0.2)
                        Utility:Tween(ToggleIndicator, {Position = UDim2.new(0, 2, 0.5, -8)}, 0.2)
                    end
                    
                    -- Call callback in protected mode to catch errors
                    local success, err = pcall(function()
                        options.Callback(Library.Flags[options.Flag])
                    end)
                    
                    if not success then
                        warn("Toggle callback error: " .. tostring(err))
                    end
                end
                
                Toggle.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        UpdateToggle()
                    end
                end)
                
                ToggleButton.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        UpdateToggle()
                    end
                end)
                
                -- Hover effects
                Toggle.MouseEnter:Connect(function()
                    Utility:Tween(Toggle, {BackgroundColor3 = Library.Theme.HoverColor}, 0.2)
                end)
                
                Toggle.MouseLeave:Connect(function()
                    Utility:Tween(Toggle, {BackgroundColor3 = Library.Theme.SectionColor}, 0.2)
                end)
                
                -- Toggle object
                local ToggleObj = {
                    Frame = Toggle,
                    Button = ToggleButton,
                    Indicator = ToggleIndicator,
                    Value = options.Default
                }
                
                function ToggleObj:Set(value)
                    if value == Library.Flags[options.Flag] then return end
                    
                    Library.Flags[options.Flag] = value
                    ToggleObj.Value = value
                    
                    if value then
                        Utility:Tween(ToggleButton, {BackgroundColor3 = Library.Theme.ToggleOnColor}, 0.2)
                        Utility:Tween(ToggleIndicator, {Position = UDim2.new(1, -18, 0.5, -8)}, 0.2)
                    else
                        Utility:Tween(ToggleButton, {BackgroundColor3 = Library.Theme.ToggleOffColor}, 0.2)
                        Utility:Tween(ToggleIndicator, {Position = UDim2.new(0, 2, 0.5, -8)}, 0.2)
                    end
                    
                    -- Call callback in protected mode to catch errors
                    local success, err = pcall(function()
                        options.Callback(value)
                    end)
                    
                    if not success then
                        warn("Toggle callback error: " .. tostring(err))
                    end
                end
                
                return ToggleObj
            end
            
            -- Create Slider function
            function Section:CreateSlider(options)
                options = options or {}
                options.Name = options.Name or "Slider"
                options.Min = options.Min or 0
                options.Max = options.Max or 100
                options.Default = options.Default or options.Min
                options.Increment = options.Increment or 1
                options.Flag = options.Flag or options.Name
                options.Callback = options.Callback or function() end
                options.ValueFormat = options.ValueFormat or "%d"
                
                -- Validate default value
                options.Default = math.clamp(options.Default, options.Min, options.Max)
                
                -- Create Slider
                local Slider = Utility:Create("Frame", {
                    Name = options.Name.."Slider",
                    BackgroundColor3 = Library.Theme.SectionColor,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 50),
                    Parent = Section.Content
                }, {
                    Utility:Create("UICorner", {
                        CornerRadius = UDim.new(0, 6)
                    }),
                    Utility:Create("TextLabel", {
                        Name = "Title",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(1, -20, 0, 25),
                        Font = Enum.Font.GothamSemibold,
                        Text = options.Name,
                        TextColor3 = Library.Theme.TextColor,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left
                    }),
                    Utility:Create("TextLabel", {
                        Name = "Value",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, -50, 0, 0),
                        Size = UDim2.new(0, 40, 0, 25),
                        Font = Enum.Font.GothamSemibold,
                        Text = string.format(options.ValueFormat, options.Default),
                        TextColor3 = Library.Theme.TextColor,
                        TextSize = 14
                    })
                })
                
                -- Create Slider Bar
                local SliderBar = Utility:Create("Frame", {
                    Name = "SliderBar",
                    BackgroundColor3 = Library.Theme.BackgroundColor,
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 10, 0, 30),
                    Size = UDim2.new(1, -20, 0, 10),
                    Parent = Slider
                }, {
                    Utility:Create("UICorner", {
                        CornerRadius = UDim.new(1, 0)
                    })
                })
                
                -- Create Slider Fill
                local SliderFill = Utility:Create("Frame", {
                    Name = "Fill",
                    BackgroundColor3 = Library.Theme.AccentColor,
                    BorderSizePixel = 0,
                    Size = UDim2.new((options.Default - options.Min) / (options.Max - options.Min), 0, 1, 0),
                    Parent = SliderBar
                }, {
                    Utility:Create("UICorner", {
                        CornerRadius = UDim.new(1, 0)
                    })
                })
                
                -- Set initial value
                Library.Flags[options.Flag] = options.Default
                
                -- Slider functionality
                local function UpdateSlider(input)
                    local sizeX = math.clamp((input.Position.X - SliderBar.AbsolutePosition.X) / SliderBar.AbsoluteSize.X, 0, 1)
                    local value = math.floor((options.Min + ((options.Max - options.Min) * sizeX)) / options.Increment + 0.5) * options.Increment
                    value = math.clamp(value, options.Min, options.Max)
                    
                    Library.Flags[options.Flag] = value
                    Slider.Value.Text = string.format(options.ValueFormat, value)
                    Utility:Tween(SliderFill, {Size = UDim2.new((value - options.Min) / (options.Max - options.Min), 0, 1, 0)}, 0.1)
                    
                    -- Call callback in protected mode to catch errors
                    local success, err = pcall(function()
                        options.Callback(value)
                    end)
                    
                    if not success then
                        warn("Slider callback error: " .. tostring(err))
                    end
                end
                
                SliderBar.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        local connection
                        connection = RunService.RenderStepped:Connect(function()
                            UpdateSlider(input)
                        end)
                        
                        input.Changed:Connect(function()
                            if input.UserInputState == Enum.UserInputState.End then
                                connection:Disconnect()
                            end
                        end)
                    end
                end)
                
                SliderBar.InputChanged:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseMovement then
                        UpdateSlider(input)
                    end
                end)
                
                -- Hover effects
                Slider.MouseEnter:Connect(function()
                    Utility:Tween(Slider, {BackgroundColor3 = Library.Theme.HoverColor}, 0.2)
                end)
                
                Slider.MouseLeave:Connect(function()
                    Utility:Tween(Slider, {BackgroundColor3 = Library.Theme.SectionColor}, 0.2)
                end)
                
                -- Slider object
                local SliderObj = {
                    Frame = Slider,
                    Bar = SliderBar,
                    Fill = SliderFill,
                    Value = options.Default
                }
                
                function SliderObj:Set(value)
                    value = math.clamp(value, options.Min, options.Max)
                    Library.Flags[options.Flag] = value
                    SliderObj.Value = value
                    
                    Slider.Value.Text = string.format(options.ValueFormat, value)
                    Utility:Tween(SliderFill, {Size = UDim2.new((value - options.Min) / (options.Max - options.Min), 0, 1, 0)}, 0.1)
                    
                    -- Call callback in protected mode to catch errors
                    local success, err = pcall(function()
                        options.Callback(value)
                    end)
                    
                    if not success then
                        warn("Slider callback error: " .. tostring(err))
                    end
                end
                
                return SliderObj
            end
            
            -- Create Dropdown function
            function Section:CreateDropdown(options)
                options = options or {}
                options.Name = options.Name or "Dropdown"
                options.Options = options.Options or {}
                options.Default = options.Default or nil
                options.Flag = options.Flag or options.Name
                options.Callback = options.Callback or function() end
                options.MultiSelect = options.MultiSelect or false
                
                -- Create Dropdown
                local Dropdown = Utility:Create("Frame", {
                    Name = options.Name.."Dropdown",
                    BackgroundColor3 = Library.Theme.SectionColor,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 40),
                    ClipsDescendants = true,
                    Parent = Section.Content
                }, {
                    Utility:Create("UICorner", {
                        CornerRadius = UDim.new(0, 6)
                    }),
                    Utility:Create("TextLabel", {
                        Name = "Title",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(1, -40, 0, 40),
                        Font = Enum.Font.GothamSemibold,
                        Text = options.Name,
                        TextColor3 = Library.Theme.TextColor,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left
                    }),
                    Utility:Create("TextButton", {
                        Name = "DropdownButton",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(1, -30, 0, 5),
                        Size = UDim2.new(0, 30, 0, 30),
                        Font = Enum.Font.GothamBold,
                        Text = "▼",
                        TextColor3 = Library.Theme.TextColor,
                        TextSize = 14
                    })
                })
                
                -- Create Dropdown Content
                local DropdownContent = Utility:Create("Frame", {
                    Name = "Content",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(0, 0, 0, 40),
                    Size = UDim2.new(1, 0, 0, 0),
                    Parent = Dropdown
                }, {
                    Utility:Create("UIListLayout", {
                        SortOrder = Enum.SortOrder.LayoutOrder,
                        Padding = UDim.new(0, 5)
                    }),
                    Utility:Create("UIPadding", {
                        PaddingLeft = UDim.new(0, 5),
                        PaddingRight = UDim.new(0, 5),
                        PaddingBottom = UDim.new(0, 5)
                    })
                })
                
                -- Create Selected Value
                local SelectedValue = Utility:Create("TextLabel", {
                    Name = "SelectedValue",
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -120, 0, 0),
                    Size = UDim2.new(0, 80, 0, 40),
                    Font = Enum.Font.GothamSemibold,
                    Text = options.Default or "None",
                    TextColor3 = Library.Theme.TextColor,
                    TextSize = 14,
                    TextXAlignment = Enum.TextXAlignment.Right,
                    Parent = Dropdown
                })
                
                -- Set initial value
                if options.MultiSelect then
                    Library.Flags[options.Flag] = {}
                    if options.Default then
                        if type(options.Default) == "table" then
                            for _, value in pairs(options.Default) do
                                if table.find(options.Options, value) then
                                    table.insert(Library.Flags[options.Flag], value)
                                end
                            end
                        elseif table.find(options.Options, options.Default) then
                            table.insert(Library.Flags[options.Flag], options.Default)
                        end
                    end
                    
                    -- Update selected text for multi-select
                    if #Library.Flags[options.Flag] > 0 then
                        if #Library.Flags[options.Flag] == 1 then
                            SelectedValue.Text = Library.Flags[options.Flag][1]
                        else
                            SelectedValue.Text = #Library.Flags[options.Flag] .. " Selected"
                        end
                    else
                        SelectedValue.Text = "None"
                    end
                else
                    Library.Flags[options.Flag] = options.Default
                end
                
                -- Dropdown functionality
                local isOpen = false
                
                local function ToggleDropdown()
                    isOpen = not isOpen
                    
                    if isOpen then
                        Utility:Tween(Dropdown, {Size = UDim2.new(1, 0, 0, 40 + DropdownContent.UIListLayout.AbsoluteContentSize.Y + 10)}, 0.2)
                        Utility:Tween(Dropdown.DropdownButton, {Rotation = 180}, 0.2)
                    else
                        Utility:Tween(Dropdown, {Size = UDim2.new(1, 0, 0, 40)}, 0.2)
                        Utility:Tween(Dropdown.DropdownButton, {Rotation = 0}, 0.2)
                    end
                end
                
                Dropdown.DropdownButton.MouseButton1Click:Connect(ToggleDropdown)
                
                -- Create dropdown options
                for i, option in ipairs(options.Options) do
                    local isSelected = false
                    
                    if options.MultiSelect then
                        isSelected = table.find(Library.Flags[options.Flag], option) ~= nil
                    else
                        isSelected = Library.Flags[options.Flag] == option
                    end
                    
                    local OptionButton = Utility:Create("TextButton", {
                        Name = option.."Option",
                        BackgroundColor3 = isSelected and Library.Theme.AccentColor or Library.Theme.BackgroundColor,
                        BorderSizePixel = 0,
                        Size = UDim2.new(1, 0, 0, 30),
                        Font = Enum.Font.GothamSemibold,
                        Text = option,
                        TextColor3 = isSelected and Color3.fromRGB(255, 255, 255) or Library.Theme.TextColor,
                        TextSize = 14,
                        Parent = DropdownContent
                    }, {
                        Utility:Create("UICorner", {
                            CornerRadius = UDim.new(0, 6)
                        })
                    })
                    
                    -- Option button functionality
                    OptionButton.MouseButton1Click:Connect(function()
                        if options.MultiSelect then
                            -- Toggle selection for this option
                            local index = table.find(Library.Flags[options.Flag], option)
                            
                            if index then
                                table.remove(Library.Flags[options.Flag], index)
                                Utility:Tween(OptionButton, {BackgroundColor3 = Library.Theme.BackgroundColor}, 0.2)
                                Utility:Tween(OptionButton, {TextColor3 = Library.Theme.TextColor}, 0.2)
                            else
                                table.insert(Library.Flags[options.Flag], option)
                                Utility:Tween(OptionButton, {BackgroundColor3 = Library.Theme.AccentColor}, 0.2)
                                Utility:Tween(OptionButton, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
                            end
                            
                            -- Update selected text for multi-select
                            if #Library.Flags[options.Flag] > 0 then
                                if #Library.Flags[options.Flag] == 1 then
                                    SelectedValue.Text = Library.Flags[options.Flag][1]
                                else
                                    SelectedValue.Text = #Library.Flags[options.Flag] .. " Selected"
                                end
                            else
                                SelectedValue.Text = "None"
                            end
                            
                            -- Call callback
                            local success, err = pcall(function()
                                options.Callback(Library.Flags[options.Flag])
                            end)
                            
                            if not success then
                                warn("Dropdown callback error: " .. tostring(err))
                            end
                        else
                            -- Single selection
                            SelectedValue.Text = option
                            Library.Flags[options.Flag] = option
                            
                            -- Update all option buttons
                            for _, child in pairs(DropdownContent:GetChildren()) do
                                if child:IsA("TextButton") then
                                    if child.Text == option then
                                        Utility:Tween(child, {BackgroundColor3 = Library.Theme.AccentColor}, 0.2)
                                        Utility:Tween(child, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
                                    else
                                        Utility:Tween(child, {BackgroundColor3 = Library.Theme.BackgroundColor}, 0.2)
                                        Utility:Tween(child, {TextColor3 = Library.Theme.TextColor}, 0.2)
                                    end
                                end
                            end
                            
                            -- Call callback
                            local success, err = pcall(function()
                                options.Callback(option)
                            end)
                            
                            if not success then
                                warn("Dropdown callback error: " .. tostring(err))
                            end
                            
                            ToggleDropdown()
                        end
                    end)
                    
                    -- Hover effects
                    OptionButton.MouseEnter:Connect(function()
                        if (options.MultiSelect and not table.find(Library.Flags[options.Flag], option)) or
                           (not options.MultiSelect and Library.Flags[options.Flag] ~= option) then
                            Utility:Tween(OptionButton, {BackgroundColor3 = Library.Theme.HoverColor}, 0.2)
                        end
                    end)
                    
                    OptionButton.MouseLeave:Connect(function()
                        if (options.MultiSelect and not table.find(Library.Flags[options.Flag], option)) or
                           (not options.MultiSelect and Library.Flags[options.Flag] ~= option) then
                            Utility:Tween(OptionButton, {BackgroundColor3 = Library.Theme.BackgroundColor}, 0.2)
                        end
                    end)
                end
                
                -- Hover effects
                Dropdown.MouseEnter:Connect(function()
                    Utility:Tween(Dropdown, {BackgroundColor3 = Library.Theme.HoverColor}, 0.2)
                end)
                
                Dropdown.MouseLeave:Connect(function()
                    Utility:Tween(Dropdown, {BackgroundColor3 = Library.Theme.SectionColor}, 0.2)
                end)
                
                -- Dropdown object
                local DropdownObj = {
                    Frame = Dropdown,
                    Content = DropdownContent,
                    Selected = SelectedValue,
                    Value = options.Default
                }
                
                function DropdownObj:Set(value)
                    if options.MultiSelect then
                        if type(value) ~= "table" then
                            value = {value}
                        end
                        
                        -- Clear current selections
                        Library.Flags[options.Flag] = {}
                        
                        -- Update all option buttons
                        for _, child in pairs(DropdownContent:GetChildren()) do
                            if child:IsA("TextButton") then
                                local optionValue = child.Text
                                local isSelected = table.find(value, optionValue) ~= nil
                                
                                if isSelected then
                                    table.insert(Library.Flags[options.Flag], optionValue)
                                    child.BackgroundColor3 = Library.Theme.AccentColor
                                    child.TextColor3 = Color3.fromRGB(255, 255, 255)
                                else
                                    child.BackgroundColor3 = Library.Theme.BackgroundColor
                                    child.TextColor3 = Library.Theme.TextColor
                                end
                            end
                        end
                        
                        -- Update selected text
                        if #Library.Flags[options.Flag] > 0 then
                            if #Library.Flags[options.Flag] == 1 then
                                SelectedValue.Text = Library.Flags[options.Flag][1]
                            else
                                SelectedValue.Text = #Library.Flags[options.Flag] .. " Selected"
                            end
                        else
                            SelectedValue.Text = "None"
                        end
                        
                        DropdownObj.Value = Library.Flags[options.Flag]
                        options.Callback(Library.Flags[options.Flag])
                    else
                        if table.find(options.Options, value) then
                            SelectedValue.Text = value
                            Library.Flags[options.Flag] = value
                            DropdownObj.Value = value
                            
                            -- Update all option buttons
                            for _, child in pairs(DropdownContent:GetChildren()) do
                                if child:IsA("TextButton") then
                                    if child.Text == value then
                                        child.BackgroundColor3 = Library.Theme.AccentColor
                                        child.TextColor3 = Color3.fromRGB(255, 255, 255)
                                    else
                                        child.BackgroundColor3 = Library.Theme.BackgroundColor
                                        child.TextColor3 = Library.Theme.TextColor
                                    end
                                end
                            end
                            
                            options.Callback(value)
                        end
                    end
                end
                
                function DropdownObj:Refresh(newOptions)
                    -- Clear existing options
                    for _, child in pairs(DropdownContent:GetChildren()) do
                        if child:IsA("TextButton") then
                            child:Destroy()
                        end
                    end
                    
                    -- Reset values if needed
                    if options.MultiSelect then
                        Library.Flags[options.Flag] = {}
                        SelectedValue.Text = "None"
                    else
                        Library.Flags[options.Flag] = nil
                        SelectedValue.Text = "None"
                    end
                    
                    -- Add new options
                    for i, option in ipairs(newOptions) do
                        local OptionButton = Utility:Create("TextButton", {
                            Name = option.."Option",
                            BackgroundColor3 = Library.Theme.BackgroundColor,
                            BorderSizePixel = 0,
                            Size = UDim2.new(1, 0, 0, 30),
                            Font = Enum.Font.GothamSemibold,
                            Text = option,
                            TextColor3 = Library.Theme.TextColor,
                            TextSize = 14,
                            Parent = DropdownContent
                        }, {
                            Utility:Create("UICorner", {
                                CornerRadius = UDim.new(0, 6)
                            })
                        })
                        
                        -- Option button functionality
                        OptionButton.MouseButton1Click:Connect(function()
                            if options.MultiSelect then
                                -- Toggle selection for this option
                                local index = table.find(Library.Flags[options.Flag], option)
                                
                                if index then
                                    table.remove(Library.Flags[options.Flag], index)
                                    Utility:Tween(OptionButton, {BackgroundColor3 = Library.Theme.BackgroundColor}, 0.2)
                                    Utility:Tween(OptionButton, {TextColor3 = Library.Theme.TextColor}, 0.2)
                                else
                                    table.insert(Library.Flags[options.Flag], option)
                                    Utility:Tween(OptionButton, {BackgroundColor3 = Library.Theme.AccentColor}, 0.2)
                                    Utility:Tween(OptionButton, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
                                end
                                
                                -- Update selected text for multi-select
                                if #Library.Flags[options.Flag] > 0 then
                                    if #Library.Flags[options.Flag] == 1 then
                                        SelectedValue.Text = Library.Flags[options.Flag][1]
                                    else
                                        SelectedValue.Text = #Library.Flags[options.Flag] .. " Selected"
                                    end
                                else
                                    SelectedValue.Text = "None"
                                end
                                
                                options.Callback(Library.Flags[options.Flag])
                            else
                                SelectedValue.Text = option
                                Library.Flags[options.Flag] = option
                                
                                -- Update all option buttons
                                for _, child in pairs(DropdownContent:GetChildren()) do
                                    if child:IsA("TextButton") then
                                        if child.Text == option then
                                            Utility:Tween(child, {BackgroundColor3 = Library.Theme.AccentColor}, 0.2)
                                            Utility:Tween(child, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
                                        else
                                            Utility:Tween(child, {BackgroundColor3 = Library.Theme.BackgroundColor}, 0.2)
                                            Utility:Tween(child, {TextColor3 = Library.Theme.TextColor}, 0.2)
                                        end
                                    end
                                end
                                
                                options.Callback(option)
                                ToggleDropdown()
                            end
                        end)
                        
                        -- Hover effects
                        OptionButton.MouseEnter:Connect(function()
                            if (options.MultiSelect and not table.find(Library.Flags[options.Flag], option)) or
                               (not options.MultiSelect and Library.Flags[options.Flag] ~= option) then
                                Utility:Tween(OptionButton, {BackgroundColor3 = Library.Theme.HoverColor}, 0.2)
                            end
                        end)
                        
                        OptionButton.MouseLeave:Connect(function()
                            if (options.MultiSelect and not table.find(Library.Flags[options.Flag], option)) or
                               (not options.MultiSelect and Library.Flags[options.Flag] ~= option) then
                                Utility:Tween(OptionButton, {BackgroundColor3 = Library.Theme.BackgroundColor}, 0.2)
                            end
                        end)
                    end
                    
                    options.Options = newOptions
                    
                    -- Update dropdown size if open
                    if isOpen then
                        Dropdown.Size = UDim2.new(1, 0, 0, 40 + DropdownContent.UIListLayout.AbsoluteContentSize.Y + 10)
                    end
                end
                
                return DropdownObj
            end
            
            -- Create Textbox function
            function Section:CreateTextbox(options)
                options = options or {}
                options.Name = options.Name or "Textbox"
                options.Default = options.Default or ""
                options.PlaceholderText = options.PlaceholderText or "Enter text..."
                options.ClearOnFocus = options.ClearOnFocus ~= nil and options.ClearOnFocus or true
                options.Flag = options.Flag or options.Name
                options.Callback = options.Callback or function() end
                
                -- Create Textbox
                local Textbox = Utility:Create("Frame", {
                    Name = options.Name.."Textbox",
                    BackgroundColor3 = Library.Theme.SectionColor,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 40),
                    Parent = Section.Content
                }, {
                    Utility:Create("UICorner", {
                        CornerRadius = UDim.new(0, 6)
                    }),
                    Utility:Create("TextLabel", {
                        Name = "Title",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(0, 100, 1, 0),
                        Font = Enum.Font.GothamSemibold,
                        Text = options.Name,
                        TextColor3 = Library.Theme.TextColor,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                })
                
                -- Create Textbox Input
                local TextboxInput = Utility:Create("TextBox", {
                    Name = "Input",
                    BackgroundColor3 = Library.Theme.BackgroundColor,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -160, 0.5, -15),
                    Size = UDim2.new(0, 150, 0, 30),
                    Font = Enum.Font.Gotham,
                    Text = options.Default,
                    PlaceholderText = options.PlaceholderText,
                    TextColor3 = Library.Theme.TextColor,
                    TextSize = 14,
                    ClearTextOnFocus = options.ClearOnFocus,
                    Parent = Textbox
                }, {
                    Utility:Create("UICorner", {
                        CornerRadius = UDim.new(0, 6)
                    })
                })
                
                -- Set initial value
                Library.Flags[options.Flag] = options.Default
                
                -- Textbox functionality
                TextboxInput.FocusLost:Connect(function(enterPressed)
                    Library.Flags[options.Flag] = TextboxInput.Text
                    
                    -- Call callback in protected mode to catch errors
                    local success, err = pcall(function()
                        options.Callback(TextboxInput.Text)
                    end)
                    
                    if not success then
                        warn("Textbox callback error: " .. tostring(err))
                    end
                end)
                
                -- Hover effects
                Textbox.MouseEnter:Connect(function()
                    Utility:Tween(Textbox, {BackgroundColor3 = Library.Theme.HoverColor}, 0.2)
                end)
                
                Textbox.MouseLeave:Connect(function()
                    Utility:Tween(Textbox, {BackgroundColor3 = Library.Theme.SectionColor}, 0.2)
                end)
                
                -- Textbox object
                local TextboxObj = {
                    Frame = Textbox,
                    Input = TextboxInput,
                    Value = options.Default
                }
                
                function TextboxObj:Set(value)
                    TextboxInput.Text = value
                    Library.Flags[options.Flag] = value
                    TextboxObj.Value = value
                    
                    -- Call callback in protected mode to catch errors
                    local success, err = pcall(function()
                        options.Callback(value)
                    end)
                    
                    if not success then
                        warn("Textbox callback error: " .. tostring(err))
                    end
                end
                
                return TextboxObj
            end
            
            -- Create Label function
            function Section:CreateLabel(options)
                options = options or {}
                options.Text = options.Text or "Label"
                options.Color = options.Color or Library.Theme.TextColor
                
                -- Create Label
                local Label = Utility:Create("TextLabel", {
                    Name = "Label",
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 20),
                    Font = Enum.Font.GothamSemibold,
                    Text = options.Text,
                    TextColor3 = options.Color,
                    TextSize = 14,
                    TextWrapped = true,
                    Parent = Section.Content
                })
                
                -- Label object
                local LabelObj = {
                    Label = Label
                }
                
                function LabelObj:Set(text)
                    Label.Text = text
                end
                
                function LabelObj:SetColor(color)
                    Label.TextColor3 = color
                end
                
                return LabelObj
            end
            
            -- Create Keybind function
            function Section:CreateKeybind(options)
                options = options or {}
                options.Name = options.Name or "Keybind"
                options.Default = options.Default or Enum.KeyCode.Unknown
                options.Flag = options.Flag or options.Name
                options.Callback = options.Callback or function() end
                
                -- Create Keybind
                local Keybind = Utility:Create("Frame", {
                    Name = options.Name.."Keybind",
                    BackgroundColor3 = Library.Theme.SectionColor,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 40),
                    Parent = Section.Content
                }, {
                    Utility:Create("UICorner", {
                        CornerRadius = UDim.new(0, 6)
                    }),
                    Utility:Create("TextLabel", {
                        Name = "Title",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(1, -120, 1, 0),
                        Font = Enum.Font.GothamSemibold,
                        Text = options.Name,
                        TextColor3 = Library.Theme.TextColor,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                })
                
                -- Create Keybind Button
                local KeybindButton = Utility:Create("TextButton", {
                    Name = "KeybindButton",
                    BackgroundColor3 = Library.Theme.BackgroundColor,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -110, 0.5, -15),
                    Size = UDim2.new(0, 100, 0, 30),
                    Font = Enum.Font.GothamSemibold,
                    Text = options.Default ~= Enum.KeyCode.Unknown and options.Default.Name or "None",
                    TextColor3 = Library.Theme.TextColor,
                    TextSize = 14,
                    Parent = Keybind
                }, {
                    Utility:Create("UICorner", {
                        CornerRadius = UDim.new(0, 6)
                    })
                })
                
                -- Set initial value
                Library.Flags[options.Flag] = options.Default
                
                -- Keybind functionality
                local waitingForInput = false
                
                KeybindButton.MouseButton1Click:Connect(function()
                    waitingForInput = true
                    KeybindButton.Text = "..."
                    
                    -- Highlight effect
                    Utility:Tween(KeybindButton, {BackgroundColor3 = Library.Theme.AccentColor}, 0.2)
                    Utility:Tween(KeybindButton, {TextColor3 = Color3.fromRGB(255, 255, 255)}, 0.2)
                end)
                
                UserInputService.InputBegan:Connect(function(input)
                    if waitingForInput and input.UserInputType == Enum.UserInputType.Keyboard then
                        waitingForInput = false
                        
                        local key = input.KeyCode
                        Library.Flags[options.Flag] = key
                        KeybindButton.Text = key.Name
                        
                        -- Restore normal appearance
                        Utility:Tween(KeybindButton, {BackgroundColor3 = Library.Theme.BackgroundColor}, 0.2)
                        Utility:Tween(KeybindButton, {TextColor3 = Library.Theme.TextColor}, 0.2)
                        
                        -- Call callback in protected mode to catch errors
                        local success, err = pcall(function()
                            options.Callback(key)
                        end)
                        
                        if not success then
                            warn("Keybind callback error: " .. tostring(err))
                        end
                    elseif not waitingForInput and input.UserInputType == Enum.UserInputType.Keyboard then
                        if input.KeyCode == Library.Flags[options.Flag] then
                            -- Call callback in protected mode to catch errors
                            local success, err = pcall(function()
                                options.Callback(input.KeyCode)
                            end)
                            
                            if not success then
                                warn("Keybind callback error: " .. tostring(err))
                            end
                        end
                    end
                end)
                
                -- Hover effects
                Keybind.MouseEnter:Connect(function()
                    Utility:Tween(Keybind, {BackgroundColor3 = Library.Theme.HoverColor}, 0.2)
                end)
                
                Keybind.MouseLeave:Connect(function()
                    Utility:Tween(Keybind, {BackgroundColor3 = Library.Theme.SectionColor}, 0.2)
                end)
                
                -- Keybind object
                local KeybindObj = {
                    Frame = Keybind,
                    Button = KeybindButton,
                    Value = options.Default
                }
                
                function KeybindObj:Set(key)
                    Library.Flags[options.Flag] = key
                    KeybindObj.Value = key
                    KeybindButton.Text = key.Name
                    
                    -- Call callback in protected mode to catch errors
                    local success, err = pcall(function()
                        options.Callback(key)
                    end)
                    
                    if not success then
                        warn("Keybind callback error: " .. tostring(err))
                    end
                end
                
                return KeybindObj
            end
            
            -- Create Colorpicker function
            function Section:CreateColorpicker(options)
                options = options or {}
                options.Name = options.Name or "Colorpicker"
                options.Default = options.Default or Color3.fromRGB(255, 255, 255)
                options.Flag = options.Flag or options.Name
                options.Callback = options.Callback or function() end
                
                -- Create Colorpicker
                local Colorpicker = Utility:Create("Frame", {
                    Name = options.Name.."Colorpicker",
                    BackgroundColor3 = Library.Theme.SectionColor,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 40),
                    Parent = Section.Content
                }, {
                    Utility:Create("UICorner", {
                        CornerRadius = UDim.new(0, 6)
                    }),
                    Utility:Create("TextLabel", {
                        Name = "Title",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 0),
                        Size = UDim2.new(1, -60, 1, 0),
                        Font = Enum.Font.GothamSemibold,
                        Text = options.Name,
                        TextColor3 = Library.Theme.TextColor,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left
                    })
                })
                
                -- Create Color Display
                local ColorDisplay = Utility:Create("Frame", {
                    Name = "ColorDisplay",
                    BackgroundColor3 = options.Default,
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, -50, 0.5, -15),
                    Size = UDim2.new(0, 40, 0, 30),
                    Parent = Colorpicker
                }, {
                    Utility:Create("UICorner", {
                        CornerRadius = UDim.new(0, 6)
                    }),
                    Utility:Create("UIStroke", {
                        Color = Color3.fromRGB(100, 100, 100),
                        Thickness = 1
                    })
                })
                
                -- Set initial value
                Library.Flags[options.Flag] = options.Default
                
                -- Create Color Picker UI (simplified for this example)
                local isOpen = false
                local ColorPickerUI
                
                local function CreateColorPickerUI()
                    ColorPickerUI = Utility:Create("Frame", {
                        Name = "ColorPickerUI",
                        BackgroundColor3 = Library.Theme.BackgroundColor,
                        BorderSizePixel = 0,
                        Position = UDim2.new(1, 10, 0, 0),
                        Size = UDim2.new(0, 200, 0, 220),
                        Visible = false,
                        Parent = Colorpicker
                    }, {
                        Utility:Create("UICorner", {
                            CornerRadius = UDim.new(0, 6)
                        }),
                        Utility:Create("TextLabel", {
                            Name = "Title",
                            BackgroundTransparency = 1,
                            Position = UDim2.new(0, 10, 0, 5),
                            Size = UDim2.new(1, -20, 0, 20),
                            Font = Enum.Font.GothamSemibold,
                            Text = "Color Picker",
                            TextColor3 = Library.Theme.TextColor,
                            TextSize = 14
                        }),
                        Utility:Create("Frame", {
                            Name = "ColorArea",
                            BackgroundColor3 = Color3.fromRGB(255, 0, 0),
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 10, 0, 30),
                            Size = UDim2.new(1, -20, 0, 100)
                        }, {
                            Utility:Create("UICorner", {
                                CornerRadius = UDim.new(0, 6)
                            }),
                            Utility:Create("UIGradient", {
                                Color = ColorSequence.new({
                                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
                                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                                }),
                                Transparency = NumberSequence.new({
                                    NumberSequenceKeypoint.new(0, 0),
                                    NumberSequenceKeypoint.new(1, 0)
                                }),
                                Rotation = 90
                            })
                        }),
                        Utility:Create("Frame", {
                            Name = "HueSlider",
                            BackgroundColor3 = Color3.fromRGB(255, 255, 255),
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 10, 0, 140),
                            Size = UDim2.new(1, -20, 0, 20)
                        }, {
                            Utility:Create("UICorner", {
                                CornerRadius = UDim.new(0, 6)
                            }),
                            Utility:Create("UIGradient", {
                                Color = ColorSequence.new({
                                    ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
                                    ColorSequenceKeypoint.new(0.167, Color3.fromRGB(255, 255, 0)),
                                    ColorSequenceKeypoint.new(0.333, Color3.fromRGB(0, 255, 0)),
                                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(0, 255, 255)),
                                    ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 0, 255)),
                                    ColorSequenceKeypoint.new(0.833, Color3.fromRGB(255, 0, 255)),
                                    ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 0))
                                })
                            })
                        }),
                        Utility:Create("TextButton", {
                            Name = "ConfirmButton",
                            BackgroundColor3 = Library.Theme.AccentColor,
                            BorderSizePixel = 0,
                            Position = UDim2.new(0, 10, 0, 170),
                            Size = UDim2.new(1, -20, 0, 40),
                            Font = Enum.Font.GothamSemibold,
                            Text = "Confirm",
                            TextColor3 = Color3.fromRGB(255, 255, 255),
                            TextSize = 14
                        }, {
                            Utility:Create("UICorner", {
                                CornerRadius = UDim.new(0, 6)
                            })
                        })
                    })
                    
                    -- For simplicity, we'll just use the confirm button to set a random color
                    ColorPickerUI.ConfirmButton.MouseButton1Click:Connect(function()
                        local newColor = Color3.fromHSV(math.random(), math.random(), math.random())
                        ColorDisplay.BackgroundColor3 = newColor
                        Library.Flags[options.Flag] = newColor
                        
                        -- Call callback in protected mode to catch errors
                        local success, err = pcall(function()
                            options.Callback(newColor)
                        end)
                        
                        if not success then
                            warn("Colorpicker callback error: " .. tostring(err))
                        end
                        
                        isOpen = false
                        ColorPickerUI.Visible = false
                    end)
                end
                
                -- Colorpicker functionality
                ColorDisplay.InputBegan:Connect(function(input)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        if not ColorPickerUI then
                            CreateColorPickerUI()
                        end
                        
                        isOpen = not isOpen
                        ColorPickerUI.Visible = isOpen
                    end
                end)
                
                -- Hover effects
                Colorpicker.MouseEnter:Connect(function()
                    Utility:Tween(Colorpicker, {BackgroundColor3 = Library.Theme.HoverColor}, 0.2)
                end)
                
                Colorpicker.MouseLeave:Connect(function()
                    Utility:Tween(Colorpicker, {BackgroundColor3 = Library.Theme.SectionColor}, 0.2)
                end)
                
                -- Colorpicker object
                local ColorpickerObj = {
                    Frame = Colorpicker,
                    Display = ColorDisplay,
                    Value = options.Default
                }
                
                function ColorpickerObj:Set(color)
                    ColorDisplay.BackgroundColor3 = color
                    Library.Flags[options.Flag] = color
                    ColorpickerObj.Value = color
                    
                    -- Call callback in protected mode to catch errors
                    local success, err = pcall(function()
                        options.Callback(color)
                    end)
                    
                    if not success then
                        warn("Colorpicker callback error: " .. tostring(err))
                    end
                end
                
                return ColorpickerObj
            end
            
            -- Create Paragraph function
            function Section:CreateParagraph(options)
                options = options or {}
                options.Title = options.Title or "Title"
                options.Content = options.Content or "Content"
                
                -- Create Paragraph
                local Paragraph = Utility:Create("Frame", {
                    Name = "Paragraph",
                    BackgroundColor3 = Library.Theme.SectionColor,
                    BorderSizePixel = 0,
                    Size = UDim2.new(1, 0, 0, 60),
                    AutomaticSize = Enum.AutomaticSize.Y,
                    Parent = Section.Content
                }, {
                    Utility:Create("UICorner", {
                        CornerRadius = UDim.new(0, 6)
                    }),
                    Utility:Create("TextLabel", {
                        Name = "Title",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 5),
                        Size = UDim2.new(1, -20, 0, 20),
                        Font = Enum.Font.GothamBold,
                        Text = options.Title,
                        TextColor3 = Library.Theme.TextColor,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextWrapped = true
                    }),
                    Utility:Create("TextLabel", {
                        Name = "Content",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 25),
                        Size = UDim2.new(1, -20, 0, 0),
                        AutomaticSize = Enum.AutomaticSize.Y,
                        Font = Enum.Font.Gotham,
                        Text = options.Content,
                        TextColor3 = Library.Theme.InfoColor,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        TextWrapped = true
                    })
                })
                
                -- Paragraph object
                local ParagraphObj = {
                    Frame = Paragraph,
                    Title = Paragraph.Title,
                    Content = Paragraph.Content
                }
                
                function ParagraphObj:SetTitle(title)
                    Paragraph.Title.Text = title
                end
                
                function ParagraphObj:SetContent(content)
                    Paragraph.Content.Text = content
                end
                
                return ParagraphObj
            end
            
            -- Create ImageDesc function (NEW)
            function Section:CreateImageDesc(options)
                options = options or {}
                options.Title = options.Title or "Image Title"
                options.Description = options.Description or "Image Description"
                options.Image = options.Image or nil
                options.Size = options.Size or UDim2.new(1, 0, 0, 120)
                
                local imageId = nil
                
                -- Process image if provided
                if options.Image then
                    local success, processedId = Utility:ValidateImageId(options.Image)
                    if success then
                        imageId = processedId
                    elseif Library.Icons[options.Image] then
                        imageId = Library.Icons[options.Image]
                    else
                        imageId = "rbxassetid://7743878358" -- Default placeholder image
                    end
                else
                    imageId = "rbxassetid://7743878358" -- Default placeholder image
                end
                
                -- Create ImageDesc
                local ImageDesc = Utility:Create("Frame", {
                    Name = "ImageDesc",
                    BackgroundColor3 = Library.Theme.SectionColor,
                    BorderSizePixel = 0,
                    Size = options.Size,
                    Parent = Section.Content
                }, {
                    Utility:Create("UICorner", {
                        CornerRadius = UDim.new(0, 6)
                    }),
                    Utility:Create("TextLabel", {
                        Name = "Title",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 110, 0, 10),
                        Size = UDim2.new(1, -120, 0, 20),
                        Font = Enum.Font.GothamBold,
                        Text = options.Title,
                        TextColor3 = Library.Theme.TextColor,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextWrapped = true
                    }),
                    Utility:Create("TextLabel", {
                        Name = "Description",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 110, 0, 30),
                        Size = UDim2.new(1, -120, 1, -40),
                        Font = Enum.Font.Gotham,
                        Text = options.Description,
                        TextColor3 = Library.Theme.InfoColor,
                        TextSize = 14,
                        TextXAlignment = Enum.TextXAlignment.Left,
                        TextYAlignment = Enum.TextYAlignment.Top,
                        TextWrapped = true
                    }),
                    Utility:Create("ImageLabel", {
                        Name = "Image",
                        BackgroundTransparency = 1,
                        Position = UDim2.new(0, 10, 0, 10),
                        Size = UDim2.new(0, 90, 0, 90),
                        Image = imageId,
                        ScaleType = Enum.ScaleType.Fit
                    }, {
                        Utility:Create("UICorner", {
                            CornerRadius = UDim.new(0, 6)
                        })
                    })
                })
                
                -- Hover effects
                ImageDesc.MouseEnter:Connect(function()
                    Utility:Tween(ImageDesc, {BackgroundColor3 = Library.Theme.HoverColor}, 0.2)
                end)
                
                ImageDesc.MouseLeave:Connect(function()
                    Utility:Tween(ImageDesc, {BackgroundColor3 = Library.Theme.SectionColor}, 0.2)
                end)
                
                -- ImageDesc object
                local ImageDescObj = {
                    Frame = ImageDesc,
                    Title = ImageDesc.Title,
                    Description = ImageDesc.Description,
                    Image = ImageDesc.Image
                }
                
                function ImageDescObj:SetTitle(title)
                    ImageDesc.Title.Text = title
                end
                
                function ImageDescObj:SetDescription(description)
                    ImageDesc.Description.Text = description
                end
                
                function ImageDescObj:SetImage(image)
                    local success, processedId = Utility:ValidateImageId(image)
                    if success then
                        ImageDesc.Image.Image = processedId
                    elseif Library.Icons[image] then
                        ImageDesc.Image.Image = Library.Icons[image]
                    end
                end
                
                return ImageDescObj
            end
            
            return Section
        end
        
        return Tab
    end
    
    -- Notification function
    function Library:Notify(options)
        options = options or {}
        options.Title = options.Title or "Notification"
        options.Content = options.Content or "Content"
        options.Duration = options.Duration or 3
        options.Type = options.Type or "Info" -- Info, Success, Error, Warning
        
        -- Determine color based on type
        local accentColor = Library.Theme.AccentColor
        if options.Type == "Success" then
            accentColor = Library.Theme.SuccessColor
        elseif options.Type == "Error" then
            accentColor = Library.Theme.ErrorColor
        elseif options.Type == "Warning" then
            accentColor = Color3.fromRGB(255, 165, 0)
        end
        
        -- Create Notification
        local Notification = Utility:Create("Frame", {
            Name = "Notification",
            BackgroundColor3 = Library.Theme.BackgroundColor,
            BorderSizePixel = 0,
            Position = UDim2.new(1, -330, 1, -100),
            Size = UDim2.new(0, 300, 0, 80),
            Parent = game.CoreGui:FindFirstChild("EnhancedUI") or Window.ScreenGui
        }, {
            Utility:Create("UICorner", {
                CornerRadius = UDim.new(0, 6)
            }),
            Utility:Create("Frame", {
                Name = "LeftAccent",
                BackgroundColor3 = accentColor,
                BorderSizePixel = 0,
                Position = UDim2.new(0, 0, 0, 0),
                Size = UDim2.new(0, 5, 1, 0)
            }, {
                Utility:Create("UICorner", {
                    CornerRadius = UDim.new(0, 6)
                })
            }),
            Utility:Create("TextLabel", {
                Name = "Title",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 15, 0, 5),
                Size = UDim2.new(1, -20, 0, 20),
                Font = Enum.Font.GothamBold,
                Text = options.Title,
                TextColor3 = Library.Theme.TextColor,
                TextSize = 16,
                TextXAlignment = Enum.TextXAlignment.Left
            }),
            Utility:Create("TextLabel", {
                Name = "Content",
                BackgroundTransparency = 1,
                Position = UDim2.new(0, 15, 0, 30),
                Size = UDim2.new(1, -20, 0, 40),
                Font = Enum.Font.Gotham,
                Text = options.Content,
                TextColor3 = Library.Theme.InfoColor,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextWrapped = true
            })
        })
        
        -- Animation
        Notification.Position = UDim2.new(1, 0, 1, -100)
        Utility:Tween(Notification, {Position = UDim2.new(1, -330, 1, -100)}, 0.3)
        
        -- Auto-remove
        task.spawn(function()
            task.wait(options.Duration)
            Utility:Tween(Notification, {Position = UDim2.new(1, 0, 1, -100)}, 0.3)
            task.wait(0.3)
            Notification:Destroy()
        end)
        
        return Notification
    end
    
    -- Destroy GUI function
    function Library:DestroyGui()
        if Window.ScreenGui then
            Window.ScreenGui:Destroy()
        end
    end
    
    -- Discord Join function
    function Library:DiscordJoin(inviteCode)
        inviteCode = inviteCode or "yourInviteCode"
        
        -- Create notification
        Library:Notify({
            Title = "Discord",
            Content = "Joining Discord server...",
            Duration = 3
        })
        
        -- In a real implementation, you would use HttpService to make a request
        -- For this example, we'll just simulate it
        task.spawn(function()
            task.wait(1)
            Library:Notify({
                Title = "Discord",
                Content = "Copied invite link to clipboard!",
                Duration = 3
            })
        end)
    end
    
    return Window
end

return Library
