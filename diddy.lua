local Lighting = game:GetService("Lighting")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local TextService = game:GetService("TextService")
local Camera = game:GetService("Workspace").CurrentCamera
local Mouse = LocalPlayer:GetMouse()
local httpService = game:GetService("HttpService")

local RenderStepped = RunService.RenderStepped

local ProtectGui = protectgui or (syn and syn.protect_gui) or function() end

local Themes = {
    Names = {
        "Lunar Glow",
        "Lunar Dusk",
        "Abyss Eclipse",
        "Ocean Depths",
        "Forest Canopy",
        "Sunset Horizon",
        "Midnight Violet",
        "Arctic Frost"
    },
    ["Lunar Glow"] = {
        Accent = Color3.fromRGB(0, 0, 0),

        AcrylicMain = Color3.fromRGB(255, 255, 255), 
        AcrylicBorder = Color3.fromRGB(200, 200, 200),
        AcrylicGradient = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(255, 255, 255)),
        AcrylicNoise = 1,

        TitleBarLine = Color3.fromRGB(50, 50, 50),
        Tab = Color3.fromRGB(0, 0, 0),

        Element = Color3.fromRGB(240, 240, 240),
        ElementBorder = Color3.fromRGB(190, 190, 190),
        InElementBorder = Color3.fromRGB(190, 190, 190),
        ElementTransparency = 0,

        ToggleSlider = Color3.fromRGB(100, 100, 100),
        ToggleToggled = Color3.fromRGB(0, 0, 0),

        SliderRail = Color3.fromRGB(190, 190, 190),

        DropdownFrame = Color3.fromRGB(210, 210, 210),
        DropdownHolder = Color3.fromRGB(210, 210, 210),
        DropdownBorder = Color3.fromRGB(255, 255, 255),
        DropdownOption = Color3.fromRGB(180, 180, 180),

        Keybind = Color3.fromRGB(200, 200, 200),

        Input = Color3.fromRGB(230, 230, 230),
        InputFocused = Color3.fromRGB(190, 190, 190),
        InputIndicator = Color3.fromRGB(0, 0, 0),

        Dialog = Color3.fromRGB(220, 220, 220),
        DialogHolder = Color3.fromRGB(210, 210, 210),
        DialogHolderLine = Color3.fromRGB(200, 200, 200),
        DialogButton = Color3.fromRGB(200, 200, 200),
        DialogButtonBorder = Color3.fromRGB(170, 170, 170),
        DialogBorder = Color3.fromRGB(120, 120, 120),
        DialogInput = Color3.fromRGB(215, 215, 215),
        DialogInputLine = Color3.fromRGB(50, 50, 50),

        Text = Color3.fromRGB(0, 0, 0),
        SubText = Color3.fromRGB(80, 80, 80),
        Hover = Color3.fromRGB(120, 120, 120),
        HoverChange = 0.04
    },
    ["Lunar Dusk"] = {
        Accent = Color3.fromRGB(160, 160, 160),

        AcrylicMain = Color3.fromRGB(20, 20, 20),
        AcrylicBorder = Color3.fromRGB(50, 50, 50),
        AcrylicGradient = ColorSequence.new(Color3.fromRGB(20, 20, 20), Color3.fromRGB(20, 20, 20)),
        AcrylicNoise = 1,

        TitleBarLine = Color3.fromRGB(180, 180, 180),
        Tab = Color3.fromRGB(160, 160, 160),

        Element = Color3.fromRGB(30, 30, 30),
        ElementBorder = Color3.fromRGB(55, 55, 55),
        InElementBorder = Color3.fromRGB(55, 55, 55),
        ElementTransparency = 0,

        ToggleSlider = Color3.fromRGB(170, 170, 170),
        ToggleToggled = Color3.fromRGB(255, 255, 255),

        SliderRail = Color3.fromRGB(55, 55, 55),

        DropdownFrame = Color3.fromRGB(65, 65, 65),
        DropdownHolder = Color3.fromRGB(65, 65, 65),
        DropdownBorder = Color3.fromRGB(20, 20, 20),
        DropdownOption = Color3.fromRGB(40, 40, 40),

        Keybind = Color3.fromRGB(45, 45, 45),

        Input = Color3.fromRGB(20, 20, 20),
        InputFocused = Color3.fromRGB(50, 50, 50),
        InputIndicator = Color3.fromRGB(170, 170, 170),

        Dialog = Color3.fromRGB(30, 30, 30),
        DialogHolder = Color3.fromRGB(40, 40, 40),
        DialogHolderLine = Color3.fromRGB(25, 25, 25),
        DialogButton = Color3.fromRGB(50, 50, 50),
        DialogButtonBorder = Color3.fromRGB(70, 70, 70),
        DialogBorder = Color3.fromRGB(140, 140, 140),
        DialogInput = Color3.fromRGB(40, 40, 40),
        DialogInputLine = Color3.fromRGB(170, 170, 170),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(170, 170, 170),
        Hover = Color3.fromRGB(150, 150, 150),
        HoverChange = 0.04
    },
    ["Abyss Eclipse"] = {
        Accent = Color3.fromRGB(120, 120, 120), 

        AcrylicMain = Color3.fromRGB(3, 3, 3),
        AcrylicBorder = Color3.fromRGB(25, 25, 25),
        AcrylicGradient = ColorSequence.new(Color3.fromRGB(3, 3, 3), Color3.fromRGB(3, 3, 3)),
        AcrylicNoise = 1,

        TitleBarLine = Color3.fromRGB(140, 140, 140),
        Tab = Color3.fromRGB(120, 120, 120),

        Element = Color3.fromRGB(10, 10, 10),
        ElementBorder = Color3.fromRGB(30, 30, 30),
        InElementBorder = Color3.fromRGB(30, 30, 30),
        ElementTransparency = 0,

        ToggleSlider = Color3.fromRGB(140, 140, 140),
        ToggleToggled = Color3.fromRGB(255, 255, 255),

        SliderRail = Color3.fromRGB(30, 30, 30),

        DropdownFrame = Color3.fromRGB(40, 40, 40),
        DropdownHolder = Color3.fromRGB(40, 40, 40),
        DropdownBorder = Color3.fromRGB(3, 3, 3),
        DropdownOption = Color3.fromRGB(20, 20, 20),

        Keybind = Color3.fromRGB(25, 25, 25),

        Input = Color3.fromRGB(5, 5, 5),
        InputFocused = Color3.fromRGB(30, 30, 30),
        InputIndicator = Color3.fromRGB(140, 140, 140),

        Dialog = Color3.fromRGB(10, 10, 10),
        DialogHolder = Color3.fromRGB(15, 15, 15),
        DialogHolderLine = Color3.fromRGB(5, 5, 5),
        DialogButton = Color3.fromRGB(25, 25, 25),
        DialogButtonBorder = Color3.fromRGB(40, 40, 40),
        DialogBorder = Color3.fromRGB(90, 90, 90),
        DialogInput = Color3.fromRGB(20, 20, 20),
        DialogInputLine = Color3.fromRGB(120, 120, 120),

        Text = Color3.fromRGB(255, 255, 255),
        SubText = Color3.fromRGB(140, 140, 140),
        Hover = Color3.fromRGB(120, 120, 120),
        HoverChange = 0.04
    },
    ["Ocean Depths"] = {
        Accent = Color3.fromRGB(0, 120, 215),

        AcrylicMain = Color3.fromRGB(10, 30, 45),
        AcrylicBorder = Color3.fromRGB(30, 60, 80),
        AcrylicGradient = ColorSequence.new(Color3.fromRGB(10, 30, 45), Color3.fromRGB(15, 40, 60)),
        AcrylicNoise = 0.9,

        TitleBarLine = Color3.fromRGB(0, 150, 220),
        Tab = Color3.fromRGB(0, 120, 215),

        Element = Color3.fromRGB(15, 40, 60),
        ElementBorder = Color3.fromRGB(30, 70, 90),
        InElementBorder = Color3.fromRGB(30, 70, 90),
        ElementTransparency = 0,

        ToggleSlider = Color3.fromRGB(20, 80, 120),
        ToggleToggled = Color3.fromRGB(0, 180, 240),

        SliderRail = Color3.fromRGB(20, 60, 90),

        DropdownFrame = Color3.fromRGB(20, 50, 70),
        DropdownHolder = Color3.fromRGB(20, 50, 70),
        DropdownBorder = Color3.fromRGB(10, 30, 45),
        DropdownOption = Color3.fromRGB(15, 40, 60),

        Keybind = Color3.fromRGB(15, 45, 65),

        Input = Color3.fromRGB(10, 35, 55),
        InputFocused = Color3.fromRGB(20, 60, 90),
        InputIndicator = Color3.fromRGB(0, 150, 220),

        Dialog = Color3.fromRGB(15, 40, 60),
        DialogHolder = Color3.fromRGB(20, 50, 70),
        DialogHolderLine = Color3.fromRGB(10, 30, 45),
        DialogButton = Color3.fromRGB(20, 60, 90),
        DialogButtonBorder = Color3.fromRGB(30, 80, 110),
        DialogBorder = Color3.fromRGB(0, 120, 215),
        DialogInput = Color3.fromRGB(15, 45, 65),
        DialogInputLine = Color3.fromRGB(0, 150, 220),

        Text = Color3.fromRGB(220, 240, 255),
        SubText = Color3.fromRGB(170, 210, 240),
        Hover = Color3.fromRGB(0, 150, 220),
        HoverChange = 0.05
    },
    ["Forest Canopy"] = {
        Accent = Color3.fromRGB(40, 160, 80),

        AcrylicMain = Color3.fromRGB(20, 40, 25),
        AcrylicBorder = Color3.fromRGB(40, 70, 45),
        AcrylicGradient = ColorSequence.new(Color3.fromRGB(20, 40, 25), Color3.fromRGB(25, 50, 30)),
        AcrylicNoise = 0.9,

        TitleBarLine = Color3.fromRGB(60, 180, 100),
        Tab = Color3.fromRGB(40, 160, 80),

        Element = Color3.fromRGB(25, 50, 30),
        ElementBorder = Color3.fromRGB(45, 80, 50),
        InElementBorder = Color3.fromRGB(45, 80, 50),
        ElementTransparency = 0,

        ToggleSlider = Color3.fromRGB(30, 90, 40),
        ToggleToggled = Color3.fromRGB(60, 200, 100),

        SliderRail = Color3.fromRGB(35, 70, 40),

        DropdownFrame = Color3.fromRGB(30, 60, 35),
        DropdownHolder = Color3.fromRGB(30, 60, 35),
        DropdownBorder = Color3.fromRGB(20, 40, 25),
        DropdownOption = Color3.fromRGB(25, 50, 30),

        Keybind = Color3.fromRGB(25, 55, 30),

        Input = Color3.fromRGB(20, 45, 25),
        InputFocused = Color3.fromRGB(35, 70, 40),
        InputIndicator = Color3.fromRGB(60, 180, 100),

        Dialog = Color3.fromRGB(25, 50, 30),
        DialogHolder = Color3.fromRGB(30, 60, 35),
        DialogHolderLine = Color3.fromRGB(20, 40, 25),
        DialogButton = Color3.fromRGB(35, 70, 40),
        DialogButtonBorder = Color3.fromRGB(45, 90, 50),
        DialogBorder = Color3.fromRGB(40, 160, 80),
        DialogInput = Color3.fromRGB(25, 55, 30),
        DialogInputLine = Color3.fromRGB(60, 180, 100),

        Text = Color3.fromRGB(220, 255, 230),
        SubText = Color3.fromRGB(180, 230, 190),
        Hover = Color3.fromRGB(60, 180, 100),
        HoverChange = 0.05
    },
    ["Sunset Horizon"] = {
        Accent = Color3.fromRGB(240, 120, 40),

        AcrylicMain = Color3.fromRGB(40, 25, 35),
        AcrylicBorder = Color3.fromRGB(70, 45, 60),
        AcrylicGradient = ColorSequence.new(Color3.fromRGB(40, 25, 35), Color3.fromRGB(50, 30, 45)),
        AcrylicNoise = 0.9,

        TitleBarLine = Color3.fromRGB(240, 140, 60),
        Tab = Color3.fromRGB(240, 120, 40),

        Element = Color3.fromRGB(50, 30, 45),
        ElementBorder = Color3.fromRGB(80, 50, 70),
        InElementBorder = Color3.fromRGB(80, 50, 70),
        ElementTransparency = 0,

        ToggleSlider = Color3.fromRGB(90, 50, 70),
        ToggleToggled = Color3.fromRGB(240, 150, 70),

        SliderRail = Color3.fromRGB(70, 40, 60),

        DropdownFrame = Color3.fromRGB(60, 35, 50),
        DropdownHolder = Color3.fromRGB(60, 35, 50),
        DropdownBorder = Color3.fromRGB(40, 25, 35),
        DropdownOption = Color3.fromRGB(50, 30, 45),

        Keybind = Color3.fromRGB(55, 35, 50),

        Input = Color3.fromRGB(45, 25, 40),
        InputFocused = Color3.fromRGB(70, 40, 60),
        InputIndicator = Color3.fromRGB(240, 140, 60),

        Dialog = Color3.fromRGB(50, 30, 45),
        DialogHolder = Color3.fromRGB(60, 35, 50),
        DialogHolderLine = Color3.fromRGB(40, 25, 35),
        DialogButton = Color3.fromRGB(70, 40, 60),
        DialogButtonBorder = Color3.fromRGB(90, 50, 80),
        DialogBorder = Color3.fromRGB(240, 120, 40),
        DialogInput = Color3.fromRGB(55, 35, 50),
        DialogInputLine = Color3.fromRGB(240, 140, 60),

        Text = Color3.fromRGB(255, 230, 215),
        SubText = Color3.fromRGB(230, 190, 170),
        Hover = Color3.fromRGB(240, 140, 60),
        HoverChange = 0.05
    },
    ["Midnight Violet"] = {
        Accent = Color3.fromRGB(140, 80, 220),

        AcrylicMain = Color3.fromRGB(25, 20, 40),
        AcrylicBorder = Color3.fromRGB(50, 40, 80),
        AcrylicGradient = ColorSequence.new(Color3.fromRGB(25, 20, 40), Color3.fromRGB(30, 25, 50)),
        AcrylicNoise = 0.9,

        TitleBarLine = Color3.fromRGB(160, 100, 240),
        Tab = Color3.fromRGB(140, 80, 220),

        Element = Color3.fromRGB(30, 25, 50),
        ElementBorder = Color3.fromRGB(60, 50, 100),
        InElementBorder = Color3.fromRGB(60, 50, 100),
        ElementTransparency = 0,

        ToggleSlider = Color3.fromRGB(70, 50, 120),
        ToggleToggled = Color3.fromRGB(170, 120, 250),

        SliderRail = Color3.fromRGB(50, 40, 90),

        DropdownFrame = Color3.fromRGB(40, 30, 70),
        DropdownHolder = Color3.fromRGB(40, 30, 70),
        DropdownBorder = Color3.fromRGB(25, 20, 40),
        DropdownOption = Color3.fromRGB(30, 25, 50),

        Keybind = Color3.fromRGB(35, 30, 60),

        Input = Color3.fromRGB(25, 20, 45),
        InputFocused = Color3.fromRGB(50, 40, 90),
        InputIndicator = Color3.fromRGB(160, 100, 240),

        Dialog = Color3.fromRGB(30, 25, 50),
        DialogHolder = Color3.fromRGB(40, 30, 70),
        DialogHolderLine = Color3.fromRGB(25, 20, 40),
        DialogButton = Color3.fromRGB(50, 40, 90),
        DialogButtonBorder = Color3.fromRGB(70, 60, 120),
        DialogBorder = Color3.fromRGB(140, 80, 220),
        DialogInput = Color3.fromRGB(35, 30, 60),
        DialogInputLine = Color3.fromRGB(160, 100, 240),

        Text = Color3.fromRGB(230, 220, 255),
        SubText = Color3.fromRGB(190, 180, 230),
        Hover = Color3.fromRGB(160, 100, 240),
        HoverChange = 0.05
    },
    ["Arctic Frost"] = {
        Accent = Color3.fromRGB(100, 200, 250),

        AcrylicMain = Color3.fromRGB(230, 240, 245),
        AcrylicBorder = Color3.fromRGB(200, 220, 230),
        AcrylicGradient = ColorSequence.new(Color3.fromRGB(230, 240, 245), Color3.fromRGB(235, 245, 250)),
        AcrylicNoise = 0.9,

        TitleBarLine = Color3.fromRGB(120, 210, 255),
        Tab = Color3.fromRGB(100, 200, 250),

        Element = Color3.fromRGB(235, 245, 250),
        ElementBorder = Color3.fromRGB(210, 230, 240),
        InElementBorder = Color3.fromRGB(210, 230, 240),
        ElementTransparency = 0,

        ToggleSlider = Color3.fromRGB(180, 220, 240),
        ToggleToggled = Color3.fromRGB(100, 200, 250),

        SliderRail = Color3.fromRGB(200, 225, 235),

        DropdownFrame = Color3.fromRGB(220, 235, 245),
        DropdownHolder = Color3.fromRGB(220, 235, 245),
        DropdownBorder = Color3.fromRGB(230, 240, 245),
        DropdownOption = Color3.fromRGB(235, 245, 250),

        Keybind = Color3.fromRGB(225, 240, 245),

        Input = Color3.fromRGB(230, 240, 245),
        InputFocused = Color3.fromRGB(200, 225, 235),
        InputIndicator = Color3.fromRGB(100, 200, 250),

        Dialog = Color3.fromRGB(235, 245, 250),
        DialogHolder = Color3.fromRGB(220, 235, 245),
        DialogHolderLine = Color3.fromRGB(230, 240, 245),
        DialogButton = Color3.fromRGB(200, 225, 235),
        DialogButtonBorder = Color3.fromRGB(180, 210, 225),
        DialogBorder = Color3.fromRGB(100, 200, 250),
        DialogInput = Color3.fromRGB(225, 240, 245),
        DialogInputLine = Color3.fromRGB(120, 210, 255),

        Text = Color3.fromRGB(30, 50, 70),
        SubText = Color3.fromRGB(70, 90, 110),
        Hover = Color3.fromRGB(120, 210, 255),
        HoverChange = 0.05
    }
}

