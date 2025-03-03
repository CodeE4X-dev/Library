getgenv().namehub = "StarX"
local UserInputService = game:GetService('UserInputService')
local LocalPlayer = game:GetService('Players').LocalPlayer
local TweenService = game:GetService('TweenService')
local HttpService = game:GetService('HttpService')
local CoreGui = game:GetService('CoreGui')

local Mouse = LocalPlayer:GetMouse();

local Library = {
    connections = {};
    Flags = {};
    Enabled = true;
    slider_drag = false;
    core = nil;
    dragging = false;
    drag_position = nil;
    start_position = nil;
}

if isfolder("StarX") then
    delfolder("StarX")
end

function Library:disconnect()
	for _, value in Library.connections do
		if not Library.connections[value] then
			continue
		end

		Library.connections[value]:Disconnect()
		Library.connections[value] = nil
	end
end

function Library:clear()
	for _, object in CoreGui:GetChildren() do
		if object.Name ~= "Star" then
			continue
		end
	
		object:Destroy()
	end
end

function Library:exist()
    if not Library.core then return end
    if not Library.core.Parent then return end
    return true
end

function Library:save_flags()
    if not Library.exist() then return end

    local flags = HttpService:JSONEncode(Library.Flags)
end

function Library:load_flags()
    if not isfile(`StarX/{game.GameId}.lua`) then Library.save_flags() return end

    local flags = readfile(`StarX/{game.GameId}.lua`)
    if not flags then Library.save_flags() return end

    Library.Flags = HttpService:JSONDecode(flags)
end

Library.load_flags()
Library.clear()

function Library:open()
	self.Container.Visible = true
	self.Shadow.Visible = true
	self.Mobile.Modal = true

	TweenService:Create(self.Container, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
		Size = UDim2.new(0, 699, 0, 426)
	}):Play()

	TweenService:Create(self.Shadow, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
		Size = UDim2.new(0, 776, 0, 509)
	}):Play()
end

function Library:close()
	TweenService:Create(self.Shadow, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
		Size = UDim2.new(0, 0, 0, 0)
	}):Play()

	local main_tween = TweenService:Create(self.Container, TweenInfo.new(0.6, Enum.EasingStyle.Circular, Enum.EasingDirection.InOut), {
		Size = UDim2.new(0, 0, 0, 0)
	})

	main_tween:Play()
	main_tween.Completed:Once(function()
		if Library.enabled then
			return
		end

		self.Container.Visible = false
		self.Shadow.Visible = false
		self.Mobile.Modal = false
	end)
end

function Library:drag()
	if not Library.drag_position then
		return
	end
	
	if not Library.start_position then
		return
	end
	
	local delta = self.input.Position - Library.drag_position
	local position = UDim2.new(Library.start_position.X.Scale, Library.start_position.X.Offset + delta.X, Library.start_position.Y.Scale, Library.start_position.Y.Offset + delta.Y)

	TweenService:Create(self.container.Container, TweenInfo.new(0.2), {
		Position = position
	}):Play()

    TweenService:Create(self.container.Shadow, TweenInfo.new(0.2), {
		Position = position
	}):Play()
end

function Library:visible()
	Library.enabled = not Library.enabled

	if Library.enabled then
		Library.open(self)
	else
		Library.close(self)
	end
end

