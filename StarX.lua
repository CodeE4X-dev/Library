-- loadstring(game:HttpGet("https://raw.githubusercontent.com/CodeE4X-dev/Library/refs/heads/main/StarX.lua"))()
local UILibrary = {}
UILibrary.__index = UILibrary

-- Default Theme
UILibrary.Theme = {
    Background = Color3.fromRGB(30, 30, 30),
    Text = Color3.fromRGB(255, 255, 255),
    Accent = Color3.fromRGB(0, 120, 215),
    CornerRadius = UDim.new(0, 6)
}

-- Utility Functions
function UILibrary:RoundCorners(instance)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = self.Theme.CornerRadius
    corner.Parent = instance
end

function UILibrary:Create(class, properties)
    local instance = Instance.new(class)
    for property, value in pairs(properties) do
        instance[property] = value
    end
    return instance
end

-- Window
function UILibrary:Window(options)
    local window = self:Create("ScreenGui", {
        Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui"),
        Name = "UILibraryWindow"
    })

    local mainFrame = self:Create("Frame", {
        Parent = window,
        Size = options.size or UDim2.new(0, 400, 0, 500),
        Position = UDim2.new(0.5, -200, 0.5, -250),
        BackgroundColor3 = self.Theme.Background,
        ClipsDescendants = true
    })
    self:RoundCorners(mainFrame)

    local titleBar = self:Create("Frame", {
        Parent = mainFrame,
        Size = UDim2.new(1, 0, 0, 30),
        BackgroundColor3 = self.Theme.Accent
    })
    self:RoundCorners(titleBar)

    local titleLabel = self:Create("TextLabel", {
        Parent = titleBar,
        Size = UDim2.new(1, 0, 1, 0),
        Text = options.title,
        TextColor3 = self.Theme.Text,
        BackgroundTransparency = 1,
        Font = Enum.Font.SourceSansBold,
        TextSize = 18
    })

    local closeButton = self:Create("TextButton", {
        Parent = titleBar,
        Size = UDim2.new(0, 30, 1, 0),
        Position = UDim2.new(1, -30, 0, 0),
        Text = "X",
        TextColor3 = self.Theme.Text,
        BackgroundColor3 = self.Theme.Accent,
        Font = Enum.Font.SourceSansBold,
        TextSize = 18
    })
    self:RoundCorners(closeButton)

    closeButton.MouseButton1Click:Connect(function()
        window:Destroy()
    end)

    -- Drag Functionality
    local dragging
    local dragInput
    local dragStart
    local startPos

    local function update(input)
        local delta = input.Position - dragStart
        mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    titleBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = mainFrame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    titleBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    -- Tab System
    function mainFrame:Tab(options)
        local tabFrame = self:Create("Frame", {
            Parent = mainFrame,
            Size = UDim2.new(1, -10, 1, -40),
            Position = UDim2.new(0, 5, 0, 35),
            BackgroundColor3 = self.Theme.Background,
            ClipsDescendants = true
        })
        self:RoundCorners(tabFrame)

        local tabButton = self:Create("TextButton", {
            Parent = titleBar,
            Size = UDim2.new(0, 100, 1, 0),
            Position = UDim2.new(0, 5, 0, 0),
            Text = options.title,
            TextColor3 = self.Theme.Text,
            BackgroundColor3 = self.Theme.Accent,
            Font = Enum.Font.SourceSansBold,
            TextSize = 14
        })
        self:RoundCorners(tabButton)

        tabButton.MouseButton1Click:Connect(function()
            for _, child in ipairs(mainFrame:GetChildren()) do
                if child:IsA("Frame") and child ~= titleBar then
                    child.Visible = false
                end
            end
            tabFrame.Visible = true
        end)

        -- Paragraph
        function tabFrame:Paragraph(options)
            local paragraphFrame = self:Create("Frame", {
                Parent = tabFrame,
                Size = UDim2.new(1, -10, 0, 0),
                Position = UDim2.new(0, 5, 0, 0),
                BackgroundColor3 = self.Theme.Background,
                AutomaticSize = Enum.AutomaticSize.Y
            })
            self:RoundCorners(paragraphFrame)

            local titleLabel = self:Create("TextLabel", {
                Parent = paragraphFrame,
                Size = UDim2.new(1, 0, 0, 20),
                Text = options.title,
                TextColor3 = self.Theme.Text,
                BackgroundTransparency = 1,
                Font = Enum.Font.SourceSansBold,
                TextSize = 14
            })

            local descriptionLabel = self:Create("TextLabel", {
                Parent = paragraphFrame,
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 0, 25),
                Text = options.description,
                TextColor3 = self.Theme.Text,
                BackgroundTransparency = 1,
                Font = Enum.Font.SourceSans,
                TextSize = 14,
                TextWrapped = true,
                AutomaticSize = Enum.AutomaticSize.Y
            })

            return paragraphFrame
        end

        -- Button
        function tabFrame:Button(options)
            local button = self:Create("TextButton", {
                Parent = tabFrame,
                Size = UDim2.new(1, -10, 0, 30),
                Position = UDim2.new(0, 5, 0, 0),
                Text = options.text,
                TextColor3 = self.Theme.Text,
                BackgroundColor3 = self.Theme.Accent,
                Font = Enum.Font.SourceSansBold,
                TextSize = 14
            })
            self:RoundCorners(button)

            button.MouseButton1Click:Connect(options.callback)
            return button
        end

        -- Toggle
        function tabFrame:Toggle(options)
            local toggleFrame = self:Create("Frame", {
                Parent = tabFrame,
                Size = UDim2.new(1, -10, 0, 30),
                Position = UDim2.new(0, 5, 0, 0),
                BackgroundColor3 = self.Theme.Background
            })
            self:RoundCorners(toggleFrame)

            local toggleButton = self:Create("TextButton", {
                Parent = toggleFrame,
                Size = UDim2.new(0, 20, 0, 20),
                Position = UDim2.new(1, -25, 0.5, -10),
                Text = "",
                BackgroundColor3 = self.Theme.Accent
            })
            self:RoundCorners(toggleButton)

            local toggleLabel = self:Create("TextLabel", {
                Parent = toggleFrame,
                Size = UDim2.new(1, -30, 1, 0),
                Text = options.text,
                TextColor3 = self.Theme.Text,
                BackgroundTransparency = 1,
                Font = Enum.Font.SourceSans,
                TextSize = 14
            })

            local toggled = false
            toggleButton.MouseButton1Click:Connect(function()
                toggled = not toggled
                options.callback(toggled)
                toggleButton.BackgroundColor3 = toggled and Color3.fromRGB(0, 255, 0) or self.Theme.Accent
            end)

            return toggleFrame
        end

        -- Slider
        function tabFrame:Slider(options)
            local sliderFrame = self:Create("Frame", {
                Parent = tabFrame,
                Size = UDim2.new(1, -10, 0, 50),
                Position = UDim2.new(0, 5, 0, 0),
                BackgroundColor3 = self.Theme.Background
            })
            self:RoundCorners(sliderFrame)

            local sliderLabel = self:Create("TextLabel", {
                Parent = sliderFrame,
                Size = UDim2.new(1, 0, 0, 20),
                Text = options.text,
                TextColor3 = self.Theme.Text,
                BackgroundTransparency = 1,
                Font = Enum.Font.SourceSans,
                TextSize = 14
            })

            local sliderBar = self:Create("Frame", {
                Parent = sliderFrame,
                Size = UDim2.new(1, 0, 0, 5),
                Position = UDim2.new(0, 0, 0, 25),
                BackgroundColor3 = self.Theme.Accent
            })
            self:RoundCorners(sliderBar)

            local sliderButton = self:Create("TextButton", {
                Parent = sliderBar,
                Size = UDim2.new(0, 10, 1, 0),
                Position = UDim2.new(0, 0, 0, 0),
                Text = "",
                BackgroundColor3 = self.Theme.Text
            })
            self:RoundCorners(sliderButton)

            local dragging = false
            sliderButton.MouseButton1Down:Connect(function()
                dragging = true
            end)

            game:GetService("UserInputService").InputEnded:Connect(function(input)
                if input.UserInputType == Enum.UserInputType.MouseButton1 then
                    dragging = false
                end
            end)

            game:GetService("UserInputService").InputChanged:Connect(function(input)
                if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local xOffset = math.clamp(input.Position.X - sliderBar.AbsolutePosition.X, 0, sliderBar.AbsoluteSize.X)
                    local value = math.floor(((xOffset / sliderBar.AbsoluteSize.X) * (options.max - options.min)) + options.min
                    sliderButton.Position = UDim2.new(0, xOffset - 5, 0, 0)
                    options.callback(value)
                end
            end)

            return sliderFrame
        end

        -- Dropdown
        function tabFrame:Dropdown(options)
            local dropdownFrame = self:Create("Frame", {
                Parent = tabFrame,
                Size = UDim2.new(1, -10, 0, 30),
                Position = UDim2.new(0, 5, 0, 0),
                BackgroundColor3 = self.Theme.Background
            })
            self:RoundCorners(dropdownFrame)

            local dropdownButton = self:Create("TextButton", {
                Parent = dropdownFrame,
                Size = UDim2.new(1, 0, 1, 0),
                Text = options.text,
                TextColor3 = self.Theme.Text,
                BackgroundColor3 = self.Theme.Accent,
                Font = Enum.Font.SourceSansBold,
                TextSize = 14
            })
            self:RoundCorners(dropdownButton)

            local dropdownOptions = self:Create("Frame", {
                Parent = dropdownFrame,
                Size = UDim2.new(1, 0, 0, 0),
                Position = UDim2.new(0, 0, 1, 5),
                BackgroundColor3 = self.Theme.Background,
                ClipsDescendants = true,
                Visible = false
            })
            self:RoundCorners(dropdownOptions)

            local optionHeight = 25
            local totalHeight = #options.options * optionHeight
            dropdownOptions.Size = UDim2.new(1, 0, 0, totalHeight)

            for i, option in ipairs(options.options) do
                local optionButton = self:Create("TextButton", {
                    Parent = dropdownOptions,
                    Size = UDim2.new(1, 0, 0, optionHeight),
                    Position = UDim2.new(0, 0, 0, (i - 1) * optionHeight),
                    Text = option,
                    TextColor3 = self.Theme.Text,
                    BackgroundColor3 = self.Theme.Accent,
                    Font = Enum.Font.SourceSans,
                    TextSize = 14
                })
                self:RoundCorners(optionButton)

                optionButton.MouseButton1Click:Connect(function()
                    dropdownButton.Text = option
                    dropdownOptions.Visible = false
                    options.callback(option)
                end)
            end

            dropdownButton.MouseButton1Click:Connect(function()
                dropdownOptions.Visible = not dropdownOptions.Visible
            end)

            return dropdownFrame
        end

        -- Textbox
        function tabFrame:Textbox(options)
            local textboxFrame = self:Create("Frame", {
                Parent = tabFrame,
                Size = UDim2.new(1, -10, 0, 30),
                Position = UDim2.new(0, 5, 0, 0),
                BackgroundColor3 = self.Theme.Background
            })
            self:RoundCorners(textboxFrame)

            local textbox = self:Create("TextBox", {
                Parent = textboxFrame,
                Size = UDim2.new(1, 0, 1, 0),
                Text = options.text,
                TextColor3 = self.Theme.Text,
                BackgroundColor3 = self.Theme.Accent,
                Font = Enum.Font.SourceSans,
                TextSize = 14,
                PlaceholderText = options.text
            })
            self:RoundCorners(textbox)

            textbox.FocusLost:Connect(function()
                options.callback(textbox.Text)
            end)

            return textboxFrame
        end

        -- Keybind
        function tabFrame:Keybind(options)
            local keybindFrame = self:Create("Frame", {
                Parent = tabFrame,
                Size = UDim2.new(1, -10, 0, 30),
                Position = UDim2.new(0, 5, 0, 0),
                BackgroundColor3 = self.Theme.Background
            })
            self:RoundCorners(keybindFrame)

            local keybindButton = self:Create("TextButton", {
                Parent = keybindFrame,
                Size = UDim2.new(1, 0, 1, 0),
                Text = options.text,
                TextColor3 = self.Theme.Text,
                BackgroundColor3 = self.Theme.Accent,
                Font = Enum.Font.SourceSansBold,
                TextSize = 14
            })
            self:RoundCorners(keybindButton)

            local listening = false
            keybindButton.MouseButton1Click:Connect(function()
                listening = true
                keybindButton.Text = "Press a key..."
            end)

            game:GetService("UserInputService").InputBegan:Connect(function(input)
                if listening and input.UserInputType == Enum.UserInputType.Keyboard then
                    listening = false
                    keybindButton.Text = input.KeyCode.Name
                    options.callback(input.KeyCode)
                end
            end)

            return keybindFrame
        end

        -- Image with Description
        function tabFrame:Image(options)
            local imageFrame = self:Create("Frame", {
                Parent = tabFrame,
                Size = UDim2.new(1, -10, 0, 150),
                Position = UDim2.new(0, 5, 0, 0),
                BackgroundColor3 = self.Theme.Background
            })
            self:RoundCorners(imageFrame)

            local image = self:Create("ImageLabel", {
                Parent = imageFrame,
                Size = UDim2.new(1, 0, 0, 100),
                Image = "rbxassetid://" .. options.imageId,
                BackgroundTransparency = 1
            })

            local descriptionLabel = self:Create("TextLabel", {
                Parent = imageFrame,
                Size = UDim2.new(1, 0, 0, 40),
                Position = UDim2.new(0, 0, 0, 110),
                Text = options.description,
                TextColor3 = self.Theme.Text,
                BackgroundTransparency = 1,
                Font = Enum.Font.SourceSans,
                TextSize = 14,
                TextWrapped = true
            })

            return imageFrame
        end

        return tabFrame
    end

    return mainFrame
end

return UILibrary