local Library = {
    Version = "2.0.0",

    OpenFrames = {},
    Options = {},
    Themes = Themes.Names,

    Window = nil,
    WindowFrame = nil,
    Unloaded = false,

    Creator = nil,

    DialogOpen = false,
    UseAcrylic = false,
    Acrylic = false,
    Transparency = true,
    MinimizeKeybind = nil,
    MinimizerIcon = nil,
    MinimizeKey = Enum.KeyCode.LeftControl,
}

-- [[ The rest of the original library code would go here ]]

-- New module for images with descriptions
local ImageModule = {}

function ImageModule:New(Parent, Config)
    assert(Config.Image, "ImageModule - Missing Image URL or AssetId")
    
    local ImageContainer = {
        Visible = true
    }
    
    -- Default configuration
    Config.Size = Config.Size or UDim2.new(1, 0, 0, 200)
    Config.Description = Config.Description or ""
    Config.Title = Config.Title or ""
    Config.BorderColor = Config.BorderColor or Color3.fromRGB(60, 60, 60)
    Config.BorderThickness = Config.BorderThickness or 1
    Config.BorderRadius = Config.BorderRadius or UDim.new(0, 6)
    Config.ImageSize = Config.ImageSize or UDim2.new(0, 180, 0, 180)
    Config.ImagePosition = Config.ImagePosition or UDim2.new(0, 10, 0.5, 0)
    Config.ImageAnchorPoint = Config.ImageAnchorPoint or Vector2.new(0, 0.5)
    
    -- Create the main frame
    local Frame = Creator.New("Frame", {
        Size = Config.Size,
        BackgroundTransparency = 0.89,
        BackgroundColor3 = Color3.fromRGB(130, 130, 130),
        Parent = Parent,
        ThemeTag = {
            BackgroundColor3 = "Element",
            BackgroundTransparency = "ElementTransparency",
        },
    }, {
        Creator.New("UICorner", {
            CornerRadius = Config.BorderRadius,
        }),
        Creator.New("UIStroke", {
            Transparency = 0.5,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = Config.BorderColor,
            Thickness = Config.BorderThickness,
            ThemeTag = {
                Color = "ElementBorder",
            },
        })
    })
    
    -- Create the image
    local Image = Creator.New("ImageLabel", {
        Size = Config.ImageSize,
        Position = Config.ImagePosition,
        AnchorPoint = Config.ImageAnchorPoint,
        BackgroundTransparency = 1,
        Image = Config.Image,
        ScaleType = Config.ScaleType or Enum.ScaleType.Fit,
        Parent = Frame
    }, {
        Creator.New("UICorner", {
            CornerRadius = UDim.new(0, 4),
        })
    })
    
    -- Create the title
    local Title = Creator.New("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
        Text = Config.Title,
        TextColor3 = Color3.fromRGB(240, 240, 240),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Left,
        Size = UDim2.new(0, 0, 0, 20),
        Position = UDim2.new(0, Config.ImageSize.X.Offset + 20, 0, 20),
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.X,
        Parent = Frame,
        ThemeTag = {
            TextColor3 = "Text",
        },
    })
    
    -- Create the description
    local Description = Creator.New("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
        Text = Config.Description,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 14,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        Size = UDim2.new(1, -(Config.ImageSize.X.Offset + 30), 1, -80),
        Position = UDim2.new(0, Config.ImageSize.X.Offset + 20, 0, 50),
        BackgroundTransparency = 1,
        Parent = Frame,
        ThemeTag = {
            TextColor3 = "SubText",
        },
    })
    
    -- Functions
    function ImageContainer:SetTitle(NewTitle)
        Title.Text = NewTitle
    end
    
    function ImageContainer:SetDescription(NewDescription)
        Description.Text = NewDescription
    end
    
    function ImageContainer:SetImage(NewImage)
        Image.Image = NewImage
    end
    
    function ImageContainer:SetVisible(Visible)
        Frame.Visible = Visible
        ImageContainer.Visible = Visible
    end
    
    function ImageContainer:Destroy()
        Frame:Destroy()
    end
    
    return ImageContainer