function Library:new()
	local container = Instance.new("ScreenGui")
	container.Name = "Star"
     container.Parent = CoreGui

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
	ContainerCorner.Parent = container.Container

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
	TextLabel.Text = getgenv().namehub
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
     tabs.Parent = container.Container

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
    container.Container.InputBegan:Connect(function(input: InputObject)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            Library.dragging = true
            Library.drag_position = input.Position
            Library.start_position = container.Container.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    Library.dragging = false
                    Library.drag_position = nil
                    Library.start_position = nil
                end
            end)
        end
    end)

    UserInputService.InputChanged:Connect(function(input: InputObject)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            Library.drag({
                input = input,
                container = container
            })
        end
    end)

    UserInputService.InputBegan:Connect(function(input: InputObject, process: boolean)
        if process then return end

        if not Library.exist() then return end

        if input.KeyCode == Enum.KeyCode.Insert then
            Library.visible(container)
        end
    end)

    mobile_button.MouseButton1Click:Connect(function()
        Library.visible(container)
    end)

    local Tab = {}

    function Tab:update_sections()
        self.left_section.Visible = true
        self.right_section.Visible = true

        for _, object in container.Container:GetChildren() do
            if not object.Name:find("Section") then
                continue
            end

            if object == self.left_section then 
                continue
            end

            if object == self.right_section then
                continue
            end

            object.Visible = false
        end
    end

    function Tab:open_tab()
		Tab.update_sections({
			left_section = self.left_section,
			right_section = self.right_section
		})

		TweenService:Create(self.tab.Fill, TweenInfo.new(0.4), {
			BackgroundTransparency = 0
		}):Play()

		TweenService:Create(self.tab.Glow, TweenInfo.new(0.4), {
			ImageTransparency = 0
		}):Play()

		TweenService:Create(self.tab.TextLabel, TweenInfo.new(0.4), {
			TextTransparency = 0
		}):Play()

		TweenService:Create(self.tab.Logo, TweenInfo.new(0.4), {
			ImageTransparency = 0
		}):Play()

		for _, object in tabs:GetChildren() do
			if object.Name ~= 'Tab' then
				continue
			end

			if object == self.tab then
				continue
			end

			TweenService:Create(object.Fill, TweenInfo.new(0.4), {
				BackgroundTransparency = 1
			}):Play()

			TweenService:Create(object.Glow, TweenInfo.new(0.4), {
				ImageTransparency = 1
			}):Play()
	
			TweenService:Create(object.TextLabel, TweenInfo.new(0.4), {
				TextTransparency = 0.5
			}):Play()
	
			TweenService:Create(object.Logo, TweenInfo.new(0.4), {
				ImageTransparency = 0.5
			}):Play()
		end
	end

    function Tab:create_tab(options)
        local title = options.Title
        local icon = options.Icon
    
        -- Tabel untuk mencocokkan ikon dengan rbassetid
        local icons = {
                assets = {
                    ["lucide-accessibility"] = "rbxassetid://10709751939",
                    ["lucide-activity"] = "rbxassetid://10709752035",
                    ["lucide-air-vent"] = "rbxassetid://10709752131",
                    ["lucide-airplay"] = "rbxassetid://10709752254",
                    ["lucide-alarm-check"] = "rbxassetid://10709752405",
                    ["lucide-alarm-clock"] = "rbxassetid://10709752630",
                    ["lucide-alarm-clock-off"] = "rbxassetid://10709752508",
                    ["lucide-alarm-minus"] = "rbxassetid://10709752732",
                    ["lucide-alarm-plus"] = "rbxassetid://10709752825",
                    ["lucide-album"] = "rbxassetid://10709752906",
                    ["lucide-alert-circle"] = "rbxassetid://10709752996",
                    ["lucide-alert-octagon"] = "rbxassetid://10709753064",
                    ["lucide-alert-triangle"] = "rbxassetid://10709753149",
                    ["lucide-align-center"] = "rbxassetid://10709753570",
                    ["lucide-align-center-horizontal"] = "rbxassetid://10709753272",
                    ["lucide-align-center-vertical"] = "rbxassetid://10709753421",
                    ["lucide-align-end-horizontal"] = "rbxassetid://10709753692",
                    ["lucide-align-end-vertical"] = "rbxassetid://10709753808",
                    ["lucide-align-horizontal-distribute-center"] = "rbxassetid://10747779791",
                    ["lucide-align-horizontal-distribute-end"] = "rbxassetid://10747784534",
                    ["lucide-align-horizontal-distribute-start"] = "rbxassetid://10709754118",
                    ["lucide-align-horizontal-justify-center"] = "rbxassetid://10709754204",
                    ["lucide-align-horizontal-justify-end"] = "rbxassetid://10709754317",
                    ["lucide-align-horizontal-justify-start"] = "rbxassetid://10709754436",
                    ["lucide-align-horizontal-space-around"] = "rbxassetid://10709754590",
                    ["lucide-align-horizontal-space-between"] = "rbxassetid://10709754749",
                    ["lucide-align-justify"] = "rbxassetid://10709759610",
                    ["lucide-align-left"] = "rbxassetid://10709759764",
                    ["lucide-align-right"] = "rbxassetid://10709759895",
                    ["lucide-align-start-horizontal"] = "rbxassetid://10709760051",
                    ["lucide-align-start-vertical"] = "rbxassetid://10709760244",
                    ["lucide-align-vertical-distribute-center"] = "rbxassetid://10709760351",
                    ["lucide-align-vertical-distribute-end"] = "rbxassetid://10709760434",
                    ["lucide-align-vertical-distribute-start"] = "rbxassetid://10709760612",
                    ["lucide-align-vertical-justify-center"] = "rbxassetid://10709760814",
                    ["lucide-align-vertical-justify-end"] = "rbxassetid://10709761003",
                    ["lucide-align-vertical-justify-start"] = "rbxassetid://10709761176",
                    ["lucide-align-vertical-space-around"] = "rbxassetid://10709761324",
                    ["lucide-align-vertical-space-between"] = "rbxassetid://10709761434",
                    ["lucide-anchor"] = "rbxassetid://10709761530",
                    ["lucide-angry"] = "rbxassetid://10709761629",
                    ["lucide-annoyed"] = "rbxassetid://10709761722",
                    ["lucide-aperture"] = "rbxassetid://10709761813",
                    ["lucide-apple"] = "rbxassetid://10709761889",
                    ["lucide-archive"] = "rbxassetid://10709762233",
                    ["lucide-archive-restore"] = "rbxassetid://10709762058",
                    ["lucide-armchair"] = "rbxassetid://10709762327",
                    ["lucide-arrow-big-down"] = "rbxassetid://10747796644",
                    ["lucide-arrow-big-left"] = "rbxassetid://10709762574",
                    ["lucide-arrow-big-right"] = "rbxassetid://10709762727",
                    ["lucide-arrow-big-up"] = "rbxassetid://10709762879",
                    ["lucide-arrow-down"] = "rbxassetid://10709767827",
                    ["lucide-arrow-down-circle"] = "rbxassetid://10709763034",
                    ["lucide-arrow-down-left"] = "rbxassetid://10709767656",
                    ["lucide-arrow-down-right"] = "rbxassetid://10709767750",
                    ["lucide-arrow-left"] = "rbxassetid://10709768114",
                    ["lucide-arrow-left-circle"] = "rbxassetid://10709767936",
                    ["lucide-arrow-left-right"] = "rbxassetid://10709768019",
                    ["lucide-arrow-right"] = "rbxassetid://10709768347",
                    ["lucide-arrow-right-circle"] = "rbxassetid://10709768226",
                    ["lucide-arrow-up"] = "rbxassetid://10709768939",
                    ["lucide-arrow-up-circle"] = "rbxassetid://10709768432",
                    ["lucide-arrow-up-down"] = "rbxassetid://10709768538",
                    ["lucide-arrow-up-left"] = "rbxassetid://10709768661",
                    ["lucide-arrow-up-right"] = "rbxassetid://10709768787",
                    ["lucide-asterisk"] = "rbxassetid://10709769095",
                    ["lucide-at-sign"] = "rbxassetid://10709769286",
                    ["lucide-award"] = "rbxassetid://10709769406",
                    ["lucide-axe"] = "rbxassetid://10709769508",
                    ["lucide-axis-3d"] = "rbxassetid://10709769598",
                    ["lucide-baby"] = "rbxassetid://10709769732",
                    ["lucide-backpack"] = "rbxassetid://10709769841",
                    ["lucide-baggage-claim"] = "rbxassetid://10709769935",
                    ["lucide-banana"] = "rbxassetid://10709770005",
                    ["lucide-banknote"] = "rbxassetid://10709770178",
                    ["lucide-bar-chart"] = "rbxassetid://10709773755",
                    ["lucide-bar-chart-2"] = "rbxassetid://10709770317",
                    ["lucide-bar-chart-3"] = "rbxassetid://10709770431",
                    ["lucide-bar-chart-4"] = "rbxassetid://10709770560",
                    ["lucide-bar-chart-horizontal"] = "rbxassetid://10709773669",
                    ["lucide-barcode"] = "rbxassetid://10747360675",
                    ["lucide-baseline"] = "rbxassetid://10709773863",
                    ["lucide-bath"] = "rbxassetid://10709773963",
                    ["lucide-battery"] = "rbxassetid://10709774640",
                    ["lucide-battery-charging"] = "rbxassetid://10709774068",
                    ["lucide-battery-full"] = "rbxassetid://10709774206",
                    ["lucide-battery-low"] = "rbxassetid://10709774370",
                    ["lucide-battery-medium"] = "rbxassetid://10709774513",
                    ["lucide-beaker"] = "rbxassetid://10709774756",
                    ["lucide-bed"] = "rbxassetid://10709775036",
                    ["lucide-bed-double"] = "rbxassetid://10709774864",
                    ["lucide-bed-single"] = "rbxassetid://10709774968",
                    ["lucide-beer"] = "rbxassetid://10709775167",
                    ["lucide-bell"] = "rbxassetid://10709775704",
                    ["lucide-bell-minus"] = "rbxassetid://10709775241",
                    ["lucide-bell-off"] = "rbxassetid://10709775320",
                    ["lucide-bell-plus"] = "rbxassetid://10709775448",
                    ["lucide-bell-ring"] = "rbxassetid://10709775560",
                    ["lucide-bike"] = "rbxassetid://10709775894",
                    ["lucide-binary"] = "rbxassetid://10709776050",
                    ["lucide-bitcoin"] = "rbxassetid://10709776126",
                    ["lucide-bluetooth"] = "rbxassetid://10709776655",
                    ["lucide-bluetooth-connected"] = "rbxassetid://10709776240",
                    ["lucide-bluetooth-off"] = "rbxassetid://10709776344",
                    ["lucide-bluetooth-searching"] = "rbxassetid://10709776501",
                    ["lucide-bold"] = "rbxassetid://10747813908",
                    ["lucide-bomb"] = "rbxassetid://10709781460",
                    ["lucide-bone"] = "rbxassetid://10709781605",
                    ["lucide-book"] = "rbxassetid://10709781824",
                    ["lucide-book-open"] = "rbxassetid://10709781717",
                    ["lucide-bookmark"] = "rbxassetid://10709782154",
                    ["lucide-bookmark-minus"] = "rbxassetid://10709781919",
                    ["lucide-bookmark-plus"] = "rbxassetid://10709782044",
                    ["lucide-bot"] = "rbxassetid://10709782230",
                    ["lucide-box"] = "rbxassetid://10709782497",
                    ["lucide-box-select"] = "rbxassetid://10709782342",
                    ["lucide-boxes"] = "rbxassetid://10709782582",
                    ["lucide-briefcase"] = "rbxassetid://10709782662",
                    ["lucide-brush"] = "rbxassetid://10709782758",
                    ["lucide-bug"] = "rbxassetid://10709782845",
                    ["lucide-building"] = "rbxassetid://10709783051",
                    ["lucide-building-2"] = "rbxassetid://10709782939",
                    ["lucide-bus"] = "rbxassetid://10709783137",
                    ["lucide-cake"] = "rbxassetid://10709783217",
                    ["lucide-calculator"] = "rbxassetid://10709783311",
                    ["lucide-calendar"] = "rbxassetid://10709789505",
                    ["lucide-calendar-check"] = "rbxassetid://10709783474",
                    ["lucide-calendar-check-2"] = "rbxassetid://10709783392",
                    ["lucide-calendar-clock"] = "rbxassetid://10709783577",
                    ["lucide-calendar-days"] = "rbxassetid://10709783673",
                    ["lucide-calendar-heart"] = "rbxassetid://10709783835",
                    ["lucide-calendar-minus"] = "rbxassetid://10709783959",
                    ["lucide-calendar-off"] = "rbxassetid://10709788784",
                    ["lucide-calendar-plus"] = "rbxassetid://10709788937",
                    ["lucide-calendar-range"] = "rbxassetid://10709789053",
                    ["lucide-calendar-search"] = "rbxassetid://10709789200",
                    ["lucide-calendar-x"] = "rbxassetid://10709789407",
                    ["lucide-calendar-x-2"] = "rbxassetid://10709789329",
                    ["lucide-camera"] = "rbxassetid://10709789686",
                    ["lucide-camera-off"] = "rbxassetid://10747822677",
                    ["lucide-car"] = "rbxassetid://10709789810",
                    ["lucide-carrot"] = "rbxassetid://10709789960",
                    ["lucide-cast"] = "rbxassetid://10709790097",
                    ["lucide-charge"] = "rbxassetid://10709790202",
                    ["lucide-check"] = "rbxassetid://10709790644",
                    ["lucide-check-circle"] = "rbxassetid://10709790387",
                    ["lucide-check-circle-2"] = "rbxassetid://10709790298",
                    ["lucide-check-square"] = "rbxassetid://10709790537",
                    ["lucide-chef-hat"] = "rbxassetid://10709790757",
                    ["lucide-cherry"] = "rbxassetid://10709790875",
                    ["lucide-chevron-down"] = "rbxassetid://10709790948",
                    ["lucide-chevron-first"] = "rbxassetid://10709791015",
                    ["lucide-chevron-last"] = "rbxassetid://10709791130",
                    ["lucide-chevron-left"] = "rbxassetid://10709791281",
                    ["lucide-chevron-right"] = "rbxassetid://10709791437",
                    ["lucide-chevron-up"] = "rbxassetid://10709791523",
                    ["lucide-chevrons-down"] = "rbxassetid://10709796864",
                    ["lucide-chevrons-down-up"] = "rbxassetid://10709791632",
                    ["lucide-chevrons-left"] = "rbxassetid://10709797151",
                    ["lucide-chevrons-left-right"] = "rbxassetid://10709797006",
                    ["lucide-chevrons-right"] = "rbxassetid://10709797382",
                    ["lucide-chevrons-right-left"] = "rbxassetid://10709797274",
                    ["lucide-chevrons-up"] = "rbxassetid://10709797622",
                    ["lucide-chevrons-up-down"] = "rbxassetid://10709797508",
                    ["lucide-chrome"] = "rbxassetid://10709797725",
                    ["lucide-circle"] = "rbxassetid://10709798174",
                    ["lucide-circle-dot"] = "rbxassetid://10709797837",
                    ["lucide-circle-ellipsis"] = "rbxassetid://10709797985",
                    ["lucide-circle-slashed"] = "rbxassetid://10709798100",
                    ["lucide-citrus"] = "rbxassetid://10709798276",
                    ["lucide-clapperboard"] = "rbxassetid://10709798350",
                    ["lucide-clipboard"] = "rbxassetid://10709799288",
                    ["lucide-clipboard-check"] = "rbxassetid://10709798443",
                    ["lucide-clipboard-copy"] = "rbxassetid://10709798574",
                    ["lucide-clipboard-edit"] = "rbxassetid://10709798682",
                    ["lucide-clipboard-list"] = "rbxassetid://10709798792",
                    ["lucide-clipboard-signature"] = "rbxassetid://10709798890",
                    ["lucide-clipboard-type"] = "rbxassetid://10709798999",
                    ["lucide-clipboard-x"] = "rbxassetid://10709799124",
                    ["lucide-clock"] = "rbxassetid://10709805144",
                    ["lucide-clock-1"] = "rbxassetid://10709799535",
                    ["lucide-clock-10"] = "rbxassetid://10709799718",
                    ["lucide-clock-11"] = "rbxassetid://10709799818",
                    ["lucide-clock-12"] = "rbxassetid://10709799962",
                    ["lucide-clock-2"] = "rbxassetid://10709803876",
                    ["lucide-clock-3"] = "rbxassetid://10709803989",
                    ["lucide-clock-4"] = "rbxassetid://10709804164",
                    ["lucide-clock-5"] = "rbxassetid://10709804291",
                    ["lucide-clock-6"] = "rbxassetid://10709804435",
                    ["lucide-clock-7"] = "rbxassetid://10709804599",
                    ["lucide-clock-8"] = "rbxassetid://10709804784",
                    ["lucide-clock-9"] = "rbxassetid://10709804996",
                    ["lucide-cloud"] = "rbxassetid://10709806740",
                    ["lucide-cloud-cog"] = "rbxassetid://10709805262",
                    ["lucide-cloud-drizzle"] = "rbxassetid://10709805371",
                    ["lucide-cloud-fog"] = "rbxassetid://10709805477",
                    ["lucide-cloud-hail"] = "rbxassetid://10709805596",
                    ["lucide-cloud-lightning"] = "rbxassetid://10709805727",
                    ["lucide-cloud-moon"] = "rbxassetid://10709805942",
                    ["lucide-cloud-moon-rain"] = "rbxassetid://10709805838",
                    ["lucide-cloud-off"] = "rbxassetid://10709806060",
                    ["lucide-cloud-rain"] = "rbxassetid://10709806277",
                    ["lucide-cloud-rain-wind"] = "rbxassetid://10709806166",
                    ["lucide-cloud-snow"] = "rbxassetid://10709806374",
                    ["lucide-cloud-sun"] = "rbxassetid://10709806631",
                    ["lucide-cloud-sun-rain"] = "rbxassetid://10709806475",
                    ["lucide-cloudy"] = "rbxassetid://10709806859",
                    ["lucide-clover"] = "rbxassetid://10709806995",
                    ["lucide-code"] = "rbxassetid://10709810463",
                    ["lucide-code-2"] = "rbxassetid://10709807111",
                    ["lucide-codepen"] = "rbxassetid://10709810534",
                    ["lucide-codesandbox"] = "rbxassetid://10709810676",
                    ["lucide-coffee"] = "rbxassetid://10709810814",
                    ["lucide-cog"] = "rbxassetid://10709810948",
                    ["lucide-coins"] = "rbxassetid://10709811110",
                    ["lucide-columns"] = "rbxassetid://10709811261",
                    ["lucide-command"] = "rbxassetid://10709811365",
                    ["lucide-compass"] = "rbxassetid://10709811445",
                    ["lucide-component"] = "rbxassetid://10709811595",
                    ["lucide-concierge-bell"] = "rbxassetid://10709811706",
                    ["lucide-connection"] = "rbxassetid://10747361219",
                    ["lucide-contact"] = "rbxassetid://10709811834",
                    ["lucide-contrast"] = "rbxassetid://10709811939",
                    ["lucide-cookie"] = "rbxassetid://10709812067",
                    ["lucide-copy"] = "rbxassetid://10709812159",
                    ["lucide-copyleft"] = "rbxassetid://10709812251",
                    ["lucide-copyright"] = "rbxassetid://10709812311",
                    ["lucide-corner-down-left"] = "rbxassetid://10709812396",
                    ["lucide-corner-down-right"] = "rbxassetid://10709812485",
                    ["lucide-corner-left-down"] = "rbxassetid://10709812632",
                    ["lucide-corner-left-up"] = "rbxassetid://10709812784",
                    ["lucide-corner-right-down"] = "rbxassetid://10709812939",
                    ["lucide-corner-right-up"] = "rbxassetid://10709813094",
                    ["lucide-corner-up-left"] = "rbxassetid://10709813185",
                    ["lucide-corner-up-right"] = "rbxassetid://10709813281",
                    ["lucide-cpu"] = "rbxassetid://10709813383",
                    ["lucide-croissant"] = "rbxassetid://10709818125",
                    ["lucide-crop"] = "rbxassetid://10709818245",
                    ["lucide-cross"] = "rbxassetid://10709818399",
                    ["lucide-crosshair"] = "rbxassetid://10709818534",
                    ["lucide-crown"] = "rbxassetid://10709818626",
                    ["lucide-cup-soda"] = "rbxassetid://10709818763",
                    ["lucide-curly-braces"] = "rbxassetid://10709818847",
                    ["lucide-currency"] = "rbxassetid://10709818931",
                    ["lucide-database"] = "rbxassetid://10709818996",
                    ["lucide-delete"] = "rbxassetid://10709819059",
                    ["lucide-diamond"] = "rbxassetid://10709819149",
                    ["lucide-dice-1"] = "rbxassetid://10709819266",
                    ["lucide-dice-2"] = "rbxassetid://10709819361",
                    ["lucide-dice-3"] = "rbxassetid://10709819508",
                    ["lucide-dice-4"] = "rbxassetid://10709819670",
                    ["lucide-dice-5"] = "rbxassetid://10709819801",
                    ["lucide-dice-6"] = "rbxassetid://10709819896",
                    ["lucide-dices"] = "rbxassetid://10723343321",
                    ["lucide-diff"] = "rbxassetid://10723343416",
                    ["lucide-disc"] = "rbxassetid://10723343537",
                    ["lucide-divide"] = "rbxassetid://10723343805",
                    ["lucide-divide-circle"] = "rbxassetid://10723343636",
                    ["lucide-divide-square"] = "rbxassetid://10723343737",
                    ["lucide-dollar-sign"] = "rbxassetid://10723343958",
                    ["lucide-download"] = "rbxassetid://10723344270",
                    ["lucide-download-cloud"] = "rbxassetid://10723344088",
                    ["lucide-droplet"] = "rbxassetid://10723344432",
                    ["lucide-droplets"] = "rbxassetid://10734883356",
                    ["lucide-drumstick"] = "rbxassetid://10723344737",
                    ["lucide-edit"] = "rbxassetid://10734883598",
                    ["lucide-edit-2"] = "rbxassetid://10723344885",
                    ["lucide-edit-3"] = "rbxassetid://10723345088",
                    ["lucide-egg"] = "rbxassetid://10723345518",
                    ["lucide-egg-fried"] = "rbxassetid://10723345347",
                    ["lucide-electricity"] = "rbxassetid://10723345749",
                    ["lucide-electricity-off"] = "rbxassetid://10723345643",
                    ["lucide-equal"] = "rbxassetid://10723345990",
                    ["lucide-equal-not"] = "rbxassetid://10723345866",
                    ["lucide-eraser"] = "rbxassetid://10723346158",
                    ["lucide-euro"] = "rbxassetid://10723346372",
                    ["lucide-expand"] = "rbxassetid://10723346553",
                    ["lucide-external-link"] = "rbxassetid://10723346684",
                    ["lucide-eye"] = "rbxassetid://10723346959",
                    ["lucide-eye-off"] = "rbxassetid://10723346871",
                    ["lucide-factory"] = "rbxassetid://10723347051",
                    ["lucide-fan"] = "rbxassetid://10723354359",
                    ["lucide-fast-forward"] = "rbxassetid://10723354521",
                    ["lucide-feather"] = "rbxassetid://10723354671",
                    ["lucide-figma"] = "rbxassetid://10723354801",
                    ["lucide-file"] = "rbxassetid://10723374641",
                    ["lucide-file-archive"] = "rbxassetid://10723354921",
                    ["lucide-file-audio"] = "rbxassetid://10723355148",
                    ["lucide-file-audio-2"] = "rbxassetid://10723355026",
                    ["lucide-file-axis-3d"] = "rbxassetid://10723355272",
                    ["lucide-file-badge"] = "rbxassetid://10723355622",
                    ["lucide-file-badge-2"] = "rbxassetid://10723355451",
                    ["lucide-file-bar-chart"] = "rbxassetid://10723355887",
                    ["lucide-file-bar-chart-2"] = "rbxassetid://10723355746",
                    ["lucide-file-box"] = "rbxassetid://10723355989",
                    ["lucide-file-check"] = "rbxassetid://10723356210",
                    ["lucide-file-check-2"] = "rbxassetid://10723356100",
                    ["lucide-file-clock"] = "rbxassetid://10723356329",
                    ["lucide-file-code"] = "rbxassetid://10723356507",
                    ["lucide-file-cog"] = "rbxassetid://10723356830",
                    ["lucide-file-cog-2"] = "rbxassetid://10723356676",
                    ["lucide-file-diff"] = "rbxassetid://10723357039",
                    ["lucide-file-digit"] = "rbxassetid://10723357151",
                    ["lucide-file-down"] = "rbxassetid://10723357322",
                    ["lucide-file-edit"] = "rbxassetid://10723357495",
                    ["lucide-file-heart"] = "rbxassetid://10723357637",
                    ["lucide-file-image"] = "rbxassetid://10723357790",
                    ["lucide-file-input"] = "rbxassetid://10723357933",
                    ["lucide-file-json"] = "rbxassetid://10723364435",
                    ["lucide-file-json-2"] = "rbxassetid://10723364361",
                    ["lucide-file-key"] = "rbxassetid://10723364605",
                    ["lucide-file-key-2"] = "rbxassetid://10723364515",
                    ["lucide-file-line-chart"] = "rbxassetid://10723364725",
                    ["lucide-file-lock"] = "rbxassetid://10723364957",
                    ["lucide-file-lock-2"] = "rbxassetid://10723364861",
                    ["lucide-file-minus"] = "rbxassetid://10723365254",
                    ["lucide-file-minus-2"] = "rbxassetid://10723365086",
                    ["lucide-file-output"] = "rbxassetid://10723365457",
                    ["lucide-file-pie-chart"] = "rbxassetid://10723365598",
                    ["lucide-file-plus"] = "rbxassetid://10723365877",
                    ["lucide-file-plus-2"] = "rbxassetid://10723365766",
                    ["lucide-file-question"] = "rbxassetid://10723365987",
                    ["lucide-file-scan"] = "rbxassetid://10723366167",
                    ["lucide-file-search"] = "rbxassetid://10723366550",
                    ["lucide-file-search-2"] = "rbxassetid://10723366340",
                    ["lucide-file-signature"] = "rbxassetid://10723366741",
                    ["lucide-file-spreadsheet"] = "rbxassetid://10723366962",
                    ["lucide-file-symlink"] = "rbxassetid://10723367098",
                    ["lucide-file-terminal"] = "rbxassetid://10723367244",
                    ["lucide-file-text"] = "rbxassetid://10723367380",
                    ["lucide-file-type"] = "rbxassetid://10723367606",
                    ["lucide-file-type-2"] = "rbxassetid://10723367509",
                    ["lucide-file-up"] = "rbxassetid://10723367734",
                    ["lucide-file-video"] = "rbxassetid://10723373884",
                    ["lucide-file-video-2"] = "rbxassetid://10723367834",
                    ["lucide-file-volume"] = "rbxassetid://10723374172",
                    ["lucide-file-volume-2"] = "rbxassetid://10723374030",
                    ["lucide-file-warning"] = "rbxassetid://10723374276",
                    ["lucide-file-x"] = "rbxassetid://10723374544",
                    ["lucide-file-x-2"] = "rbxassetid://10723374378",
                    ["lucide-files"] = "rbxassetid://10723374759",
                    ["lucide-film"] = "rbxassetid://10723374981",
                    ["lucide-filter"] = "rbxassetid://10723375128",
                    ["lucide-fingerprint"] = "rbxassetid://10723375250",
                    ["lucide-flag"] = "rbxassetid://10723375890",
                    ["lucide-flag-off"] = "rbxassetid://10723375443",
                    ["lucide-flag-triangle-left"] = "rbxassetid://10723375608",
                    ["lucide-flag-triangle-right"] = "rbxassetid://10723375727",
                    ["lucide-flame"] = "rbxassetid://10723376114",
                    ["lucide-flashlight"] = "rbxassetid://10723376471",
                    ["lucide-flashlight-off"] = "rbxassetid://10723376365",
                    ["lucide-flask-conical"] = "rbxassetid://10734883986",
                    ["lucide-flask-round"] = "rbxassetid://10723376614",
                    ["lucide-flip-horizontal"] = "rbxassetid://10723376884",
                    ["lucide-flip-horizontal-2"] = "rbxassetid://10723376745",
                    ["lucide-flip-vertical"] = "rbxassetid://10723377138",
                    ["lucide-flip-vertical-2"] = "rbxassetid://10723377026",
                    ["lucide-flower"] = "rbxassetid://10747830374",
                    ["lucide-flower-2"] = "rbxassetid://10723377305",
                    ["lucide-focus"] = "rbxassetid://10723377537",
                    ["lucide-folder"] = "rbxassetid://10723387563",
                    ["lucide-folder-archive"] = "rbxassetid://10723384478",
                    ["lucide-folder-check"] = "rbxassetid://10723384605",
                    ["lucide-folder-clock"] = "rbxassetid://10723384731",
                    ["lucide-folder-closed"] = "rbxassetid://10723384893",
                    ["lucide-folder-cog"] = "rbxassetid://10723385213",
                    ["lucide-folder-cog-2"] = "rbxassetid://10723385036",
                    ["lucide-folder-down"] = "rbxassetid://10723385338",
                    ["lucide-folder-edit"] = "rbxassetid://10723385445",
                    ["lucide-folder-heart"] = "rbxassetid://10723385545",
                    ["lucide-folder-input"] = "rbxassetid://10723385721",
                    ["lucide-folder-key"] = "rbxassetid://10723385848",
                    ["lucide-folder-lock"] = "rbxassetid://10723386005",
                    ["lucide-folder-minus"] = "rbxassetid://10723386127",
                    ["lucide-folder-open"] = "rbxassetid://10723386277",
                    ["lucide-folder-output"] = "rbxassetid://10723386386",
                    ["lucide-folder-plus"] = "rbxassetid://10723386531",
                    ["lucide-folder-search"] = "rbxassetid://10723386787",
                    ["lucide-folder-search-2"] = "rbxassetid://10723386674",
                    ["lucide-folder-symlink"] = "rbxassetid://10723386930",
                    ["lucide-folder-tree"] = "rbxassetid://10723387085",
                    ["lucide-folder-up"] = "rbxassetid://10723387265",
                    ["lucide-folder-x"] = "rbxassetid://10723387448",
                    ["lucide-folders"] = "rbxassetid://10723387721",
                    ["lucide-form-input"] = "rbxassetid://10723387841",
                    ["lucide-forward"] = "rbxassetid://10723388016",
                    ["lucide-frame"] = "rbxassetid://10723394389",
                    ["lucide-framer"] = "rbxassetid://10723394565",
                    ["lucide-frown"] = "rbxassetid://10723394681",
                    ["lucide-fuel"] = "rbxassetid://10723394846",
                    ["lucide-function-square"] = "rbxassetid://10723395041",
                    ["lucide-gamepad"] = "rbxassetid://10723395457",
                    ["lucide-gamepad-2"] = "rbxassetid://10723395215",
                    ["lucide-gauge"] = "rbxassetid://10723395708",
                    ["lucide-gavel"] = "rbxassetid://10723395896",
                    ["lucide-gem"] = "rbxassetid://10723396000",
                    ["lucide-ghost"] = "rbxassetid://10723396107",
                    ["lucide-gift"] = "rbxassetid://10723396402",
                    ["lucide-gift-card"] = "rbxassetid://10723396225",
                    ["lucide-git-branch"] = "rbxassetid://10723396676",
                    ["lucide-git-branch-plus"] = "rbxassetid://10723396542",
                    ["lucide-git-commit"] = "rbxassetid://10723396812",
                    ["lucide-git-compare"] = "rbxassetid://10723396954",
                    ["lucide-git-fork"] = "rbxassetid://10723397049",
                    ["lucide-git-merge"] = "rbxassetid://10723397165",
                    ["lucide-git-pull-request"] = "rbxassetid://10723397431",
                    ["lucide-git-pull-request-closed"] = "rbxassetid://10723397268",
                    ["lucide-git-pull-request-draft"] = "rbxassetid://10734884302",
                    ["lucide-glass"] = "rbxassetid://10723397788",
                    ["lucide-glass-2"] = "rbxassetid://10723397529",
                    ["lucide-glass-water"] = "rbxassetid://10723397678",
                    ["lucide-glasses"] = "rbxassetid://10723397895",
                    ["lucide-globe"] = "rbxassetid://10723404337",
                    ["lucide-globe-2"] = "rbxassetid://10723398002",
                    ["lucide-grab"] = "rbxassetid://10723404472",
                    ["lucide-graduation-cap"] = "rbxassetid://10723404691",
                    ["lucide-grape"] = "rbxassetid://10723404822",
                    ["lucide-grid"] = "rbxassetid://10723404936",
                    ["lucide-grip-horizontal"] = "rbxassetid://10723405089",
                    ["lucide-grip-vertical"] = "rbxassetid://10723405236",
                    ["lucide-hammer"] = "rbxassetid://10723405360",
                    ["lucide-hand"] = "rbxassetid://10723405649",
                    ["lucide-hand-metal"] = "rbxassetid://10723405508",
                    ["lucide-hard-drive"] = "rbxassetid://10723405749",
                    ["lucide-hard-hat"] = "rbxassetid://10723405859",
                    ["lucide-hash"] = "rbxassetid://10723405975",
                    ["lucide-haze"] = "rbxassetid://10723406078",
                    ["lucide-headphones"] = "rbxassetid://10723406165",
                    ["lucide-heart"] = "rbxassetid://10723406885",
                    ["lucide-heart-crack"] = "rbxassetid://10723406299",
                    ["lucide-heart-handshake"] = "rbxassetid://10723406480",
                    ["lucide-heart-off"] = "rbxassetid://10723406662",
                    ["lucide-heart-pulse"] = "rbxassetid://10723406795",
                    ["lucide-help-circle"] = "rbxassetid://10723406988",
                    ["lucide-hexagon"] = "rbxassetid://10723407092",
                    ["lucide-highlighter"] = "rbxassetid://10723407192",
                    ["lucide-history"] = "rbxassetid://10723407335",
                    ["lucide-home"] = "rbxassetid://10723407389",
                    ["lucide-hourglass"] = "rbxassetid://10723407498",
                    ["lucide-ice-cream"] = "rbxassetid://10723414308",
                    ["lucide-image"] = "rbxassetid://10723415040",
                    ["lucide-image-minus"] = "rbxassetid://10723414487",
                    ["lucide-image-off"] = "rbxassetid://10723414677",
                    ["lucide-image-plus"] = "rbxassetid://10723414827",
                    ["lucide-import"] = "rbxassetid://10723415205",
                    ["lucide-inbox"] = "rbxassetid://10723415335",
                    ["lucide-indent"] = "rbxassetid://10723415494",
                    ["lucide-indian-rupee"] = "rbxassetid://10723415642",
                    ["lucide-infinity"] = "rbxassetid://10723415766",
                    ["lucide-info"] = "rbxassetid://10723415903",
                    ["lucide-inspect"] = "rbxassetid://10723416057",
                    ["lucide-italic"] = "rbxassetid://10723416195",
                    ["lucide-japanese-yen"] = "rbxassetid://10723416363",
                    ["lucide-joystick"] = "rbxassetid://10723416527",
                    ["lucide-key"] = "rbxassetid://10723416652",
                    ["lucide-keyboard"] = "rbxassetid://10723416765",
                    ["lucide-lamp"] = "rbxassetid://10723417513",
                    ["lucide-lamp-ceiling"] = "rbxassetid://10723416922",
                    ["lucide-lamp-desk"] = "rbxassetid://10723417016",
                    ["lucide-lamp-floor"] = "rbxassetid://10723417131",
                    ["lucide-lamp-wall-down"] = "rbxassetid://10723417240",
                    ["lucide-lamp-wall-up"] = "rbxassetid://10723417356",
                    ["lucide-landmark"] = "rbxassetid://10723417608",
                    ["lucide-languages"] = "rbxassetid://10723417703",
                    ["lucide-laptop"] = "rbxassetid://10723423881",
                    ["lucide-laptop-2"] = "rbxassetid://10723417797",
                    ["lucide-lasso"] = "rbxassetid://10723424235",
                    ["lucide-lasso-select"] = "rbxassetid://10723424058",
                    ["lucide-laugh"] = "rbxassetid://10723424372",
                    ["lucide-layers"] = "rbxassetid://10723424505",
                    ["lucide-layout"] = "rbxassetid://10723425376",
                    ["lucide-layout-dashboard"] = "rbxassetid://10723424646",
                    ["lucide-layout-grid"] = "rbxassetid://10723424838",
                    ["lucide-layout-list"] = "rbxassetid://10723424963",
                    ["lucide-layout-template"] = "rbxassetid://10723425187",
                    ["lucide-leaf"] = "rbxassetid://10723425539",
                    ["lucide-library"] = "rbxassetid://10723425615",
                    ["lucide-life-buoy"] = "rbxassetid://10723425685",
                    ["lucide-lightbulb"] = "rbxassetid://10723425852",
                    ["lucide-lightbulb-off"] = "rbxassetid://10723425762",
                    ["lucide-line-chart"] = "rbxassetid://10723426393",
                    ["lucide-link"] = "rbxassetid://10723426722",
                    ["lucide-link-2"] = "rbxassetid://10723426595",
                    ["lucide-link-2-off"] = "rbxassetid://10723426513",
                    ["lucide-list"] = "rbxassetid://10723433811",
                    ["lucide-list-checks"] = "rbxassetid://10734884548",
                    ["lucide-list-end"] = "rbxassetid://10723426886",
                    ["lucide-list-minus"] = "rbxassetid://10723426986",
                    ["lucide-list-music"] = "rbxassetid://10723427081",
                    ["lucide-list-ordered"] = "rbxassetid://10723427199",
                    ["lucide-list-plus"] = "rbxassetid://10723427334",
                    ["lucide-list-start"] = "rbxassetid://10723427494",
                    ["lucide-list-video"] = "rbxassetid://10723427619",
                    ["lucide-list-x"] = "rbxassetid://10723433655",
                    ["lucide-loader"] = "rbxassetid://10723434070",
                    ["lucide-loader-2"] = "rbxassetid://10723433935",
                    ["lucide-locate"] = "rbxassetid://10723434557",
                    ["lucide-locate-fixed"] = "rbxassetid://10723434236",
                    ["lucide-locate-off"] = "rbxassetid://10723434379",
                    ["lucide-lock"] = "rbxassetid://10723434711",
                    ["lucide-log-in"] = "rbxassetid://10723434830",
                    ["lucide-log-out"] = "rbxassetid://10723434906",
                    ["lucide-luggage"] = "rbxassetid://10723434993",
                    ["lucide-magnet"] = "rbxassetid://10723435069",
                    ["lucide-mail"] = "rbxassetid://10734885430",
                    ["lucide-mail-check"] = "rbxassetid://10723435182",
                    ["lucide-mail-minus"] = "rbxassetid://10723435261",
                    ["lucide-mail-open"] = "rbxassetid://10723435342",
                    ["lucide-mail-plus"] = "rbxassetid://10723435443",
                    ["lucide-mail-question"] = "rbxassetid://10723435515",
                    ["lucide-mail-search"] = "rbxassetid://10734884739",
                    ["lucide-mail-warning"] = "rbxassetid://10734885015",
                    ["lucide-mail-x"] = "rbxassetid://10734885247",
                    ["lucide-mails"] = "rbxassetid://10734885614",
                    ["lucide-map"] = "rbxassetid://10734886202",
                    ["lucide-map-pin"] = "rbxassetid://10734886004",
                    ["lucide-map-pin-off"] = "rbxassetid://10734885803",
                    ["lucide-maximize"] = "rbxassetid://10734886735",
                    ["lucide-maximize-2"] = "rbxassetid://10734886496",
                    ["lucide-medal"] = "rbxassetid://10734887072",
                    ["lucide-megaphone"] = "rbxassetid://10734887454",
                    ["lucide-megaphone-off"] = "rbxassetid://10734887311",
                    ["lucide-meh"] = "rbxassetid://10734887603",
                    ["lucide-menu"] = "rbxassetid://10734887784",
                    ["lucide-message-circle"] = "rbxassetid://10734888000",
                    ["lucide-message-square"] = "rbxassetid://10734888228",
                    ["lucide-mic"] = "rbxassetid://10734888864",
                    ["lucide-mic-2"] = "rbxassetid://10734888430",
                    ["lucide-mic-off"] = "rbxassetid://10734888646",
                    ["lucide-microscope"] = "rbxassetid://10734889106",
                    ["lucide-microwave"] = "rbxassetid://10734895076",
                    ["lucide-milestone"] = "rbxassetid://10734895310",
                    ["lucide-minimize"] = "rbxassetid://10734895698",
                    ["lucide-minimize-2"] = "rbxassetid://10734895530",
                    ["lucide-minus"] = "rbxassetid://10734896206",
                    ["lucide-minus-circle"] = "rbxassetid://10734895856",
                    ["lucide-minus-square"] = "rbxassetid://10734896029",
                    ["lucide-monitor"] = "rbxassetid://10734896881",
                    ["lucide-monitor-off"] = "rbxassetid://10734896360",
                    ["lucide-monitor-speaker"] = "rbxassetid://10734896512",
                    ["lucide-moon"] = "rbxassetid://10734897102",
                    ["lucide-more-horizontal"] = "rbxassetid://10734897250",
                    ["lucide-more-vertical"] = "rbxassetid://10734897387",
                    ["lucide-mountain"] = "rbxassetid://10734897956",
                    ["lucide-mountain-snow"] = "rbxassetid://10734897665",
                    ["lucide-mouse"] = "rbxassetid://10734898592",
                    ["lucide-mouse-pointer"] = "rbxassetid://10734898476",
                    ["lucide-mouse-pointer-2"] = "rbxassetid://10734898194",
                    ["lucide-mouse-pointer-click"] = "rbxassetid://10734898355",
                    ["lucide-move"] = "rbxassetid://10734900011",
                    ["lucide-move-3d"] = "rbxassetid://10734898756",
                    ["lucide-move-diagonal"] = "rbxassetid://10734899164",
                    ["lucide-move-diagonal-2"] = "rbxassetid://10734898934",
                    ["lucide-move-horizontal"] = "rbxassetid://10734899414",
                    ["lucide-move-vertical"] = "rbxassetid://10734899821",
                    ["lucide-music"] = "rbxassetid://10734905958",
                    ["lucide-music-2"] = "rbxassetid://10734900215",
                    ["lucide-music-3"] = "rbxassetid://10734905665",
                    ["lucide-music-4"] = "rbxassetid://10734905823",
                    ["lucide-navigation"] = "rbxassetid://10734906744",
                    ["lucide-navigation-2"] = "rbxassetid://10734906332",
                    ["lucide-navigation-2-off"] = "rbxassetid://10734906144",
                    ["lucide-navigation-off"] = "rbxassetid://10734906580",
                    ["lucide-network"] = "rbxassetid://10734906975",
                    ["lucide-newspaper"] = "rbxassetid://10734907168",
                    ["lucide-octagon"] = "rbxassetid://10734907361",
                    ["lucide-option"] = "rbxassetid://10734907649",
                    ["lucide-outdent"] = "rbxassetid://10734907933",
                    ["lucide-package"] = "rbxassetid://10734909540",
                    ["lucide-package-2"] = "rbxassetid://10734908151",
                    ["lucide-package-check"] = "rbxassetid://10734908384",
                    ["lucide-package-minus"] = "rbxassetid://10734908626",
                    ["lucide-package-open"] = "rbxassetid://10734908793",
                    ["lucide-package-plus"] = "rbxassetid://10734909016",
                    ["lucide-package-search"] = "rbxassetid://10734909196",
                    ["lucide-package-x"] = "rbxassetid://10734909375",
                    ["lucide-paint-bucket"] = "rbxassetid://10734909847",
                    ["lucide-paintbrush"] = "rbxassetid://10734910187",
                    ["lucide-paintbrush-2"] = "rbxassetid://10734910030",
                    ["lucide-palette"] = "rbxassetid://10734910430",
                    ["lucide-palmtree"] = "rbxassetid://10734910680",
                    ["lucide-paperclip"] = "rbxassetid://10734910927",
                    ["lucide-party-popper"] = "rbxassetid://10734918735",
                    ["lucide-pause"] = "rbxassetid://10734919336",
                    ["lucide-pause-circle"] = "rbxassetid://10735024209",
                    ["lucide-pause-octagon"] = "rbxassetid://10734919143",
                    ["lucide-pen-tool"] = "rbxassetid://10734919503",
                    ["lucide-pencil"] = "rbxassetid://10734919691",
                    ["lucide-percent"] = "rbxassetid://10734919919",
                    ["lucide-person-standing"] = "rbxassetid://10734920149",
                    ["lucide-phone"] = "rbxassetid://10734921524",
                    ["lucide-phone-call"] = "rbxassetid://10734920305",
                    ["lucide-phone-forwarded"] = "rbxassetid://10734920508",
                    ["lucide-phone-incoming"] = "rbxassetid://10734920694",
                    ["lucide-phone-missed"] = "rbxassetid://10734920845",
                    ["lucide-phone-off"] = "rbxassetid://10734921077",
                    ["lucide-phone-outgoing"] = "rbxassetid://10734921288",
                    ["lucide-pie-chart"] = "rbxassetid://10734921727",
                    ["lucide-piggy-bank"] = "rbxassetid://10734921935",
                    ["lucide-pin"] = "rbxassetid://10734922324",
                    ["lucide-pin-off"] = "rbxassetid://10734922180",
                    ["lucide-pipette"] = "rbxassetid://10734922497",
                    ["lucide-pizza"] = "rbxassetid://10734922774",
                    ["lucide-plane"] = "rbxassetid://10734922971",
                    ["lucide-play"] = "rbxassetid://10734923549",
                    ["lucide-play-circle"] = "rbxassetid://10734923214",
                    ["lucide-plus"] = "rbxassetid://10734924532",
                    ["lucide-plus-circle"] = "rbxassetid://10734923868",
                    ["lucide-plus-square"] = "rbxassetid://10734924219",
                    ["lucide-podcast"] = "rbxassetid://10734929553",
                    ["lucide-pointer"] = "rbxassetid://10734929723",
                    ["lucide-pound-sterling"] = "rbxassetid://10734929981",
                    ["lucide-power"] = "rbxassetid://10734930466",
                    ["lucide-power-off"] = "rbxassetid://10734930257",
                    ["lucide-printer"] = "rbxassetid://10734930632",
                    ["lucide-puzzle"] = "rbxassetid://10734930886",
                    ["lucide-quote"] = "rbxassetid://10734931234",
                    ["lucide-radio"] = "rbxassetid://10734931596",
                    ["lucide-radio-receiver"] = "rbxassetid://10734931402",
                    ["lucide-rectangle-horizontal"] = "rbxassetid://10734931777",
                    ["lucide-rectangle-vertical"] = "rbxassetid://10734932081",
                    ["lucide-recycle"] = "rbxassetid://10734932295",
                    ["lucide-redo"] = "rbxassetid://10734932822",
                    ["lucide-redo-2"] = "rbxassetid://10734932586",
                    ["lucide-refresh-ccw"] = "rbxassetid://10734933056",
                    ["lucide-refresh-cw"] = "rbxassetid://10734933222",
                    ["lucide-refrigerator"] = "rbxassetid://10734933465",
                    ["lucide-regex"] = "rbxassetid://10734933655",
                    ["lucide-repeat"] = "rbxassetid://10734933966",
                    ["lucide-repeat-1"] = "rbxassetid://10734933826",
                    ["lucide-reply"] = "rbxassetid://10734934252",
                    ["lucide-reply-all"] = "rbxassetid://10734934132",
                    ["lucide-rewind"] = "rbxassetid://10734934347",
                    ["lucide-rocket"] = "rbxassetid://10734934585",
                    ["lucide-rocking-chair"] = "rbxassetid://10734939942",
                    ["lucide-rotate-3d"] = "rbxassetid://10734940107",
                    ["lucide-rotate-ccw"] = "rbxassetid://10734940376",
                    ["lucide-rotate-cw"] = "rbxassetid://10734940654",
                    ["lucide-rss"] = "rbxassetid://10734940825",
                    ["lucide-ruler"] = "rbxassetid://10734941018",
                    ["lucide-russian-ruble"] = "rbxassetid://10734941199",
                    ["lucide-sailboat"] = "rbxassetid://10734941354",
                    ["lucide-save"] = "rbxassetid://10734941499",
                    ["lucide-scale"] = "rbxassetid://10734941912",
                    ["lucide-scale-3d"] = "rbxassetid://10734941739",
                    ["lucide-scaling"] = "rbxassetid://10734942072",
                    ["lucide-scan"] = "rbxassetid://10734942565",
                    ["lucide-scan-face"] = "rbxassetid://10734942198",
                    ["lucide-scan-line"] = "rbxassetid://10734942351",
                    ["lucide-scissors"] = "rbxassetid://10734942778",
                    ["lucide-screen-share"] = "rbxassetid://10734943193",
                    ["lucide-screen-share-off"] = "rbxassetid://10734942967",
                    ["lucide-scroll"] = "rbxassetid://10734943448",
                    ["lucide-search"] = "rbxassetid://10734943674",
                    ["lucide-send"] = "rbxassetid://10734943902",
                    ["lucide-separator-horizontal"] = "rbxassetid://10734944115",
                    ["lucide-separator-vertical"] = "rbxassetid://10734944326",
                    ["lucide-server"] = "rbxassetid://10734949856",
                    ["lucide-server-cog"] = "rbxassetid://10734944444",
                    ["lucide-server-crash"] = "rbxassetid://10734944554",
                    ["lucide-server-off"] = "rbxassetid://10734944668",
                    ["lucide-settings"] = "rbxassetid://10734950309",
                    ["lucide-settings-2"] = "rbxassetid://10734950020",
                    ["lucide-share"] = "rbxassetid://10734950813",
                    ["lucide-share-2"] = "rbxassetid://10734950553",
                    ["lucide-sheet"] = "rbxassetid://10734951038",
                    ["lucide-shield"] = "rbxassetid://10734951847",
                    ["lucide-shield-alert"] = "rbxassetid://10734951173",
                    ["lucide-shield-check"] = "rbxassetid://10734951367",
                    ["lucide-shield-close"] = "rbxassetid://10734951535",
                    ["lucide-shield-off"] = "rbxassetid://10734951684",
                    ["lucide-shirt"] = "rbxassetid://10734952036",
                    ["lucide-shopping-bag"] = "rbxassetid://10734952273",
                    ["lucide-shopping-cart"] = "rbxassetid://10734952479",
                    ["lucide-shovel"] = "rbxassetid://10734952773",
                    ["lucide-shower-head"] = "rbxassetid://10734952942",
                    ["lucide-shrink"] = "rbxassetid://10734953073",
                    ["lucide-shrub"] = "rbxassetid://10734953241",
                    ["lucide-shuffle"] = "rbxassetid://10734953451",
                    ["lucide-sidebar"] = "rbxassetid://10734954301",
                    ["lucide-sidebar-close"] = "rbxassetid://10734953715",
                    ["lucide-sidebar-open"] = "rbxassetid://10734954000",
                    ["lucide-sigma"] = "rbxassetid://10734954538",
                    ["lucide-signal"] = "rbxassetid://10734961133",
                    ["lucide-signal-high"] = "rbxassetid://10734954807",
                    ["lucide-signal-low"] = "rbxassetid://10734955080",
                    ["lucide-signal-medium"] = "rbxassetid://10734955336",
                    ["lucide-signal-zero"] = "rbxassetid://10734960878",
                    ["lucide-siren"] = "rbxassetid://10734961284",
                    ["lucide-skip-back"] = "rbxassetid://10734961526",
                    ["lucide-skip-forward"] = "rbxassetid://10734961809",
                    ["lucide-skull"] = "rbxassetid://10734962068",
                    ["lucide-slack"] = "rbxassetid://10734962339",
                    ["lucide-slash"] = "rbxassetid://10734962600",
                    ["lucide-slice"] = "rbxassetid://10734963024",
                    ["lucide-sliders"] = "rbxassetid://10734963400",
                    ["lucide-sliders-horizontal"] = "rbxassetid://10734963191",
                    ["lucide-smartphone"] = "rbxassetid://10734963940",
                    ["lucide-smartphone-charging"] = "rbxassetid://10734963671",
                    ["lucide-smile"] = "rbxassetid://10734964441",
                    ["lucide-smile-plus"] = "rbxassetid://10734964188",
                    ["lucide-snowflake"] = "rbxassetid://10734964600",
                    ["lucide-sofa"] = "rbxassetid://10734964852",
                    ["lucide-sort-asc"] = "rbxassetid://10734965115",
                    ["lucide-sort-desc"] = "rbxassetid://10734965287",
                    ["lucide-speaker"] = "rbxassetid://10734965419",
                    ["lucide-sprout"] = "rbxassetid://10734965572",
                    ["lucide-square"] = "rbxassetid://10734965702",
                    ["lucide-star"] = "rbxassetid://10734966248",
                    ["lucide-star-half"] = "rbxassetid://10734965897",
                    ["lucide-star-off"] = "rbxassetid://10734966097",
                    ["lucide-stethoscope"] = "rbxassetid://10734966384",
                    ["lucide-sticker"] = "rbxassetid://10734972234",
                    ["lucide-sticky-note"] = "rbxassetid://10734972463",
                    ["lucide-stop-circle"] = "rbxassetid://10734972621",
                    ["lucide-stretch-horizontal"] = "rbxassetid://10734972862",
                    ["lucide-stretch-vertical"] = "rbxassetid://10734973130",
                    ["lucide-strikethrough"] = "rbxassetid://10734973290",
                    ["lucide-subscript"] = "rbxassetid://10734973457",
                    ["lucide-sun"] = "rbxassetid://10734974297",
                    ["lucide-sun-dim"] = "rbxassetid://10734973645",
                    ["lucide-sun-medium"] = "rbxassetid://10734973778",
                    ["lucide-sun-moon"] = "rbxassetid://10734973999",
                    ["lucide-sun-snow"] = "rbxassetid://10734974130",
                    ["lucide-sunrise"] = "rbxassetid://10734974522",
                    ["lucide-sunset"] = "rbxassetid://10734974689",
                    ["lucide-superscript"] = "rbxassetid://10734974850",
                    ["lucide-swiss-franc"] = "rbxassetid://10734975024",
                    ["lucide-switch-camera"] = "rbxassetid://10734975214",
                    ["lucide-sword"] = "rbxassetid://10734975486",
                    ["lucide-swords"] = "rbxassetid://10734975692",
                    ["lucide-syringe"] = "rbxassetid://10734975932",
                    ["lucide-table"] = "rbxassetid://10734976230",
                    ["lucide-table-2"] = "rbxassetid://10734976097",
                    ["lucide-tablet"] = "rbxassetid://10734976394",
                    ["lucide-tag"] = "rbxassetid://10734976528",
                    ["lucide-tags"] = "rbxassetid://10734976739",
                    ["lucide-target"] = "rbxassetid://10734977012",
                    ["lucide-tent"] = "rbxassetid://10734981750",
                    ["lucide-terminal"] = "rbxassetid://10734982144",
                    ["lucide-terminal-square"] = "rbxassetid://10734981995",
                    ["lucide-text-cursor"] = "rbxassetid://10734982395",
                    ["lucide-text-cursor-input"] = "rbxassetid://10734982297",
                    ["lucide-thermometer"] = "rbxassetid://10734983134",
                    ["lucide-thermometer-snowflake"] = "rbxassetid://10734982571",
                    ["lucide-thermometer-sun"] = "rbxassetid://10734982771",
                    ["lucide-thumbs-down"] = "rbxassetid://10734983359",
                    ["lucide-thumbs-up"] = "rbxassetid://10734983629",
                    ["lucide-ticket"] = "rbxassetid://10734983868",
                    ["lucide-timer"] = "rbxassetid://10734984606",
                    ["lucide-timer-off"] = "rbxassetid://10734984138",
                    ["lucide-timer-reset"] = "rbxassetid://10734984355",
                    ["lucide-toggle-left"] = "rbxassetid://10734984834",
                    ["lucide-toggle-right"] = "rbxassetid://10734985040",
                    ["lucide-tornado"] = "rbxassetid://10734985247",
                    ["lucide-toy-brick"] = "rbxassetid://10747361919",
                    ["lucide-train"] = "rbxassetid://10747362105",
                    ["lucide-trash"] = "rbxassetid://10747362393",
                    ["lucide-trash-2"] = "rbxassetid://10747362241",
                    ["lucide-tree-deciduous"] = "rbxassetid://10747362534",
                    ["lucide-tree-pine"] = "rbxassetid://10747362748",
                    ["lucide-trees"] = "rbxassetid://10747363016",
                    ["lucide-trending-down"] = "rbxassetid://10747363205",
                    ["lucide-trending-up"] = "rbxassetid://10747363465",
                    ["lucide-triangle"] = "rbxassetid://10747363621",
                    ["lucide-trophy"] = "rbxassetid://10747363809",
                    ["lucide-truck"] = "rbxassetid://10747364031",
                    ["lucide-tv"] = "rbxassetid://10747364593",
                    ["lucide-tv-2"] = "rbxassetid://10747364302",
                    ["lucide-type"] = "rbxassetid://10747364761",
                    ["lucide-umbrella"] = "rbxassetid://10747364971",
                    ["lucide-underline"] = "rbxassetid://10747365191",
                    ["lucide-undo"] = "rbxassetid://10747365484",
                    ["lucide-undo-2"] = "rbxassetid://10747365359",
                    ["lucide-unlink"] = "rbxassetid://10747365771",
                    ["lucide-unlink-2"] = "rbxassetid://10747397871",
                    ["lucide-unlock"] = "rbxassetid://10747366027",
                    ["lucide-upload"] = "rbxassetid://10747366434",
                    ["lucide-upload-cloud"] = "rbxassetid://10747366266",
                    ["lucide-usb"] = "rbxassetid://10747366606",
                    ["lucide-user"] = "rbxassetid://10747373176",
                    ["lucide-user-check"] = "rbxassetid://10747371901",
                    ["lucide-user-cog"] = "rbxassetid://10747372167",
                    ["lucide-user-minus"] = "rbxassetid://10747372346",
                    ["lucide-user-plus"] = "rbxassetid://10747372702",
                    ["lucide-user-x"] = "rbxassetid://10747372992",
                    ["lucide-users"] = "rbxassetid://10747373426",
                    ["lucide-utensils"] = "rbxassetid://10747373821",
                    ["lucide-utensils-crossed"] = "rbxassetid://10747373629",
                    ["lucide-venetian-mask"] = "rbxassetid://10747374003",
                    ["lucide-verified"] = "rbxassetid://10747374131",
                    ["lucide-vibrate"] = "rbxassetid://10747374489",
                    ["lucide-vibrate-off"] = "rbxassetid://10747374269",
                    ["lucide-video"] = "rbxassetid://10747374938",
                    ["lucide-video-off"] = "rbxassetid://10747374721",
                    ["lucide-view"] = "rbxassetid://10747375132",
                    ["lucide-voicemail"] = "rbxassetid://10747375281",
                    ["lucide-volume"] = "rbxassetid://10747376008",
                    ["lucide-volume-1"] = "rbxassetid://10747375450",
                    ["lucide-volume-2"] = "rbxassetid://10747375679",
                    ["lucide-volume-x"] = "rbxassetid://10747375880",
                    ["lucide-wallet"] = "rbxassetid://10747376205",
                    ["lucide-wand"] = "rbxassetid://10747376565",
                    ["lucide-wand-2"] = "rbxassetid://10747376349",
                    ["lucide-watch"] = "rbxassetid://10747376722",
                    ["lucide-waves"] = "rbxassetid://10747376931",
                    ["lucide-webcam"] = "rbxassetid://10747381992",
                    ["lucide-wifi"] = "rbxassetid://10747382504",
                    ["lucide-wifi-off"] = "rbxassetid://10747382268",
                    ["lucide-wind"] = "rbxassetid://10747382750",
                    ["lucide-wrap-text"] = "rbxassetid://10747383065",
                    ["lucide-wrench"] = "rbxassetid://10747383470",
                    ["lucide-x"] = "rbxassetid://10747384394",
                    ["lucide-x-circle"] = "rbxassetid://10747383819",
                    ["lucide-x-octagon"] = "rbxassetid://10747384037",
                    ["lucide-x-square"] = "rbxassetid://10747384217",
                    ["lucide-zoom-in"] = "rbxassetid://10747384552",
                    ["lucide-zoom-out"] = "rbxassetid://10747384679"
                }
        }
    
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
        TextLabel.Text = title
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
        Logo.Image = icons[icon] or "" -- Menggunakan tabel ikon untuk mengatur Image
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
		UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(66, 89, 182)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(37, 57, 137))}
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
		left_section.AutomaticCanvasSize = Enum.AutomaticSize.XY
		left_section.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
		left_section.ScrollBarThickness = 0

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
		right_section.AutomaticCanvasSize = Enum.AutomaticSize.XY
		right_section.ScrollBarImageColor3 = Color3.fromRGB(0, 0, 0)
		right_section.ScrollBarThickness = 0

		local rightsectionlist = Instance.new("UIListLayout")
		rightsectionlist.Parent = right_section

		rightsectionlist.HorizontalAlignment = Enum.HorizontalAlignment.Center
		rightsectionlist.SortOrder = Enum.SortOrder.LayoutOrder
		rightsectionlist.Padding = UDim.new(0, 7)

		if container.Container:FindFirstChild('RightSection') then
			left_section.Visible = false
			right_section.Visible = false
		else
			Tab.open_tab({
				tab = tab,
				left_section = left_section,
				right_section = right_section
			})
		end

		left_section.Parent = container.Container
		right_section.Parent = container.Container

		tab.MouseButton1Click:Connect(function()
			Tab.open_tab({
				tab = tab,
				left_section = left_section,
				right_section = right_section
			})
		end)

        local Module = {}

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

		function Module:enable_toggle()
			TweenService:Create(self.Checkbox.Fill, TweenInfo.new(0.4), {
				BackgroundTransparency = 0
			}):Play()

			TweenService:Create(self.Checkbox.Glow, TweenInfo.new(0.4), {
				ImageTransparency = 0
			}):Play()
		end

		function Module:disable_toggle()
			TweenService:Create(self.Checkbox.Fill, TweenInfo.new(0.4), {
				BackgroundTransparency = 1
			}):Play()

			TweenService:Create(self.Checkbox.Glow, TweenInfo.new(0.4), {
				ImageTransparency = 1
			}):Play()
		end

		function Module:update_toggle()
			if self.state then
				Module.enable_toggle(self.toggle)
			else
				Module.disable_toggle(self.toggle)
			end
		end

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
			UIGradient.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(66, 89, 182)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(37, 57, 137))}
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

		function Module:slider_loop()
			Library.slider_drag = true
			
			while Library.slider_drag do
				Module.update_slider(self)
				
				task.wait()
			end
		end


        function Module:create_slider()
			local drag = false
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
			UIGradient.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.50, 0.00), NumberSequenceKeypoint.new(0.53, 1.00), NumberSequenceKeypoint.new(1.00, 1.00)}
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
			UIGradient_2.Transparency = NumberSequence.new{NumberSequenceKeypoint.new(0.00, 0.00), NumberSequenceKeypoint.new(0.50, 0.00), NumberSequenceKeypoint.new(0.50, 1.00), NumberSequenceKeypoint.new(1.00, 1.00)}
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
			
			UserInputService.InputEnded:Connect(function(input: InputObject, process: boolean)
				if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
					Library.slider_drag = false
					Library.save_flags()
				end
			end)
		end

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

			function Dropdown:open()
				dropdown.Box.TextLabel.Text = Library.Flags[self.flag]

				TweenService:Create(dropdown.Box.Options, TweenInfo.new(0.4), {
					Size = UDim2.new(0, 202, 0, list_size)
				}):Play()

				TweenService:Create(dropdown, TweenInfo.new(0.4), {
					Size = UDim2.new(0, 215, 0, 30 + list_size)
				}):Play()

				TweenService:Create(dropdown.Box.Arrow, TweenInfo.new(0.4), {
					Rotation = 180
				}):Play()
			end
			
			function Dropdown:close()
				dropdown.Box.TextLabel.Text = self.name
				TweenService:Create(dropdown.Box.Options, TweenInfo.new(0.4), {
					Size = UDim2.new(0, 202, 0, 0)
				}):Play()

				TweenService:Create(dropdown, TweenInfo.new(0.4), {
					Size = UDim2.new(0, 215, 0, 36)
				}):Play()

				TweenService:Create(dropdown.Box.Arrow, TweenInfo.new(0.4), {
					Rotation = 0
				}):Play()
			end

			function Dropdown:clear()
				for _, object in dropdown.Box.Options:GetChildren() do
					if object.Name ~= 'Option' then
						continue
					end

					object:Destroy()
				end
			end

			function Dropdown:select_option()
				TweenService:Create(self.new_option, TweenInfo.new(0.4), {
					TextTransparency = 0
				}):Play()

				for _, object in dropdown.Box.Options:GetChildren() do
					if object.Name ~= 'Option' then
						continue
					end

					if object.Text == Library.Flags[self.flag] then
						continue
					end

					TweenService:Create(object, TweenInfo.new(0.4), {
						TextTransparency = 0.5
					}):Play()
				end

				dropdown.Box.TextLabel.Text = self.new_option.Text
			end

			function Dropdown:update()
				Dropdown.clear()

				for _, value in self.options do
					list_size += 23

					local new_option = option:Clone()
					new_option.Parent = dropdown.Box.Options
					new_option.Text = value
	
					if value == Library.Flags[self.flag] then
						new_option.TextTransparency = 0
					end
	
					new_option.MouseButton1Click:Connect(function()
						Library.Flags[self.flag] = value
						
						if list_open then
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

			if not Library.Flags[self.flag] then
				Library.Flags[self.flag] = self.value
			else
				textbox.Box.TextHolder.Text = Library.Flags[self.flag]
			end

			self.callback(Library.Flags[self.flag])
			textbox.Box.TextHolder.FocusLost:Connect(function()
				self.callback(textbox.Box.TextHolder.Text)
				Library.save_flags()
			end)

			function Textbox:update(text)
				textbox.Box.TextHolder.Text = text
				self.callback(text)
			end

            return Textbox;
        end
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
				local a,b = UserInputService.InputBegan:Wait();
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
        return Module
    end
    return Tab
end

return Library