end

-- Add the ImageModule to the Library
Library.ImageModule = ImageModule

-- Add the ImageModule to Elements
ElementsTable.Image = (function()
    local Element = {}
    Element.__index = Element
    Element.__type = "Image"

    function Element:New(Idx, Config)
        assert(Config.Title, "Image - Missing Title")
        assert(Config.Image, "Image - Missing Image URL or AssetId")
        
        local ImageElement = ImageModule:New(self.Container, {
            Title = Config.Title,
            Description = Config.Description or "",
            Image = Config.Image,
            Size = Config.Size or UDim2.new(1, 0, 0, 200),
            BorderColor = Config.BorderColor,
            BorderThickness = Config.BorderThickness,
            BorderRadius = Config.BorderRadius,
            ImageSize = Config.ImageSize,
            ImagePosition = Config.ImagePosition,
            ImageAnchorPoint = Config.ImageAnchorPoint,
            ScaleType = Config.ScaleType
        })
        
        function ImageElement:SetTitle(NewTitle)
            ImageElement:SetTitle(NewTitle)
        end
        
        function ImageElement:SetDescription(NewDesc)
            ImageElement:SetDescription(NewDesc)
        end
        
        function ImageElement:SetImage(NewImage)
            ImageElement:SetImage(NewImage)
        end
        
        function ImageElement:Visible(Bool)
            ImageElement:SetVisible(Bool)
        end
        
        function ImageElement:Destroy()
            ImageElement:Destroy()
            Library.Options[Idx] = nil
        end
        
        Library.Options[Idx] = ImageElement
        return ImageElement
    end

    return Element
end)()

-- Add the Image element to the Elements table
Elements["AddImage"] = function(self, Idx, Config)
    ElementsTable.Image.Container = self.Container
    ElementsTable.Image.Type = self.Type
    ElementsTable.Image.ScrollFrame = self.ScrollFrame
    ElementsTable.Image.Library = Library

    return ElementsTable.Image:New(Idx, Config)
end

-- Add a gallery module for multiple images
local GalleryModule = {}

function GalleryModule:New(Parent, Config)
    assert(Config.Images, "GalleryModule - Missing Images table")
    
    local GalleryContainer = {
        Visible = true,
        CurrentIndex = 1
    }
    
    -- Default configuration
    Config.Size = Config.Size or UDim2.new(1, 0, 0, 250)
    Config.Title = Config.Title or "Image Gallery"
    Config.BorderColor = Config.BorderColor or Color3.fromRGB(60, 60, 60)
    Config.BorderThickness = Config.BorderThickness or 1
    Config.BorderRadius = Config.BorderRadius or UDim.new(0, 6)
    
    -- Create the main frame
    local Frame = Creator.New("Frame", {
        Size = Config.Size,
        BackgroundTransparency = 0.89,
        BackgroundColor3 = Color3.fromRGB(130, 130, 130),
        Parent = Parent,
        ThemeTag = {
            BackgroundColor3 = "Element",
            BackgroundTransparency = "ElementTransparency",
        },
    }, {
        Creator.New("UICorner", {
            CornerRadius = Config.BorderRadius,
        }),
        Creator.New("UIStroke", {
            Transparency = 0.5,
            ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
            Color = Config.BorderColor,
            Thickness = Config.BorderThickness,
            ThemeTag = {
                Color = "ElementBorder",
            },
        })
    })
    
    -- Create the title
    local Title = Creator.New("TextLabel", {
        FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json", Enum.FontWeight.Medium, Enum.FontStyle.Normal),
        Text = Config.Title,
        TextColor3 = Color3.fromRGB(240, 240, 240),
        TextSize = 16,
        TextXAlignment = Enum.TextXAlignment.Center,
        Size = UDim2.new(1, -20, 0, 20),
        Position = UDim2.new(0, 10, 0, 10),
        BackgroundTransparency = 1,
        Parent = Frame,
        ThemeTag = {
            TextColor3 = "Text",
        },
    })
    
    -- Create the image container
    local ImageContainer = Creator.New("Frame", {
        Size = UDim2.new(1, -20, 1, -80),
        Position = UDim2.new(0, 10, 0, 40),
        BackgroundTransparency = 1,
        Parent = Frame
    })
    
    -- Create the navigation buttons
    local PrevButton = Creator.New("TextButton", {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(0, 10, 1, -35),
        BackgroundTransparency = 0.5,
        Text = "<",
        TextColor3 = Color3.fromRGB(240, 240, 240),
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        Parent = Frame,
        ThemeTag = {
            BackgroundColor3 = "DialogButton",
            TextColor3 = "Text",
        },
    }, {
        Creator.New("UICorner", {
            CornerRadius = UDim.new(0, 4),
        })
    })
    
    local NextButton = Creator.New("TextButton", {
        Size = UDim2.new(0, 30, 0, 30),
        Position = UDim2.new(1, -40, 1, -35),
        BackgroundTransparency = 0.5,
        Text = ">",
        TextColor3 = Color3.fromRGB(240, 240, 240),
        TextSize = 18,
        Font = Enum.Font.GothamBold,
        Parent = Frame,
        ThemeTag = {
            BackgroundColor3 = "DialogButton",
            TextColor3 = "Text",
        },
    }, {
        Creator.New("UICorner", {
            CornerRadius = UDim.new(0, 4),
        })
    })
    
    -- Create the counter label
    local CounterLabel = Creator.New("TextLabel", {
        Size = UDim2.new(1, -100, 0, 30),
        Position = UDim2.new(0, 50, 1, -35),
        BackgroundTransparency = 1,
        Text = "1 / " .. #Config.Images,
        TextColor3 = Color3.fromRGB(200, 200, 200),
        TextSize = 14,
        Font = Enum.Font.Gotham,
        Parent = Frame,
        ThemeTag = {
            TextColor3 = "SubText",
        },
    })
    
    -- Create image elements for each image
    local ImageElements = {}
    for i, imageData in ipairs(Config.Images) do
        local Image = Creator.New("ImageLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Image = imageData.Image,
            ScaleType = imageData.ScaleType or Enum.ScaleType.Fit,
            Visible = i == 1,
            Parent = ImageContainer
        }, {
            Creator.New("UICorner", {
                CornerRadius = UDim.new(0, 4),
            })
        })
        
        local Description = Creator.New("TextLabel", {
            FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
            Text = imageData.Description or "",
            TextColor3 = Color3.fromRGB(200, 200, 200),
            TextSize = 14,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Bottom,
            Size = UDim2.new(1, 0, 0, 30),
            Position = UDim2.new(0, 0, 1, -30),
            BackgroundTransparency = 0.7,
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            Parent = Image,
            ThemeTag = {
                TextColor3 = "Text",
            },
        }, {
            Creator.New("UICorner", {
                CornerRadius = UDim.new(0, 4),
            })
        })
        
        table.insert(ImageElements, {
            Image = Image,
            Description = Description,
            Data = imageData
        })
    end
    
    -- Functions to navigate through images
    local function UpdateDisplay()
        for i, element in ipairs(ImageElements) do
            element.Image.Visible = i == GalleryContainer.CurrentIndex
        end
        CounterLabel.Text = GalleryContainer.CurrentIndex .. " / " .. #ImageElements
    end
    
    Creator.AddSignal(PrevButton.MouseButton1Click, function()
        GalleryContainer.CurrentIndex = GalleryContainer.CurrentIndex - 1
        if GalleryContainer.CurrentIndex < 1 then
            GalleryContainer.CurrentIndex = #ImageElements
        end
        UpdateDisplay()
    end)
    
    Creator.AddSignal(NextButton.MouseButton1Click, function()
        GalleryContainer.CurrentIndex = GalleryContainer.CurrentIndex + 1
        if GalleryContainer.CurrentIndex > #ImageElements then
            GalleryContainer.CurrentIndex = 1
        end
        UpdateDisplay()
    end)
    
    -- Public methods
    function GalleryContainer:SetTitle(NewTitle)
        Title.Text = NewTitle
    end
    
    function GalleryContainer:AddImage(ImageData)
        assert(ImageData.Image, "Missing Image URL or AssetId")
        
        local Image = Creator.New("ImageLabel", {
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Image = ImageData.Image,
            ScaleType = ImageData.ScaleType or Enum.ScaleType.Fit,
            Visible = false,
            Parent = ImageContainer
        }, {
            Creator.New("UICorner", {
                CornerRadius = UDim.new(0, 4),
            })
        })
        
        local Description = Creator.New("TextLabel", {
            FontFace = Font.new("rbxasset://fonts/families/GothamSSm.json"),
            Text = ImageData.Description or "",
            TextColor3 = Color3.fromRGB(200, 200, 200),
            TextSize = 14,
            TextWrapped = true,
            TextXAlignment = Enum.TextXAlignment.Center,
            TextYAlignment = Enum.TextYAlignment.Bottom,
            Size = UDim2.new(1, 0, 0, 30),
            Position = UDim2.new(0, 0, 1, -30),
            BackgroundTransparency = 0.7,
            BackgroundColor3 = Color3.fromRGB(0, 0, 0),
            Parent = Image,
            ThemeTag = {
                TextColor3 = "Text",
            },
        }, {
            Creator.New("UICorner", {
                CornerRadius = UDim.new(0, 4),
            })
        })
        
        table.insert(ImageElements, {
            Image = Image,
            Description = Description,
            Data = ImageData
        })
        
        CounterLabel.Text = GalleryContainer.CurrentIndex .. " / " .. #ImageElements
    end
    
    function GalleryContainer:RemoveImage(Index)
        if ImageElements[Index] then
            ImageElements[Index].Image:Destroy()
            table.remove(ImageElements, Index)
            
            if GalleryContainer.CurrentIndex > #ImageElements then
                GalleryContainer.CurrentIndex = #ImageElements
            end
            
            if #ImageElements == 0 then
                GalleryContainer.CurrentIndex = 0
                CounterLabel.Text = "0 / 0"
            else
                UpdateDisplay()
            end
        end
    end
    
    function GalleryContainer:SetVisible(Visible)
        Frame.Visible = Visible
        GalleryContainer.Visible = Visible
    end
    
    function GalleryContainer:Destroy()
        Frame:Destroy()
    end
    
    return GalleryContainer
end

-- Add the GalleryModule to the Library
Library.GalleryModule = GalleryModule

-- Add the Gallery element to Elements
ElementsTable.Gallery = (function()
    local Element = {}
    Element.__index = Element
    Element.__type = "Gallery"

    function Element:New(Idx, Config)
        assert(Config.Title, "Gallery - Missing Title")
        assert(Config.Images, "Gallery - Missing Images table")
        
        local GalleryElement = GalleryModule:New(self.Container, {
            Title = Config.Title,
            Images = Config.Images,
            Size = Config.Size or UDim2.new(1, 0, 0, 250),
            BorderColor = Config.BorderColor,
            BorderThickness = Config.BorderThickness,
            BorderRadius = Config.BorderRadius
        })
        
        function GalleryElement:SetTitle(NewTitle)
            GalleryElement:SetTitle(NewTitle)
        end
        
        function GalleryElement:AddImage(ImageData)
            GalleryElement:AddImage(ImageData)
        end
        
        function GalleryElement:RemoveImage(Index)
            GalleryElement:RemoveImage(Index)
        end
        
        function GalleryElement:Visible(Bool)
            GalleryElement:SetVisible(Bool)
        end
        
        function GalleryElement:Destroy()
            GalleryElement:Destroy()
            Library.Options[Idx] = nil
        end
        
        Library.Options[Idx] = GalleryElement
        return GalleryElement
    end

    return Element
end)()

-- Add the Gallery element to the Elements table
Elements["AddGallery"] = function(self, Idx, Config)
    ElementsTable.Gallery.Container = self.Container
    ElementsTable.Gallery.Type = self.Type
    ElementsTable.Gallery.ScrollFrame = self.ScrollFrame
    ElementsTable.Gallery.Library = Library

    return ElementsTable.Gallery:New(Idx, Config)
end

return Library, SaveManager, InterfaceManager
