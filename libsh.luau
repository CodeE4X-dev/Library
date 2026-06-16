
local a = (cloneref or clonereference or function(a)
    return a
end)
local b, c, d, e, f, g, h, i, j, k, l = a(game:GetService'CoreGui'), a(game:GetService'Players'), a(game:GetService'RunService'), a(game:GetService'SoundService'), a(game:GetService'UserInputService'), a(game:GetService'TextService'), a(game:GetService'Teams'), a(game:GetService'TweenService'), getgenv or function()
    return shared
end, setclipboard or nil, protectgui or (syn and syn.protect_gui) or function() end
local m, n = gethui or function()
    return b
end, c.LocalPlayer or c.PlayerAdded:Wait()
local o, p, q, r, s, t, u, v = a(n:GetMouse()), {}, {}, {}, {}, {}, 'https://raw.githubusercontent.com/uhfork/Obsidian/refs/heads/main/', {}
local w = {
    TransparencyTexture = {
        RobloxId = 139785960036434,
        Path = 'Obsidian/assets/TransparencyTexture.png',
        URL = u .. 'assets/TransparencyTexture.png',
        Id = nil,
    },
    SaturationMap = {
        RobloxId = 4155801252,
        Path = 'Obsidian/assets/SaturationMap.png',
        URL = u .. 'assets/SaturationMap.png',
        Id = nil,
    },
    LoadingIcon = {
        RobloxId = 97544096941083,
        Path = 'Obsidian/assets/LoadingIcon.png',
        URL = u .. 'assets/LoadingIcon.png',
        Id = nil,
    },
    CheckIcon = {
        RobloxId = 97682394690683,
        Path = 'Obsidian/assets/CheckIcon.png',
        URL = u .. 'assets/CheckIcon.png',
        Id = nil,
    },
}

do
    local function RecursiveCreatePath(x, y)
        if not isfolder or not makefolder then
            return
        end

        local z, A = x:split'/', ''

        if y then
            table.remove(z, #z)
        end

        for B, C in ipairs(z)do
            if not isfolder(A .. C) then
                makefolder(A .. C)
            end

            A = A .. C .. '/'
        end

        return A
    end

    function v.AddAsset(x, y, z, A, B)
        if w[x] ~= nil then
            error(string.format('Asset %q already exists', x))
        end

        assert(typeof(y) == 'number', 'RobloxAssetId must be a number')

        w[x] = {
            RobloxId = y,
            Path = string.format('Obsidian/custom_assets/%s', x),
            URL = z,
            Tintable = B == true,
            Id = nil,
        }

        v.DownloadAsset(x, A)
    end
    function v.GetAsset(x)
        if not w[x] then
            return nil
        end

        local y = w[x]

        if y.Id then
            return y.Id
        end

        local z = string.format('rbxassetid://%s', y.RobloxId)

        if getcustomasset then
            local A, B = pcall(getcustomasset, y.Path)

            if A and B then
                z = B
            end
        end

        y.Id = z

        return z
    end
    function v.IsTintable(x)
        if w[x] and w[x].Tintable == true then
            return true
        end

        for y, z in w do
            if z.Tintable ~= true then
                continue
            end
            if z.Id == x then
                return true
            end
            if x == string.format('rbxassetid://%s', z.RobloxId) then
                return true
            end
        end

        return false
    end
    function v.DownloadAsset(x, y)
        if not getcustomasset or not writefile or not isfile then
            return false, 'missing functions'
        end

        local z = w[x]

        RecursiveCreatePath(z.Path, true)

        if y ~= true and isfile(z.Path) then
            return true, nil
        end

        local A, B = pcall(function()
            writefile(z.Path, game:HttpGet(z.URL))
        end)

        return A, B
    end

    for x, y in w do
        v.DownloadAsset(x)
    end
end

local x = {
    LocalPlayer = n,
    DevicePlatform = nil,
    IsMobile = false,
    IsRobloxFocused = true,
    ScreenGui = nil,
    Window = nil,
    SearchText = '',
    Searching = false,
    GlobalSearch = false,
    LastSearchTab = nil,
    ActiveTab = nil,
    Tabs = {},
    TabButtons = {},
    DependencyBoxes = {},
    KeybindFrame = nil,
    KeybindContainer = nil,
    KeybindToggles = {},
    Notifications = {},
    Dialogues = {},
    ActiveLoading = nil,
    ActiveDialog = nil,
    Corners = {},
    ToggleKeybind = Enum.KeyCode.RightControl,
    TweenInfo = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    NotifyTweenInfo = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
    Toggled = false,
    Unloaded = false,
    Labels = p,
    Buttons = q,
    Toggles = r,
    Options = s,
    NotifySide = 'Right',
    ForceCheckbox = false,
    ShowToggleFrameInKeybinds = true,
    NotifyOnError = false,
    CantDragForced = false,
    Signals = {},
    UnloadSignals = {},
    OriginalMinSize = Vector2.new(480, 360),
    MinSize = Vector2.new(480, 360),
    DPIScale = 1,
    CornerRadius = 4,
    CornerRadiusDropdown = false,
    IsLightTheme = false,
    Scheme = {
        BackgroundColor = Color3.fromRGB(15, 15, 15),
        MainColor = Color3.fromRGB(25, 25, 25),
        AccentColor = Color3.fromRGB(125, 85, 255),
        OutlineColor = Color3.fromRGB(40, 40, 40),
        FontColor = Color3.new(1, 1, 1),
        Font = Font.fromEnum(Enum.Font.Code),
        RedColor = Color3.fromRGB(255, 50, 50),
        DestructiveColor = Color3.fromRGB(220, 38, 38),
        DarkColor = Color3.new(0, 0, 0),
        WhiteColor = Color3.new(1, 1, 1),
        BackgroundImageEnabled = false,
        BackgroundImage = '',
        WindowGlow = false,
    },
    Registry = {},
    Scales = {},
    ImageManager = v,
}

if d:IsStudio() then
    if f.TouchEnabled and not f.MouseEnabled then
        x.IsMobile = true
        x.OriginalMinSize = Vector2.new(480, 240)
    else
        x.IsMobile = false
        x.OriginalMinSize = Vector2.new(480, 360)
    end
else
    pcall(function()
        x.DevicePlatform = f:GetPlatform()
    end)

    x.IsMobile = (x.DevicePlatform == Enum.Platform.Android or x.DevicePlatform == Enum.Platform.IOS)
    x.OriginalMinSize = x.IsMobile and Vector2.new(480, 240) or Vector2.new(480, 360)
end

local y, z, A, B, C = {
    Frame = {BorderSizePixel = 0},
    ImageLabel = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
    },
    ImageButton = {
        AutoButtonColor = false,
        BorderSizePixel = 0,
    },
    ScrollingFrame = {BorderSizePixel = 0},
    TextLabel = {
        BorderSizePixel = 0,
        FontFace = 'Font',
        RichText = true,
        TextColor3 = 'FontColor',
    },
    TextButton = {
        AutoButtonColor = false,
        BorderSizePixel = 0,
        FontFace = 'Font',
        RichText = true,
        TextColor3 = 'FontColor',
    },
    TextBox = {
        BorderSizePixel = 0,
        FontFace = 'Font',
        PlaceholderColor3 = function()
            local y, z, A = x.Scheme.FontColor:ToHSV()

            return Color3.fromHSV(y, z, A / 2)
        end,
        Text = '',
        TextColor3 = 'FontColor',
    },
    UIListLayout = {
        SortOrder = Enum.SortOrder.LayoutOrder,
    },
    UIStroke = {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
    },
    Window = {
        Title = 'No Title',
        Footer = 'No Footer',
        Position = UDim2.fromOffset(6, 6),
        Size = UDim2.fromOffset(600, 520),
        IconSize = UDim2.fromOffset(30, 30),
        AutoShow = true,
        Center = true,
        Resizable = true,
        Glow = false,
        SearchbarSize = UDim2.fromScale(1, 1),
        GlobalSearch = false,
        CornerRadius = 4,
        NotifySide = 'Right',
        Font = Enum.Font.Code,
        ToggleKeybind = Enum.KeyCode.RightControl,
        ShowMobileButtons = true,
        MobileButtonsSide = 'Left',
        UnlockMouseWhileOpen = true,
        EnableSidebarResize = false,
        EnableCompacting = true,
        DisableCompactingSnap = false,
        SidebarCompacted = true,
        MinContainerWidth = 256,
        MinSidebarWidth = 128,
        SidebarCompactWidth = 48,
        SidebarCollapseThreshold = 0.5,
        CompactWidthActivation = 128,
    },
    Dialog = {
        Title = 'Dialog',
        Description = 'No Description',
        AutoDismiss = true,
        OutsideClickDismiss = true,
        FooterButtons = {},
    },
    Loading = {
        Title = 'mspaint',
        Icon = 95816097006870,
        IconSize = UDim2.fromOffset(30, 30),
        LoadingIcon = v.GetAsset'LoadingIcon',
        LoadingIconColor = nil,
        LoadingIconTweenTime = 1,
        CurrentStep = 0,
        TotalSteps = 10,
        ShowSidebar = false,
        AutoResizeHeight = false,
        WindowWidth = 450,
        WindowHeight = 275,
        ContentWidth = 450,
        SidebarWidth = 250,
    },
    Toggle = {
        Text = 'Toggle',
        Default = false,
        Callback = function() end,
        Changed = function() end,
        Risky = false,
        Disabled = false,
        Visible = true,
    },
    Input = {
        Text = 'Input',
        Default = '',
        Finished = false,
        Numeric = false,
        ClearTextOnFocus = true,
        ClearTextOnBlur = false,
        Placeholder = '',
        AllowEmpty = true,
        EmptyReset = '---',
        Callback = function() end,
        Changed = function() end,
        VerifyValue = nil,
        Disabled = false,
        Visible = true,
    },
    Slider = {
        Text = 'Slider',
        Default = 0,
        Min = 0,
        Max = 100,
        Rounding = 0,
        Prefix = '',
        Suffix = '',
        Callback = function() end,
        Changed = function() end,
        Disabled = false,
        Visible = true,
    },
    Dropdown = {
        Values = {},
        DisabledValues = {},
        Multi = false,
        MaxVisibleDropdownItems = 8,
        Callback = function() end,
        Changed = function() end,
        Disabled = false,
        Visible = true,
    },
    Viewport = {
        Object = nil,
        Camera = nil,
        Clone = true,
        AutoFocus = true,
        Interactive = false,
        Height = 200,
        Visible = true,
    },
    Image = {
        Image = '',
        Transparency = 0,
        BackgroundTransparency = 0,
        Color = Color3.new(1, 1, 1),
        RectOffset = Vector2.zero,
        RectSize = Vector2.zero,
        ScaleType = Enum.ScaleType.Fit,
        Height = 200,
        Visible = true,
    },
    Video = {
        Video = '',
        Looped = false,
        Playing = false,
        Volume = 1,
        Height = 200,
        Visible = true,
    },
    UIPassthrough = {
        Instance = nil,
        Height = 24,
        Visible = true,
    },
    KeyPicker = {
        Text = 'KeyPicker',
        Default = 'None',
        DefaultModifiers = {},
        Blacklisted = {},
        BlacklistedModifiers = {},
        Whitelisted = {},
        WhitelistedModifiers = {},
        Mode = 'Toggle',
        Modes = {
            'Always',
            'Toggle',
            'Hold',
        },
        SyncToggleState = false,
        Callback = function() end,
        ChangedCallback = function() end,
        Changed = function() end,
        Clicked = function() end,
    },
    ColorPicker = {
        Default = Color3.new(1, 1, 1),
        Callback = function() end,
        Changed = function() end,
    },
}, {
    Bottom = {0, 1},
    Right = {1, 0},
}, {
    Left = {0.5, 1},
    Right = {0.5, 1},
}, {
    RedColor = 'Red',
    WhiteColor = 'White',
    DarkColor = 'Dark',
}, {
    Red = 'RedColor',
    White = 'WhiteColor',
    Dark = 'DarkColor',
}

local function GetSchemeValue(D)
    if not D then
        return nil
    end

    local E = B[D]

    if E and x.Scheme[E] ~= nil then
        x.Scheme[D] = x.Scheme[E]
        x.Scheme[E] = nil

        return x.Scheme[D]
    end

    local F = C[D]

    if F and x.Scheme[F] ~= nil then
        warn(string.format('Scheme Value %q is deprecated, please use %q instead.', D, F))

        return x.Scheme[F]
    end

    return x.Scheme[D]
end
local function WaitForEvent(D, E, F)
    local G = Instance.new'BindableEvent'
    local H = D:Once(function(...)
        if not F or typeof(F) == 'function' and F(...) then
            G:Fire(true)
        else
            G:Fire(false)
        end
    end)

    task.delay(E, function()
        H:Disconnect()
        G:Fire(false)
    end)

    local I = G.Event:Wait()

    G:Destroy()

    return I
end
local function IsMouseInput(D, E)
    return D.UserInputType == Enum.UserInputType.MouseButton1 or (E == true and D.UserInputType == Enum.UserInputType.MouseButton2) or D.UserInputType == Enum.UserInputType.Touch
end
local function IsClickInput(D, E)
    return IsMouseInput(D, E) and D.UserInputState == Enum.UserInputState.Begin and x.IsRobloxFocused
end
local function IsHoverInput(D)
    return (D.UserInputType == Enum.UserInputType.MouseMovement or D.UserInputType == Enum.UserInputType.Touch) and D.UserInputState == Enum.UserInputState.Change
end
local function IsDragInput(D, E)
    return IsMouseInput(D, E) and (D.UserInputState == Enum.UserInputState.Begin or D.UserInputState == Enum.UserInputState.Change) and x.IsRobloxFocused
end
local function GetTableSize(D)
    local E = 0

    for F, G in D do
        E += 1
    end

    return E
end
local function StopTween(D)
    if not (D and D.PlaybackState == Enum.PlaybackState.Playing) then
        return
    end

    D:Cancel()
end
local function Trim(D)
    return D:match'^%s*(.-)%s*$'
end
local function Round(D, E)
    assert(E >= 0, 'Invalid rounding number.')

    if E == 0 then
        return math.floor(D)
    end

    return tonumber(string.format('%.' .. E .. 'f', D))
end
local function GetPlayers(D)
    local E = c:GetPlayers()

    if D then
        local G = table.find(E, n)

        if G then
            table.remove(E, G)
        end
    end

    table.sort(E, function(G, H)
        return G.Name:lower() < H.Name:lower()
    end)

    return E
end
local function GetTeams()
    local D = h:GetTeams()

    table.sort(D, function(E, G)
        return E.Name:lower() < G.Name:lower()
    end)

    return D
end

function x.UpdateDependencyBoxes(D)
    for E, G in x.DependencyBoxes do
        G:Update(true)
    end

    if x.Searching then
        x:UpdateSearch(x.SearchText)
    end
end

local function CheckDepbox(D, E)
    local G = 0

    for H, I in D.Elements do
        if I.Type == 'Divider' then
            I.Holder.Visible = false

            continue
        elseif I.SubButton then
            local J = false

            if I.Text:lower():match(E) and I.Visible then
                J = true
            else
                I.Base.Visible = false
            end
            if I.SubButton.Text:lower():match(E) and I.SubButton.Visible then
                J = true
            else
                I.SubButton.Base.Visible = false
            end

            I.Holder.Visible = J

            if J then
                G += 1
            end

            continue
        end
        if I.Text and I.Text:lower():match(E) and I.Visible then
            I.Holder.Visible = true

            G += 1
        else
            I.Holder.Visible = false
        end
    end
    for H, I in D.DependencyBoxes do
        if not I.Visible then
            continue
        end

        G += CheckDepbox(I, E)
    end

    D.Holder.Visible = G > 0

    return G
end
local function RestoreDepbox(D)
    for E, G in D.Elements do
        G.Holder.Visible = typeof(G.Visible) == 'boolean' and G.Visible or true

        if G.SubButton then
            G.Base.Visible = G.Visible
            G.SubButton.Base.Visible = G.SubButton.Visible
        end
    end

    D:Resize()

    D.Holder.Visible = true

    for E, G in D.DependencyBoxes do
        if not G.Visible then
            continue
        end

        RestoreDepbox(G)
    end
end
local function ApplySearchToTab(D, E)
    if not D then
        return
    end

    local G = false

    for H, I in D.Groupboxes do
        local J = 0

        for K, L in I.Elements do
            if L.Type == 'Divider' then
                L.Holder.Visible = false

                continue
            elseif L.SubButton then
                local M = false

                if L.Text:lower():match(E) and L.Visible then
                    M = true
                else
                    L.Base.Visible = false
                end
                if L.SubButton.Text:lower():match(E) and L.SubButton.Visible then
                    M = true
                else
                    L.SubButton.Base.Visible = false
                end

                L.Holder.Visible = M

                if M then
                    J += 1
                end

                continue
            end
            if L.Text and L.Text:lower():match(E) and L.Visible then
                L.Holder.Visible = true

                J += 1
            else
                L.Holder.Visible = false
            end
        end
        for K, L in I.DependencyBoxes do
            if not L.Visible then
                continue
            end

            J += CheckDepbox(L, E)
        end

        if J > 0 then
            I:Resize()

            G = true
        end

        I.BoxHolder.Visible = J > 0
    end
    for H, I in D.Tabboxes do
        local J, K = 0, {}

        for L, M in I.Tabs do
            K[M] = 0

            for N, O in M.Elements do
                if O.Type == 'Divider' then
                    O.Holder.Visible = false

                    continue
                elseif O.SubButton then
                    local P = false

                    if O.Text:lower():match(E) and O.Visible then
                        P = true
                    else
                        O.Base.Visible = false
                    end
                    if O.SubButton.Text:lower():match(E) and O.SubButton.Visible then
                        P = true
                    else
                        O.SubButton.Base.Visible = false
                    end

                    O.Holder.Visible = P

                    if P then
                        K[M] += 1
                    end

                    continue
                end
                if O.Text and O.Text:lower():match(E) and O.Visible then
                    O.Holder.Visible = true

                    K[M] += 1
                else
                    O.Holder.Visible = false
                end
            end
            for N, O in M.DependencyBoxes do
                if not O.Visible then
                    continue
                end

                K[M] += CheckDepbox(O, E)
            end
        end
        for L, M in K do
            L.ButtonHolder.Visible = M > 0

            if M > 0 then
                J += 1

                G = true

                if I.ActiveTab == L then
                    L:Resize()
                elseif I.ActiveTab and K[I.ActiveTab] == 0 then
                    L:Show()
                end
            end
        end

        I.BoxHolder.Visible = J > 0
    end

    return G
end
local function ResetTab(D)
    if not D then
        return
    end

    for E, G in D.Groupboxes do
        for H, I in G.Elements do
            I.Holder.Visible = typeof(I.Visible) == 'boolean' and I.Visible or true

            if I.SubButton then
                I.Base.Visible = I.Visible
                I.SubButton.Base.Visible = I.SubButton.Visible
            end
        end
        for H, I in G.DependencyBoxes do
            if not I.Visible then
                continue
            end

            RestoreDepbox(I)
        end

        G:Resize()

        G.BoxHolder.Visible = true
    end
    for E, G in D.Tabboxes do
        for H, I in G.Tabs do
            for J, K in I.Elements do
                K.Holder.Visible = typeof(K.Visible) == 'boolean' and K.Visible or true

                if K.SubButton then
                    K.Base.Visible = K.Visible
                    K.SubButton.Base.Visible = K.SubButton.Visible
                end
            end
            for J, K in I.DependencyBoxes do
                if not K.Visible then
                    continue
                end

                RestoreDepbox(K)
            end

            I.ButtonHolder.Visible = true
        end

        if G.ActiveTab then
            G.ActiveTab:Resize()
        end

        G.BoxHolder.Visible = true
    end
end

function x.UpdateSearch(D, E)
    x.SearchText = E

    local G = {}

    if x.GlobalSearch then
        for H, I in x.Tabs do
            if typeof(I) == 'table' and not I.IsKeyTab then
                table.insert(G, I)
            end
        end
    elseif x.LastSearchTab and typeof(x.LastSearchTab) == 'table' then
        table.insert(G, x.LastSearchTab)
    end

    for H, I in ipairs(G)do
        ResetTab(I)
    end

    local H = E:lower()

    if Trim(H) == '' then
        x.Searching = false
        x.LastSearchTab = nil

        return
    end
    if not x.GlobalSearch and x.ActiveTab and x.ActiveTab.IsKeyTab then
        x.Searching = false
        x.LastSearchTab = nil

        return
    end

    x.Searching = true

    local I = {}

    if x.GlobalSearch then
        I = G

        if #I == 0 then
            for J, K in x.Tabs do
                if typeof(K) == 'table' and not K.IsKeyTab then
                    table.insert(I, K)
                end
            end
        end
    elseif x.ActiveTab then
        table.insert(I, x.ActiveTab)
    end

    local J, K = false

    for L, M in ipairs(I)do
        local N = ApplySearchToTab(M, H)

        if N then
            if not K then
                K = M
            end
            if M == x.ActiveTab then
                J = true
            end
        end
    end

    if x.GlobalSearch then
        if J and x.ActiveTab then
            x.ActiveTab:RefreshSides()
        elseif K then
            local L = E

            task.defer(function()
                if x.SearchText ~= L then
                    return
                end
                if x.ActiveTab ~= K then
                    K:Show()
                end
            end)
        end

        x.LastSearchTab = nil
    else
        x.LastSearchTab = x.ActiveTab
    end
end
function x.AddToRegistry(D, E, G)
    x.Registry[E] = G
end
function x.RemoveFromRegistry(D, E)
    x.Registry[E] = nil
end
function x.UpdateColorsUsingRegistry(D)
    for E, G in x.Registry do
        for H, I in G do
            local J = GetSchemeValue(I)

            if J or typeof(I) == 'function' then
                E[H] = J or I()
            end
        end
    end
end
function x.SetDPIScale(D, E)
    x.DPIScale = E / 100
    x.MinSize = x.OriginalMinSize * x.DPIScale

    for G, H in x.Scales do
        H.Scale = x.DPIScale
    end
    for G, H in s do
        if H.Type == 'Dropdown' then
            H:RecalculateListSize()
        end
    end
    for G, H in x.Notifications do
        H:Resize()
    end
end
function x.GiveSignal(D, E)
    local G = typeof(E)

    if E and (G == 'RBXScriptConnection' or G == 'RBXScriptSignal') then
        table.insert(x.Signals, E)
    end

    return E
end
function IsValidCustomIcon(D)
    return typeof(D) == 'string' and (D:match'rbxasset' or D:match'roblox%.com/asset/%?id=' or D:match'rbxthumb://type=')
end

local D, E = pcall(function()
    return ((loadstring(game:HttpGet'https://raw.githubusercontent.com/deividcomsono/lucide-roblox-direct/refs/heads/main/source.lua')))()
end)

function x.GetIcon(G, H)
    if not D then
        return
    end

    local I, J = pcall(E.GetAsset, H)

    if not I then
        return
    end

    return J
end
function x.GetCustomIcon(G, H)
    if not H then
        return nil
    end
    if tonumber(H) then
        H = string.format('rbxassetid://%s', tostring(H))
    end

    local I = w[H]

    if I then
        return {
            Url = v.GetAsset(H),
            ImageRectOffset = Vector2.zero,
            ImageRectSize = Vector2.zero,
            Custom = true,
            Tint = I.Tintable == true,
        }
    end

    local J = IsValidCustomIcon(H)

    if J then
        local K = {
            Url = H,
            ImageRectOffset = Vector2.zero,
            ImageRectSize = Vector2.zero,
            Custom = true,
        }

        if v.IsTintable(H) then
            K.Tint = true
        end

        return K
    end

    local K = x:GetIcon(H)

    if K then
        return K
    end

    return nil
end
function x.GetCustomImage(G, H)
    if not H then
        return ''
    end
    if tonumber(H) then
        H = string.format('rbxassetid://%s', tostring(H))
    end

    local I = typeof(H) == 'string' and (H:match'rbxasset' or H:match'roblox%.com/asset/%?id=')

    if I then
        return {
            Url = H,
            Custom = true,
        }
    end

    return ''
end
function x.Validate(G, H, I)
    if typeof(H) ~= 'table' then
        return I
    end

    for J, K in I do
        if typeof(J) == 'number' then
            continue
        end
        if typeof(K) == 'table' then
            H[J] = x:Validate(H[J], K)
        elseif H[J] == nil then
            H[J] = K
        end
    end

    return H
end

local function FillInstance(G, H)
    local I = x.Registry[H] or {}

    for J, K in G do
        if J ~= 'Text' then
            local L = GetSchemeValue(K)

            if L or typeof(K) == 'function' then
                I[J] = K
                K = L or K()
            else
                I[J] = nil
            end
        end

        H[J] = K
    end

    if GetTableSize(I) > 0 then
        x.Registry[H] = I
    end
end
local function New(G, H)
    local I = Instance.new(G)

    if y[G] then
        FillInstance(y[G], I)
    end

    FillInstance(H, I)

    if H.Parent and not H.ZIndex then
        pcall(function()
            I.ZIndex = H.Parent.ZIndex
        end)
    end

    return I
end
local function SafeParentUI(G, H)
    local I = pcall(function()
        if not H then
            H = b
        end

        local I

        if typeof(H) == 'function' then
            I = H()
        else
            I = H
        end

        G.Parent = I
    end)

    if not (I and G.Parent) then
        G.Parent = x.LocalPlayer:WaitForChild('PlayerGui', math.huge)
    end
end
local function ParentUI(G, H)
    if H then
        SafeParentUI(G, b)

        return
    end

    pcall(l, G)
    SafeParentUI(G, m)
end

local G = New('ScreenGui', {
    Name = 'Obsidian',
    DisplayOrder = 999,
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Global,
})

ParentUI(G)

x.ScreenGui = G

G.DescendantRemoving:Connect(function(H)
    x:RemoveFromRegistry(H)
end)

local H, I, J = (New('TextButton', {
    BackgroundTransparency = 1,
    Modal = false,
    Size = UDim2.fromScale(0, 0),
    AnchorPoint = Vector2.zero,
    Text = '',
    ZIndex = -999,
    Parent = G,
}))

do
    I = New('Frame', {
        AnchorPoint = Vector2.new(1, 0),
        BackgroundTransparency = 1,
        Position = UDim2.new(1, -6, 0, 6),
        Size = UDim2.new(0, 300, 1, -6),
        Parent = G,
    })

    table.insert(x.Scales, New('UIScale', {Parent = I}))

    J = New('UIListLayout', {
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        Padding = UDim.new(0, 8),
        Parent = I,
    })
end

function x.GetBetterColor(K, L, M)
    M = M * (x.IsLightTheme and -4 or 2)

    return Color3.fromRGB(math.clamp(L.R * 255 + M, 0, 255), math.clamp(L.G * 255 + M, 0, 255), math.clamp(L.B * 255 + M, 0, 255))
end
function x.GetLighterColor(K, L)
    local M, N, O = L:ToHSV()

    return Color3.fromHSV(M, math.max(0, N - 0.1), math.min(1, O + 0.1))
end
function x.GetDarkerColor(K, L)
    local M, N, O = L:ToHSV()

    return Color3.fromHSV(M, N, O / 2)
end
function x.GetKeyString(K, L)
    if L.EnumType == Enum.KeyCode and L.Value > 33 and L.Value < 127 then
        return string.char(L.Value)
    end

    return L.Name
end
function x.GetTextBounds(K, L, M, N, O)
    local P = Instance.new'GetTextBoundsParams'

    P.Text = L
    P.RichText = true
    P.Font = M
    P.Size = N
    P.Width = O or workspace.CurrentCamera.ViewportSize.X - 32

    local Q = g:GetTextBoundsAsync(P)

    return Q.X, Q.Y
end
function x.MouseIsOverFrame(K, L, M)
    local N, O = L.AbsolutePosition, L.AbsoluteSize

    return M.X >= N.X and M.X <= N.X + O.X and M.Y >= N.Y and M.Y <= N.Y + O.Y
end
function x.SafeCallback(K, L, ...)
    if not (L and typeof(L) == 'function') then
        return
    end

    local M = table.pack(xpcall(L, function(M)
        task.defer(error, debug.traceback(M, 2))

        if K.NotifyOnError then
            K:Notify{
                Title = 'Error',
                Description = M,
                Time = 10,
                Icon = 'circle-x',
            }
        end

        return M
    end, ...))

    if not M[1] then
        return nil
    end

    return table.unpack(M, 2, M.n)
end
function x.MakeDraggable(K, L, M, N, O)
    local P, Q, R, S = false

    M.InputBegan:Connect(function(T)
        if not IsClickInput(T) or O and x.CantDragForced then
            return
        end

        Q = T.Position
        R = L.Position
        P = true
        S = T.Changed:Connect(function()
            if T.UserInputState ~= Enum.UserInputState.End then
                return
            end

            P = false

            if S and S.Connected then
                S:Disconnect()

                S = nil
            end
        end)
    end)
    x:GiveSignal(f.InputChanged:Connect(function(T)
        if (not N and not x.Toggled) or (O and x.CantDragForced) or not (G and G.Parent) then
            P = false

            if S and S.Connected then
                S:Disconnect()

                S = nil
            end

            return
        end
        if P and IsHoverInput(T) then
            local U = T.Position - Q

            L.Position = UDim2.new(R.X.Scale, R.X.Offset + U.X, R.Y.Scale, R.Y.Offset + U.Y)
        end
    end))
end
function x.MakeResizable(K, L, M, N)
    local O, P, Q, R = false

    M.InputBegan:Connect(function(S)
        if not IsClickInput(S) then
            return
        end

        P = S.Position
        Q = L.Size
        O = true
        R = S.Changed:Connect(function()
            if S.UserInputState ~= Enum.UserInputState.End then
                return
            end

            O = false

            if R and R.Connected then
                R:Disconnect()

                R = nil
            end
        end)
    end)
    x:GiveSignal(f.InputChanged:Connect(function(S)
        if not L.Visible or not (G and G.Parent) then
            O = false

            if R and R.Connected then
                R:Disconnect()

                R = nil
            end

            return
        end
        if O and IsHoverInput(S) then
            local T = S.Position - P

            L.Size = UDim2.new(Q.X.Scale, math.clamp(Q.X.Offset + T.X, x.MinSize.X, math.huge), Q.Y.Scale, math.clamp(Q.Y.Offset + T.Y, x.MinSize.Y, math.huge))

            if N then
                x:SafeCallback(N)
            end
        end
    end))
end
function x.MakeCover(K, L, M)
    local N, O = z[M] or {0, 0}, A[M] or {1, 0.5}
    local P = New('Frame', {
        AnchorPoint = Vector2.new(N[1], N[2]),
        BackgroundColor3 = L.BackgroundColor3,
        Position = UDim2.fromScale(N[1], N[2]),
        Size = UDim2.fromScale(O[1], O[2]),
        Parent = L,
    })

    return P
end
function x.MakeLine(K, L, M)
    local N = New('Frame', {
        AnchorPoint = M.AnchorPoint or Vector2.zero,
        BackgroundColor3 = 'OutlineColor',
        Position = M.Position,
        Size = M.Size,
        ZIndex = M.ZIndex or L.ZIndex,
        Parent = L,
    })

    return N
end
function x.AddOutline(K, L)
    local M, N = New('UIStroke', {
        Color = 'OutlineColor',
        Thickness = 1,
        ZIndex = 2,
        Parent = L,
    }), New('UIStroke', {
        Color = 'DarkColor',
        Thickness = 2,
        ZIndex = 1,
        Parent = L,
    })

    return M, N
end
function x.AddBlank(K, L, M)
    return New('Frame', {
        BackgroundTransparency = 1,
        Size = M or UDim2.fromScale(0, 0),
        Parent = L,
    })
end
function x.MakeOutline(K, L, M, N)
    warn'Obsidian:MakeOutline is deprecated, please use Obsidian:AddOutline instead.'

    local O = New('Frame', {
        BackgroundColor3 = 'DarkColor',
        Position = UDim2.fromOffset(-2, -2),
        Size = UDim2.new(1, 4, 1, 4),
        ZIndex = N,
        Parent = L,
    })
    local P = New('Frame', {
        BackgroundColor3 = 'OutlineColor',
        Position = UDim2.fromOffset(1, 1),
        Size = UDim2.new(1, -2, 1, -2),
        ZIndex = N,
        Parent = O,
    })

    if M and M > 0 then
        New('UICorner', {
            CornerRadius = UDim.new(0, M + 1),
            Parent = O,
        })
        New('UICorner', {
            CornerRadius = UDim.new(0, M),
            Parent = P,
        })
    end

    return O, P
end
function x.AddDraggableLabel(K, L)
    local M, N = {}, New('TextLabel', {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundColor3 = 'BackgroundColor',
        Size = UDim2.fromOffset(0, 0),
        Position = UDim2.fromOffset(6, 6),
        Text = L,
        TextSize = 15,
        ZIndex = 10,
        Parent = G,
    })

    table.insert(x.Corners, New('UICorner', {
        CornerRadius = UDim.new(0, x.CornerRadius),
        Parent = N,
    }))
    New('UIPadding', {
        PaddingBottom = UDim.new(0, 6),
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12),
        PaddingTop = UDim.new(0, 6),
        Parent = N,
    })
    table.insert(x.Scales, New('UIScale', {Parent = N}))
    x:AddOutline(N)
    x:MakeDraggable(N, N, true)

    M.Label = N

    function M.SetText(O, P)
        N.Text = P
    end
    function M.SetVisible(O, P)
        N.Visible = P
    end

    return M
end
function x.AddDraggableButton(K, L, M, N)
    local O, P = {}, New('TextButton', {
        BackgroundColor3 = 'BackgroundColor',
        Position = UDim2.fromOffset(6, 6),
        TextSize = 16,
        ZIndex = 10,
        Parent = G,
    })

    table.insert(x.Corners, New('UICorner', {
        CornerRadius = UDim.new(0, x.CornerRadius),
        Parent = P,
    }))

    if not N then
        table.insert(x.Scales, New('UIScale', {Parent = P}))
    end

    x:AddOutline(P)
    P.MouseButton1Click:Connect(function()
        x:SafeCallback(M, O)
    end)
    x:MakeDraggable(P, P, true)

    O.Button = P

    function O.SetText(Q, R)
        local S, T = x:GetTextBounds(R, x.Scheme.Font, 16)

        P.Text = R
        P.Size = UDim2.fromOffset(S * 2, T * 2)
    end

    O:SetText(L)

    return O
end
function x.AddDraggableIconButton(K, L, M, N)
    local O, P = {}, New('TextButton', {
        BackgroundColor3 = 'BackgroundColor',
        Position = UDim2.fromOffset(6, 6),
        Size = UDim2.fromOffset(32, 32),
        Text = '',
        TextSize = 16,
        ZIndex = 10,
        Parent = G,
    })

    table.insert(x.Corners, New('UICorner', {
        CornerRadius = UDim.new(0, x.CornerRadius),
        Parent = P,
    }))

    if not N then
        table.insert(x.Scales, New('UIScale', {Parent = P}))
    end

    x:AddOutline(P)

    local Q = New('ImageLabel', {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(2, 2),
        Size = UDim2.new(1, -4, 1, -4),
        ZIndex = 11,
        Parent = P,
    })

    table.insert(x.Corners, New('UICorner', {
        CornerRadius = UDim.new(0, x.CornerRadius / 2),
        Parent = Q,
    }))
    P.MouseButton1Click:Connect(function()
        x:SafeCallback(M, O)
    end)
    x:MakeDraggable(P, P, true)

    O.Button = P

    function O.SetIcon(R, S)
        local T = x:GetCustomIcon(S)

        assert(T, 'Image must be a valid Roblox asset or a valid URL or a valid lucide icon.')

        Q.Image = T.Url
        Q.ImageRectOffset = T.ImageRectOffset
        Q.ImageRectSize = T.ImageRectSize
    end

    O:SetIcon(L)

    return O
end
function x.AddDraggableMenu(K, L)
    local M = New('Frame', {
        AutomaticSize = Enum.AutomaticSize.XY,
        BackgroundColor3 = 'BackgroundColor',
        Position = UDim2.fromOffset(6, 6),
        Size = UDim2.fromOffset(0, 0),
        ZIndex = 10,
        Parent = G,
    })

    table.insert(x.Corners, New('UICorner', {
        CornerRadius = UDim.new(0, x.CornerRadius),
        Parent = M,
    }))
    table.insert(x.Scales, New('UIScale', {Parent = M}))
    x:AddOutline(M)
    x:MakeLine(M, {
        Position = UDim2.fromOffset(0, 34),
        Size = UDim2.new(1, 0, 0, 1),
    })

    local N = New('TextLabel', {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 34),
        Text = L,
        TextSize = 15,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = M,
    })

    New('UIPadding', {
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12),
        Parent = N,
    })

    local O = New('Frame', {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, 35),
        Size = UDim2.new(1, 0, 1, -35),
        Parent = M,
    })

    New('UIListLayout', {
        Padding = UDim.new(0, 7),
        Parent = O,
    })
    New('UIPadding', {
        PaddingBottom = UDim.new(0, 7),
        PaddingLeft = UDim.new(0, 7),
        PaddingRight = UDim.new(0, 7),
        PaddingTop = UDim.new(0, 7),
        Parent = O,
    })
    x:MakeDraggable(M, N, true)

    return M, O
end

do
    local K = x:AddDraggableLabel''

    K:SetVisible(false)

    function x.SetWatermark(L, M)
        warn'Watermark is deprecated, please use Library:AddDraggableLabel instead.'
        K:SetText(M)
    end
    function x.SetWatermarkVisibility(L, M)
        warn'Watermark is deprecated, please use Library:AddDraggableLabel instead.'
        K:SetVisible(M)
    end
end

local K

function x.AddContextMenu(L, M, N, O, P, Q)
    local R, S = (M:FindFirstAncestorOfClass'ScreenGui')

    if R ~= G and (x.ActiveLoading and R ~= x.ActiveLoading.ScreenGui) then
        R = G
    end
    if P then
        S = New('ScrollingFrame', {
            AutomaticCanvasSize = P == 2 and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
            AutomaticSize = P == 1 and Enum.AutomaticSize.Y or Enum.AutomaticSize.None,
            BackgroundColor3 = 'BackgroundColor',
            BottomImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
            CanvasSize = UDim2.fromOffset(0, 0),
            ScrollBarImageColor3 = 'OutlineColor',
            ScrollBarThickness = P == 2 and 2 or 0,
            Size = typeof(N) == 'function' and N() or N,
            TopImage = 'rbxasset://textures/ui/Scroll/scroll-middle.png',
            Visible = false,
            ZIndex = 10,
            Parent = R,
        })
    else
        S = New('Frame', {
            BackgroundColor3 = 'BackgroundColor',
            Size = typeof(N) == 'function' and N() or N,
            Visible = false,
            ZIndex = 10,
            Parent = R,
        })
    end

    table.insert(x.Scales, New('UIScale', {Parent = S}))
    New('UIStroke', {
        Color = 'OutlineColor',
        Parent = S,
    })

    local T = {
        Active = false,
        Holder = M,
        Menu = S,
        List = nil,
        Signal = nil,
        Size = N,
    }

    if P then
        T.List = New('UIListLayout', {Parent = S})
    end

    function T.Open(U)
        if K == T then
            return
        elseif K then
            K:Close()
        end

        K = T
        T.Active = true

        if typeof(O) == 'function' then
            S.Position = UDim2.fromOffset(math.floor(M.AbsolutePosition.X + O()[1]), math.floor(M.AbsolutePosition.Y + O()[2]))
        else
            S.Position = UDim2.fromOffset(math.floor(M.AbsolutePosition.X + O[1]), math.floor(M.AbsolutePosition.Y + O[2]))
        end

        S.Size = typeof(T.Size) == 'function' and T.Size() or T.Size

        if typeof(Q) == 'function' then
            x:SafeCallback(Q, true)
        end

        S.Visible = true
        T.Signal = M:GetPropertyChangedSignal'AbsolutePosition':Connect(function()
            if typeof(O) == 'function' then
                S.Position = UDim2.fromOffset(math.floor(M.AbsolutePosition.X + O()[1]), math.floor(M.AbsolutePosition.Y + O()[2]))
            else
                S.Position = UDim2.fromOffset(math.floor(M.AbsolutePosition.X + O[1]), math.floor(M.AbsolutePosition.Y + O[2]))
            end
        end)
    end
    function T.Close(U)
        if K ~= T then
            return
        end

        S.Visible = false

        if T.Signal then
            T.Signal:Disconnect()

            T.Signal = nil
        end

        T.Active = false
        K = nil

        if typeof(Q) == 'function' then
            x:SafeCallback(Q, false)
        end
    end
    function T.Toggle(U)
        if T.Active then
            T:Close()
        else
            T:Open()
        end
    end
    function T.SetSize(U, V)
        T.Size = V
        S.Size = typeof(V) == 'function' and V() or V
    end

    return T
end

x:GiveSignal(f.InputBegan:Connect(function(L)
    if x.Unloaded then
        return
    end
    if IsClickInput(L, true) then
        local M = L.Position

        if K and not (x:MouseIsOverFrame(K.Menu, M) or x:MouseIsOverFrame(K.Holder, M)) then
            K:Close()
        end
    end
end))

local L = New('TextLabel', {
    Name = 'Tooltip',
    AutomaticSize = Enum.AutomaticSize.Y,
    BackgroundColor3 = 'BackgroundColor',
    TextSize = 14,
    TextWrapped = true,
    Visible = false,
    ZIndex = 20,
    Parent = G,
})

New('UIPadding', {
    PaddingBottom = UDim.new(0, 2),
    PaddingLeft = UDim.new(0, 4),
    PaddingRight = UDim.new(0, 4),
    PaddingTop = UDim.new(0, 2),
    Parent = L,
})
table.insert(x.Scales, New('UIScale', {Parent = L}))
New('UIStroke', {
    Color = 'OutlineColor',
    Parent = L,
})
L:GetPropertyChangedSignal'AbsolutePosition':Connect(function()
    if x.Unloaded then
        return
    end

    local M = x:GetTextBounds(L.Text, L.FontFace, L.TextSize, (workspace.CurrentCamera.ViewportSize.X - L.AbsolutePosition.X - 8) / x.DPIScale)

    L.Size = UDim2.fromOffset(M + 8)
end)

local M

function x.AddTooltip(N, O, P, Q)
    local R = {
        Disabled = false,
        Hovering = false,
        Signals = {},
    }

    local function DoHover()
        if M == Q or x.ActiveDialog or (K and x:MouseIsOverFrame(K.Menu, o)) or (R.Disabled and typeof(P) ~= 'string') or (not R.Disabled and typeof(O) ~= 'string') then
            return
        end

        M = Q

        local S = Q:FindFirstAncestorOfClass'ScreenGui'

        if S ~= G and (x.ActiveLoading and S ~= x.ActiveLoading.ScreenGui) then
            S = G
        end

        L.Parent = S
        L.Text = R.Disabled and P or O
        L.Visible = true

        while(x.Toggled or x.ActiveLoading) and not x.ActiveDialog and x:MouseIsOverFrame(Q, o) and not (K and x:MouseIsOverFrame(K.Menu, o)) do
            L.Position = UDim2.fromOffset(o.X + 14, o.Y + 12)

            d.RenderStepped:Wait()
        end

        L.Visible = false
        M = nil
    end
    local function GiveSignal(S)
        local T = typeof(S)

        if S and (T == 'RBXScriptConnection' or T == 'RBXScriptSignal') then
            table.insert(R.Signals, S)
        end

        return S
    end

    GiveSignal(Q.MouseEnter:Connect(DoHover))
    GiveSignal(Q.MouseMoved:Connect(DoHover))
    GiveSignal(Q.MouseLeave:Connect(function()
        if M ~= Q then
            return
        end

        L.Visible = false
        M = nil
    end))

    function R.Destroy(S)
        for T = #R.Signals, 1, -1 do
            local U = table.remove(R.Signals, T)

            if U and U.Connected then
                U:Disconnect()
            end
        end

        if M == Q then
            if L then
                L.Visible = false
            end

            M = nil
        end
    end

    table.insert(t, L)

    return R
end
function x.OnUnload(N, O)
    table.insert(x.UnloadSignals, O)
end
function x.Unload(N)
    for O = #x.Signals, 1, -1 do
        local P = table.remove(x.Signals, O)

        if P and P.Connected then
            P:Disconnect()
        end
    end

    for O, P in x.UnloadSignals do
        x:SafeCallback(P)
    end
    for O, P in t do
        x:SafeCallback(P.Destroy, P)
    end

    x.Unloaded = true

    if x.ActiveLoading then
        x.ActiveLoading:Destroy()
    end
    if G then
        G:Destroy()
    end

    j().Library = nil
end

local N, O, P, Q, R, S = x:GetIcon'check', x:GetIcon'chevron-up', x:GetIcon'move-diagonal-2', x:GetIcon'key', x:GetIcon'move', x:GetIcon'file-question-mark'

function x.SetIconModule(T, U)
    D = true
    E = U
    N = x:GetIcon'check'
    O = x:GetIcon'chevron-up'
    P = x:GetIcon'move-diagonal-2'
    Q = x:GetIcon'key'
    R = x:GetIcon'move'
    S = x:GetIcon'file-question-mark'
end

local T = {}

do
    local U = {}

    function U.AddKeyPicker(V, W, X)
        X = x:Validate(X, y.KeyPicker)

        local Y = V
        local Z, _ = Y.TextLabel, {
            Text = X.Text,
            Value = X.Default,
            Modifiers = X.DefaultModifiers,
            DisplayValue = X.Default,
            Blacklisted = X.Blacklisted,
            BlacklistedModifiers = X.BlacklistedModifiers,
            Whitelisted = X.Whitelisted,
            WhitelistedModifiers = X.WhitelistedModifiers,
            Toggled = false,
            Mode = X.Mode,
            SyncToggleState = X.SyncToggleState,
            Callback = X.Callback,
            ChangedCallback = X.ChangedCallback,
            Changed = X.Changed,
            Clicked = X.Clicked,
            Type = 'KeyPicker',
        }

        if _.Mode == 'Press' then
            assert(Y.Type == 'Label', "KeyPicker with the mode 'Press' can be only applied on Labels.")

            _.SyncToggleState = false
            X.Modes = {
                'Press',
            }
            X.Mode = 'Press'
        end
        if _.SyncToggleState then
            X.Modes = {
                'Toggle',
                'Hold',
            }

            if not table.find(X.Modes, X.Mode) then
                X.Mode = 'Toggle'
            end
        end

        local aa, ab, ac, ad, ae = false, {
            MB1 = Enum.UserInputType.MouseButton1,
            MB2 = Enum.UserInputType.MouseButton2,
            MB3 = Enum.UserInputType.MouseButton3,
        }, {
            [Enum.UserInputType.MouseButton1] = 'MB1',
            [Enum.UserInputType.MouseButton2] = 'MB2',
            [Enum.UserInputType.MouseButton3] = 'MB3',
        }, {
            LAlt = Enum.KeyCode.LeftAlt,
            RAlt = Enum.KeyCode.RightAlt,
            LCtrl = Enum.KeyCode.LeftControl,
            RCtrl = Enum.KeyCode.RightControl,
            LShift = Enum.KeyCode.LeftShift,
            RShift = Enum.KeyCode.RightShift,
            Tab = Enum.KeyCode.Tab,
            CapsLock = Enum.KeyCode.CapsLock,
        }, {
            [Enum.KeyCode.LeftAlt] = 'LAlt',
            [Enum.KeyCode.RightAlt] = 'RAlt',
            [Enum.KeyCode.LeftControl] = 'LCtrl',
            [Enum.KeyCode.RightControl] = 'RCtrl',
            [Enum.KeyCode.LeftShift] = 'LShift',
            [Enum.KeyCode.RightShift] = 'RShift',
            [Enum.KeyCode.Tab] = 'Tab',
            [Enum.KeyCode.CapsLock] = 'CapsLock',
        }
        local af, ag = function(af)
            return af.UserInputType == Enum.UserInputType.Keyboard and ae[af.KeyCode] ~= nil
        end, function()
            local af = {}

            for ag, ah in ad do
                if table.find(af, ag) then
                    continue
                end
                if not f:IsKeyDown(ah) then
                    continue
                end

                table.insert(af, ag)
            end

            return af
        end
        local ah, ai, aj, ak = function(ah)
            if not (typeof(ah) == 'table' and GetTableSize(ah) > 0) then
                return true
            end

            local ai, aj = ag(), true

            for ak, al in ah do
                if table.find(ai, al) then
                    continue
                end

                aj = false

                break
            end

            return aj
        end, function(ah)
            if not ah then
                return false
            end
            if ac[ah.UserInputType] ~= nil then
                return f:IsMouseButtonPressed(ah.UserInputType) and not f:GetFocusedTextBox()
            elseif ah.UserInputType == Enum.UserInputType.Keyboard then
                return f:IsKeyDown(ah.KeyCode) and not f:GetFocusedTextBox()
            else
                return false
            end
        end, function(ah)
            local ai = {}

            for aj, ak in ah do
                table.insert(ai, ad[ak])
            end

            return ai
        end, function(ah)
            if typeof(ah) ~= 'table' then
                return {}
            end

            local ai = {}

            for aj, ak in ah do
                if not ad[ak] then
                    continue
                end

                table.insert(ai, ak)
            end

            return ai
        end

        _.Modifiers = ak(_.Modifiers)

        local al = New('TextButton', {
            BackgroundColor3 = 'MainColor',
            Size = UDim2.fromOffset(18, 18),
            Text = _.Value,
            TextSize = 14,
            Parent = Z,
        })

        New('UIStroke', {
            Color = 'OutlineColor',
            Parent = al,
        })

        local am = {
            Normal = _.Mode ~= 'Toggle',
        }

        do
            local an = New('TextButton', {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 16),
                Text = '',
                Visible = not X.NoUI,
                Parent = x.KeybindContainer,
            })
            local ao, ap = New('TextLabel', {
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(0, 1),
                Text = '',
                TextSize = 14,
                TextTransparency = 0.5,
                Parent = an,
            }), New('Frame', {
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = 'MainColor',
                Position = UDim2.fromScale(0, 0.5),
                Size = UDim2.fromOffset(14, 14),
                SizeConstraint = Enum.SizeConstraint.RelativeYY,
                Parent = an,
            })

            New('UIStroke', {
                Color = 'OutlineColor',
                Parent = ap,
            })

            local aq = New('ImageLabel', {
                Image = N and N.Url or '',
                ImageColor3 = 'FontColor',
                ImageRectOffset = N and N.ImageRectOffset or Vector2.zero,
                ImageRectSize = N and N.ImageRectSize or Vector2.zero,
                ImageTransparency = 1,
                Position = UDim2.fromOffset(2, 2),
                Size = UDim2.new(1, -4, 1, -4),
                Parent = ap,
            })

            function am.Display(ar, as)
                ao.TextTransparency = as and 0 or 0.5
                aq.ImageTransparency = as and 0 or 1
            end
            function am.SetText(ar, as)
                ao.Text = as
            end
            function am.SetVisibility(ar, as)
                an.Visible = as
            end
            function am.SetNormal(ar, as)
                am.Normal = as
                an.Active = not as
                ao.Position = as and UDim2.fromOffset(0, 0) or UDim2.fromOffset(22, 0)
                ap.Visible = not as
            end

            _.DoClick = function(...) end

            an.MouseButton1Click:Connect(function()
                if am.Normal then
                    return
                end

                _.Toggled = not _.Toggled

                _:DoClick()
            end)

            am.Holder = an
            am.Label = ao
            am.Checkbox = ap
            am.Loaded = true

            table.insert(x.KeybindToggles, am)
        end

        local an = x:AddContextMenu(al, UDim2.fromOffset(62, 0), function()
            return {
                al.AbsoluteSize.X + 1.5,
                0.5,
            }
        end, 1, nil)

        _.Menu = an

        local ao = {}

        for ap, aq in X.Modes do
            local ar, as = {}, New('TextButton', {
                BackgroundColor3 = 'MainColor',
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 21),
                Text = aq,
                TextSize = 14,
                TextTransparency = 0.5,
                Parent = an.Menu,
            })

            function ar.Select(at)
                for au, av in ao do
                    av:Deselect()
                end

                _.Mode = aq
                as.BackgroundTransparency = 0
                as.TextTransparency = 0

                an:Close()
            end
            function ar.Deselect(at)
                _.Mode = nil
                as.BackgroundTransparency = 1
                as.TextTransparency = 0.5
            end

            as.MouseButton1Click:Connect(function()
                ar:Select()
            end)

            if _.Mode == aq then
                ar:Select()
            end

            ao[aq] = ar
        end

        function _.Display(ap, aq)
            if x.Unloaded then
                return
            end

            local ar, as = x:GetTextBounds(aq or _.DisplayValue, al.FontFace, al.TextSize, Z.AbsoluteSize.X)

            al.Text = aq or _.DisplayValue
            al.Size = UDim2.fromOffset((ar + 9), (as + 4))
        end
        function _.Update(ap)
            _:Display()

            if X.NoUI then
                return
            end
            if _.Mode == 'Toggle' and Y.Type == 'Toggle' and Y.Disabled then
                am:SetVisibility(false)

                return
            end

            local aq, ar = _:GetState(), x.ShowToggleFrameInKeybinds and _.Mode == 'Toggle'

            if _.SyncToggleState and Y.Value ~= aq then
                Y:SetValue(aq)
            end
            if am.Loaded then
                if ar then
                    am:SetNormal(false)
                else
                    am:SetNormal(true)
                end

                am:SetText(('[%s] %s (%s)'):format(_.DisplayValue, _.Text, _.Mode))
                am:SetVisibility(true)
                am:Display(aq)
            end
        end
        function _.GetState(ap)
            if _.Mode == 'Always' then
                return true
            elseif _.Mode == 'Hold' then
                local aq = _.Value

                if aq == 'None' then
                    return false
                end
                if not ah(_.Modifiers) then
                    return false
                end
                if ab[aq] ~= nil then
                    return f:IsMouseButtonPressed(ab[aq]) and not f:GetFocusedTextBox()
                else
                    return f:IsKeyDown(Enum.KeyCode[aq]) and not f:GetFocusedTextBox()
                end
            else
                return _.Toggled
            end
        end
        function _.OnChanged(ap, aq)
            _.Changed = aq
        end
        function _.OnClick(ap, aq)
            _.Clicked = aq
        end
        function _.DoClick(ap)
            if _.Mode == 'Press' then
                if _.Toggled and X.WaitForCallback == true then
                    return
                end

                _.Toggled = true
            end

            x:SafeCallback(_.Callback, _.Toggled)
            x:SafeCallback(_.Clicked, _.Toggled)

            if _.Mode == 'Press' then
                _.Toggled = false
            end
        end
        function _.SetValue(ap, aq)
            local ar, as, at = aq[1], aq[2], aq[3]
            local au, av = pcall(function()
                if ar == 'None' then
                    ar = nil

                    return nil
                end
                if ab[ar] == nil then
                    return Enum.KeyCode[ar]
                end

                return ab[ar]
            end)

            if ar == nil then
                _.Value = 'None'
            elseif au then
                _.Value = ar
            else
                _.Value = 'Unknown'
            end

            _.Modifiers = ak(if typeof(at) == 'table'then at else _.Modifiers)
            _.DisplayValue = if GetTableSize(_.Modifiers) > 0 then(table.concat(_.Modifiers, ' + ') .. ' + ' .. _.Value)else _.Value

            if ao[as] then
                ao[as]:Select()
            end

            local aw = aj(_.Modifiers)

            x:SafeCallback(_.ChangedCallback, av, aw)
            x:SafeCallback(_.Changed, av, aw)
            _:Update()
        end
        function _.SetText(ap, aq)
            am:SetText(aq)
            _:Update()
        end

        al.MouseButton1Click:Connect(function()
            if aa then
                return
            end

            aa = true
            al.Text = '...'
            al.Size = UDim2.fromOffset(29, 18)

            local ap, aq, ar = {}

            ar = function()
                aq = f.InputBegan:Wait()

                if f:GetFocusedTextBox() ~= nil then
                    return true
                end
                if aq.KeyCode == Enum.KeyCode.Escape then
                    return false
                end

                local as, at = (af(aq))

                if ac[aq.UserInputType] ~= nil then
                    at = ac[aq.UserInputType]
                elseif aq.UserInputType == Enum.UserInputType.Keyboard then
                    if as then
                        at = ae[aq.KeyCode]
                    else
                        at = aq.KeyCode.Name
                    end
                end
                if at then
                    if as then
                        if _.WhitelistedModifiers and #_.WhitelistedModifiers > 0 and not table.find(_.WhitelistedModifiers, at) then
                            return ar()
                        end
                        if _.BlacklistedModifiers and table.find(_.BlacklistedModifiers, at) then
                            return ar()
                        end
                    else
                        if _.Whitelisted and #_.Whitelisted > 0 and not table.find(_.Whitelisted, at) then
                            return ar()
                        end
                        if _.Blacklisted and table.find(_.Blacklisted, at) then
                            return ar()
                        end
                    end
                end

                return false
            end

            repeat
                task.wait()

                al.Text = '...'
                al.Size = UDim2.fromOffset(29, 18)

                if ar() then
                    aa = false

                    _:Update()

                    return
                end
                if aq.KeyCode == Enum.KeyCode.Escape then
                    break
                end
                if af(aq) then
                    local as = false

                    repeat
                        task.wait()

                        if f:IsKeyDown(aq.KeyCode) then
                            task.wait(0.075)

                            if f:IsKeyDown(aq.KeyCode) then
                                if not table.find(ap, ae[aq.KeyCode]) then
                                    ap[#ap + 1] = ae[aq.KeyCode]

                                    _:Display(table.concat(ap, ' + ') .. ' + ...')
                                end
                                if ar() then
                                    as = true

                                    break
                                end
                                if aq.KeyCode == Enum.KeyCode.Escape then
                                    break
                                end
                                if not af(aq) then
                                    break
                                end
                            else
                                if not table.find(ap, ae[aq.KeyCode]) then
                                    break
                                end
                            end
                        end
                    until false

                    if as then
                        aa = false

                        _:Update()

                        return
                    end
                end

                break
            until false

            local as = 'Unknown'

            if ac[aq.UserInputType] ~= nil then
                as = ac[aq.UserInputType]
            elseif aq.UserInputType == Enum.UserInputType.Keyboard then
                as = aq.KeyCode == Enum.KeyCode.Escape and 'None' or aq.KeyCode.Name
            end

            ap = if aq.KeyCode == Enum.KeyCode.Escape or as == 'Unknown'then{}else ap
            _.Toggled = false

            _:SetValue{
                as,
                _.Mode,
                ap,
            }

            repeat
                task.wait()
            until not ai(aq) or f:GetFocusedTextBox()

            aa = false
        end)
        al.MouseButton2Click:Connect(an.Toggle)
        x:GiveSignal(f.InputBegan:Connect(function(ap)
            if x.Unloaded then
                return
            end
            if _.Mode == 'Always' or _.Value == 'Unknown' or _.Value == 'None' or aa or f:GetFocusedTextBox() then
                return
            end

            local aq, ar, as = _.Value, ah(_.Modifiers), false

            if aq and ar == true and (ac[ap.UserInputType] == aq or (ap.UserInputType == Enum.UserInputType.Keyboard and ap.KeyCode.Name == aq)) then
                as = true
            end
            if _.Mode == 'Toggle' then
                if as then
                    _.Toggled = not _.Toggled

                    _:DoClick()
                end
            elseif _.Mode == 'Press' then
                if as then
                    _:DoClick()
                end
            end

            _:Update()
        end))
        x:GiveSignal(f.InputEnded:Connect(function()
            if x.Unloaded then
                return
            end
            if _.Value == 'Unknown' or _.Value == 'None' or aa or f:GetFocusedTextBox() then
                return
            end

            _:Update()
        end))
        _:Update()

        if Y.Addons then
            table.insert(Y.Addons, _)
        end

        _.Default = _.Value
        _.DefaultModifiers = table.clone(_.Modifiers or {})
        s[W] = _

        return V
    end

    local aa = {}

    for ab = 0, 1, 0.1 do
        table.insert(aa, ColorSequenceKeypoint.new(ab, Color3.fromHSV(ab, 1, 1)))
    end

    function U.AddColorPicker(ab, ac, ad)
        ad = x:Validate(ad, y.ColorPicker)

        local ae = ab
        local af, ag = ae.TextLabel, {
            Value = ad.Default,
            Transparency = ad.Transparency or 0,
            Title = ad.Title,
            Callback = ad.Callback,
            Changed = ad.Changed,
            Type = 'ColorPicker',
        }

        ag.Hue, ag.Sat, ag.Vib = ag.Value:ToHSV()

        local ah = New('TextButton', {
            BackgroundColor3 = ag.Value,
            Size = UDim2.fromOffset(18, 18),
            Text = '',
            Parent = af,
        })
        local ai, aj, ak = New('UIStroke', {
            Color = x:GetDarkerColor(ag.Value),
            Parent = ah,
        }), New('ImageLabel', {
            Image = v.GetAsset'TransparencyTexture',
            ImageTransparency = (1 - ag.Transparency),
            ScaleType = Enum.ScaleType.Tile,
            Position = UDim2.new(0, -1, 0, -1),
            Size = UDim2.new(1, 2, 1, 2),
            TileSize = UDim2.fromOffset(9, 9),
            Parent = ah,
        }), x:AddContextMenu(ah, UDim2.fromOffset(ad.Transparency and 256 or 234, 0), function()
            return {
                0.5,
                ah.AbsoluteSize.Y + 1.5,
            }
        end, 1)

        ak.List.Padding = UDim.new(0, 8)
        ag.ColorMenu = ak

        New('UIPadding', {
            PaddingBottom = UDim.new(0, 6),
            PaddingLeft = UDim.new(0, 6),
            PaddingRight = UDim.new(0, 6),
            PaddingTop = UDim.new(0, 6),
            Parent = ak.Menu,
        })

        if typeof(ag.Title) == 'string' then
            New('TextLabel', {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 8),
                Text = ag.Title,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = ak.Menu,
            })
        end

        local al = New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 200),
            Parent = ak.Menu,
        })

        New('UIListLayout', {
            FillDirection = Enum.FillDirection.Horizontal,
            Padding = UDim.new(0, 6),
            Parent = al,
        })

        local am = New('ImageButton', {
            BackgroundColor3 = ag.Value,
            Image = v.GetAsset'SaturationMap',
            Size = UDim2.fromOffset(200, 200),
            Parent = al,
        })
        local an = New('Frame', {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = 'WhiteColor',
            Size = UDim2.fromOffset(6, 6),
            Parent = am,
        })

        New('UICorner', {
            CornerRadius = UDim.new(1, 0),
            Parent = an,
        })
        New('UIStroke', {
            Color = 'DarkColor',
            Parent = an,
        })

        local ao = New('TextButton', {
            Size = UDim2.fromOffset(16, 200),
            Text = '',
            Parent = al,
        })

        New('UIGradient', {
            Color = ColorSequence.new(aa),
            Rotation = 90,
            Parent = ao,
        })

        local ap, aq, ar, as = (New('Frame', {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = 'WhiteColor',
            BorderColor3 = 'DarkColor',
            BorderSizePixel = 1,
            Position = UDim2.fromScale(0.5, ag.Hue),
            Size = UDim2.new(1, 2, 0, 1),
            Parent = ao,
        }))

        if ad.Transparency then
            aq = New('ImageButton', {
                Image = v.GetAsset'TransparencyTexture',
                ScaleType = Enum.ScaleType.Tile,
                Size = UDim2.fromOffset(16, 200),
                TileSize = UDim2.fromOffset(8, 8),
                Parent = al,
            })
            ar = New('Frame', {
                BackgroundColor3 = ag.Value,
                Size = UDim2.fromScale(1, 1),
                Parent = aq,
            })

            New('UIGradient', {
                Rotation = 90,
                Transparency = NumberSequence.new{
                    NumberSequenceKeypoint.new(0, 0),
                    NumberSequenceKeypoint.new(1, 1),
                },
                Parent = ar,
            })

            as = New('Frame', {
                AnchorPoint = Vector2.new(0.5, 0.5),
                BackgroundColor3 = 'WhiteColor',
                BorderColor3 = 'DarkColor',
                BorderSizePixel = 1,
                Position = UDim2.fromScale(0.5, ag.Transparency),
                Size = UDim2.new(1, 2, 0, 1),
                Parent = aq,
            })
        end

        local at = New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 20),
            Parent = ak.Menu,
        })

        New('UIListLayout', {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalFlex = Enum.UIFlexAlignment.Fill,
            Padding = UDim.new(0, 8),
            Parent = at,
        })

        local au = New('TextBox', {
            BackgroundColor3 = 'MainColor',
            ClearTextOnFocus = false,
            Size = UDim2.fromScale(1, 1),
            Text = '#??????',
            TextSize = 14,
            Parent = at,
        })

        New('UIStroke', {
            Color = 'OutlineColor',
            Parent = au,
        })

        local av = New('TextBox', {
            BackgroundColor3 = 'MainColor',
            ClearTextOnFocus = false,
            Size = UDim2.fromScale(1, 1),
            Text = '?, ?, ?',
            TextSize = 14,
            Parent = at,
        })

        New('UIStroke', {
            Color = 'OutlineColor',
            Parent = av,
        })

        local aw = x:AddContextMenu(ah, UDim2.fromOffset(93, 0), function()
            return {
                ah.AbsoluteSize.X + 1.5,
                0.5,
            }
        end, 1)

        ag.ContextMenu = aw
        aw.List.Padding = UDim.new(0, 6)

        do
            local function CreateButton(V, W)
                local X = New('TextButton', {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 21),
                    Text = V,
                    TextSize = 14,
                    Parent = aw.Menu,
                })

                X.MouseButton1Click:Connect(function()
                    x:SafeCallback(W)
                    aw:Close()
                end)
            end

            CreateButton('Copy color', function()
                x.CopiedColor = {
                    ag.Value,
                    ag.Transparency,
                }
            end)

            ag.SetValueRGB = function(...) end

            CreateButton('Paste color', function()
                ag:SetValueRGB(x.CopiedColor[1], x.CopiedColor[2])
            end)

            if k then
                CreateButton('Copy Hex', function()
                    k(tostring(ag.Value:ToHex()))
                end)
                CreateButton('Copy RGB', function()
                    k(table.concat({
                        math.floor(ag.Value.R * 255),
                        math.floor(ag.Value.G * 255),
                        math.floor(ag.Value.B * 255),
                    }, ', '))
                end)
            end
        end

        function ag.SetHSVFromRGB(V, W)
            ag.Hue, ag.Sat, ag.Vib = W:ToHSV()
        end
        function ag.Display(V)
            if x.Unloaded then
                return
            end

            ag.Value = Color3.fromHSV(ag.Hue, ag.Sat, ag.Vib)
            ah.BackgroundColor3 = ag.Value
            ai.Color = x:GetDarkerColor(ag.Value)
            aj.ImageTransparency = (1 - ag.Transparency)
            am.BackgroundColor3 = Color3.fromHSV(ag.Hue, 1, 1)

            if ar then
                ar.BackgroundColor3 = ag.Value
            end

            an.Position = UDim2.fromScale(ag.Sat, 1 - ag.Vib)
            ap.Position = UDim2.fromScale(0.5, ag.Hue)

            if as then
                as.Position = UDim2.fromScale(0.5, ag.Transparency)
            end

            au.Text = '#' .. ag.Value:ToHex()
            av.Text = table.concat({
                math.floor(ag.Value.R * 255),
                math.floor(ag.Value.G * 255),
                math.floor(ag.Value.B * 255),
            }, ', ')
        end
        function ag.Update(V)
            ag:Display()
            x:SafeCallback(ag.Callback, ag.Value)
            x:SafeCallback(ag.Changed, ag.Value)
        end
        function ag.OnChanged(V, W)
            ag.Changed = W
        end
        function ag.SetValue(V, W, X)
            if typeof(W) == 'Color3' then
                ag:SetValueRGB(W, X)

                return
            end

            local Y = Color3.fromHSV(W[1], W[2], W[3])

            ag.Transparency = ad.Transparency and X or 0

            ag:SetHSVFromRGB(Y)
            ag:Update()
        end
        function ag.SetValueRGB(V, W, X)
            ag.Transparency = ad.Transparency and X or 0

            ag:SetHSVFromRGB(W)
            ag:Update()
        end

        ah.MouseButton1Click:Connect(ak.Toggle)
        ah.MouseButton2Click:Connect(aw.Toggle)
        am.InputBegan:Connect(function(V)
            while IsDragInput(V) do
                local W = am.AbsolutePosition.X
                local X = W + am.AbsoluteSize.X
                local Y, Z = math.clamp(o.X, W, X), am.AbsolutePosition.Y
                local _ = Z + am.AbsoluteSize.Y
                local ax, ay, az = math.clamp(o.Y, Z, _), ag.Sat, ag.Vib

                ag.Sat = (Y - W) / (X - W)
                ag.Vib = 1 - ((ax - Z) / (_ - Z))

                if ag.Sat ~= ay or ag.Vib ~= az then
                    ag:Update()
                end

                d.RenderStepped:Wait()
            end
        end)
        ao.InputBegan:Connect(function(ax)
            while IsDragInput(ax) do
                local ay = ao.AbsolutePosition.Y
                local az = ay + ao.AbsoluteSize.Y
                local V, W = math.clamp(o.Y, ay, az), ag.Hue

                ag.Hue = (V - ay) / (az - ay)

                if ag.Hue ~= W then
                    ag:Update()
                end

                d.RenderStepped:Wait()
            end
        end)

        if aq then
            aq.InputBegan:Connect(function(ax)
                while IsDragInput(ax) do
                    local ay, az = aq.AbsolutePosition.Y, aq.AbsolutePosition.Y + aq.AbsoluteSize.Y
                    local V, W = math.clamp(o.Y, ay, az), ag.Transparency

                    ag.Transparency = (V - ay) / (az - ay)

                    if ag.Transparency ~= W then
                        ag:Update()
                    end

                    d.RenderStepped:Wait()
                end
            end)
        end

        au.FocusLost:Connect(function(ax)
            if not ax then
                return
            end

            local ay, az = pcall(Color3.fromHex, au.Text)

            if ay and typeof(az) == 'Color3' then
                ag.Hue, ag.Sat, ag.Vib = az:ToHSV()
            end

            ag:Update()
        end)
        av.FocusLost:Connect(function(ax)
            if not ax then
                return
            end

            local ay, az, V = av.Text:match'(%d+),%s*(%d+),%s*(%d+)'

            if ay and az and V then
                ag:SetHSVFromRGB(Color3.fromRGB(ay, az, V))
            end

            ag:Update()
        end)
        ag:Display()

        if ae.Addons then
            table.insert(ae.Addons, ag)
        end

        ag.Default = ag.Value
        s[ac] = ag

        return ab
    end

    T.__index = U
    T.__namecall = function(ab, ac, ...)
        return U[ac](...)
    end
end

local aa = {}

do
    local ab = {}

    function ab.AddDivider(ac, ...)
        local ad, ae, af, ag = select(1, ...), 0, 0

        if typeof(ad) == 'table' then
            ag = ad.Text
            ae = ad.MarginTop or ad.Margin or 0
            af = ad.MarginBottom or ad.Margin or 0
        elseif typeof(ad) == 'string' then
            ag = ad
        end

        local ah = ac
        local ai = ah.Container
        local aj = New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 6 + ae + af),
            Parent = ai,
        })
        local ak = New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 1, 0),
            Parent = aj,
        })

        New('UIPadding', {
            PaddingTop = UDim.new(0, ae),
            PaddingBottom = UDim.new(0, af),
            Parent = aj,
        })

        if ag then
            local al = New('TextLabel', {
                AutomaticSize = Enum.AutomaticSize.X,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 0),
                Text = ag,
                TextSize = 14,
                TextTransparency = 0.5,
                TextXAlignment = Enum.TextXAlignment.Center,
                Parent = ak,
            })
            local am = x:GetTextBounds(ag, al.FontFace, al.TextSize, al.AbsoluteSize.X)
            local an = am // 2 + 10

            New('Frame', {
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = 'MainColor',
                BorderColor3 = 'OutlineColor',
                BorderSizePixel = 1,
                Position = UDim2.fromScale(0, 0.5),
                Size = UDim2.new(0.5, -an, 0, 2),
                Parent = ak,
            })
            New('Frame', {
                AnchorPoint = Vector2.new(1, 0.5),
                BackgroundColor3 = 'MainColor',
                BorderColor3 = 'OutlineColor',
                BorderSizePixel = 1,
                Position = UDim2.fromScale(1, 0.5),
                Size = UDim2.new(0.5, -an, 0, 2),
                Parent = ak,
            })
        else
            New('Frame', {
                AnchorPoint = Vector2.new(0, 0.5),
                BackgroundColor3 = 'MainColor',
                BorderColor3 = 'OutlineColor',
                BorderSizePixel = 1,
                Position = UDim2.fromScale(0, 0.5),
                Size = UDim2.new(1, 0, 0, 2),
                Parent = ak,
            })
        end

        ah:Resize()

        local al = {
            Holder = aj,
            Text = ag,
            MarginTop = ae,
            MarginBottom = af,
            Type = 'Divider',
        }

        table.insert(ah.Elements, al)

        return al
    end
    function ab.AddLabel(ac, ...)
        local ad, ae, af, ag = {}, {}, select(1, ...), select(2, ...)

        if typeof(af) == 'table' or typeof(ag) == 'table' then
            local ah = typeof(af) == 'table' and af or ag

            ad.Text = ah.Text or ''
            ad.DoesWrap = ah.DoesWrap or false
            ad.Size = ah.Size or 14
            ad.Visible = ah.Visible or true
            ad.Idx = typeof(ag) == 'table' and af or nil
        else
            ad.Text = af or ''
            ad.DoesWrap = ag or false
            ad.Size = 14
            ad.Visible = true
            ad.Idx = select(3, ...) or nil
        end

        local ah = ac
        local ai, aj = ah.Container, {
            Text = ad.Text,
            DoesWrap = ad.DoesWrap,
            Addons = ae,
            Visible = ad.Visible,
            Type = 'Label',
        }
        local ak = New('TextLabel', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 18),
            Text = aj.Text,
            TextSize = ad.Size,
            TextWrapped = aj.DoesWrap,
            TextXAlignment = ah.IsKeyTab and Enum.TextXAlignment.Center or Enum.TextXAlignment.Left,
            Parent = ai,
        })

        local function UpdateLabelSize()
            if not aj.DoesWrap then
                return
            end

            local al = ak.AbsoluteSize.X

            if al <= 0 then
                return
            end

            local am, an = x:GetTextBounds(aj.Text, ak.FontFace, ak.TextSize, al)

            ak.Size = UDim2.new(1, 0, 0, math.max(18, an + 4))
        end

        function aj.SetVisible(al, am)
            aj.Visible = am
            ak.Visible = aj.Visible

            ah:Resize()
        end
        function aj.SetText(al, am)
            aj.Text = am
            ak.Text = am

            if aj.DoesWrap then
                UpdateLabelSize()
            end

            ah:Resize()
        end

        if aj.DoesWrap then
            UpdateLabelSize()
            ak:GetPropertyChangedSignal'AbsoluteSize':Connect(function()
                UpdateLabelSize()
                ah:Resize()
            end)
        else
            New('UIListLayout', {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalAlignment = Enum.HorizontalAlignment.Right,
                Padding = UDim.new(0, 6),
                Parent = ak,
            })
        end

        ah:Resize()

        aj.TextLabel = ak
        aj.Container = ai
        aj.Holder = ak

        if not ad.DoesWrap then
            setmetatable(aj, T)
        end

        table.insert(ah.Elements, aj)

        if ad.Idx then
            p[ad.Idx] = aj
        else
            table.insert(p, aj)
        end

        return aj
    end
    function ab.AddButton(ac, ...)
        local function GetInfo(...)
            local ad, ae, af = {}, select(1, ...), select(2, ...)

            if typeof(ae) == 'table' or typeof(af) == 'table' then
                local ag = typeof(ae) == 'table' and ae or af

                ad.Text = ag.Text or ''
                ad.Func = ag.Func or ag.Callback or function() end
                ad.DoubleClick = ag.DoubleClick
                ad.Tooltip = ag.Tooltip
                ad.DisabledTooltip = ag.DisabledTooltip
                ad.Risky = ag.Risky or false
                ad.Disabled = ag.Disabled or false
                ad.Visible = ag.Visible or true
                ad.Idx = typeof(af) == 'table' and ae or nil
            else
                ad.Text = ae or ''
                ad.Func = af or function() end
                ad.DoubleClick = false
                ad.Tooltip = nil
                ad.DisabledTooltip = nil
                ad.Risky = false
                ad.Disabled = false
                ad.Visible = true
                ad.Idx = select(3, ...) or nil
            end

            return ad
        end

        local ad, ae = GetInfo(...), ac
        local af, ag = ae.Container, {
            Text = ad.Text,
            Func = ad.Func,
            DoubleClick = ad.DoubleClick,
            Tooltip = ad.Tooltip,
            DisabledTooltip = ad.DisabledTooltip,
            TooltipTable = nil,
            Risky = ad.Risky,
            Disabled = ad.Disabled,
            Visible = ad.Visible,
            Tween = nil,
            Type = 'Button',
        }
        local ah = New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 21),
            Parent = af,
        })

        New('UIListLayout', {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalFlex = Enum.UIFlexAlignment.Fill,
            Padding = UDim.new(0, 9),
            Parent = ah,
        })

        local function CreateButton(ai)
            local aj = New('TextButton', {
                Active = not ai.Disabled,
                BackgroundColor3 = ai.Disabled and 'BackgroundColor' or 'MainColor',
                Size = UDim2.fromScale(1, 1),
                Text = ai.Text,
                TextSize = 14,
                TextTransparency = 0.4,
                Visible = ai.Visible,
                Parent = ah,
            })
            local ak = New('UIStroke', {
                Color = 'OutlineColor',
                Transparency = ai.Disabled and 0.5 or 0,
                Parent = aj,
            })

            return aj, ak
        end
        local function InitEvents(ai)
            ai.Base.MouseEnter:Connect(function()
                if ai.Disabled then
                    return
                end

                ai.Tween = i:Create(ai.Base, x.TweenInfo, {TextTransparency = 0})

                ai.Tween:Play()
            end)
            ai.Base.MouseLeave:Connect(function()
                if ai.Disabled then
                    return
                end

                ai.Tween = i:Create(ai.Base, x.TweenInfo, {TextTransparency = 0.4})

                ai.Tween:Play()
            end)
            ai.Base.MouseButton1Click:Connect(function()
                if ai.Disabled or ai.Locked then
                    return
                end
                if ai.DoubleClick then
                    ai.Locked = true
                    ai.Base.Text = 'Are you sure?'
                    ai.Base.TextColor3 = x.Scheme.AccentColor
                    x.Registry[ai.Base].TextColor3 = 'AccentColor'

                    local aj = WaitForEvent(ai.Base.MouseButton1Click, 0.5)

                    ai.Base.Text = ai.Text
                    ai.Base.TextColor3 = ai.Risky and x.Scheme.RedColor or x.Scheme.FontColor
                    x.Registry[ai.Base].TextColor3 = ai.Risky and 'RedColor' or 'FontColor'

                    if aj then
                        x:SafeCallback(ai.Func)
                    end

                    d.RenderStepped:Wait()

                    ai.Locked = false

                    return
                end

                x:SafeCallback(ai.Func)
            end)
        end

        ag.Base, ag.Stroke = CreateButton(ag)

        InitEvents(ag)

        function ag.AddButton(ai, ...)
            local aj = GetInfo(...)
            local ak = {
                Text = aj.Text,
                Func = aj.Func,
                DoubleClick = aj.DoubleClick,
                Tooltip = aj.Tooltip,
                DisabledTooltip = aj.DisabledTooltip,
                TooltipTable = nil,
                Risky = aj.Risky,
                Disabled = aj.Disabled,
                Visible = aj.Visible,
                Tween = nil,
                Type = 'SubButton',
            }

            ag.SubButton = ak
            ak.Base, ak.Stroke = CreateButton(ak)

            InitEvents(ak)

            function ak.UpdateColors(al)
                if x.Unloaded then
                    return
                end

                StopTween(ak.Tween)

                ak.Base.BackgroundColor3 = ak.Disabled and x.Scheme.BackgroundColor or x.Scheme.MainColor
                ak.Base.TextTransparency = ak.Disabled and 0.8 or 0.4
                ak.Stroke.Transparency = ak.Disabled and 0.5 or 0
                x.Registry[ak.Base].BackgroundColor3 = ak.Disabled and 'BackgroundColor' or 'MainColor'
            end
            function ak.SetDisabled(al, am)
                ak.Disabled = am

                if ak.TooltipTable then
                    ak.TooltipTable.Disabled = ak.Disabled
                end

                ak.Base.Active = not ak.Disabled

                ak:UpdateColors()
            end
            function ak.SetVisible(al, am)
                ak.Visible = am
                ak.Base.Visible = ak.Visible

                ae:Resize()
            end
            function ak.SetText(al, am)
                ak.Text = am
                ak.Base.Text = am
            end

            if typeof(ak.Tooltip) == 'string' or typeof(ak.DisabledTooltip) == 'string' then
                ak.TooltipTable = x:AddTooltip(ak.Tooltip, ak.DisabledTooltip, ak.Base)
                ak.TooltipTable.Disabled = ak.Disabled
            end
            if ak.Risky then
                ak.Base.TextColor3 = x.Scheme.RedColor
                x.Registry[ak.Base].TextColor3 = 'RedColor'
            end

            ak:UpdateColors()

            if aj.Idx then
                q[aj.Idx] = ak
            else
                table.insert(q, ak)
            end

            return ak
        end
        function ag.UpdateColors(ai)
            if x.Unloaded then
                return
            end

            StopTween(ag.Tween)

            ag.Base.BackgroundColor3 = ag.Disabled and x.Scheme.BackgroundColor or x.Scheme.MainColor
            ag.Base.TextTransparency = ag.Disabled and 0.8 or 0.4
            ag.Stroke.Transparency = ag.Disabled and 0.5 or 0
            x.Registry[ag.Base].BackgroundColor3 = ag.Disabled and 'BackgroundColor' or 'MainColor'
        end
        function ag.SetDisabled(ai, aj)
            ag.Disabled = aj

            if ag.TooltipTable then
                ag.TooltipTable.Disabled = ag.Disabled
            end

            ag.Base.Active = not ag.Disabled

            ag:UpdateColors()
        end
        function ag.SetVisible(ai, aj)
            ag.Visible = aj
            ah.Visible = ag.Visible

            ae:Resize()
        end
        function ag.SetText(ai, aj)
            ag.Text = aj
            ag.Base.Text = aj
        end

        if typeof(ag.Tooltip) == 'string' or typeof(ag.DisabledTooltip) == 'string' then
            ag.TooltipTable = x:AddTooltip(ag.Tooltip, ag.DisabledTooltip, ag.Base)
            ag.TooltipTable.Disabled = ag.Disabled
        end
        if ag.Risky then
            ag.Base.TextColor3 = x.Scheme.RedColor
            x.Registry[ag.Base].TextColor3 = 'RedColor'
        end

        ag:UpdateColors()
        ae:Resize()

        ag.Holder = ah

        table.insert(ae.Elements, ag)

        if ad.Idx then
            q[ad.Idx] = ag
        else
            table.insert(q, ag)
        end

        return ag
    end
    function ab.AddCheckbox(ac, ad, ae)
        ae = x:Validate(ae, y.Toggle)

        local af = ac
        local ag, ah = af.Container, {
            Text = ae.Text,
            Value = ae.Default,
            Tooltip = ae.Tooltip,
            DisabledTooltip = ae.DisabledTooltip,
            TooltipTable = nil,
            Callback = ae.Callback,
            Changed = ae.Changed,
            Risky = ae.Risky,
            Disabled = ae.Disabled,
            Visible = ae.Visible,
            Addons = {},
            Variant = 'Checkbox',
            Type = 'Toggle',
        }
        local ai = New('TextButton', {
            Active = not ah.Disabled,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 18),
            Text = '',
            Visible = ah.Visible,
            Parent = ag,
        })
        local aj = New('TextLabel', {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(26, 0),
            Size = UDim2.new(1, -26, 1, 0),
            Text = ah.Text,
            TextSize = 14,
            TextTransparency = 0.4,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = ai,
        })

        New('UIListLayout', {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            Padding = UDim.new(0, 6),
            Parent = aj,
        })

        local ak = New('Frame', {
            BackgroundColor3 = 'MainColor',
            Size = UDim2.fromScale(1, 1),
            SizeConstraint = Enum.SizeConstraint.RelativeYY,
            Parent = ai,
        })

        New('UICorner', {
            CornerRadius = UDim.new(0, 2),
            Parent = ak,
        })

        local al, am = New('UIStroke', {
            Color = 'OutlineColor',
            Parent = ak,
        }), New('ImageLabel', {
            Image = N and N.Url or '',
            ImageColor3 = 'FontColor',
            ImageRectOffset = N and N.ImageRectOffset or Vector2.zero,
            ImageRectSize = N and N.ImageRectSize or Vector2.zero,
            ImageTransparency = 1,
            Position = UDim2.fromOffset(2, 2),
            Size = UDim2.new(1, -4, 1, -4),
            Parent = ak,
        })

        function ah.UpdateColors(an)
            ah:Display()
        end
        function ah.Display(an)
            if x.Unloaded then
                return
            end

            al.Transparency = ah.Disabled and 0.5 or 0

            if ah.Disabled then
                aj.TextTransparency = 0.8
                am.ImageTransparency = ah.Value and 0.8 or 1
                ak.BackgroundColor3 = x.Scheme.BackgroundColor
                x.Registry[ak].BackgroundColor3 = 'BackgroundColor'

                return
            end

            i:Create(aj, x.TweenInfo, {
                TextTransparency = ah.Value and 0 or 0.4,
            }):Play()
            i:Create(am, x.TweenInfo, {
                ImageTransparency = ah.Value and 0 or 1,
            }):Play()

            ak.BackgroundColor3 = x.Scheme.MainColor
            x.Registry[ak].BackgroundColor3 = 'MainColor'
        end
        function ah.OnChanged(an, ao)
            ah.Changed = ao
        end
        function ah.SetValue(an, ao)
            if ah.Disabled then
                return
            end

            ah.Value = ao

            ah:Display()

            for ap, aq in ah.Addons do
                if aq.Type == 'KeyPicker' and aq.SyncToggleState then
                    aq.Toggled = ah.Value

                    aq:Update()
                end
            end

            x:UpdateDependencyBoxes()
            x:SafeCallback(ah.Callback, ah.Value)
            x:SafeCallback(ah.Changed, ah.Value)
        end
        function ah.SetDisabled(an, ao)
            ah.Disabled = ao

            if ah.TooltipTable then
                ah.TooltipTable.Disabled = ah.Disabled
            end

            for ap, aq in ah.Addons do
                if aq.Type == 'KeyPicker' and aq.SyncToggleState then
                    aq:Update()
                end
            end

            ai.Active = not ah.Disabled

            ah:Display()
        end
        function ah.SetVisible(an, ao)
            ah.Visible = ao
            ai.Visible = ah.Visible

            af:Resize()
        end
        function ah.SetText(an, ao)
            ah.Text = ao
            aj.Text = ao
        end

        ai.MouseButton1Click:Connect(function()
            if ah.Disabled then
                return
            end

            ah:SetValue(not ah.Value)
        end)

        if typeof(ah.Tooltip) == 'string' or typeof(ah.DisabledTooltip) == 'string' then
            ah.TooltipTable = x:AddTooltip(ah.Tooltip, ah.DisabledTooltip, ai)
            ah.TooltipTable.Disabled = ah.Disabled
        end
        if ah.Risky then
            aj.TextColor3 = x.Scheme.RedColor
            x.Registry[aj].TextColor3 = 'RedColor'
        end

        ah:Display()
        af:Resize()

        ah.TextLabel = aj
        ah.Container = ag

        setmetatable(ah, T)

        ah.Holder = ai

        table.insert(af.Elements, ah)

        ah.Default = ah.Value
        r[ad] = ah

        return ah
    end
    function ab.AddToggle(ac, ad, ae)
        if x.ForceCheckbox then
            return ab.AddCheckbox(ac, ad, ae)
        end

        ae = x:Validate(ae, y.Toggle)

        local af = ac
        local ag, ah = af.Container, {
            Text = ae.Text,
            Value = ae.Default,
            Tooltip = ae.Tooltip,
            DisabledTooltip = ae.DisabledTooltip,
            TooltipTable = nil,
            Callback = ae.Callback,
            Changed = ae.Changed,
            Risky = ae.Risky,
            Disabled = ae.Disabled,
            Visible = ae.Visible,
            Addons = {},
            Variant = 'Switch',
            Type = 'Toggle',
        }
        local ai = New('TextButton', {
            Active = not ah.Disabled,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 18),
            Text = '',
            Visible = ah.Visible,
            Parent = ag,
        })
        local aj = New('TextLabel', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, -40, 1, 0),
            Text = ah.Text,
            TextSize = 14,
            TextTransparency = 0.4,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = ai,
        })

        New('UIListLayout', {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            Padding = UDim.new(0, 6),
            Parent = aj,
        })

        local ak = New('Frame', {
            AnchorPoint = Vector2.new(1, 0),
            BackgroundColor3 = 'MainColor',
            Position = UDim2.fromScale(1, 0),
            Size = UDim2.fromOffset(32, 18),
            Parent = ai,
        })

        New('UICorner', {
            CornerRadius = UDim.new(1, 0),
            Parent = ak,
        })
        New('UIPadding', {
            PaddingBottom = UDim.new(0, 2),
            PaddingLeft = UDim.new(0, 2),
            PaddingRight = UDim.new(0, 2),
            PaddingTop = UDim.new(0, 2),
            Parent = ak,
        })

        local al, am = New('UIStroke', {
            Color = 'OutlineColor',
            Parent = ak,
        }), New('Frame', {
            BackgroundColor3 = 'FontColor',
            Size = UDim2.fromScale(1, 1),
            SizeConstraint = Enum.SizeConstraint.RelativeYY,
            Parent = ak,
        })

        New('UICorner', {
            CornerRadius = UDim.new(1, 0),
            Parent = am,
        })

        function ah.UpdateColors(an)
            ah:Display()
        end
        function ah.Display(an)
            if x.Unloaded then
                return
            end

            local ao = ah.Value and 1 or 0

            ak.BackgroundTransparency = ah.Disabled and 0.75 or 0
            al.Transparency = ah.Disabled and 0.75 or 0
            ak.BackgroundColor3 = ah.Value and x.Scheme.AccentColor or x.Scheme.MainColor
            al.Color = ah.Value and x.Scheme.AccentColor or x.Scheme.OutlineColor
            x.Registry[ak].BackgroundColor3 = ah.Value and 'AccentColor' or 'MainColor'
            x.Registry[al].Color = ah.Value and 'AccentColor' or 'OutlineColor'

            if ah.Disabled then
                aj.TextTransparency = 0.8
                am.AnchorPoint = Vector2.new(ao, 0)
                am.Position = UDim2.fromScale(ao, 0)
                am.BackgroundColor3 = x:GetDarkerColor(x.Scheme.FontColor)
                x.Registry[am].BackgroundColor3 = function()
                    return x:GetDarkerColor(x.Scheme.FontColor)
                end

                return
            end

            i:Create(aj, x.TweenInfo, {
                TextTransparency = ah.Value and 0 or 0.4,
            }):Play()
            i:Create(am, x.TweenInfo, {
                AnchorPoint = Vector2.new(ao, 0),
                Position = UDim2.fromScale(ao, 0),
            }):Play()

            am.BackgroundColor3 = x.Scheme.FontColor
            x.Registry[am].BackgroundColor3 = 'FontColor'
        end
        function ah.OnChanged(an, ao)
            ah.Changed = ao
        end
        function ah.SetValue(an, ao)
            if ah.Disabled then
                return
            end

            ah.Value = ao

            ah:Display()

            for ap, aq in ah.Addons do
                if aq.Type == 'KeyPicker' and aq.SyncToggleState then
                    aq.Toggled = ah.Value

                    aq:Update()
                end
            end

            x:UpdateDependencyBoxes()
            x:SafeCallback(ah.Callback, ah.Value)
            x:SafeCallback(ah.Changed, ah.Value)
        end
        function ah.SetDisabled(an, ao)
            ah.Disabled = ao

            if ah.TooltipTable then
                ah.TooltipTable.Disabled = ah.Disabled
            end

            for ap, aq in ah.Addons do
                if aq.Type == 'KeyPicker' and aq.SyncToggleState then
                    aq:Update()
                end
            end

            ai.Active = not ah.Disabled

            ah:Display()
        end
        function ah.SetVisible(an, ao)
            ah.Visible = ao
            ai.Visible = ah.Visible

            af:Resize()
        end
        function ah.SetText(an, ao)
            ah.Text = ao
            aj.Text = ao
        end

        ai.MouseButton1Click:Connect(function()
            if ah.Disabled then
                return
            end

            ah:SetValue(not ah.Value)
        end)

        if typeof(ah.Tooltip) == 'string' or typeof(ah.DisabledTooltip) == 'string' then
            ah.TooltipTable = x:AddTooltip(ah.Tooltip, ah.DisabledTooltip, ai)
            ah.TooltipTable.Disabled = ah.Disabled
        end
        if ah.Risky then
            aj.TextColor3 = x.Scheme.RedColor
            x.Registry[aj].TextColor3 = 'RedColor'
        end

        ah:Display()
        af:Resize()

        ah.TextLabel = aj
        ah.Container = ag

        setmetatable(ah, T)

        ah.Holder = ai

        table.insert(af.Elements, ah)

        ah.Default = ah.Value
        r[ad] = ah

        return ah
    end
    function ab.AddInput(ac, ad, ae)
        if typeof(ae) == 'table' and (typeof(ae.VerifyValue) == 'function' and ae.Finished ~= true) then
            ae.Finished = true
        end

        ae = x:Validate(ae, y.Input)

        local af = ac
        local ag, ah = af.Container, {
            Text = ae.Text,
            Value = ae.Default,
            Finished = ae.Finished,
            Numeric = ae.Numeric,
            ClearTextOnFocus = ae.ClearTextOnFocus,
            ClearTextOnBlur = ae.ClearTextOnBlur,
            Placeholder = ae.Placeholder,
            AllowEmpty = ae.AllowEmpty,
            EmptyReset = ae.EmptyReset,
            Tooltip = ae.Tooltip,
            DisabledTooltip = ae.DisabledTooltip,
            TooltipTable = nil,
            Callback = ae.Callback,
            Changed = ae.Changed,
            VerifyValue = ae.VerifyValue,
            Disabled = ae.Disabled,
            Visible = ae.Visible,
            Type = 'Input',
        }
        local ai = New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 39),
            Visible = ah.Visible,
            Parent = ag,
        })
        local aj, ak = New('TextLabel', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 14),
            Text = ah.Text,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = ai,
        }), New('TextBox', {
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = 'MainColor',
            ClearTextOnFocus = not ah.Disabled and ah.ClearTextOnFocus,
            PlaceholderText = ah.Placeholder,
            Position = UDim2.fromScale(0, 1),
            Size = UDim2.new(1, 0, 0, 21),
            Text = ah.Value,
            TextEditable = not ah.Disabled,
            TextScaled = true,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = ai,
        })

        New('UIPadding', {
            PaddingBottom = UDim.new(0, 3),
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8),
            PaddingTop = UDim.new(0, 4),
            Parent = ak,
        })
        New('UIStroke', {
            Color = 'OutlineColor',
            Parent = ak,
        })

        function ah.UpdateColors(al)
            if x.Unloaded then
                return
            end

            aj.TextTransparency = ah.Disabled and 0.8 or 0
            ak.TextTransparency = ah.Disabled and 0.8 or 0
        end
        function ah.OnChanged(al, am)
            ah.Changed = am
        end
        function ah.SetValue(al, am)
            if not ah.AllowEmpty and Trim(am) == '' then
                am = ah.EmptyReset
            end
            if ae.MaxLength and #am > ae.MaxLength then
                am = am:sub(1, ae.MaxLength)
            end
            if ah.Numeric then
                if #tostring(am) > 0 and not tonumber(am) then
                    am = ah.Value
                end
            end
            if typeof(ae.VerifyValue) == 'function' and (am ~= ah.EmptyReset and ae.VerifyValue(am) ~= true) then
                am = ah.EmptyReset
            end

            ah.Value = am
            ak.Text = am

            if not ah.Disabled then
                x:SafeCallback(ah.Callback, ah.Value)
                x:SafeCallback(ah.Changed, ah.Value)
            end
        end
        function ah.SetDisabled(al, am)
            ah.Disabled = am

            if ah.TooltipTable then
                ah.TooltipTable.Disabled = ah.Disabled
            end

            ak.ClearTextOnFocus = not ah.Disabled and ah.ClearTextOnFocus
            ak.TextEditable = not ah.Disabled

            ah:UpdateColors()
        end
        function ah.SetVisible(al, am)
            ah.Visible = am
            ai.Visible = ah.Visible

            af:Resize()
        end
        function ah.SetText(al, am)
            ah.Text = am
            aj.Text = am
        end

        if ah.Finished then
            ak.FocusLost:Connect(function(al)
                if not al then
                    if ah.ClearTextOnBlur then
                        ak.Text = ah.Value
                    end

                    return
                end

                ah:SetValue(ak.Text)
            end)
        else
            ak:GetPropertyChangedSignal'Text':Connect(function()
                if ak.Text == ah.Value then
                    return
                end

                ah:SetValue(ak.Text)
            end)
        end
        if typeof(ah.Tooltip) == 'string' or typeof(ah.DisabledTooltip) == 'string' then
            ah.TooltipTable = x:AddTooltip(ah.Tooltip, ah.DisabledTooltip, ak)
            ah.TooltipTable.Disabled = ah.Disabled
        end

        af:Resize()

        ah.Holder = ai

        table.insert(af.Elements, ah)

        ah.Default = ah.Value

        if typeof(ae.VerifyValue) == 'function' and (ah.Default ~= ah.EmptyReset and ae.VerifyValue(ah.Default) ~= true) then
            ah:SetValue(ah.EmptyReset)

            ah.Default = ah.EmptyReset
        end

        s[ad] = ah

        return ah
    end
    function ab.AddSlider(ac, ad, ae)
        ae = x:Validate(ae, y.Slider)

        local af = ac
        local ag, ah = af.Container, {
            Text = ae.Text,
            Value = ae.Default,
            Min = ae.Min,
            Max = ae.Max,
            Prefix = ae.Prefix,
            Suffix = ae.Suffix,
            Compact = ae.Compact,
            Rounding = ae.Rounding,
            HideMax = ae.HideMax,
            Tooltip = ae.Tooltip,
            DisabledTooltip = ae.DisabledTooltip,
            TooltipTable = nil,
            Callback = ae.Callback,
            Changed = ae.Changed,
            Disabled = ae.Disabled,
            Visible = ae.Visible,
            Type = 'Slider',
        }
        local ai, aj = (New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, ae.Compact and 15 or 33),
            Visible = ah.Visible,
            Parent = ag,
        }))

        if not ae.Compact then
            aj = New('TextLabel', {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 14),
                Text = ah.Text,
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = ai,
            })
        end

        local ak = New('TextButton', {
            Active = not ah.Disabled,
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = 'MainColor',
            Position = UDim2.fromScale(0, 1),
            Size = UDim2.new(1, 0, 0, 15),
            Text = '',
            Parent = ai,
        })

        New('UIStroke', {
            Color = 'OutlineColor',
            Parent = ak,
        })

        local al = New('TextLabel', {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Text = '',
            TextSize = 14,
            ZIndex = 2,
            Parent = ak,
        })

        New('UIStroke', {
            ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
            Color = 'DarkColor',
            LineJoinMode = Enum.LineJoinMode.Miter,
            Parent = al,
        })

        local am = New('Frame', {
            BackgroundColor3 = 'AccentColor',
            Size = UDim2.fromScale(0.5, 1),
            Parent = ak,
        })

        function ah.UpdateColors(an)
            if x.Unloaded then
                return
            end
            if aj then
                aj.TextTransparency = ah.Disabled and 0.8 or 0
            end

            al.TextTransparency = ah.Disabled and 0.8 or 0
            am.BackgroundColor3 = ah.Disabled and x.Scheme.OutlineColor or x.Scheme.AccentColor
            x.Registry[am].BackgroundColor3 = ah.Disabled and 'OutlineColor' or 'AccentColor'
        end
        function ah.Display(an)
            if x.Unloaded then
                return
            end

            local ao

            if ae.FormatDisplayValue then
                ao = ae.FormatDisplayValue(ah, ah.Value)
            end
            if ao then
                al.Text = tostring(ao)
            else
                if ae.Compact then
                    al.Text = string.format('%s: %s%s%s', ah.Text, ah.Prefix, ah.Value, ah.Suffix)
                elseif ae.HideMax then
                    al.Text = string.format('%s%s%s', ah.Prefix, ah.Value, ah.Suffix)
                else
                    al.Text = string.format('%s%s%s/%s%s%s', ah.Prefix, ah.Value, ah.Suffix, ah.Prefix, ah.Max, ah.Suffix)
                end
            end

            local ap = (ah.Value - ah.Min) / (ah.Max - ah.Min)

            am.Size = UDim2.fromScale(ap, 1)
        end
        function ah.OnChanged(an, ao)
            ah.Changed = ao
        end
        function ah.SetMax(an, ao)
            assert(ao > ah.Min, 'Max value cannot be less than the current min value.')
            ah:SetValue(math.clamp(ah.Value, ah.Min, ao))

            ah.Max = ao

            ah:Display()
        end
        function ah.SetMin(an, ao)
            assert(ao < ah.Max, 'Min value cannot be greater than the current max value.')
            ah:SetValue(math.clamp(ah.Value, ao, ah.Max))

            ah.Min = ao

            ah:Display()
        end
        function ah.SetValue(an, ao)
            if ah.Disabled then
                return
            end

            local ap = tonumber(ao)

            if not ap or ap == ah.Value then
                return
            end

            ap = math.clamp(ap, ah.Min, ah.Max)
            ah.Value = ap

            ah:Display()
            x:SafeCallback(ah.Callback, ah.Value)
            x:SafeCallback(ah.Changed, ah.Value)
        end
        function ah.SetDisabled(an, ao)
            ah.Disabled = ao

            if ah.TooltipTable then
                ah.TooltipTable.Disabled = ah.Disabled
            end

            ak.Active = not ah.Disabled

            ah:UpdateColors()
        end
        function ah.SetVisible(an, ao)
            ah.Visible = ao
            ai.Visible = ah.Visible

            af:Resize()
        end
        function ah.SetText(an, ao)
            ah.Text = ao

            if aj then
                aj.Text = ao

                return
            end

            ah:Display()
        end
        function ah.SetPrefix(an, ao)
            ah.Prefix = ao

            ah:Display()
        end
        function ah.SetSuffix(an, ao)
            ah.Suffix = ao

            ah:Display()
        end

        ak.InputBegan:Connect(function(an)
            if not IsClickInput(an) or ah.Disabled then
                return
            end
            if x.ActiveTab then
                if x.ActiveTab.Sides then
                    for ao, ap in x.ActiveTab.Sides do
                        ap.ScrollingEnabled = false
                    end
                else
                    x.ActiveTab.Container.ScrollingEnabled = false
                end
            end
            if x.ActiveLoading and x.ActiveLoading.Sidebar then
                x.ActiveLoading.Sidebar.Container.ScrollingEnabled = false
            end

            while IsDragInput(an) do
                local ao = o.X
                local ap, aq = math.clamp((ao - ak.AbsolutePosition.X) / ak.AbsoluteSize.X, 0, 1), ah.Value

                ah.Value = Round(ah.Min + ((ah.Max - ah.Min) * ap), ah.Rounding)

                ah:Display()

                if ah.Value ~= aq then
                    x:SafeCallback(ah.Callback, ah.Value)
                    x:SafeCallback(ah.Changed, ah.Value)
                end

                d.RenderStepped:Wait()
            end

            if x.ActiveTab then
                if x.ActiveTab.Sides then
                    for ao, ap in x.ActiveTab.Sides do
                        ap.ScrollingEnabled = true
                    end
                else
                    x.ActiveTab.Container.ScrollingEnabled = true
                end
            end
            if x.ActiveLoading and x.ActiveLoading.Sidebar then
                x.ActiveLoading.Sidebar.Container.ScrollingEnabled = true
            end
        end)

        if typeof(ah.Tooltip) == 'string' or typeof(ah.DisabledTooltip) == 'string' then
            ah.TooltipTable = x:AddTooltip(ah.Tooltip, ah.DisabledTooltip, ak)
            ah.TooltipTable.Disabled = ah.Disabled
        end

        ah:UpdateColors()
        ah:Display()
        af:Resize()

        ah.Holder = ai

        table.insert(af.Elements, ah)

        ah.Default = ah.Value
        s[ad] = ah

        return ah
    end
    function ab.AddDropdown(ac, ad, ae)
        ae = x:Validate(ae, y.Dropdown)

        local af = ac
        local ag = af.Container

        if ae.SpecialType == 'Player' then
            ae.Values = GetPlayers(ae.ExcludeLocalPlayer)
            ae.AllowNull = true
        elseif ae.SpecialType == 'Team' then
            ae.Values = GetTeams()
            ae.AllowNull = true
        end

        local ah = {
            Text = typeof(ae.Text) == 'string' and ae.Text or nil,
            Value = ae.Multi and {} or nil,
            Values = ae.Values,
            DisabledValues = ae.DisabledValues,
            ValueImages = ae.ValueImages,
            Multi = ae.Multi,
            SpecialType = ae.SpecialType,
            ExcludeLocalPlayer = ae.ExcludeLocalPlayer,
            EnablePlayerImages = ae.EnablePlayerImages,
            Tooltip = ae.Tooltip,
            DisabledTooltip = ae.DisabledTooltip,
            TooltipTable = nil,
            Callback = ae.Callback,
            Changed = ae.Changed,
            Disabled = ae.Disabled,
            Visible = ae.Visible,
            Type = 'Dropdown',
        }
        local ai = New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, ah.Text and 39 or 21),
            Visible = ah.Visible,
            Parent = ag,
        })
        local aj, ak = New('TextLabel', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 14),
            Text = ah.Text,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            Visible = not not ae.Text,
            ZIndex = 3,
            Parent = ai,
        }), New('TextButton', {
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = 'MainColor',
            Position = UDim2.fromScale(0, 1),
            Size = UDim2.new(1, 0, 0, 21),
            Text = '',
            TextTransparency = 1,
            ZIndex = 2,
            Parent = ai,
        })

        New('UIPadding', {
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 4),
            Parent = ak,
        })
        New('UIStroke', {
            Color = 'OutlineColor',
            Parent = ak,
        })

        local al, am, an, ao = New('ImageLabel', {
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(-4, 3),
            Size = UDim2.fromOffset(16, 16),
            Image = '',
            ImageTransparency = 1,
            ZIndex = 2,
            Parent = ak,
        }), New('TextButton', {
            Active = not ah.Disabled,
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 21),
            Text = '---',
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            ZIndex = 2,
            Parent = ak,
        }), (New('ImageLabel', {
            AnchorPoint = Vector2.new(1, 0.5),
            Image = O and O.Url or '',
            ImageColor3 = 'FontColor',
            ImageRectOffset = O and O.ImageRectOffset or Vector2.zero,
            ImageRectSize = O and O.ImageRectSize or Vector2.zero,
            ImageTransparency = 0.5,
            Position = UDim2.fromScale(1, 0.5),
            Size = UDim2.fromOffset(16, 16),
            Parent = ak,
        }))

        if ae.Searchable then
            ao = New('TextBox', {
                BackgroundTransparency = 1,
                PlaceholderText = 'Search...',
                Position = UDim2.fromOffset(-8, 0),
                Size = UDim2.new(1, -12, 1, 0),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = false,
                Parent = am,
            })

            New('UIPadding', {
                PaddingLeft = UDim.new(0, 8),
                Parent = ao,
            })
        end

        local ap, aq = function(ap)
            if not ap then
                return nil
            end

            local aq

            if ah.SpecialType == 'Player' and ah.EnablePlayerImages == true then
                if typeof(ap) == 'Instance' and ap:IsA'Player' then
                    aq = {
                        Url = string.format('rbxthumb://type=AvatarHeadShot&id=%s&w=48&h=48', tostring(ap.UserId)),
                    }
                end
            else
                if ae.ValueImages and ae.ValueImages[ap] then
                    aq = x:GetCustomIcon(ae.ValueImages[ap])
                end
            end

            return aq
        end, x:AddContextMenu(ak, function()
            return UDim2.fromOffset((ak.AbsoluteSize.X / x.DPIScale) + 1, 0)
        end, function()
            return {
                0.5,
                ak.AbsoluteSize.Y + 1.5,
            }
        end, 2, function(ap)
            am.TextTransparency = (ap and ao) and 1 or 0
            an.ImageTransparency = ap and 0 or 0.5
            an.Rotation = ap and 180 or 0

            if ao then
                ao.Text = ''
                ao.Visible = ap
            end
        end)

        ah.Menu = aq

        function ah.RecalculateListSize(ar, as)
            local at = math.clamp((as or GetTableSize(ah.Values)) * 21, 0, ae.MaxVisibleDropdownItems * 21)

            aq:SetSize(function()
                return UDim2.fromOffset((ak.AbsoluteSize.X / x.DPIScale) + 1, at)
            end)
        end
        function ah.UpdateColors(ar)
            if x.Unloaded then
                return
            end

            aj.TextTransparency = ah.Disabled and 0.8 or 0
            am.TextTransparency = ah.Disabled and 0.8 or 0
            al.ImageTransparency = ah.Disabled and 0.8 or 0
            an.ImageTransparency = ah.Disabled and 0.8 or aq.Active and 0 or 0.5
        end
        function ah.Display(ar)
            if x.Unloaded then
                return
            end

            local as, at = ''

            if ae.Multi then
                for au, av in ah.Values do
                    if ah.Value[av] then
                        if not at then
                            at = ap(av)
                        end

                        as = as .. (ae.FormatDisplayValue and tostring(ae.FormatDisplayValue(av)) or tostring(av)) .. ', '
                    end
                end

                as = as:sub(1, #as - 2)
            else
                at = ap(ah.Value)
                as = ah.Value and tostring(ah.Value) or ''

                if as ~= '' and ae.FormatDisplayValue then
                    as = tostring(ae.FormatDisplayValue(as))
                end
            end

            local au, av = am.AbsoluteSize.X - 28, x:GetTextBounds(as, x.Scheme.Font, 14, math.huge)

            if av > au then
                local aw = as

                repeat
                    aw = aw:sub(1, #aw - 1)
                    as = aw .. '...'
                    av = x:GetTextBounds(as, x.Scheme.Font, 14, math.huge)
                until av <= au or #aw <= 0
            end

            am.Text = (as == '' and '---' or as)

            if at then
                al.Image = at.Url
                al.ImageRectOffset = at.ImageRectOffset or Vector2.zero
                al.ImageRectSize = at.ImageRectSize or Vector2.zero
                al.ImageTransparency = 0
            else
                al.Image = ''
                al.ImageTransparency = 1
            end

            am.Size = at and UDim2.new(1, -8, 0, 21) or UDim2.new(1, 0, 0, 21)
            am.Position = at and UDim2.fromOffset(14, 0) or UDim2.fromOffset(0, 0)
        end
        function ah.OnChanged(ar, as)
            ah.Changed = as
        end
        function ah.GetActiveValues(ar)
            if ae.Multi then
                local as = {}

                for at, au in ah.Value do
                    table.insert(as, at)
                end

                return as
            end

            return ah.Value and 1 or 0
        end
        function ah.AddButton(ar, ...)
            local function GetInfo(...)
                local as, at, au = {}, select(1, ...), select(2, ...)

                if typeof(at) == 'table' or typeof(au) == 'table' then
                    local av = typeof(at) == 'table' and at or au

                    as.Text = av.Text or ''
                    as.Func = av.Func or av.Callback or function() end
                    as.Idx = typeof(au) == 'table' and at or nil
                else
                    as.Text = at or ''
                    as.Func = au or function() end
                    as.Idx = select(4, ...) or nil
                end

                return as
            end

            local as = GetInfo(...)
            local at, au = {
                Text = as.Text,
                Func = function()
                    x:SafeCallback(as.Func)
                    ah:Display()

                    for at, au in q do
                        au:UpdateButton()
                    end

                    x:UpdateDependencyBoxes()
                    x:SafeCallback(ah.Callback, ah.Value)
                    x:SafeCallback(ah.Changed, ah.Value)
                end,
                Tween = nil,
                Type = 'Button',
            }, New('Frame', {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -2, 0, 21),
                Parent = aq.Menu,
            })

            New('UIListLayout', {
                FillDirection = Enum.FillDirection.Horizontal,
                HorizontalFlex = Enum.UIFlexAlignment.Fill,
                Padding = UDim.new(0, 6),
                Parent = au,
            })
            New('UIPadding', {
                PaddingLeft = UDim.new(0, 4),
                PaddingRight = UDim.new(0, 4),
                Parent = au,
            })

            local function CreateButton(av)
                local aw = New('TextButton', {
                    BackgroundColor3 = 'MainColor',
                    Size = UDim2.fromScale(1, 1),
                    Text = av.Text,
                    TextSize = 14,
                    TextTransparency = 0.4,
                    Visible = true,
                    Parent = au,
                })

                New('UIStroke', {
                    Color = 'OutlineColor',
                    Transparency = 0,
                    Parent = aw,
                })

                return aw
            end
            local function InitEvents(av)
                av.Base.MouseEnter:Connect(function()
                    av.Tween = i:Create(av.Base, x.TweenInfo, {TextTransparency = 0})

                    av.Tween:Play()
                end)
                av.Base.MouseLeave:Connect(function()
                    av.Tween = i:Create(av.Base, x.TweenInfo, {TextTransparency = 0.4})

                    av.Tween:Play()
                end)
                av.Base.MouseButton1Click:Connect(function()
                    x:SafeCallback(av.Func)
                end)
            end

            at.Base = CreateButton(at)

            InitEvents(at)

            function at.AddButton(av, ...)
                local aw = GetInfo(...)
                local ax = {
                    Text = aw.Text,
                    Func = function()
                        x:SafeCallback(aw.Func)
                        ah:Display()

                        for ax, ay in q do
                            ay:UpdateButton()
                        end

                        x:UpdateDependencyBoxes()
                        x:SafeCallback(ah.Callback, ah.Value)
                        x:SafeCallback(ah.Changed, ah.Value)
                    end,
                    Tween = nil,
                    Type = 'SubButton',
                }

                at.SubButton = ax
                ax.Base = CreateButton(ax)

                InitEvents(ax)

                return ax
            end

            return at
        end

        local ar = {}

        function ah.BuildDropdownList(as)
            local at, au = ah.Values, ah.DisabledValues

            for av, aw in ar do
                av.Parent:Destroy()
            end

            table.clear(ar)

            if ae.Multi then
                as:AddButton('Select All', function()
                    local av = {}

                    for aw, ax in at do
                        if not table.find(au, ax) then
                            av[ax] = true
                        end
                    end

                    as:SetValue(av)
                end):AddButton('Deselect All', function()
                    as:SetValue()
                end)
            end

            aq.Menu.UIListLayout.Padding = UDim.new(0, ae.Multi and 4 or 0)

            local av

            if ae.Multi then
                New('UIPadding', {
                    PaddingTop = UDim.new(0, 4),
                    Parent = aq.Menu,
                })

                av = New('Frame', {
                    AutomaticSize = Enum.AutomaticSize.Y,
                    BackgroundTransparency = 1,
                    LayoutOrder = ae.Multi and 1 or 0,
                    Size = UDim2.fromScale(1, 1),
                    Parent = aq.Menu,
                })

                New('UIListLayout', {
                    Padding = UDim.new(0, 0),
                    Parent = av,
                })
            end

            local aw = 0

            for ax, ay in at do
                local az = tostring(ae.FormatListValue and ae.FormatListValue(ay) or ay)

                if ao and not az:lower():match(ao.Text:lower()) then
                    continue
                end

                aw += 1

                local U, V, W = table.find(au, ay), {}, ap(ay)
                local X = New('Frame', {
                    BackgroundColor3 = 'MainColor',
                    BackgroundTransparency = 1,
                    LayoutOrder = U and 1 or 0,
                    Size = UDim2.new(1, 0, 0, 21),
                    Parent = ae.Multi and av or aq.Menu,
                })
                local Y, Z = W and New('ImageLabel', {
                    BackgroundTransparency = 1,
                    Image = W.Url,
                    ImageRectOffset = W.ImageRectOffset,
                    ImageRectSize = W.ImageRectSize,
                    ImageTransparency = 0.5,
                    Size = UDim2.fromOffset(16, 16),
                    Position = UDim2.fromOffset(4, 3),
                    Parent = X,
                }), New('TextButton', {
                    BackgroundTransparency = 1,
                    Size = W and UDim2.new(1, -18, 0, 21) or UDim2.new(1, 0, 0, 21),
                    Position = W and UDim2.fromOffset(18, 0) or UDim2.fromOffset(0, 0),
                    Text = az,
                    TextSize = 14,
                    TextTransparency = 0.5,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = X,
                })

                New('UIPadding', {
                    PaddingLeft = UDim.new(0, 7),
                    PaddingRight = UDim.new(0, 7),
                    Parent = Z,
                })

                local _

                if ae.Multi then
                    _ = ah.Value[ay]
                else
                    _ = ah.Value == ay
                end

                function V.UpdateButton(aA)
                    if ae.Multi then
                        _ = ah.Value[ay]
                    else
                        _ = ah.Value == ay
                    end

                    X.BackgroundTransparency = _ and 0 or 1
                    Z.TextTransparency = U and 0.8 or _ and 0 or 0.5

                    if Y then
                        Y.ImageTransparency = U and 0.8 or _ and 0 or 0.5
                    end
                end

                if not U then
                    Z.MouseButton1Click:Connect(function()
                        local aA = not _

                        if not (ah:GetActiveValues() == 1 and not aA and not ae.AllowNull) then
                            _ = aA

                            if ae.Multi then
                                ah.Value[ay] = _ and true or nil
                            else
                                ah.Value = _ and ay or nil
                            end

                            for aB, aC in ar do
                                aC:UpdateButton()
                            end
                        end

                        V:UpdateButton()
                        ah:Display()
                        x:UpdateDependencyBoxes()
                        x:SafeCallback(ah.Callback, ah.Value)
                        x:SafeCallback(ah.Changed, ah.Value)
                    end)
                end

                V:UpdateButton()
                ah:Display()

                ar[Z] = V
            end

            ah:RecalculateListSize(aw)
        end
        function ah.SetValue(as, at)
            if ae.Multi then
                local au = {}

                for av, aw in at or {}do
                    if typeof(aw) ~= 'boolean' then
                        au[aw] = true
                    elseif aw and table.find(ah.Values, av) then
                        au[av] = true
                    end
                end

                ah.Value = au
            else
                if table.find(ah.Values, at) then
                    ah.Value = at
                elseif not at then
                    ah.Value = nil
                end
            end

            ah:Display()

            for au, av in ar do
                av:UpdateButton()
            end

            if not ah.Disabled then
                x:UpdateDependencyBoxes()
                x:SafeCallback(ah.Callback, ah.Value)
                x:SafeCallback(ah.Changed, ah.Value)
            end
        end
        function ah.SetValues(as, at)
            ah.Values = at

            ah:BuildDropdownList()
        end
        function ah.AddValues(as, at)
            if typeof(at) == 'table' then
                for au, av in at do
                    table.insert(ah.Values, av)
                end
            elseif typeof(at) == 'string' then
                table.insert(ah.Values, at)
            else
                return
            end

            ah:BuildDropdownList()
        end
        function ah.SetDisabledValues(as, at)
            ah.DisabledValues = at

            ah:BuildDropdownList()
        end
        function ah.AddDisabledValues(as, at)
            if typeof(at) == 'table' then
                for au, av in at do
                    table.insert(ah.DisabledValues, av)
                end
            elseif typeof(at) == 'string' then
                table.insert(ah.DisabledValues, at)
            else
                return
            end

            ah:BuildDropdownList()
        end
        function ah.SetValueImages(as, at)
            if typeof(at) ~= 'table' then
                return
            end

            ah.ValueImages = at

            ah:BuildDropdownList()
        end
        function ah.AddValueImages(as, at)
            if typeof(at) ~= 'table' then
                return
            end

            for au, av in at do
                ah.ValueImages[au] = av
            end

            ah:BuildDropdownList()
        end
        function ah.SetDisabled(as, at)
            ah.Disabled = at

            if ah.TooltipTable then
                ah.TooltipTable.Disabled = ah.Disabled
            end

            aq:Close()

            am.Active = not ah.Disabled

            ah:UpdateColors()
        end
        function ah.SetVisible(as, at)
            ah.Visible = at
            ai.Visible = ah.Visible

            af:Resize()
        end
        function ah.SetText(as, at)
            ah.Text = at
            ai.Size = UDim2.new(1, 0, 0, at and 39 or 21)
            aj.Text = at and at or ''
            aj.Visible = not not at
        end

        local as = function()
            if ah.Disabled then
                return
            end

            aq:Toggle()
        end

        ak.MouseButton1Click:Connect(as)
        am.MouseButton1Click:Connect(as)

        if ao then
            ao:GetPropertyChangedSignal'Text':Connect(ah.BuildDropdownList)
        end

        local at = {}

        if typeof(ae.Default) == 'string' then
            local au = table.find(ah.Values, ae.Default)

            if au then
                table.insert(at, au)
            end
        elseif typeof(ae.Default) == 'table' then
            for au, av in next, ae.Default do
                local aw = table.find(ah.Values, av)

                if aw then
                    table.insert(at, aw)
                end
            end
        elseif ah.Values[ae.Default] ~= nil then
            table.insert(at, ae.Default)
        end
        if next(at) then
            for au = 1, #at do
                local av = at[au]

                if ae.Multi then
                    ah.Value[ah.Values[av] ] = true
                else
                    ah.Value = ah.Values[av]
                end
                if not ae.Multi then
                    break
                end
            end
        end
        if typeof(ah.Tooltip) == 'string' or typeof(ah.DisabledTooltip) == 'string' then
            ah.TooltipTable = x:AddTooltip(ah.Tooltip, ah.DisabledTooltip, ak)
            ah.TooltipTable.Disabled = ah.Disabled
        end

        ah:UpdateColors()
        ah:Display()
        ah:BuildDropdownList()
        af:Resize()

        ah.Holder = ai

        table.insert(af.Elements, ah)

        ah.Default = at
        ah.DefaultValues = ah.Values
        s[ad] = ah

        return ah
    end
    function ab.AddViewport(ac, ad, ae)
        ae = x:Validate(ae, y.Viewport)

        local af = ac
        local ag, ah, ai, aj, ak, al = af.Container, false, false, 0, (ae.Object)

        if ae.Clone and typeof(ae.Object) == 'Instance' then
            if ae.Object.Archivable then
                ak = ak:Clone()
            else
                ae.Object.Archivable = true
                ak = ak:Clone()
                ae.Object.Archivable = false
            end
        end

        local am = {
            Object = ak,
            Camera = if not ae.Camera then Instance.new'Camera'else ae.Camera,
            Interactive = ae.Interactive,
            AutoFocus = ae.AutoFocus,
            Visible = ae.Visible,
            Type = 'Viewport',
        }

        assert(typeof(am.Object) == 'Instance' and (am.Object:IsA'BasePart' or am.Object:IsA'Model'), 'Instance must be a BasePart or Model.')
        assert(typeof(am.Camera) == 'Instance' and am.Camera:IsA'Camera', 'Camera must be a valid Camera instance.')

        local function GetModelSize(an)
            if an:IsA'BasePart' then
                return an.Size
            end

            return select(2, an:GetBoundingBox())
        end
        local function FocusCamera()
            local an = GetModelSize(am.Object)
            local ao = math.max(an.X, an.Y, an.Z)
            local ap, aq = ao * 2, am.Object:GetPivot().Position

            am.Camera.CFrame = CFrame.new(aq + Vector3.new(0, ao / 2, ap), aq)
        end

        local an = New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, ae.Height),
            Visible = am.Visible,
            Parent = ag,
        })
        local ao = New('Frame', {
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = 'MainColor',
            BorderColor3 = 'OutlineColor',
            BorderSizePixel = 1,
            Position = UDim2.fromScale(0, 1),
            Size = UDim2.fromScale(1, 1),
            Parent = an,
        })

        New('UIPadding', {
            PaddingBottom = UDim.new(0, 3),
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8),
            PaddingTop = UDim.new(0, 4),
            Parent = ao,
        })

        local ap = New('ViewportFrame', {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Parent = ao,
            CurrentCamera = am.Camera,
            Active = am.Interactive,
        })

        ap.MouseEnter:Connect(function()
            if not am.Interactive then
                return
            end

            for aq, ar in af.Tab.Sides do
                ar.ScrollingEnabled = false
            end
        end)
        ap.MouseLeave:Connect(function()
            if not am.Interactive then
                return
            end

            for aq, ar in af.Tab.Sides do
                ar.ScrollingEnabled = true
            end
        end)
        ap.InputBegan:Connect(function(aq)
            if not am.Interactive then
                return
            end
            if aq.UserInputType == Enum.UserInputType.MouseButton2 then
                ah = true
                al = aq.Position
            elseif aq.UserInputType == Enum.UserInputType.Touch and not ai then
                ah = true
                al = aq.Position
            end
        end)
        x:GiveSignal(f.InputEnded:Connect(function(aq)
            if x.Unloaded then
                return
            end
            if not am.Interactive then
                return
            end
            if aq.UserInputType == Enum.UserInputType.MouseButton2 then
                ah = false
            elseif aq.UserInputType == Enum.UserInputType.Touch then
                ah = false
            end
        end))
        x:GiveSignal(f.InputChanged:Connect(function(aq)
            if x.Unloaded then
                return
            end
            if not am.Interactive or not ah or ai then
                return
            end
            if aq.UserInputType == Enum.UserInputType.MouseMovement or aq.UserInputType == Enum.UserInputType.Touch then
                local ar = aq.Position - al

                al = aq.Position

                local as, at, au = am.Object:GetPivot().Position, am.Camera, CFrame.fromAxisAngle(Vector3.new(0, 1, 0), -ar.X * 0.01)

                at.CFrame = CFrame.new(as) * au * CFrame.new(-as) * at.CFrame

                local av = CFrame.fromAxisAngle(at.CFrame.RightVector, -ar.Y * 0.01)
                local aw = CFrame.new(as) * av * CFrame.new(-as) * at.CFrame

                if aw.UpVector.Y > 0.1 then
                    at.CFrame = aw
                end
            end
        end))
        ap.InputChanged:Connect(function(aq)
            if not am.Interactive then
                return
            end
            if aq.UserInputType == Enum.UserInputType.MouseWheel then
                local ar = aq.Position.Z * 2

                am.Camera.CFrame += am.Camera.CFrame.LookVector * ar
            end
        end)
        x:GiveSignal(f.TouchPinch:Connect(function(aq, ar, as, at)
            if x.Unloaded then
                return
            end
            if not am.Interactive or not x:MouseIsOverFrame(ap, aq[1]) then
                return
            end
            if at == Enum.UserInputState.Begin then
                ai = true
                ah = false
                aj = (aq[1] - aq[2]).Magnitude
            elseif at == Enum.UserInputState.Change then
                local au = (aq[1] - aq[2]).Magnitude
                local av = (au - aj) * 0.1

                aj = au

                am.Camera.CFrame += am.Camera.CFrame.LookVector * av
            elseif at == Enum.UserInputState.End or at == Enum.UserInputState.Cancel then
                ai = false
            end
        end))

        am.Object.Parent = ap

        if am.AutoFocus then
            FocusCamera()
        end

        function am.SetObject(aq, ar, as)
            assert(ar, 'Object cannot be nil.')

            if as then
                ar = ar:Clone()
            end
            if am.Object then
                am.Object:Destroy()
            end

            am.Object = ar
            am.Object.Parent = ap

            af:Resize()
        end
        function am.SetHeight(aq, ar)
            assert(ar > 0, 'Height must be greater than 0.')

            an.Size = UDim2.new(1, 0, 0, ar)

            af:Resize()
        end
        function am.Focus(aq)
            if not am.Object then
                return
            end

            FocusCamera()
        end
        function am.SetCamera(aq, ar)
            assert(ar and typeof(ar) == 'Instance' and ar:IsA'Camera', 'Camera must be a valid Camera instance.')

            am.Camera = ar
            ap.CurrentCamera = ar
        end
        function am.SetInteractive(aq, ar)
            am.Interactive = ar
            ap.Active = ar
        end
        function am.SetVisible(aq, ar)
            am.Visible = ar
            an.Visible = am.Visible

            af:Resize()
        end

        af:Resize()

        am.Holder = an

        table.insert(af.Elements, am)

        s[ad] = am

        return am
    end
    function ab.AddImage(ac, ad, ae)
        ae = x:Validate(ae, y.Image)

        local af = ac
        local ag, ah = af.Container, {
            Image = ae.Image,
            Color = ae.Color,
            RectOffset = ae.RectOffset,
            RectSize = ae.RectSize,
            Height = ae.Height,
            ScaleType = ae.ScaleType,
            Transparency = ae.Transparency,
            BackgroundTransparency = ae.BackgroundTransparency,
            Visible = ae.Visible,
            Type = 'Image',
        }
        local ai = New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, ae.Height),
            Visible = ah.Visible,
            Parent = ag,
        })
        local aj = New('Frame', {
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = 'MainColor',
            BorderColor3 = 'OutlineColor',
            BorderSizePixel = 1,
            BackgroundTransparency = ah.BackgroundTransparency,
            Position = UDim2.fromScale(0, 1),
            Size = UDim2.fromScale(1, 1),
            Parent = ai,
        })

        New('UIPadding', {
            PaddingBottom = UDim.new(0, 3),
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8),
            PaddingTop = UDim.new(0, 4),
            Parent = aj,
        })

        local ak = {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Image = ah.Image,
            ImageTransparency = ah.Transparency,
            ImageColor3 = ah.Color,
            ImageRectOffset = ah.RectOffset,
            ImageRectSize = ah.RectSize,
            ScaleType = ah.ScaleType,
            Parent = aj,
        }
        local al = x:GetCustomIcon(ak.Image)

        assert(al, 'Image must be a valid Roblox asset or a valid URL or a valid lucide icon.')

        ak.Image = al.Url
        ak.ImageRectOffset = al.ImageRectOffset
        ak.ImageRectSize = al.ImageRectSize

        local am = New('ImageLabel', ak)

        function ah.SetHeight(an, ao)
            assert(ao > 0, 'Height must be greater than 0.')

            ah.Height = ao
            ai.Size = UDim2.new(1, 0, 0, ao)

            af:Resize()
        end
        function ah.SetImage(an, ao)
            assert(typeof(ao) == 'string', 'Image must be a string.')

            local ap = x:GetCustomIcon(ao)

            assert(ap, 'Image must be a valid Roblox asset or a valid URL or a valid lucide icon.')

            ao = ap.Url
            ah.RectOffset = ap.ImageRectOffset
            ah.RectSize = ap.ImageRectSize
            am.Image = ao
            ah.Image = ao
        end
        function ah.SetColor(an, ao)
            assert(typeof(ao) == 'Color3', 'Color must be a Color3 value.')

            am.ImageColor3 = ao
            ah.Color = ao
        end
        function ah.SetRectOffset(an, ao)
            assert(typeof(ao) == 'Vector2', 'RectOffset must be a Vector2 value.')

            am.ImageRectOffset = ao
            ah.RectOffset = ao
        end
        function ah.SetRectSize(an, ao)
            assert(typeof(ao) == 'Vector2', 'RectSize must be a Vector2 value.')

            am.ImageRectSize = ao
            ah.RectSize = ao
        end
        function ah.SetScaleType(an, ao)
            assert(typeof(ao) == 'EnumItem' and ao:IsA'ScaleType', 'ScaleType must be a valid Enum.ScaleType.')

            am.ScaleType = ao
            ah.ScaleType = ao
        end
        function ah.SetTransparency(an, ao)
            assert(typeof(ao) == 'number', 'Transparency must be a number between 0 and 1.')
            assert(ao >= 0 and ao <= 1, 'Transparency must be between 0 and 1.')

            am.ImageTransparency = ao
            ah.Transparency = ao
        end
        function ah.SetVisible(an, ao)
            ah.Visible = ao
            ai.Visible = ah.Visible

            af:Resize()
        end

        af:Resize()

        ah.Holder = ai

        table.insert(af.Elements, ah)

        s[ad] = ah

        return ah
    end
    function ab.AddVideo(ac, ad, ae)
        ae = x:Validate(ae, y.Video)

        local af = ac
        local ag, ah = af.Container, {
            Video = ae.Video,
            Looped = ae.Looped,
            Playing = ae.Playing,
            Volume = ae.Volume,
            Height = ae.Height,
            Visible = ae.Visible,
            Type = 'Video',
        }
        local ai = New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, ae.Height),
            Visible = ah.Visible,
            Parent = ag,
        })
        local aj = New('Frame', {
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = 'MainColor',
            BorderColor3 = 'OutlineColor',
            BorderSizePixel = 1,
            Position = UDim2.fromScale(0, 1),
            Size = UDim2.fromScale(1, 1),
            Parent = ai,
        })

        New('UIPadding', {
            PaddingBottom = UDim.new(0, 3),
            PaddingLeft = UDim.new(0, 8),
            PaddingRight = UDim.new(0, 8),
            PaddingTop = UDim.new(0, 4),
            Parent = aj,
        })

        local ak = New('VideoFrame', {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Video = ah.Video,
            Looped = ah.Looped,
            Volume = ah.Volume,
            Parent = aj,
        })

        ak.Playing = ah.Playing

        function ah.SetHeight(al, am)
            assert(am > 0, 'Height must be greater than 0.')

            ah.Height = am
            ai.Size = UDim2.new(1, 0, 0, am)

            af:Resize()
        end
        function ah.SetVideo(al, am)
            assert(typeof(am) == 'string', 'Video must be a string.')

            ak.Video = am
            ah.Video = am
        end
        function ah.SetLooped(al, am)
            assert(typeof(am) == 'boolean', 'Looped must be a boolean.')

            ak.Looped = am
            ah.Looped = am
        end
        function ah.SetVolume(al, am)
            assert(typeof(am) == 'number', 'Volume must be a number between 0 and 10.')

            ak.Volume = am
            ah.Volume = am
        end
        function ah.SetPlaying(al, am)
            assert(typeof(am) == 'boolean', 'Playing must be a boolean.')

            ak.Playing = am
            ah.Playing = am
        end
        function ah.Play(al)
            ak.Playing = true
            ah.Playing = true
        end
        function ah.Pause(al)
            ak.Playing = false
            ah.Playing = false
        end
        function ah.SetVisible(al, am)
            ah.Visible = am
            ai.Visible = ah.Visible

            af:Resize()
        end

        af:Resize()

        ah.Holder = ai
        ah.VideoFrame = ak

        table.insert(af.Elements, ah)

        s[ad] = ah

        return ah
    end
    function ab.AddUIPassthrough(ac, ad, ae)
        ae = x:Validate(ae, y.UIPassthrough)

        local af = ac
        local ag = af.Container

        assert(ae.Instance, 'Instance must be provided.')
        assert(typeof(ae.Instance) == 'Instance' and ae.Instance:IsA'GuiBase2d', 'Instance must inherit from GuiBase2d.')
        assert(typeof(ae.Height) == 'number' and ae.Height > 0, 'Height must be a number greater than 0.')

        local ah = {
            Instance = ae.Instance,
            Height = ae.Height,
            Visible = ae.Visible,
            Type = 'UIPassthrough',
        }
        local ai = New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, ae.Height),
            Visible = ah.Visible,
            Parent = ag,
        })

        ah.Instance.Parent = ai

        af:Resize()

        function ah.SetHeight(aj, ak)
            assert(typeof(ak) == 'number' and ak > 0, 'Height must be a number greater than 0.')

            ah.Height = ak
            ai.Size = UDim2.new(1, 0, 0, ak)

            af:Resize()
        end
        function ah.SetInstance(aj, ak)
            assert(ak, 'Instance must be provided.')
            assert(typeof(ak) == 'Instance' and ak:IsA'GuiBase2d', 'Instance must inherit from GuiBase2d.')

            if ah.Instance then
                ah.Instance.Parent = nil
            end

            ah.Instance = ak
            ah.Instance.Parent = ai
        end
        function ah.SetVisible(aj, ak)
            ah.Visible = ak
            ai.Visible = ah.Visible

            af:Resize()
        end

        ah.Holder = ai

        table.insert(af.Elements, ah)

        s[ad] = ah

        return ah
    end
    function ab.AddDependencyBox(ac)
        local ad = ac
        local ae, af, ag = (ad.Container)

        do
            af = New('Frame', {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                Visible = false,
                Parent = ae,
            })
            ag = New('UIListLayout', {
                Padding = UDim.new(0, 8),
                Parent = af,
            })
        end

        local ah = {
            Visible = false,
            Dependencies = {},
            Holder = af,
            Container = af,
            Elements = {},
            DependencyBoxes = {},
        }

        function ah.Resize(ai)
            af.Size = UDim2.new(1, 0, 0, ag.AbsoluteContentSize.Y / x.DPIScale)

            ad:Resize()
        end
        function ah.Update(ai, aj)
            for ak, al in ah.Dependencies do
                local am, an = al[1], al[2]

                if am.Type == 'Toggle' and am.Value ~= an then
                    af.Visible = false
                    ah.Visible = false

                    return
                elseif am.Type == 'Dropdown' then
                    if typeof(am.Value) == 'table' then
                        if not am.Value[an] then
                            af.Visible = false
                            ah.Visible = false

                            return
                        end
                    else
                        if am.Value ~= an then
                            af.Visible = false
                            ah.Visible = false

                            return
                        end
                    end
                end
            end

            ah.Visible = true
            af.Visible = true

            if not x.Searching then
                task.defer(function()
                    ah:Resize()
                end)
            elseif not aj then
                x:UpdateSearch(x.SearchText)
            end
        end

        ag:GetPropertyChangedSignal'AbsoluteContentSize':Connect(function()
            if not ah.Visible then
                return
            end

            ah:Resize()
        end)

        function ah.SetupDependencies(ai, aj)
            for ak, al in aj do
                assert(typeof(al) == 'table', 'Dependency should be a table.')
                assert(al[1] ~= nil, 'Dependency is missing element.')
                assert(al[2] ~= nil, 'Dependency is missing expected value.')
            end

            ah.Dependencies = aj

            ah:Update()
        end

        af:GetPropertyChangedSignal'Visible':Connect(function()
            ah:Resize()
        end)
        setmetatable(ah, aa)
        table.insert(ad.DependencyBoxes, ah)
        table.insert(x.DependencyBoxes, ah)

        return ah
    end
    function ab.AddDependencyGroupbox(ac)
        local ad = ac
        local ae, af, ag, ah = ad.Tab, (ad.BoxHolder)

        do
            ag = New('Frame', {
                BackgroundColor3 = 'BackgroundColor',
                Size = UDim2.fromScale(1, 0),
                Visible = false,
                Parent = af,
            })

            table.insert(x.Corners, New('UICorner', {
                CornerRadius = UDim.new(0, x.CornerRadius),
                Parent = ag,
            }))
            x:AddOutline(ag)

            ah = New('UIListLayout', {
                Padding = UDim.new(0, 8),
                Parent = ag,
            })

            New('UIPadding', {
                PaddingBottom = UDim.new(0, 7),
                PaddingLeft = UDim.new(0, 7),
                PaddingRight = UDim.new(0, 7),
                PaddingTop = UDim.new(0, 7),
                Parent = ag,
            })
        end

        local ai = {
            Visible = false,
            Dependencies = {},
            BoxHolder = af,
            Holder = ag,
            Container = ag,
            Tab = ae,
            Elements = {},
            DependencyBoxes = {},
        }

        function ai.Resize(aj)
            ag.Size = UDim2.new(1, 0, 0, (ah.AbsoluteContentSize.Y / x.DPIScale) + 18)
        end
        function ai.Update(aj, ak)
            for al, am in ai.Dependencies do
                local an, ao = am[1], am[2]

                if an.Type == 'Toggle' and an.Value ~= ao then
                    ag.Visible = false
                    ai.Visible = false

                    return
                elseif an.Type == 'Dropdown' then
                    if typeof(an.Value) == 'table' then
                        if not an.Value[ao] then
                            ag.Visible = false
                            ai.Visible = false

                            return
                        end
                    else
                        if an.Value ~= ao then
                            ag.Visible = false
                            ai.Visible = false

                            return
                        end
                    end
                end
            end

            ai.Visible = true

            if not x.Searching then
                ag.Visible = true

                ai:Resize()
            elseif not ak then
                x:UpdateSearch(x.SearchText)
            end
        end
        function ai.SetupDependencies(aj, ak)
            for al, am in ak do
                assert(typeof(am) == 'table', 'Dependency should be a table.')
                assert(am[1] ~= nil, 'Dependency is missing element.')
                assert(am[2] ~= nil, 'Dependency is missing expected value.')
            end

            ai.Dependencies = ak

            ai:Update()
        end

        setmetatable(ai, aa)
        table.insert(ae.DependencyGroupboxes, ai)
        table.insert(x.DependencyBoxes, ai)

        return ai
    end

    aa.__index = ab
    aa.__namecall = function(ac, ad, ...)
        return ab[ad](...)
    end
end

function x.SetFont(ab, ac)
    if typeof(ac) == 'EnumItem' then
        ac = Font.fromEnum(ac)
    end

    x.Scheme.Font = ac

    x:UpdateColorsUsingRegistry()
end
function x.SetNotifySide(ab, ac)
    x.NotifySide = ac

    if ac:lower() == 'left' then
        I.AnchorPoint = Vector2.new(0, 0)
        I.Position = UDim2.fromOffset(6, 6)
        J.HorizontalAlignment = Enum.HorizontalAlignment.Left
    else
        I.AnchorPoint = Vector2.new(1, 0)
        I.Position = UDim2.new(1, -6, 0, 6)
        J.HorizontalAlignment = Enum.HorizontalAlignment.Right
    end
end
function x.Notify(ab, ...)
    local ac, ad = {}, select(1, ...)

    if typeof(ad) == 'table' then
        ac.Title = tostring(ad.Title)
        ac.Description = tostring(ad.Description)
        ac.Time = ad.Time or 5
        ac.SoundId = ad.SoundId
        ac.Steps = ad.Steps
        ac.Persist = ad.Persist
        ac.Icon = ad.Icon
        ac.BigIcon = ad.BigIcon
        ac.IconColor = ad.IconColor
    else
        ac.Description = tostring(ad)
        ac.Time = select(2, ...) or 5
        ac.SoundId = select(3, ...)
    end

    ac.Destroyed = false

    local ae, af = false

    if typeof(ac.Time) == 'Instance' then
        af = ac.Time.Destroying:Connect(function()
            ae = true

            af:Disconnect()

            af = nil
        end)
    end

    local ag = New('Frame', {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 0),
        Visible = false,
        Parent = I,
    })
    local ah = New('Frame', {
        AutomaticSize = Enum.AutomaticSize.Y,
        BackgroundColor3 = 'MainColor',
        Position = x.NotifySide:lower() == 'left' and UDim2.new(-1, -8, 0, -2) or UDim2.new(1, 8, 0, -2),
        Size = UDim2.fromScale(1, 1),
        ZIndex = 5,
        Parent = ag,
    })

    New('UICorner', {
        CornerRadius = UDim.new(0, 4),
        Parent = ah,
    })
    New('UIListLayout', {
        Padding = UDim.new(0, 4),
        Parent = ah,
    })
    New('UIPadding', {
        PaddingBottom = UDim.new(0, 8),
        PaddingLeft = UDim.new(0, 8),
        PaddingRight = UDim.new(0, 8),
        PaddingTop = UDim.new(0, 8),
        Parent = ah,
    })
    x:AddOutline(ah)

    local ai = New('Frame', {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY,
        Size = UDim2.fromScale(1, 0),
        Parent = ah,
    })

    if ac.BigIcon then
        New('UIListLayout', {
            Padding = UDim.new(0, 8),
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Parent = ai,
        })
    end

    local aj

    if ac.BigIcon then
        local ak = x:GetCustomIcon(ac.BigIcon)

        if ak then
            aj = New('ImageLabel', {
                BackgroundTransparency = 1,
                Size = UDim2.fromOffset(24, 24),
                Image = ak.Url,
                ImageColor3 = ac.IconColor or 'AccentColor',
                ImageRectOffset = ak.ImageRectOffset,
                ImageRectSize = ak.ImageRectSize,
                Parent = ai,
            })
        end
    end

    local ak = New('Frame', {
        BackgroundTransparency = 1,
        AutomaticSize = Enum.AutomaticSize.XY,
        Size = UDim2.fromScale(0, 0),
        Parent = ai,
    })

    New('UIListLayout', {
        Padding = UDim.new(0, 4),
        Parent = ak,
    })

    local al

    if ac.Title then
        al = New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(0, 0),
            Parent = ak,
        })
    end

    local am

    if ac.Icon and al then
        local an = x:GetCustomIcon(ac.Icon)

        if an then
            am = New('ImageLabel', {
                BackgroundTransparency = 1,
                AnchorPoint = Vector2.new(0, 0.5),
                Position = UDim2.new(0, 0, 0.5, 1),
                Size = UDim2.fromOffset(15, 15),
                Image = an.Url,
                ImageColor3 = 'AccentColor',
                ImageRectOffset = an.ImageRectOffset,
                ImageRectSize = an.ImageRectSize,
                Parent = al,
            })
        end
    end

    local an, ao, ap, aq, ar = 0, 0

    if ac.Title then
        ap = New('TextLabel', {
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundTransparency = 1,
            AnchorPoint = Vector2.new(0, 0.5),
            Position = UDim2.new(0, (ac.Icon and 21 or 0), 0.5, 0),
            Size = UDim2.fromScale(0, 0),
            Text = ac.Title,
            TextColor3 = 'AccentColor',
            TextSize = 15,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextYAlignment = Enum.TextYAlignment.Center,
            TextWrapped = true,
            Parent = al,
        })
    end
    if ac.Description then
        aq = New('TextLabel', {
            AutomaticSize = Enum.AutomaticSize.None,
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(0, 0),
            Text = ac.Description,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            Parent = ak,
        })
    end

    function ac.Resize(as)
        local at, au = aj and 32 or 0, am and 21 or 0

        if ap then
            local av, aw = x:GetTextBounds(ap.Text, ap.FontFace, ap.TextSize, (I.AbsoluteSize.X / x.DPIScale) - 24 - at - au)

            ap.Size = UDim2.fromOffset(av, aw)
            an = av + au
            al.Size = UDim2.fromOffset(an, math.max(aw, am and 16 or 0))
        end
        if aq then
            local av, aw = x:GetTextBounds(aq.Text, aq.FontFace, aq.TextSize, (I.AbsoluteSize.X / x.DPIScale) - 24 - at)

            aq.Size = UDim2.fromOffset(av, aw)
            ao = av
        end

        ag.Size = UDim2.fromOffset(math.max(an, ao) + 24 + at, 0)
    end
    function ac.ChangeTitle(as, at)
        if ap then
            ac.Title = tostring(at)
            ap.Text = ac.Title

            ac:Resize()
        end
    end
    function ac.ChangeDescription(as, at)
        if aq then
            ac.Description = tostring(at)
            aq.Text = ac.Description

            ac:Resize()
        end
    end
    function ac.ChangeStep(as, at)
        if ar and ac.Steps then
            at = math.clamp(at or 0, 0, ac.Steps)
            ar.Size = UDim2.fromScale(at / ac.Steps, 1)
        end
    end
    function ac.Destroy(as)
        ac.Destroyed = true

        if typeof(ac.Time) == 'Instance' then
            pcall(ac.Time.Destroy, ac.Time)
        end
        if af then
            af:Disconnect()
        end

        i:Create(ah, x.NotifyTweenInfo, {
            Position = x.NotifySide:lower() == 'left' and UDim2.new(-1, -8, 0, -2) or UDim2.new(1, 8, 0, -2),
        }):Play()
        task.delay(x.NotifyTweenInfo.Time, function()
            x.Notifications[ag] = nil

            ag:Destroy()
        end)
    end

    ac:Resize()

    local as = New('Frame', {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 7),
        Visible = (ac.Persist ~= true and typeof(ac.Time) ~= 'Instance') or typeof(ac.Steps) == 'number',
        Parent = ah,
    })
    local at = New('Frame', {
        BackgroundColor3 = 'BackgroundColor',
        BorderColor3 = 'OutlineColor',
        BorderSizePixel = 1,
        Position = UDim2.fromOffset(0, 3),
        Size = UDim2.new(1, 0, 0, 2),
        Parent = as,
    })

    ar = New('Frame', {
        BackgroundColor3 = 'AccentColor',
        Size = UDim2.fromScale(1, 1),
        Parent = at,
    })

    if typeof(ac.Time) == 'Instance' then
        ar.Size = UDim2.fromScale(0, 1)
    end
    if ac.SoundId then
        local au = ac.SoundId

        if typeof(au) == 'number' then
            au = string.format('rbxassetid://%d', au)
        end

        New('Sound', {
            SoundId = au,
            Volume = 3,
            PlayOnRemove = true,
            Parent = e,
        }):Destroy()
    end

    x.Notifications[ag] = ac
    ag.Visible = true

    i:Create(ah, x.NotifyTweenInfo, {
        Position = UDim2.fromOffset(0, 0),
    }):Play()
    task.delay(x.NotifyTweenInfo.Time, function()
        if ac.Persist then
            return
        elseif typeof(ac.Time) == 'Instance' then
            repeat
                task.wait()
            until ae or ac.Destroyed
        else
            i:Create(ar, TweenInfo.new(ac.Time, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {
                Size = UDim2.fromScale(0, 1),
            }):Play()
            task.wait(ac.Time)
        end
        if not ac.Destroyed then
            ac:Destroy()
        end
    end)

    return ac
end
function x.SetBackgroundImageEnabled(ab, ac)
    assert(typeof(ac) == 'boolean', 'Expected boolean for State, got: ' .. typeof(ac))

    ab.Scheme.BackgroundImageEnabled = ac
    ab.Window.BackgroundImage.Visible = ac

    ab:UpdateColorsUsingRegistry()
end
function x.SetBackgroundImage(ab, ac)
    assert(typeof(ac) == 'string' or typeof(ac) == 'number', 'Expected string/number for Image, got: ' .. typeof(ac))

    ab.Scheme.BackgroundImage = x:GetCustomImage(ac).Url
    ab.Window.BackgroundImage.Image = x:GetCustomImage(ac).Url

    ab:UpdateColorsUsingRegistry()
end
function x.SetGlow(ab, ac)
    assert(typeof(ac) == 'boolean', 'Expected boolean for State, got: ' .. typeof(ac))

    ab.Scheme.WindowGlow = ac

    ab:UpdateColorsUsingRegistry()
end
function x.CreateWindow(ab, ac)
    ac = x:Validate(ac, y.Window)

    local ad = workspace.CurrentCamera.ViewportSize

    if d:IsStudio() and ad.X <= 5 and ad.Y <= 5 then
        repeat
            ad = workspace.CurrentCamera.ViewportSize

            task.wait()
        until ad.X > 5 and ad.Y > 5
    end

    local ae, af = ad.X - 64, ad.Y - 64

    x.OriginalMinSize = Vector2.new(math.min(x.OriginalMinSize.X, ae), math.min(x.OriginalMinSize.Y, af))
    x.MinSize = x.OriginalMinSize
    ac.Size = UDim2.fromOffset(math.clamp(ac.Size.X.Offset, x.MinSize.X, ae), math.clamp(ac.Size.Y.Offset, x.MinSize.Y, af))

    if typeof(ac.Font) == 'EnumItem' then
        ac.Font = Font.fromEnum(ac.Font)
    end

    ac.CornerRadius = math.min(ac.CornerRadius, 20)

    if ac.Compact ~= nil then
        ac.SidebarCompacted = ac.Compact
    end
    if ac.SidebarMinWidth ~= nil then
        ac.MinSidebarWidth = ac.SidebarMinWidth
    end

    ac.MinSidebarWidth = math.max(64, ac.MinSidebarWidth)
    ac.SidebarCompactWidth = math.max(48, ac.SidebarCompactWidth)
    ac.SidebarCollapseThreshold = math.clamp(ac.SidebarCollapseThreshold, 0.1, 0.9)
    ac.CompactWidthActivation = math.max(48, ac.CompactWidthActivation)
    x.CornerRadius = ac.CornerRadius

    x:SetNotifySide(ac.NotifySide)

    x.Scheme.BackgroundImageEnabled = ac.BackgroundImage and true or false
    x.Scheme.BackgroundImage = ac.BackgroundImage
    x.Scheme.WindowGlow = ac.Glow
    x.Scheme.Font = ac.Font
    x.ToggleKeybind = ac.ToggleKeybind
    x.GlobalSearch = ac.GlobalSearch

    local ag, ah, ai, aj, ak, al, am, an, ao, ap, aq, ar, as, at, au, av, aw, ax, ay = ac.SearchbarSize == UDim2.fromScale(1, 1), math.ceil(ac.Size.X.Offset * 0.3), (ac.SidebarCompacted)
    local az = ah

    do
        x.KeybindFrame, x.KeybindContainer = x:AddDraggableMenu'Keybinds'
        x.KeybindFrame.AnchorPoint = Vector2.new(0, 0.5)
        x.KeybindFrame.Position = UDim2.new(0, 6, 0.5, 0)
        x.KeybindFrame.Visible = false
        aj = New('TextButton', {
            BackgroundColor3 = function()
                return x:GetBetterColor(x.Scheme.BackgroundColor, -1)
            end,
            Name = 'Main',
            Text = '',
            Position = ac.Position,
            Size = ac.Size,
            Visible = false,
            Parent = G,
        })

        table.insert(x.Corners, New('UICorner', {
            CornerRadius = UDim.new(0, ac.CornerRadius),
            Parent = aj,
        }))
        table.insert(x.Scales, New('UIScale', {Parent = aj}))
        x:AddOutline(aj)
        x:MakeLine(aj, {
            Position = UDim2.fromOffset(0, 48),
            Size = UDim2.new(1, 0, 0, 1),
        })

        ak = New('Frame', {
            BackgroundColor3 = 'OutlineColor',
            Position = UDim2.fromOffset(ah, 0),
            Size = UDim2.new(0, 1, 1, -21),
            Parent = aj,
        })
        aw = New('ImageLabel', {
            Image = ac.BackgroundImage,
            Position = UDim2.fromScale(0, 0),
            Size = UDim2.fromScale(1, 1),
            ScaleType = Enum.ScaleType.Stretch,
            ZIndex = 999,
            BackgroundTransparency = 1,
            ImageTransparency = 0.75,
            Visible = ac.BackgroundImage and true or false,
            Parent = aj,
        })

        table.insert(x.Corners, New('UICorner', {
            CornerRadius = UDim.new(0, ac.CornerRadius),
            Parent = aw,
        }))

        if ac.Center then
            aj.Position = UDim2.new(0.5, -aj.Size.X.Offset / 2, 0.5, -aj.Size.Y.Offset / 2)
        end

        local aA = New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 48),
            Parent = aj,
        })

        x:MakeDraggable(aj, aA, false, true)

        al = New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, ah, 1, 0),
            Parent = aA,
        })

        New('UIListLayout', {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Center,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Padding = UDim.new(0, 6),
            Parent = al,
        })

        if ac.Icon then
            local aB = x:GetCustomIcon(ac.Icon)

            an = New('ImageLabel', {
                Image = aB.Url,
                ImageRectOffset = aB.ImageRectOffset,
                ImageRectSize = aB.ImageRectSize,
                Size = ac.IconSize,
                Parent = al,
            })
        else
            an = New('TextLabel', {
                BackgroundTransparency = 1,
                Size = ac.IconSize,
                Text = ac.Title:sub(1, 1),
                TextScaled = true,
                Visible = false,
                Parent = al,
            })
        end

        local aB = x:GetTextBounds(ac.Title, x.Scheme.Font, 20, al.AbsoluteSize.X - (ac.Icon and ac.IconSize.X.Offset + 6 or 0) - 12)

        am = New('TextLabel', {
            BackgroundTransparency = 1,
            Size = UDim2.new(0, aB, 1, 0),
            Text = ac.Title,
            TextSize = 20,
            Parent = al,
        })
        ao = New('Frame', {
            AnchorPoint = Vector2.new(1, 0.5),
            BackgroundTransparency = 1,
            Position = UDim2.new(1, -49, 0.5, 0),
            Size = UDim2.new(1, -ah - 57 - 1, 1, -16),
            Parent = aA,
        })

        New('UIListLayout', {
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Parent = ao,
        })

        aq = New('Frame', {
            Size = UDim2.fromScale(ac.DisableSearch and 1 or 0.65, 1),
            Visible = false,
            BackgroundTransparency = 1,
            Parent = ao,
        })

        New('UIListLayout', {
            FillDirection = Enum.FillDirection.Vertical,
            HorizontalAlignment = Enum.HorizontalAlignment.Left,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            Parent = aq,
        })
        New('UIPadding', {
            PaddingBottom = UDim.new(0, 8),
            PaddingLeft = UDim.new(0, 6),
            PaddingRight = UDim.new(0, 8),
            PaddingTop = UDim.new(0, 8),
            Parent = aq,
        })

        ar = New('TextLabel', {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Text = '',
            TextSize = 18,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = aq,
        })
        as = New('TextLabel', {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Text = '',
            TextWrapped = true,
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = aq,
        })
        ap = New('TextBox', {
            BackgroundColor3 = 'MainColor',
            Size = ac.SearchbarSize,
            PlaceholderText = 'Search..',
            TextSize = 14,
            TextXAlignment = Enum.TextXAlignment.Left,
            Visible = not (ac.DisableSearch or false),
            Parent = ao,
        })

        table.insert(x.Corners, New('UICorner', {
            CornerRadius = UDim.new(0, ac.CornerRadius),
            Parent = ap,
        }))
        New('UIPadding', {
            PaddingBottom = UDim.new(0, 8),
            PaddingLeft = UDim.new(0, 28),
            PaddingRight = UDim.new(0, 8),
            PaddingTop = UDim.new(0, 8),
            Parent = ap,
        })
        New('UIStroke', {
            Color = 'OutlineColor',
            Parent = ap,
        })

        local aC = x:GetIcon'search'

        if aC then
            New('ImageLabel', {
                Position = UDim2.fromOffset(-22, 0),
                Image = aC.Url,
                ImageColor3 = 'FontColor',
                ImageRectOffset = aC.ImageRectOffset,
                ImageRectSize = aC.ImageRectSize,
                ImageTransparency = 0.5,
                Size = UDim2.fromScale(1, 1),
                SizeConstraint = Enum.SizeConstraint.RelativeYY,
                Parent = ap,
            })
        end
        if R then
            New('ImageLabel', {
                AnchorPoint = Vector2.new(1, 0.5),
                Image = R.Url,
                ImageColor3 = 'OutlineColor',
                ImageRectOffset = R.ImageRectOffset,
                ImageRectSize = R.ImageRectSize,
                Position = UDim2.new(1, -10, 0.5, 0),
                Size = UDim2.fromOffset(28, 28),
                SizeConstraint = Enum.SizeConstraint.RelativeYY,
                Parent = aA,
            })
        end

        ax = New('Frame', {
            AnchorPoint = Vector2.new(0, 1),
            BackgroundColor3 = function()
                return x:GetBetterColor(x.Scheme.BackgroundColor, 4)
            end,
            Position = UDim2.fromScale(0, 1),
            Size = UDim2.new(1, 0, 0, 20 + ac.CornerRadius),
            Parent = aj,
        })

        x:MakeLine(aj, {
            AnchorPoint = Vector2.new(0, 1),
            Position = UDim2.new(0, 0, 1, -20),
            Size = UDim2.new(1, 0, 0, 1),
        })

        local U = New('Frame', {
            AnchorPoint = Vector2.new(0, 1),
            BackgroundTransparency = 1,
            Position = UDim2.fromScale(0, 1),
            Size = UDim2.new(1, 0, 0, 20),
            Parent = aj,
        })

        table.insert(x.Corners, New('UICorner', {
            CornerRadius = UDim.new(0, ac.CornerRadius),
            Parent = ax,
        }))

        ay = New('TextLabel', {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Text = ac.Footer,
            TextSize = 14,
            TextTransparency = 0.5,
            Parent = U,
        })

        if ac.Resizable then
            at = New('TextButton', {
                AnchorPoint = Vector2.new(1, 0),
                BackgroundTransparency = 1,
                Position = UDim2.new(1, -ac.CornerRadius / 4, 0, 0),
                Size = UDim2.fromScale(1, 1),
                SizeConstraint = Enum.SizeConstraint.RelativeYY,
                Text = '',
                Parent = U,
            })

            x:MakeResizable(aj, at, function()
                for V, W in x.Tabs do
                    W:Resize(true)
                end
            end)
        end

        New('ImageLabel', {
            Image = P and P.Url or '',
            ImageColor3 = 'FontColor',
            ImageRectOffset = P and P.ImageRectOffset or Vector2.zero,
            ImageRectSize = P and P.ImageRectSize or Vector2.zero,
            ImageTransparency = 0.5,
            Position = UDim2.fromOffset(2, 2),
            Size = UDim2.new(1, -4, 1, -4),
            Parent = at,
        })

        au = New('ScrollingFrame', {
            AutomaticCanvasSize = Enum.AutomaticSize.Y,
            BackgroundColor3 = 'BackgroundColor',
            CanvasSize = UDim2.fromScale(0, 0),
            Position = UDim2.fromOffset(0, 49),
            ScrollBarThickness = 0,
            Size = UDim2.new(0, ah, 1, -70),
            Parent = aj,
        })

        New('UIListLayout', {Parent = au})
        New('UIPadding', {
            PaddingBottom = UDim.new(0, 4),
            PaddingLeft = UDim.new(0, 4),
            PaddingRight = UDim.new(0, 4),
            PaddingTop = UDim.new(0, 4),
            Parent = au,
        })

        av = New('Frame', {
            AnchorPoint = Vector2.new(1, 0),
            BackgroundColor3 = function()
                return x:GetBetterColor(x.Scheme.BackgroundColor, 1)
            end,
            Name = 'Container',
            Position = UDim2.new(1, 0, 0, 49),
            Size = UDim2.new(1, -ah - 1, 1, -70),
            Parent = aj,
        })

        New('UIPadding', {
            PaddingBottom = UDim.new(0, 0),
            PaddingLeft = UDim.new(0, 6),
            PaddingRight = UDim.new(0, 6),
            PaddingTop = UDim.new(0, 0),
            Parent = av,
        })
    end

    local aA = {BackgroundImage = aw}

    function aA.ChangeTitle(aB, aC)
        assert(typeof(aC) == 'string', 'Expected string for Title, got: ' .. typeof(aC))

        am.Text = aC
        ac.Title = aC
    end
    function aA.SetBackgroundImageEnabled(aB, aC)
        return x:SetBackgroundImageEnabled(aC)
    end
    function aA.SetBackgroundImage(aB, aC)
        return x:SetBackgroundImage(aC)
    end
    function aA.SetGlow(aB, aC)
        return x:SetGlow(aC)
    end
    function aA.SetFooter(aB, aC)
        assert(typeof(aC) == 'string', 'Expected string for Footer, got: ' .. typeof(aC))

        ay.Text = aC
        ac.Footer = aC
    end
    function aA.SetCornerRadius(aB, aC)
        assert(typeof(aC) == 'number', 'Expected number for Radius, got: ' .. typeof(aC))

        aC = math.min(aC, 20)

        for U, V in x.Corners do
            if V.CornerRadius.Offset == x.CornerRadius / 2 then
                V.CornerRadius = UDim.new(0, aC / 2)
            else
                V.CornerRadius = UDim.new(0, aC)
            end
        end

        x.CornerRadius = aC
        ac.CornerRadius = aC
        at.Position = UDim2.new(1, -aC / 4, 0, 0)
        ax.Size = UDim2.new(1, 0, 0, 20 + aC)

        for U, V in x.Tabs do
            if V.IsKeyTab then
                continue
            end

            for W, X in V.Tabboxes do
                X:UpdateCorners()
            end
        end
    end

    local function ApplyCompact()
        ai = aA:GetSidebarWidth() == ac.SidebarCompactWidth

        if ac.DisableCompactingSnap then
            ai = aA:GetSidebarWidth() <= ac.CompactWidthActivation
        end

        am.Visible = not ai

        if not ac.Icon then
            an.Visible = ai
        end

        for aB, aC in x.TabButtons do
            if not aC.Icon then
                continue
            end

            aC.Label.Visible = not ai
            aC.Padding.PaddingBottom = UDim.new(0, ai and 8 or 10)
            aC.Padding.PaddingLeft = UDim.new(0, ai and 8 or 10)
            aC.Padding.PaddingRight = UDim.new(0, ai and 8 or 10)
            aC.Padding.PaddingTop = UDim.new(0, ai and 8 or 10)
            aC.Icon.SizeConstraint = ai and Enum.SizeConstraint.RelativeXY or Enum.SizeConstraint.RelativeYY
        end
    end

    function aA.IsSidebarCompacted(aB)
        return ai
    end
    function aA.SetCompact(aB, aC)
        aA:SetSidebarWidth(aC and ac.SidebarCompactWidth or az)
    end
    function aA.GetSidebarWidth(aB)
        return au.Size.X.Offset
    end
    function aA.SetSidebarWidth(aB, aC)
        aC = math.clamp(aC, 48, aj.Size.X.Offset - ac.MinContainerWidth - 1)
        ak.Position = UDim2.fromOffset(aC, 0)
        al.Size = UDim2.new(0, aC, 1, 0)
        ao.Size = UDim2.new(1, -aC - 57 - 1, 1, -16)
        au.Size = UDim2.new(0, aC, 1, -70)
        av.Size = UDim2.new(1, -aC - 1, 1, -70)

        if ac.EnableCompacting then
            ApplyCompact()
        end
        if not ai then
            az = aC
        end
    end
    function aA.ShowTabInfo(aB, aC, U)
        ar.Text = `<b>{aC or 'Name'}</b>`
        as.Text = U or 'Description'

        if ag then
            ap.Size = UDim2.fromScale(0.35, 1)
        end

        aq.Visible = true
    end
    function aA.HideTabInfo(aB)
        aq.Visible = false

        if ag then
            ap.Size = UDim2.fromScale(1, 1)
        end
    end
    function aA.AddTab(aB, ...)
        local aC, U, V

        if select('#', ...) == 1 and typeof(...) == 'table' then
            local W = select(1, ...)

            aC = W.Name or 'Tab'
            U = W.Icon
            V = W.Description or 'No Description'
        else
            aC = select(1, ...) or 'Tab'
            U = select(2, ...)
            V = select(3, ...) or 'No Description'
        end

        U = U or 'file-question-mark'

        local W, X, Y, Z, _, aD, aE

        U = if U == 'file-question-mark'then S else x:GetCustomIcon(U)

        do
            W = New('TextButton', {
                BackgroundColor3 = 'AccentColor',
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 40),
                Text = '',
                Parent = au,
            })

            local aF = New('UIPadding', {
                PaddingBottom = UDim.new(0, ai and 8 or 10),
                PaddingLeft = UDim.new(0, ai and 8 or 10),
                PaddingRight = UDim.new(0, ai and 8 or 10),
                PaddingTop = UDim.new(0, ai and 8 or 10),
                Parent = W,
            })

            New('UICorner', {
                CornerRadius = UDim.new(0, 4),
                Parent = W,
            })

            X = New('TextLabel', {
                BackgroundTransparency = 1,
                Position = UDim2.fromOffset(30, 0),
                Size = UDim2.new(1, -30, 1, 0),
                Text = aC,
                TextSize = 16,
                TextTransparency = 0.5,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = not ai,
                Parent = W,
            })
            Y = New('Frame', {
                BackgroundColor3 = 'AccentColor',
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.fromOffset(-11, 0),
                Size = UDim2.new(0, 2, 1, 0),
                Parent = W,
            })

            New('UICorner', {
                CornerRadius = UDim.new(1, 0),
                Parent = Y,
            })

            if U then
                Z = New('ImageLabel', {
                    Image = U.Url,
                    ImageColor3 = (U.Custom and not U.Tint) and 'WhiteColor' or 'AccentColor',
                    ImageRectOffset = U.ImageRectOffset,
                    ImageRectSize = U.ImageRectSize,
                    ImageTransparency = 0.5,
                    ScaleType = Enum.ScaleType.Fit,
                    Size = UDim2.fromScale(1, 1),
                    SizeConstraint = ai and Enum.SizeConstraint.RelativeXY or Enum.SizeConstraint.RelativeYY,
                    Parent = W,
                })
            end

            table.insert(x.TabButtons, {
                Label = X,
                Padding = aF,
                Icon = Z,
            })

            _ = New('Frame', {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                Visible = false,
                Parent = av,
            })
            aD = New('ScrollingFrame', {
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                CanvasSize = UDim2.fromScale(0, 0),
                ScrollBarImageTransparency = 1,
                ScrollBarThickness = 0,
                Size = UDim2.new(0.5, -3, 1, 0),
                Parent = _,
            })

            New('UIListLayout', {
                Padding = UDim.new(0, 2),
                Parent = aD,
            })
            New('UIPadding', {
                PaddingBottom = UDim.new(0, 2),
                PaddingLeft = UDim.new(0, 2),
                PaddingRight = UDim.new(0, 2),
                PaddingTop = UDim.new(0, 2),
                Parent = aD,
            })

            do
                New('Frame', {
                    BackgroundTransparency = 1,
                    LayoutOrder = -1,
                    Parent = aD,
                })
                New('Frame', {
                    BackgroundTransparency = 1,
                    LayoutOrder = 1,
                    Parent = aD,
                })
            end

            aE = New('ScrollingFrame', {
                AnchorPoint = Vector2.new(1, 0),
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                CanvasSize = UDim2.fromScale(0, 0),
                Position = UDim2.fromScale(1, 0),
                ScrollBarImageTransparency = 1,
                ScrollBarThickness = 0,
                Size = UDim2.new(0.5, -3, 1, 0),
                Parent = _,
            })

            New('UIListLayout', {
                Padding = UDim.new(0, 2),
                Parent = aE,
            })
            New('UIPadding', {
                PaddingBottom = UDim.new(0, 2),
                PaddingLeft = UDim.new(0, 2),
                PaddingRight = UDim.new(0, 2),
                PaddingTop = UDim.new(0, 2),
                Parent = aE,
            })

            do
                New('Frame', {
                    BackgroundTransparency = 1,
                    LayoutOrder = -1,
                    Parent = aE,
                })
                New('Frame', {
                    BackgroundTransparency = 1,
                    LayoutOrder = 1,
                    Parent = aE,
                })
            end
        end

        local aF, aG, aH, aI, aJ, aK, aL, aM = (New('Frame', {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(0, 7),
            Size = UDim2.fromScale(1, 0),
            Visible = false,
            Parent = _,
        }))

        do
            aG = New('Frame', {
                BackgroundColor3 = 'BackgroundColor',
                Position = UDim2.fromOffset(2, 0),
                Size = UDim2.new(1, -5, 0, 0),
                Parent = aF,
            })

            table.insert(x.Corners, New('UICorner', {
                CornerRadius = UDim.new(0, ac.CornerRadius),
                Parent = aG,
            }))

            aH, aI = x:AddOutline(aG)
            aJ = New('ScrollingFrame', {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.fromScale(1, 1),
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ScrollBarThickness = 3,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                Parent = aG,
            })

            New('UIPadding', {
                PaddingBottom = UDim.new(0, 4),
                PaddingLeft = UDim.new(0, 6),
                PaddingRight = UDim.new(0, 6),
                PaddingTop = UDim.new(0, 4),
                Parent = aJ,
            })

            aK = New('TextLabel', {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -4, 0, 14),
                Text = '',
                TextColor3 = Color3.fromRGB(255, 50, 50),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = aJ,
            })
            aL = New('UIStroke', {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
                Color = Color3.fromRGB(169, 0, 0),
                LineJoinMode = Enum.LineJoinMode.Miter,
                Parent = aK,
            })
            aM = New('TextLabel', {
                BackgroundTransparency = 1,
                Position = UDim2.fromOffset(0, 16),
                Size = UDim2.new(1, -4, 0, 0),
                Text = '',
                TextSize = 14,
                TextWrapped = true,
                Parent = aJ,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
            })

            New('UIStroke', {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
                Color = 'DarkColor',
                LineJoinMode = Enum.LineJoinMode.Miter,
                Parent = aM,
            })
        end

        local aN = {
            Groupboxes = {},
            Tabboxes = {},
            DependencyGroupboxes = {},
            Description = V,
            Sides = {aD, aE},
            WarningBox = {
                IsNormal = false,
                LockSize = false,
                Visible = false,
                Title = 'WARNING',
                Text = '',
            },
        }

        function aN.UpdateWarningBox(aO, aP)
            if typeof(aP.IsNormal) == 'boolean' then
                aN.WarningBox.IsNormal = aP.IsNormal
            end
            if typeof(aP.LockSize) == 'boolean' then
                aN.WarningBox.LockSize = aP.LockSize
            end
            if typeof(aP.Visible) == 'boolean' then
                aN.WarningBox.Visible = aP.Visible
            end
            if typeof(aP.Title) == 'string' then
                aN.WarningBox.Title = aP.Title
            end
            if typeof(aP.Text) == 'string' then
                aN.WarningBox.Text = aP.Text
            end

            aF.Visible = aN.WarningBox.Visible
            aK.Text = aN.WarningBox.Title
            aM.Text = aN.WarningBox.Text

            aN:Resize(true)

            aG.BackgroundColor3 = aN.WarningBox.IsNormal == true and x.Scheme.BackgroundColor or Color3.fromRGB(127, 0, 0)
            aI.Color = aN.WarningBox.IsNormal == true and x.Scheme.DarkColor or Color3.fromRGB(85, 0, 0)
            aH.Color = aN.WarningBox.IsNormal == true and x.Scheme.OutlineColor or Color3.fromRGB(255, 50, 50)
            aK.TextColor3 = aN.WarningBox.IsNormal == true and x.Scheme.FontColor or Color3.fromRGB(255, 50, 50)
            aL.Color = aN.WarningBox.IsNormal == true and x.Scheme.OutlineColor or Color3.fromRGB(169, 0, 0)

            if not x.Registry[aG] then
                x:AddToRegistry(aG, {})
            end
            if not x.Registry[aI] then
                x:AddToRegistry(aI, {})
            end
            if not x.Registry[aH] then
                x:AddToRegistry(aH, {})
            end
            if not x.Registry[aK] then
                x:AddToRegistry(aK, {})
            end
            if not x.Registry[aL] then
                x:AddToRegistry(aL, {})
            end

            x.Registry[aG].BackgroundColor3 = function()
                return aN.WarningBox.IsNormal == true and x.Scheme.BackgroundColor or Color3.fromRGB(127, 0, 0)
            end
            x.Registry[aI].Color = function()
                return aN.WarningBox.IsNormal == true and x.Scheme.DarkColor or Color3.fromRGB(85, 0, 0)
            end
            x.Registry[aH].Color = function()
                return aN.WarningBox.IsNormal == true and x.Scheme.OutlineColor or Color3.fromRGB(255, 50, 50)
            end
            x.Registry[aK].TextColor3 = function()
                return aN.WarningBox.IsNormal == true and x.Scheme.FontColor or Color3.fromRGB(255, 50, 50)
            end
            x.Registry[aL].Color = function()
                return aN.WarningBox.IsNormal == true and x.Scheme.OutlineColor or Color3.fromRGB(169, 0, 0)
            end
        end
        function aN.RefreshSides(aO)
            local aP = aF.Visible and aG.Size.Y.Offset + 8 or 0

            for aQ, aR in aN.Sides do
                aR.Position = UDim2.new(aR.Position.X.Scale, 0, 0, aP)
                aR.Size = UDim2.new(0.5, -3, 1, -aP)
            end
        end
        function aN.Resize(aO, aP)
            if aP then
                local aQ, aR, aS = math.floor(_.AbsoluteSize.Y / 3.25), x:GetTextBounds(aM.Text, x.Scheme.Font, aM.TextSize, aM.AbsoluteSize.X)
                local aT = 24 + aS

                if aN.WarningBox.LockSize == true and aT >= aQ then
                    aJ.CanvasSize = UDim2.fromOffset(0, aT)
                    aT = aQ
                else
                    aJ.CanvasSize = UDim2.fromOffset(0, 0)
                end

                aM.Size = UDim2.new(1, -4, 0, aS)
                aG.Size = UDim2.new(1, -5, 0, aT + 4)
            end

            aN:RefreshSides()
        end
        function aN.AddGroupbox(aO, aP)
            local aQ = New('Frame', {
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 0),
                Parent = aP.Side == 1 and aD or aE,
            })

            New('UIListLayout', {
                Padding = UDim.new(0, 6),
                Parent = aQ,
            })
            New('UIPadding', {
                PaddingBottom = UDim.new(0, 4),
                PaddingTop = UDim.new(0, 4),
                Parent = aQ,
            })

            local aR, aS, aT, aU, aV, aW, aX

            do
                aR = New('Frame', {
                    BackgroundColor3 = 'BackgroundColor',
                    Size = UDim2.fromScale(1, 0),
                    Parent = aQ,
                })

                table.insert(x.Corners, New('UICorner', {
                    CornerRadius = UDim.new(0, ac.CornerRadius),
                    Parent = aR,
                }))
                x:AddOutline(aR)

                aS = x:MakeLine(aR, {
                    Position = UDim2.fromOffset(0, 34),
                    Size = UDim2.new(1, 0, 0, 1),
                })

                local aY = x:GetCustomIcon(aP.IconName)

                if aY then
                    New('ImageLabel', {
                        Image = aY.Url,
                        ImageColor3 = aY.Custom and 'WhiteColor' or 'AccentColor',
                        ImageRectOffset = aY.ImageRectOffset,
                        ImageRectSize = aY.ImageRectSize,
                        Position = UDim2.fromOffset(6, 6),
                        Size = UDim2.fromOffset(22, 22),
                        Parent = aR,
                    })
                end

                aT = New('TextLabel', {
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(aY and 24 or 0, 0),
                    Size = UDim2.new(1, 0, 0, 34),
                    Text = aP.Name,
                    TextSize = 15,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = aR,
                })

                New('UIPadding', {
                    PaddingLeft = UDim.new(0, 12),
                    PaddingRight = UDim.new(0, 12),
                    Parent = aT,
                })

                aX = New('TextButton', {
                    AnchorPoint = Vector2.new(1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -8, 0, 8),
                    Size = UDim2.fromOffset(20, 20),
                    Text = '',
                    ZIndex = 5,
                    Parent = aR,
                })
                aW = New('ImageButton', {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    Image = O and O.Url or '',
                    ImageColor3 = 'WhiteColor',
                    ImageRectOffset = O and O.ImageRectOffset or Vector2.zero,
                    ImageRectSize = O and O.ImageRectSize or Vector2.zero,
                    Rotation = 180,
                    ZIndex = 4,
                    Parent = aX,
                })
                aU = New('Frame', {
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(0, 35),
                    Size = UDim2.new(1, 0, 1, -35),
                    Parent = aR,
                })
                aV = New('UIListLayout', {
                    Padding = UDim.new(0, 8),
                    Parent = aU,
                })

                New('UIPadding', {
                    PaddingBottom = UDim.new(0, 7),
                    PaddingLeft = UDim.new(0, 7),
                    PaddingRight = UDim.new(0, 7),
                    PaddingTop = UDim.new(0, 7),
                    Parent = aU,
                })
            end

            local aY = {
                BoxHolder = aQ,
                Holder = aR,
                Container = aU,
                Tab = aN,
                DependencyBoxes = {},
                Elements = {},
                Collapsed = false,
            }

            function aY.Resize(aZ)
                local a_

                if aZ.Collapsed then
                    a_ = UDim2.new(1, 0, 0, 34)
                else
                    a_ = UDim2.new(1, 0, 0, (aV.AbsoluteContentSize.Y / x.DPIScale) + 49)
                end

                aS.Visible = not aZ.Collapsed
                aR.Size = a_
            end
            function aY.SetCollapsed(aZ, a_)
                aZ.Collapsed = a_
                aU.Visible = not a_
                aW.Rotation = a_ and 0 or 180

                aZ:Resize()
            end
            function aY.Toggle(aZ)
                aZ:SetCollapsed(not aZ.Collapsed)
            end

            aX.MouseButton1Click:Connect(function()
                aY:Toggle()
            end)
            setmetatable(aY, aa)
            aY:Resize()

            aN.Groupboxes[aP.Name] = aY

            return aY
        end
        function aN.AddLeftGroupbox(aO, aP, aQ)
            return aN:AddGroupbox{
                Side = 1,
                Name = aP,
                IconName = aQ,
            }
        end
        function aN.AddRightGroupbox(aO, aP, aQ)
            return aN:AddGroupbox{
                Side = 2,
                Name = aP,
                IconName = aQ,
            }
        end
        function aN.AddTabbox(aO, aP)
            local aQ = New('Frame', {
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 0),
                Parent = aP.Side == 1 and aD or aE,
            })

            New('UIListLayout', {
                Padding = UDim.new(0, 6),
                Parent = aQ,
            })
            New('UIPadding', {
                PaddingBottom = UDim.new(0, 4),
                PaddingTop = UDim.new(0, 4),
                Parent = aQ,
            })

            local aR, aS

            do
                aR = New('Frame', {
                    BackgroundColor3 = 'BackgroundColor',
                    Size = UDim2.fromScale(1, 0),
                    Parent = aQ,
                })

                table.insert(x.Corners, New('UICorner', {
                    CornerRadius = UDim.new(0, ac.CornerRadius),
                    Parent = aR,
                }))
                x:AddOutline(aR)

                aS = New('Frame', {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 34),
                    Parent = aR,
                })

                New('UIListLayout', {
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    Parent = aS,
                })
            end

            local aT, aU, aV = 0, 1, {
                ActiveTab = nil,
                BoxHolder = aQ,
                Holder = aR,
                Tabs = {},
            }

            function aV.UpdateCorners(aW)
                for aX, aY in aV.Tabs do
                    aY:UpdateCorners()
                end
            end
            function aV.AddTab(aW, aX, aY)
                local aZ = aU

                aT = aT + 1
                aU = aU + 1

                local a_, a0 = x:GetCustomIcon(aY), New('TextButton', {
                    BackgroundColor3 = 'MainColor',
                    BackgroundTransparency = 0,
                    Size = UDim2.fromOffset(0, 34),
                    Text = '',
                    Parent = aS,
                })

                table.insert(x.Corners, New('UICorner', {
                    CornerRadius = UDim.new(0, ac.CornerRadius),
                    Parent = a0,
                }))

                local a1, a2, a3, a4 = New('Frame', {
                    BackgroundColor3 = 'MainColor',
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 1, -ac.CornerRadius),
                    Size = UDim2.new(1, 0, 0, ac.CornerRadius),
                    Parent = a0,
                }), New('Frame', {
                    BackgroundColor3 = 'MainColor',
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Size = UDim2.new(0, ac.CornerRadius, 1, 0),
                    Visible = false,
                    Parent = a0,
                }), New('Frame', {
                    AnchorPoint = Vector2.new(1, 0),
                    BackgroundColor3 = 'MainColor',
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, 0, 0, 0),
                    Size = UDim2.new(0, ac.CornerRadius, 1, 0),
                    Visible = false,
                    Parent = a0,
                }), New('Frame', {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundTransparency = 1,
                    Position = UDim2.fromScale(0.5, 0.5),
                    Size = UDim2.fromOffset(0, 16),
                    Parent = a0,
                })

                New('UIListLayout', {
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, 8),
                    Parent = a4,
                })

                local a5

                if a_ then
                    a5 = New('ImageLabel', {
                        Image = a_.Url,
                        ImageColor3 = 'WhiteColor',
                        ImageRectOffset = a_.ImageRectOffset,
                        ImageRectSize = a_.ImageRectSize,
                        ImageTransparency = 0.5,
                        Size = (aX and aX ~= '') and UDim2.fromOffset(18, 18) or UDim2.fromOffset(20, 20),
                        Parent = a4,
                    })
                end

                local a6

                if aX and aX ~= '' then
                    a6 = New('TextLabel', {
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundTransparency = 1,
                        Size = UDim2.fromOffset(0, 16),
                        Text = aX,
                        TextSize = 15,
                        TextTransparency = 0.5,
                        Parent = a4,
                    })
                end

                local a7, a8 = x:MakeLine(a0, {
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 0, 1, 1),
                    Size = UDim2.new(1, 0, 0, 1),
                }), New('Frame', {
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(0, 35),
                    Size = UDim2.new(1, 0, 1, -35),
                    Visible = false,
                    Parent = aR,
                })
                local a9 = New('UIListLayout', {
                    Padding = UDim.new(0, 8),
                    Parent = a8,
                })

                New('UIPadding', {
                    PaddingBottom = UDim.new(0, 7),
                    PaddingLeft = UDim.new(0, 7),
                    PaddingRight = UDim.new(0, 7),
                    PaddingTop = UDim.new(0, 7),
                    Parent = a8,
                })

                local ba = {
                    ButtonHolder = a0,
                    Container = a8,
                    ButtonCovers = {
                        BottomCover = a1,
                        LeftCover = a2,
                        RightCover = a3,
                    },
                    Tab = aN,
                    Elements = {},
                    DependencyBoxes = {},
                }

                function ba.Show(bb)
                    if aV.ActiveTab then
                        aV.ActiveTab:Hide()
                    end

                    a0.BackgroundTransparency = 1
                    a1.BackgroundTransparency = 1
                    a2.BackgroundTransparency = 1
                    a3.BackgroundTransparency = 1

                    if a6 then
                        a6.TextTransparency = 0
                    end
                    if a5 then
                        a5.ImageTransparency = 0
                    end

                    a7.Visible = false
                    a8.Visible = true
                    aV.ActiveTab = ba

                    ba:Resize()
                end
                function ba.Hide(bb)
                    a0.BackgroundTransparency = 0
                    a1.BackgroundTransparency = 0
                    a2.BackgroundTransparency = 0
                    a3.BackgroundTransparency = 0

                    if a6 then
                        a6.TextTransparency = 0.5
                    end
                    if a5 then
                        a5.ImageTransparency = 0.5
                    end

                    a7.Visible = true
                    a8.Visible = false
                    aV.ActiveTab = nil
                end
                function ba.Resize(bb)
                    if aV.ActiveTab ~= ba then
                        return
                    end

                    aR.Size = UDim2.new(1, 0, 0, (a9.AbsoluteContentSize.Y / x.DPIScale) + 49)
                end
                function ba.UpdateCorners(bb)
                    a2.Visible = aZ ~= 1
                    a3.Visible = aZ ~= aT
                    a1.Position = UDim2.new(0, 0, 1, -ac.CornerRadius)
                    a1.Size = UDim2.new(1, 0, 0, ac.CornerRadius)
                    a2.Size = UDim2.new(0, ac.CornerRadius, 1, 0)
                    a3.Size = UDim2.new(0, ac.CornerRadius, 1, 0)
                end

                if not aV.ActiveTab then
                    ba:Show()
                end

                a0.MouseButton1Click:Connect(ba.Show)
                setmetatable(ba, aa)

                aV.Tabs[aX] = ba

                aV:UpdateCorners()

                return ba
            end

            if aP.Name then
                aN.Tabboxes[aP.Name] = aV
            else
                table.insert(aN.Tabboxes, aV)
            end

            return aV
        end
        function aN.AddLeftTabbox(aO, aP)
            return aN:AddTabbox{
                Side = 1,
                Name = aP,
            }
        end
        function aN.AddRightTabbox(aO, aP)
            return aN:AddTabbox{
                Side = 2,
                Name = aP,
            }
        end
        function aN.Hover(aO, aP)
            if x.ActiveTab == aN then
                return
            end

            i:Create(X, x.TweenInfo, {
                TextTransparency = aP and 0.25 or 0.5,
            }):Play()

            if Z then
                i:Create(Z, x.TweenInfo, {
                    ImageTransparency = aP and 0.25 or 0.5,
                }):Play()
            end
        end
        function aN.Show(aO)
            if x.ActiveTab then
                x.ActiveTab:Hide()
            end

            i:Create(W, x.TweenInfo, {BackgroundTransparency = 0.85}):Play()
            i:Create(X, x.TweenInfo, {TextTransparency = 0}):Play()
            i:Create(Y, x.TweenInfo, {BackgroundTransparency = 0.4}):Play()

            if Z then
                i:Create(Z, x.TweenInfo, {ImageTransparency = 0}):Play()
            end

            aA:ShowTabInfo(aC, V)

            _.Visible = true

            aN:RefreshSides()

            x.ActiveTab = aN

            if x.Searching then
                x:UpdateSearch(x.SearchText)
            end
        end
        function aN.Hide(aO)
            i:Create(W, x.TweenInfo, {BackgroundTransparency = 1}):Play()
            i:Create(X, x.TweenInfo, {TextTransparency = 0.5}):Play()
            i:Create(Y, x.TweenInfo, {BackgroundTransparency = 1}):Play()

            if Z then
                i:Create(Z, x.TweenInfo, {ImageTransparency = 0.5}):Play()
            end

            _.Visible = false

            aA:HideTabInfo()

            x.ActiveTab = nil
        end
        function aN.SetVisible(aO, aP)
            W.Visible = aP

            if not aP and x.ActiveTab == aN then
                aN:Hide()
            end
        end

        if not x.ActiveTab then
            aN:Show()
        end

        W.MouseEnter:Connect(function()
            aN:Hover(true)

            if ai then
                x:AddTooltip(aC, '', W)
            end
        end)
        W.MouseLeave:Connect(function()
            aN:Hover(false)
        end)
        W.MouseButton1Click:Connect(aN.Show)

        x.Tabs[aC] = aN

        return aN
    end
    function aA.AddFullSizeTab(aB, ...)
        local aC, aD, aE

        if select('#', ...) == 1 and typeof(...) == 'table' then
            local aF = select(1, ...)

            aC = aF.Name or 'Tab'
            aD = aF.Icon
            aE = aF.Description or 'No Description'
        else
            aC = select(1, ...) or 'Tab'
            aD = select(2, ...)
            aE = select(3, ...) or 'No Description'
        end

        aD = aD or 'file-question-mark'

        local aF, aG, aH, aI, aJ

        aD = if aD == 'file-question-mark'then S else x:GetCustomIcon(aD)

        do
            aF = New('TextButton', {
                BackgroundColor3 = 'AccentColor',
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 40),
                Text = '',
                Parent = au,
            })

            local aK = New('UIPadding', {
                PaddingBottom = UDim.new(0, ai and 8 or 10),
                PaddingLeft = UDim.new(0, ai and 8 or 10),
                PaddingRight = UDim.new(0, ai and 8 or 10),
                PaddingTop = UDim.new(0, ai and 8 or 10),
                Parent = aF,
            })

            New('UICorner', {
                CornerRadius = UDim.new(0, 4),
                Parent = aF,
            })

            aG = New('TextLabel', {
                BackgroundTransparency = 1,
                Position = UDim2.fromOffset(30, 0),
                Size = UDim2.new(1, -30, 1, 0),
                Text = aC,
                TextSize = 16,
                TextTransparency = 0.5,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = not ai,
                Parent = aF,
            })
            aH = New('Frame', {
                BackgroundColor3 = 'AccentColor',
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Position = UDim2.fromOffset(-11, 0),
                Size = UDim2.new(0, 2, 1, 0),
                Parent = aF,
            })

            New('UICorner', {
                CornerRadius = UDim.new(1, 0),
                Parent = aH,
            })

            if aD then
                aI = New('ImageLabel', {
                    Image = aD.Url,
                    ImageColor3 = (aD.Custom and not aD.Tint) and 'WhiteColor' or 'AccentColor',
                    ImageRectOffset = aD.ImageRectOffset,
                    ImageRectSize = aD.ImageRectSize,
                    ImageTransparency = 0.5,
                    ScaleType = Enum.ScaleType.Fit,
                    Size = UDim2.fromScale(1, 1),
                    SizeConstraint = ai and Enum.SizeConstraint.RelativeXY or Enum.SizeConstraint.RelativeYY,
                    Parent = aF,
                })
            end

            table.insert(x.TabButtons, {
                Label = aG,
                Padding = aK,
                Icon = aI,
            })

            aJ = New('ScrollingFrame', {
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                CanvasSize = UDim2.fromScale(0, 0),
                ScrollBarImageTransparency = 1,
                ScrollBarThickness = 0,
                Size = UDim2.new(1, 0, 1, 0),
                Visible = false,
                Parent = av,
            })

            New('UIListLayout', {
                Padding = UDim.new(0, 2),
                Parent = aJ,
            })
            New('UIPadding', {
                PaddingBottom = UDim.new(0, 2),
                PaddingLeft = UDim.new(0, 2),
                PaddingRight = UDim.new(0, 2),
                PaddingTop = UDim.new(0, 2),
                Parent = aJ,
            })

            do
                New('Frame', {
                    BackgroundTransparency = 1,
                    LayoutOrder = -1,
                    Parent = aJ,
                })
                New('Frame', {
                    BackgroundTransparency = 1,
                    LayoutOrder = 1,
                    Parent = aJ,
                })
            end
        end

        local aK, aL, aM, aN, aO, aP, aQ, aR = (New('Frame', {
            AutomaticSize = Enum.AutomaticSize.Y,
            BackgroundTransparency = 1,
            Position = UDim2.fromOffset(0, 7),
            Size = UDim2.fromScale(1, 0),
            Visible = false,
            Parent = aJ,
        }))

        do
            aL = New('Frame', {
                BackgroundColor3 = 'BackgroundColor',
                Position = UDim2.fromOffset(2, 0),
                Size = UDim2.new(1, -5, 0, 0),
                Parent = aK,
            })

            table.insert(x.Corners, New('UICorner', {
                CornerRadius = UDim.new(0, ac.CornerRadius),
                Parent = aL,
            }))

            aM, aN = x:AddOutline(aL)
            aO = New('ScrollingFrame', {
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Size = UDim2.fromScale(1, 1),
                CanvasSize = UDim2.new(0, 0, 0, 0),
                ScrollBarThickness = 3,
                ScrollingDirection = Enum.ScrollingDirection.Y,
                Parent = aL,
            })

            New('UIPadding', {
                PaddingBottom = UDim.new(0, 4),
                PaddingLeft = UDim.new(0, 6),
                PaddingRight = UDim.new(0, 6),
                PaddingTop = UDim.new(0, 4),
                Parent = aO,
            })

            aP = New('TextLabel', {
                BackgroundTransparency = 1,
                Size = UDim2.new(1, -4, 0, 14),
                Text = '',
                TextColor3 = Color3.fromRGB(255, 50, 50),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = aO,
            })
            aQ = New('UIStroke', {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
                Color = Color3.fromRGB(169, 0, 0),
                LineJoinMode = Enum.LineJoinMode.Miter,
                Parent = aP,
            })
            aR = New('TextLabel', {
                BackgroundTransparency = 1,
                Position = UDim2.fromOffset(0, 16),
                Size = UDim2.new(1, -4, 0, 0),
                Text = '',
                TextSize = 14,
                TextWrapped = true,
                Parent = aO,
                TextXAlignment = Enum.TextXAlignment.Left,
                TextYAlignment = Enum.TextYAlignment.Top,
            })

            New('UIStroke', {
                ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
                Color = 'DarkColor',
                LineJoinMode = Enum.LineJoinMode.Miter,
                Parent = aR,
            })
        end

        local aS = {
            Groupboxes = {},
            Tabboxes = {},
            DependencyGroupboxes = {},
            Description = aE,
            Container = aJ,
            WarningBox = {
                IsNormal = false,
                LockSize = false,
                Visible = false,
                Title = 'WARNING',
                Text = '',
            },
        }

        function aS.UpdateWarningBox(aT, aU)
            if typeof(aU.IsNormal) == 'boolean' then
                aS.WarningBox.IsNormal = aU.IsNormal
            end
            if typeof(aU.LockSize) == 'boolean' then
                aS.WarningBox.LockSize = aU.LockSize
            end
            if typeof(aU.Visible) == 'boolean' then
                aS.WarningBox.Visible = aU.Visible
            end
            if typeof(aU.Title) == 'string' then
                aS.WarningBox.Title = aU.Title
            end
            if typeof(aU.Text) == 'string' then
                aS.WarningBox.Text = aU.Text
            end

            aK.Visible = aS.WarningBox.Visible
            aP.Text = aS.WarningBox.Title
            aR.Text = aS.WarningBox.Text

            aS:Resize(true)

            aL.BackgroundColor3 = aS.WarningBox.IsNormal == true and x.Scheme.BackgroundColor or Color3.fromRGB(127, 0, 0)
            aN.Color = aS.WarningBox.IsNormal == true and x.Scheme.DarkColor or Color3.fromRGB(85, 0, 0)
            aM.Color = aS.WarningBox.IsNormal == true and x.Scheme.OutlineColor or Color3.fromRGB(255, 50, 50)
            aP.TextColor3 = aS.WarningBox.IsNormal == true and x.Scheme.FontColor or Color3.fromRGB(255, 50, 50)
            aQ.Color = aS.WarningBox.IsNormal == true and x.Scheme.OutlineColor or Color3.fromRGB(169, 0, 0)

            if not x.Registry[aL] then
                x:AddToRegistry(aL, {})
            end
            if not x.Registry[aN] then
                x:AddToRegistry(aN, {})
            end
            if not x.Registry[aM] then
                x:AddToRegistry(aM, {})
            end
            if not x.Registry[aP] then
                x:AddToRegistry(aP, {})
            end
            if not x.Registry[aQ] then
                x:AddToRegistry(aQ, {})
            end

            x.Registry[aL].BackgroundColor3 = function()
                return aS.WarningBox.IsNormal == true and x.Scheme.BackgroundColor or Color3.fromRGB(127, 0, 0)
            end
            x.Registry[aN].Color = function()
                return aS.WarningBox.IsNormal == true and x.Scheme.DarkColor or Color3.fromRGB(85, 0, 0)
            end
            x.Registry[aM].Color = function()
                return aS.WarningBox.IsNormal == true and x.Scheme.OutlineColor or Color3.fromRGB(255, 50, 50)
            end
            x.Registry[aP].TextColor3 = function()
                return aS.WarningBox.IsNormal == true and x.Scheme.FontColor or Color3.fromRGB(255, 50, 50)
            end
            x.Registry[aQ].Color = function()
                return aS.WarningBox.IsNormal == true and x.Scheme.OutlineColor or Color3.fromRGB(169, 0, 0)
            end
        end
        function aS.Refresh(aT)
            local aU = aK.Visible and aL.Size.Y.Offset + 8 or 0

            aJ.Position = UDim2.new(aJ.Position.X.Scale, 0, 0, aU)
            aJ.Size = UDim2.new(1, -3, 1, -aU)
        end
        function aS.Resize(aT, aU)
            if aU then
                local aV, aW, aX = math.floor(aJ.AbsoluteSize.Y / 3.25), x:GetTextBounds(aR.Text, x.Scheme.Font, aR.TextSize, aR.AbsoluteSize.X)
                local aY = 24 + aX

                if aS.WarningBox.LockSize == true and aY >= aV then
                    aO.CanvasSize = UDim2.fromOffset(0, aY)
                    aY = aV
                else
                    aO.CanvasSize = UDim2.fromOffset(0, 0)
                end

                aR.Size = UDim2.new(1, -4, 0, aX)
                aL.Size = UDim2.new(1, -5, 0, aY + 4)
            end

            aS:Refresh()
        end
        function aS.AddGroupbox(aT, ...)
            local aU = {}

            if select('#', ...) == 1 and typeof(select(1, ...)) == 'table' then
                local aV = select(1, ...)

                aU.Name = aV.Name or 'Groupbox'
                aU.Icon = aV.Icon
            else
                aU.Name = select(1, ...) or 'Groupbox'
                aU.Icon = select(2, ...)
            end

            local aV = New('Frame', {
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 0),
                Parent = aJ,
            })

            New('UIListLayout', {
                Padding = UDim.new(0, 6),
                Parent = aV,
            })
            New('UIPadding', {
                PaddingBottom = UDim.new(0, 4),
                PaddingTop = UDim.new(0, 4),
                Parent = aV,
            })

            local aW, aX, aY, aZ, a_, a0, a1

            do
                aW = New('Frame', {
                    BackgroundColor3 = 'BackgroundColor',
                    Size = UDim2.fromScale(1, 0),
                    Parent = aV,
                })

                table.insert(x.Corners, New('UICorner', {
                    CornerRadius = UDim.new(0, ac.CornerRadius),
                    Parent = aW,
                }))
                x:AddOutline(aW)

                aX = x:MakeLine(aW, {
                    Position = UDim2.fromOffset(0, 34),
                    Size = UDim2.new(1, 0, 0, 1),
                })

                local a2 = x:GetCustomIcon(aU.Icon)

                if a2 then
                    New('ImageLabel', {
                        Image = a2.Url,
                        ImageColor3 = a2.Custom and 'WhiteColor' or 'AccentColor',
                        ImageRectOffset = a2.ImageRectOffset,
                        ImageRectSize = a2.ImageRectSize,
                        Position = UDim2.fromOffset(6, 6),
                        Size = UDim2.fromOffset(22, 22),
                        Parent = aW,
                    })
                end

                aY = New('TextLabel', {
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(a2 and 24 or 0, 0),
                    Size = UDim2.new(1, 0, 0, 34),
                    Text = aU.Name,
                    TextSize = 15,
                    TextXAlignment = Enum.TextXAlignment.Left,
                    Parent = aW,
                })

                New('UIPadding', {
                    PaddingLeft = UDim.new(0, 12),
                    PaddingRight = UDim.new(0, 12),
                    Parent = aY,
                })

                a1 = New('TextButton', {
                    AnchorPoint = Vector2.new(1, 0),
                    BackgroundTransparency = 1,
                    Position = UDim2.new(1, -8, 0, 8),
                    Size = UDim2.fromOffset(20, 20),
                    Text = '',
                    ZIndex = 5,
                    Parent = aW,
                })
                a0 = New('ImageButton', {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromScale(1, 1),
                    Image = O and O.Url or '',
                    ImageColor3 = 'WhiteColor',
                    ImageRectOffset = O and O.ImageRectOffset or Vector2.zero,
                    ImageRectSize = O and O.ImageRectSize or Vector2.zero,
                    Rotation = 180,
                    ZIndex = 4,
                    Parent = a1,
                })
                aZ = New('Frame', {
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(0, 35),
                    Size = UDim2.new(1, 0, 1, -35),
                    Parent = aW,
                })
                a_ = New('UIListLayout', {
                    Padding = UDim.new(0, 8),
                    Parent = aZ,
                })

                New('UIPadding', {
                    PaddingBottom = UDim.new(0, 7),
                    PaddingLeft = UDim.new(0, 7),
                    PaddingRight = UDim.new(0, 7),
                    PaddingTop = UDim.new(0, 7),
                    Parent = aZ,
                })
            end

            local a2 = {
                BoxHolder = aV,
                Holder = aW,
                Container = aZ,
                Tab = aS,
                DependencyBoxes = {},
                Elements = {},
                Collapsed = false,
            }

            function a2.Resize(a3)
                local a4

                if a3.Collapsed then
                    a4 = UDim2.new(1, 0, 0, 34)
                else
                    a4 = UDim2.new(1, 0, 0, (a_.AbsoluteContentSize.Y / x.DPIScale) + 49)
                end

                aX.Visible = not a3.Collapsed
                aW.Size = a4
            end
            function a2.SetCollapsed(a3, a4)
                a3.Collapsed = a4
                aZ.Visible = not a4
                a0.Rotation = a4 and 0 or 180

                a3:Resize()
            end
            function a2.Toggle(a3)
                a3:SetCollapsed(not a3.Collapsed)
            end

            a1.MouseButton1Click:Connect(function()
                a2:Toggle()
            end)
            setmetatable(a2, aa)
            a2:Resize()

            aS.Groupboxes[aU.Name] = a2

            return a2
        end
        function aS.AddTabbox(aT, aU)
            local aV = New('Frame', {
                AutomaticSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 0),
                Parent = aJ,
            })

            New('UIListLayout', {
                Padding = UDim.new(0, 6),
                Parent = aV,
            })
            New('UIPadding', {
                PaddingBottom = UDim.new(0, 4),
                PaddingTop = UDim.new(0, 4),
                Parent = aV,
            })

            local aW, aX

            do
                aW = New('Frame', {
                    BackgroundColor3 = 'BackgroundColor',
                    Size = UDim2.fromScale(1, 0),
                    Parent = aV,
                })

                table.insert(x.Corners, New('UICorner', {
                    CornerRadius = UDim.new(0, ac.CornerRadius),
                    Parent = aW,
                }))
                x:AddOutline(aW)

                aX = New('Frame', {
                    BackgroundTransparency = 1,
                    Size = UDim2.new(1, 0, 0, 34),
                    Parent = aW,
                })

                New('UIListLayout', {
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalFlex = Enum.UIFlexAlignment.Fill,
                    Parent = aX,
                })
            end

            local aY, aZ, a_ = 0, 1, {
                ActiveTab = nil,
                BoxHolder = aV,
                Holder = aW,
                Tabs = {},
            }

            function a_.UpdateCorners(a0)
                for a1, a2 in a_.Tabs do
                    a2:UpdateCorners()
                end
            end
            function a_.AddTab(a0, a1, a2)
                local a3 = aZ

                aY = aY + 1
                aZ = aZ + 1

                local a4, a5 = x:GetCustomIcon(a2), New('TextButton', {
                    BackgroundColor3 = 'MainColor',
                    BackgroundTransparency = 0,
                    Size = UDim2.fromOffset(0, 34),
                    Text = '',
                    Parent = aX,
                })

                table.insert(x.Corners, New('UICorner', {
                    CornerRadius = UDim.new(0, ac.CornerRadius),
                    Parent = a5,
                }))

                local a6, a7, a8, a9 = New('Frame', {
                    BackgroundColor3 = 'MainColor',
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 1, -ac.CornerRadius),
                    Size = UDim2.new(1, 0, 0, ac.CornerRadius),
                    Parent = a5,
                }), New('Frame', {
                    BackgroundColor3 = 'MainColor',
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 0, 0),
                    Size = UDim2.new(0, ac.CornerRadius, 1, 0),
                    Visible = false,
                    Parent = a5,
                }), New('Frame', {
                    AnchorPoint = Vector2.new(1, 0),
                    BackgroundColor3 = 'MainColor',
                    BorderSizePixel = 0,
                    Position = UDim2.new(1, 0, 0, 0),
                    Size = UDim2.new(0, ac.CornerRadius, 1, 0),
                    Visible = false,
                    Parent = a5,
                }), New('Frame', {
                    AnchorPoint = Vector2.new(0.5, 0.5),
                    AutomaticSize = Enum.AutomaticSize.X,
                    BackgroundTransparency = 1,
                    Position = UDim2.fromScale(0.5, 0.5),
                    Size = UDim2.fromOffset(0, 16),
                    Parent = a5,
                })

                New('UIListLayout', {
                    FillDirection = Enum.FillDirection.Horizontal,
                    HorizontalAlignment = Enum.HorizontalAlignment.Center,
                    VerticalAlignment = Enum.VerticalAlignment.Center,
                    Padding = UDim.new(0, 8),
                    Parent = a9,
                })

                local ba

                if a4 then
                    ba = New('ImageLabel', {
                        Image = a4.Url,
                        ImageColor3 = 'WhiteColor',
                        ImageRectOffset = a4.ImageRectOffset,
                        ImageRectSize = a4.ImageRectSize,
                        ImageTransparency = 0.5,
                        Size = (a1 and a1 ~= '') and UDim2.fromOffset(18, 18) or UDim2.fromOffset(20, 20),
                        Parent = a9,
                    })
                end

                local bb

                if a1 and a1 ~= '' then
                    bb = New('TextLabel', {
                        AutomaticSize = Enum.AutomaticSize.X,
                        BackgroundTransparency = 1,
                        Size = UDim2.fromOffset(0, 16),
                        Text = a1,
                        TextSize = 15,
                        TextTransparency = 0.5,
                        Parent = a9,
                    })
                end

                local U, V = x:MakeLine(a5, {
                    AnchorPoint = Vector2.new(0, 1),
                    Position = UDim2.new(0, 0, 1, 1),
                    Size = UDim2.new(1, 0, 0, 1),
                }), New('Frame', {
                    BackgroundTransparency = 1,
                    Position = UDim2.fromOffset(0, 35),
                    Size = UDim2.new(1, 0, 1, -35),
                    Visible = false,
                    Parent = aW,
                })
                local W = New('UIListLayout', {
                    Padding = UDim.new(0, 8),
                    Parent = V,
                })

                New('UIPadding', {
                    PaddingBottom = UDim.new(0, 7),
                    PaddingLeft = UDim.new(0, 7),
                    PaddingRight = UDim.new(0, 7),
                    PaddingTop = UDim.new(0, 7),
                    Parent = V,
                })

                local X = {
                    ButtonHolder = a5,
                    Container = V,
                    ButtonCovers = {
                        BottomCover = a6,
                        LeftCover = a7,
                        RightCover = a8,
                    },
                    Tab = aS,
                    Elements = {},
                    DependencyBoxes = {},
                }

                function X.Show(Y)
                    if a_.ActiveTab then
                        a_.ActiveTab:Hide()
                    end

                    a5.BackgroundTransparency = 1
                    a6.BackgroundTransparency = 1
                    a7.BackgroundTransparency = 1
                    a8.BackgroundTransparency = 1

                    if bb then
                        bb.TextTransparency = 0
                    end
                    if ba then
                        ba.ImageTransparency = 0
                    end

                    U.Visible = false
                    V.Visible = true
                    a_.ActiveTab = X

                    X:Resize()
                end
                function X.Hide(Y)
                    a5.BackgroundTransparency = 0
                    a6.BackgroundTransparency = 0
                    a7.BackgroundTransparency = 0
                    a8.BackgroundTransparency = 0

                    if bb then
                        bb.TextTransparency = 0.5
                    end
                    if ba then
                        ba.ImageTransparency = 0.5
                    end

                    U.Visible = true
                    V.Visible = false
                    a_.ActiveTab = nil
                end
                function X.Resize(Y)
                    if a_.ActiveTab ~= X then
                        return
                    end

                    aW.Size = UDim2.new(1, 0, 0, (W.AbsoluteContentSize.Y / x.DPIScale) + 49)
                end
                function X.UpdateCorners(Y)
                    a7.Visible = a3 ~= 1
                    a8.Visible = a3 ~= aY
                    a6.Position = UDim2.new(0, 0, 1, -ac.CornerRadius)
                    a6.Size = UDim2.new(1, 0, 0, ac.CornerRadius)
                    a7.Size = UDim2.new(0, ac.CornerRadius, 1, 0)
                    a8.Size = UDim2.new(0, ac.CornerRadius, 1, 0)
                end

                if not a_.ActiveTab then
                    X:Show()
                end

                a5.MouseButton1Click:Connect(X.Show)
                setmetatable(X, aa)

                a_.Tabs[a1] = X

                a_:UpdateCorners()

                return X
            end

            if aU then
                aS.Tabboxes[aU] = a_
            else
                table.insert(aS.Tabboxes, a_)
            end

            return a_
        end
        function aS.Hover(aT, aU)
            if x.ActiveTab == aS then
                return
            end

            i:Create(aG, x.TweenInfo, {
                TextTransparency = aU and 0.25 or 0.5,
            }):Play()

            if aI then
                i:Create(aI, x.TweenInfo, {
                    ImageTransparency = aU and 0.25 or 0.5,
                }):Play()
            end
        end
        function aS.Show(aT)
            if x.ActiveTab then
                x.ActiveTab:Hide()
            end

            i:Create(aF, x.TweenInfo, {BackgroundTransparency = 0.85}):Play()
            i:Create(aG, x.TweenInfo, {TextTransparency = 0}):Play()
            i:Create(aH, x.TweenInfo, {BackgroundTransparency = 0.4}):Play()

            if aI then
                i:Create(aI, x.TweenInfo, {ImageTransparency = 0}):Play()
            end

            aA:ShowTabInfo(aC, aE)

            aJ.Visible = true

            aS:Refresh()

            x.ActiveTab = aS

            if x.Searching then
                x:UpdateSearch(x.SearchText)
            end
        end
        function aS.Hide(aT)
            i:Create(aF, x.TweenInfo, {BackgroundTransparency = 1}):Play()
            i:Create(aG, x.TweenInfo, {TextTransparency = 0.5}):Play()
            i:Create(aH, x.TweenInfo, {BackgroundTransparency = 1}):Play()

            if aI then
                i:Create(aI, x.TweenInfo, {ImageTransparency = 0.5}):Play()
            end

            aJ.Visible = false

            aA:HideTabInfo()

            x.ActiveTab = nil
        end
        function aS.SetVisible(aT, aU)
            aF.Visible = aU

            if not aU and x.ActiveTab == aS then
                aS:Hide()
            end
        end

        if not x.ActiveTab then
            aS:Show()
        end

        aF.MouseEnter:Connect(function()
            aS:Hover(true)

            if ai then
                x:AddTooltip(aC, '', aF)
            end
        end)
        aF.MouseLeave:Connect(function()
            aS:Hover(false)
        end)
        aF.MouseButton1Click:Connect(aS.Show)

        x.Tabs[aC] = aS

        return aS
    end
    function aA.AddSpecialTab(aB, ...)
        return aA:AddFullSizeTab(...)
    end
    function aA.AddKeyTab(aB, ...)
        local aC, aD, aE

        if select('#', ...) == 1 and typeof(...) == 'table' then
            local aF = select(1, ...)

            aC = aF.Name or 'Tab'
            aD = aF.Icon
            aE = aF.Description or 'No Description'
        else
            aC = select(1, ...) or 'Tab'
            aD = select(2, ...)
            aE = select(3, ...) or 'No Description'
        end

        aD = aD or 'key'

        local aF, aG, aH, aI

        aD = if aD == 'key'then Q else x:GetCustomIcon(aD)

        do
            aF = New('TextButton', {
                BackgroundColor3 = 'MainColor',
                BackgroundTransparency = 1,
                Size = UDim2.new(1, 0, 0, 40),
                Text = '',
                Parent = au,
            })

            local aJ = New('UIPadding', {
                PaddingBottom = UDim.new(0, ai and 8 or 10),
                PaddingLeft = UDim.new(0, ai and 8 or 10),
                PaddingRight = UDim.new(0, ai and 8 or 10),
                PaddingTop = UDim.new(0, ai and 8 or 10),
                Parent = aF,
            })

            aG = New('TextLabel', {
                BackgroundTransparency = 1,
                Position = UDim2.fromOffset(30, 0),
                Size = UDim2.new(1, -30, 1, 0),
                Text = aC,
                TextSize = 16,
                TextTransparency = 0.5,
                TextXAlignment = Enum.TextXAlignment.Left,
                Visible = not ai,
                Parent = aF,
            })

            if aD then
                aH = New('ImageLabel', {
                    Image = aD.Url,
                    ImageColor3 = (aD.Custom and not aD.Tint) and 'WhiteColor' or 'AccentColor',
                    ImageRectOffset = aD.ImageRectOffset,
                    ImageRectSize = aD.ImageRectSize,
                    ImageTransparency = 0.5,
                    Size = UDim2.fromScale(1, 1),
                    SizeConstraint = ai and Enum.SizeConstraint.RelativeXY or Enum.SizeConstraint.RelativeYY,
                    Parent = aF,
                })
            end

            table.insert(x.TabButtons, {
                Label = aG,
                Padding = aJ,
                Icon = aH,
            })

            aI = New('ScrollingFrame', {
                AutomaticCanvasSize = Enum.AutomaticSize.Y,
                BackgroundTransparency = 1,
                CanvasSize = UDim2.fromScale(0, 0),
                ScrollBarThickness = 0,
                Size = UDim2.fromScale(1, 1),
                Visible = false,
                Parent = av,
            })

            New('UIListLayout', {
                HorizontalAlignment = Enum.HorizontalAlignment.Center,
                Padding = UDim.new(0, 8),
                VerticalAlignment = Enum.VerticalAlignment.Center,
                Parent = aI,
            })
            New('UIPadding', {
                PaddingLeft = UDim.new(0, 1),
                PaddingRight = UDim.new(0, 1),
                Parent = aI,
            })
        end

        local aJ = {
            Elements = {},
            Description = aE,
            IsKeyTab = true,
        }

        function aJ.AddKeyBox(aK, aL)
            assert(typeof(aL) == 'function', 'Callback must be a function')

            local aM = New('Frame', {
                BackgroundTransparency = 1,
                Size = UDim2.new(0.75, 0, 0, 21),
                Parent = aI,
            })
            local aN = New('TextBox', {
                BackgroundColor3 = 'MainColor',
                PlaceholderText = 'Key',
                Size = UDim2.new(1, -71, 1, 0),
                TextSize = 14,
                TextXAlignment = Enum.TextXAlignment.Left,
                Parent = aM,
            })

            New('UIPadding', {
                PaddingLeft = UDim.new(0, 8),
                PaddingRight = UDim.new(0, 8),
                Parent = aN,
            })
            New('UIStroke', {
                Color = 'OutlineColor',
                Parent = aN,
            })

            local aO = New('TextButton', {
                AnchorPoint = Vector2.new(1, 0),
                BackgroundColor3 = 'MainColor',
                Position = UDim2.fromScale(1, 0),
                Size = UDim2.new(0, 63, 1, 0),
                Text = 'Execute',
                TextSize = 14,
                Parent = aM,
            })

            New('UIStroke', {
                Color = 'OutlineColor',
                Parent = aO,
            })
            aO.InputBegan:Connect(function(aP)
                if not IsClickInput(aP) then
                    return
                end
                if not x:MouseIsOverFrame(aO, aP.Position) then
                    return
                end

                aL(aN.Text)
            end)
        end
        function aJ.RefreshSides(aK) end
        function aJ.Resize(aK) end
        function aJ.UpdateCorners(aK) end
        function aJ.Hover(aK, aL)
            if x.ActiveTab == aJ then
                return
            end

            i:Create(aG, x.TweenInfo, {
                TextTransparency = aL and 0.25 or 0.5,
            }):Play()

            if aH then
                i:Create(aH, x.TweenInfo, {
                    ImageTransparency = aL and 0.25 or 0.5,
                }):Play()
            end
        end
        function aJ.Show(aK)
            if x.ActiveTab then
                x.ActiveTab:Hide()
            end

            i:Create(aF, x.TweenInfo, {BackgroundTransparency = 0}):Play()
            i:Create(aG, x.TweenInfo, {TextTransparency = 0}):Play()

            if aH then
                i:Create(aH, x.TweenInfo, {ImageTransparency = 0}):Play()
            end

            aI.Visible = true

            aA:ShowTabInfo(aC, aE)
            aJ:RefreshSides()

            x.ActiveTab = aJ

            if x.Searching then
                x:UpdateSearch(x.SearchText)
            end
        end
        function aJ.Hide(aK)
            i:Create(aF, x.TweenInfo, {BackgroundTransparency = 1}):Play()
            i:Create(aG, x.TweenInfo, {TextTransparency = 0.5}):Play()

            if aH then
                i:Create(aH, x.TweenInfo, {ImageTransparency = 0.5}):Play()
            end

            aI.Visible = false

            aA:HideTabInfo()

            x.ActiveTab = nil
        end
        function aJ.SetVisible(aK, aL)
            aF.Visible = aL

            if not aL and x.ActiveTab == aJ then
                aJ:Hide()
            end
        end

        if not x.ActiveTab then
            aJ:Show()
        end

        aF.MouseEnter:Connect(function()
            aJ:Hover(true)
        end)
        aF.MouseLeave:Connect(function()
            aJ:Hover(false)
        end)
        aF.MouseButton1Click:Connect(aJ.Show)

        aJ.Container = aI

        setmetatable(aJ, aa)

        x.Tabs[aC] = aJ

        return aJ
    end
    function aA.AddDialog(aB, aC, aD)
        aD = x:Validate(aD, y.Dialog)

        local aE, aF, aG, aH, aI = {}

        aG = New('TextButton', {
            AutoButtonColor = false,
            BackgroundColor3 = 'DarkColor',
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 1),
            Text = '',
            Active = false,
            ZIndex = 9000,
            Visible = true,
            Parent = aj,
        })

        i:Create(aG, x.TweenInfo, {BackgroundTransparency = 0.5}):Play()

        aF = New('TextButton', {
            AnchorPoint = Vector2.new(0.5, 0.5),
            BackgroundColor3 = 'BackgroundColor',
            Position = UDim2.fromScale(0.5, 0.5),
            Size = UDim2.fromOffset(300, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            Text = '',
            AutoButtonColor = false,
            ZIndex = 9001,
            Parent = aG,
        })

        table.insert(x.Corners, New('UICorner', {
            CornerRadius = UDim.new(0, ac.CornerRadius),
            Parent = aF,
        }))
        x:AddOutline(aF)

        local aJ, aK = New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            ZIndex = 9002,
            Parent = aF,
        }), New('UIScale', {
            Scale = 0.95,
            Parent = aF,
        })

        i:Create(aK, x.TweenInfo, {Scale = 1}):Play()

        local aL, aM, aN = New('UIPadding', {
            PaddingBottom = UDim.new(0, 15),
            PaddingLeft = UDim.new(0, 15),
            PaddingRight = UDim.new(0, 15),
            PaddingTop = UDim.new(0, 15),
            Parent = aJ,
        }), New('UIListLayout', {
            Padding = UDim.new(0, 10),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = aJ,
        }), New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 1,
            ZIndex = 9002,
            Parent = aJ,
        })

        New('UIListLayout', {
            Padding = UDim.new(0, 6),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = aN,
        })
        New('UIPadding', {
            PaddingBottom = UDim.new(0, 5),
            Parent = aN,
        })

        local aO = New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 20),
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 1,
            ZIndex = 9002,
            Parent = aN,
        })

        New('UIListLayout', {
            Padding = UDim.new(0, 6),
            FillDirection = Enum.FillDirection.Horizontal,
            VerticalAlignment = Enum.VerticalAlignment.Center,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = aO,
        })

        if aD.Icon then
            local aP = x:GetCustomIcon(aD.Icon)

            if aP then
                local aQ = New('ImageLabel', {
                    BackgroundTransparency = 1,
                    Size = UDim2.fromOffset(16, 16),
                    Image = aP.Url,
                    ImageColor3 = 'FontColor',
                    ImageRectOffset = aP.ImageRectOffset,
                    ImageRectSize = aP.ImageRectSize,
                    LayoutOrder = 1,
                    ZIndex = 9002,
                    Parent = aO,
                })

                if aD.TitleColor then
                    aQ.ImageColor3 = aD.TitleColor
                end
            end
        end

        local aP = New('TextLabel', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 18),
            AutomaticSize = Enum.AutomaticSize.Y,
            Text = aD.Title,
            TextSize = 18,
            TextXAlignment = Enum.TextXAlignment.Left,
            LayoutOrder = 2,
            ZIndex = 9002,
            Parent = aO,
        })

        if aD.TitleColor then
            aP.TextColor3 = aD.TitleColor
        end

        local aQ = New('TextLabel', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 14),
            AutomaticSize = Enum.AutomaticSize.Y,
            Text = aD.Description,
            TextSize = 14,
            TextTransparency = aD.DescriptionColor and 0 or 0.2,
            TextXAlignment = Enum.TextXAlignment.Left,
            TextWrapped = true,
            LayoutOrder = 2,
            ZIndex = 9002,
            Parent = aN,
        })

        if aD.DescriptionColor then
            aQ.TextColor3 = aD.DescriptionColor
        end

        aH = New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.fromScale(1, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 4,
            ZIndex = 9002,
            Parent = aJ,
        })

        New('UIListLayout', {
            Padding = UDim.new(0, 8),
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = aH,
        })
        New('UIPadding', {
            PaddingBottom = UDim.new(0, 5),
            Parent = aH,
        })

        local aR = New('Frame', {
            BackgroundColor3 = 'OutlineColor',
            BackgroundTransparency = 0,
            BorderSizePixel = 0,
            Size = UDim2.new(1, 0, 0, 1),
            LayoutOrder = 5,
            ZIndex = 9002,
            Parent = aJ,
        })

        aI = New('Frame', {
            BackgroundTransparency = 1,
            Size = UDim2.new(1, 0, 0, 0),
            AutomaticSize = Enum.AutomaticSize.Y,
            LayoutOrder = 6,
            ZIndex = 9002,
            Parent = aJ,
        })

        New('UIListLayout', {
            Padding = UDim.new(0, 8),
            FillDirection = Enum.FillDirection.Horizontal,
            HorizontalAlignment = Enum.HorizontalAlignment.Right,
            Wraps = true,
            SortOrder = Enum.SortOrder.LayoutOrder,
            Parent = aI,
        })
        New('UIPadding', {
            PaddingTop = UDim.new(0, 5),
            Parent = aI,
        })

        local aS = {
            Elements = {},
            Container = aH,
        }

        function aS.Resize(aT)
            local aU, aV, aW, aX, aY = aj.AbsoluteSize.X * 0.75, 400, 0, 0, false

            for aZ, a_ in aE do
                aY = true
                aX = aX + 1
                aW = aW + a_.Container.Size.X.Offset
            end

            local aZ = aV

            if aY then
                local a_ = aW + ((aX - 1) * 8) + 30

                aZ = math.max(aV, math.min(a_, aU))
            end

            aF.Size = UDim2.fromOffset(aZ, 0)

            local a_, a0 = x:GetTextBounds(aQ.Text, x.Scheme.Font, 14, aZ - 30)

            aQ.Size = UDim2.new(1, 0, 0, a0)

            local a1 = false

            for a2, a3 in aH:GetChildren()do
                if not a3:IsA'UIListLayout' and not a3:IsA'UIPadding' then
                    a1 = true

                    break
                end
            end

            aH.Visible = a1
            aI.Visible = aY
            aR.Visible = aY
        end
        function aS.SetTitle(aT, aU)
            aP.Text = aU

            aS:Resize()
        end
        function aS.SetDescription(aT, aU)
            aQ.Text = aU

            aS:Resize()
        end
        function aS.Dismiss(aT)
            x.ActiveDialog = nil

            local aU = i:Create(aK, x.TweenInfo, {Scale = 0.95})

            i:Create(aG, x.TweenInfo, {BackgroundTransparency = 1}):Play()
            aU:Play()
            task.delay(x.TweenInfo.Time, function()
                aG:Destroy()
            end)

            x.Dialogues[aC] = nil
        end

        aG.MouseButton1Click:Connect(function()
            if aD.OutsideClickDismiss then
                aS:Dismiss()
            end
        end)

        function aS.RemoveFooterButton(aT, aU)
            if aE[aU] then
                aE[aU].Container:Destroy()

                aE[aU] = nil
            end
        end
        function aS.SetButtonDisabled(aT, aU, aV)
            if aE[aU] and type(aE[aU].SetDisabled) == 'function' then
                aE[aU]:SetDisabled(aV)
            end
        end
        function aS.SetButtonOrder(aT, aU, aV)
            if aE[aU] and aE[aU].Container then
                aE[aU].Container.LayoutOrder = aV
            end
        end
        function aS.AddFooterButton(aT, aU, aV)
            aS:RemoveFooterButton(aU)

            local aW, aX, aY, aZ, a_ = aV.WaitTime or 0, New('Frame', {
                BackgroundTransparency = 1,
                Size = UDim2.fromOffset(0, 26),
                LayoutOrder = aV.Order or 0,
                ZIndex = 9002,
                Parent = aI,
            }), 'MainColor', 'OutlineColor', aV.Variant or 'Primary'

            if a_ == 'Primary' then
                aY = 'FontColor'
                aZ = 'FontColor'
            elseif a_ == 'Secondary' then
                aY = 'MainColor'
                aZ = 'OutlineColor'
            elseif a_ == 'Destructive' then
                aY = 'DestructiveColor'
                aZ = 'DestructiveColor'
            elseif a_ == 'Ghost' then
                aY = 'BackgroundColor'
                aZ = 'BackgroundColor'
            end

            local a0 = New('TextButton', {
                BackgroundColor3 = aY,
                BorderColor3 = aZ,
                BackgroundTransparency = aW > 0 and 0.5 or 0,
                Size = UDim2.fromOffset(0, 26),
                Text = '',
                AutoButtonColor = false,
                ZIndex = 9002,
                Parent = aX,
            })

            x:AddOutline(a0)
            New('UICorner', {
                CornerRadius = UDim.new(0, 4),
                Parent = a0,
            })

            local a1, a2 = New('UIPadding', {
                PaddingLeft = UDim.new(0, 15),
                PaddingRight = UDim.new(0, 15),
                Parent = a0,
            }), x.Scheme.FontColor

            if a_ == 'Primary' then
                a2 = x.Scheme.BackgroundColor
            elseif a_ == 'Destructive' then
                a2 = Color3.new(1, 1, 1)
            end

            local a3 = New('TextLabel', {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                Text = aV.Title or aU,
                TextColor3 = a2,
                TextTransparency = aW > 0 and 0.5 or 0,
                TextSize = 14,
                ZIndex = 9002,
                Parent = a0,
            })
            local a4 = x:GetTextBounds(a3.Text, x.Scheme.Font, 14, 250)

            aX.Size = UDim2.fromOffset(a4 + 30, 26)
            a0.Size = UDim2.fromOffset(a4 + 30, 26)

            local a5

            if aW > 0 then
                a5 = New('Frame', {
                    BackgroundColor3 = 'AccentColor',
                    BorderSizePixel = 0,
                    Position = UDim2.new(0, 0, 1, -2),
                    Size = UDim2.new(0, 0, 0, 2),
                    ZIndex = 2,
                    Parent = a0,
                })

                New('UICorner', {
                    CornerRadius = UDim.new(0, 4),
                    Parent = a5,
                })
            end

            local a6 = aW <= 0
            local a7, a8 = {
                Container = aX,
                SetDisabled = function(a7, a8)
                    a6 = not a8

                    if a8 then
                        i:Create(a0, x.TweenInfo, {BackgroundTransparency = 0.5}):Play()
                        i:Create(a3, x.TweenInfo, {TextTransparency = 0.5}):Play()
                    else
                        i:Create(a0, x.TweenInfo, {BackgroundTransparency = 0}):Play()
                        i:Create(a3, x.TweenInfo, {TextTransparency = 0}):Play()
                    end
                end,
            }, typeof(aY) == 'Color3' and aY or x.Scheme[aY]
            local a9 = a_ == 'Ghost' and x.Scheme.MainColor or x:GetBetterColor(a8, 10)

            a0.MouseEnter:Connect(function()
                if not a6 then
                    return
                end

                i:Create(a0, x.TweenInfo, {BackgroundColor3 = a9}):Play()
            end)
            a0.MouseLeave:Connect(function()
                if not a6 then
                    return
                end

                i:Create(a0, x.TweenInfo, {BackgroundColor3 = a8}):Play()
            end)
            a0.MouseButton1Click:Connect(function()
                if not a6 then
                    return
                end
                if aV.Callback then
                    aV.Callback(aS)
                end
                if aD.AutoDismiss then
                    aS:Dismiss()
                end
            end)

            if aW > 0 then
                i:Create(a5, TweenInfo.new(aW, Enum.EasingStyle.Linear), {
                    Size = UDim2.new(1, 0, 0, 2),
                }):Play()
                task.delay(aW, function()
                    a7:SetDisabled(false)

                    if a5 then
                        i:Create(a5, x.TweenInfo, {BackgroundTransparency = 1}):Play()
                    end
                end)
            end

            aE[aU] = a7
        end

        for aT, aU in aD.FooterButtons do
            if type(aT) == 'number' and aU.Id then
                aT = aU.Id
            end

            aS:AddFooterButton(aT, aU)
        end

        setmetatable(aS, aa)

        x.Dialogues[aC] = aS

        aS:Resize()

        x.ActiveDialog = aS

        return aS
    end
    function aA.Toggle(aB, aC)
        if x.ActiveLoading then
            if aC == true then
                return
            end
            if not x.Toggled then
                return
            end
        end
        if typeof(aC) == 'boolean' then
            x.Toggled = aC
        else
            x.Toggled = not x.Toggled
        end

        aj.Visible = x.Toggled

        if ac.UnlockMouseWhileOpen then
            H.Modal = x.Toggled
        end
        if not x.Toggled then
            L.Visible = false

            for aD, aE in x.Options do
                if aE.Type == 'ColorPicker' then
                    aE.ColorMenu:Close()
                    aE.ContextMenu:Close()
                elseif aE.Type == 'Dropdown' or aE.Type == 'KeyPicker' then
                    aE.Menu:Close()
                end
            end
        end
    end
    function x.Toggle(aB, aC)
        return aA:Toggle(aC)
    end

    if ac.EnableSidebarResize then
        local aB, aC, aD, aE, aF, aG = (ac.MinSidebarWidth + ac.SidebarCompactWidth) * ac.SidebarCollapseThreshold, false, (New('TextButton', {
            AnchorPoint = Vector2.new(0.5, 0),
            BackgroundTransparency = 1,
            Position = UDim2.fromScale(0.5, 0),
            Size = UDim2.new(0, 8, 1, 0),
            Text = '',
            Parent = ak,
        }))

        aD.MouseEnter:Connect(function()
            i:Create(ak, x.TweenInfo, {
                BackgroundColor3 = x:GetLighterColor(x.Scheme.OutlineColor),
            }):Play()
        end)
        aD.MouseLeave:Connect(function()
            if aC then
                return
            end

            i:Create(ak, x.TweenInfo, {
                BackgroundColor3 = x.Scheme.OutlineColor,
            }):Play()
        end)
        aD.InputBegan:Connect(function(aH)
            if not IsClickInput(aH) then
                return
            end

            x.CantDragForced = true
            aE = aH.Position
            aF = aA:GetSidebarWidth()
            aC = true
            aG = aH.Changed:Connect(function()
                if aH.UserInputState ~= Enum.UserInputState.End then
                    return
                end

                x.CantDragForced = false

                i:Create(ak, x.TweenInfo, {
                    BackgroundColor3 = x.Scheme.OutlineColor,
                }):Play()

                aC = false

                if aG and aG.Connected then
                    aG:Disconnect()

                    aG = nil
                end
            end)
        end)
        x:GiveSignal(f.InputChanged:Connect(function(aH)
            if not x.Toggled or not (G and G.Parent) then
                aC = false

                if aG and aG.Connected then
                    aG:Disconnect()

                    aG = nil
                end

                return
            end
            if aC and IsHoverInput(aH) then
                local aI = aH.Position - aE
                local aJ = aF + aI.X

                if ac.DisableCompactingSnap then
                    aA:SetSidebarWidth(aJ)

                    return
                end
                if aJ > aB then
                    aA:SetSidebarWidth(math.max(aJ, ac.MinSidebarWidth))
                else
                    aA:SetSidebarWidth(ac.SidebarCompactWidth)
                end
            end
        end))
    end
    if ac.EnableCompacting and ac.SidebarCompacted then
        aA:SetSidebarWidth(ac.SidebarCompactWidth)
    end
    if ac.AutoShow and not x.ActiveLoading then
        task.spawn(x.Toggle)
    end
    if x.IsMobile then
        local aB, aC

        aB = x:AddDraggableButton('Toggle', function()
            x:Toggle()
        end, true)
        aC = x:AddDraggableButton('Lock', function(aD)
            x.CantDragForced = not x.CantDragForced

            aD:SetText(x.CantDragForced and 'Unlock' or 'Lock')
        end, true)

        if ac.MobileButtonsSide == 'Right' then
            aB.Button.Position = UDim2.new(1, -6, 0, 6)
            aB.Button.AnchorPoint = Vector2.new(1, 0)
            aC.Button.Position = UDim2.new(1, -6, 0, 46)
            aC.Button.AnchorPoint = Vector2.new(1, 0)
        else
            aC.Button.Position = UDim2.fromOffset(6, 46)
        end
        if ac.ShowMobileButtons == false then
            aB.Button.Visible = false
            aC.Button.Visible = false
        end
    end

    ap:GetPropertyChangedSignal'Text':Connect(function()
        x:UpdateSearch(ap.Text)
    end)
    x:GiveSignal(f.InputBegan:Connect(function(aB)
        if x.Unloaded then
            return
        end
        if f:GetFocusedTextBox() then
            return
        end
        if (typeof(x.ToggleKeybind) == 'table' and x.ToggleKeybind.Type == 'KeyPicker' and aB.KeyCode.Name == x.ToggleKeybind.Value) or aB.KeyCode == x.ToggleKeybind then
            x.Toggle()
        end
    end))
    x:GiveSignal(f.WindowFocused:Connect(function()
        x.IsRobloxFocused = true
    end))
    x:GiveSignal(f.WindowFocusReleased:Connect(function()
        x.IsRobloxFocused = false
    end))

    x.Window = aA

    return aA
end
function x.CreateLoading(ab, ac)
    if x.ActiveLoading then
        warn'Loading GUI already exists, you cannot create multiple Loading GUIs.'

        return x.ActiveLoading
    end

    ac = x:Validate(ac, y.Loading)

    local ad, ae = {
        CurrentStep = ac.CurrentStep,
        TotalSteps = ac.TotalSteps,
        ShowSidebar = ac.ShowSidebar,
        AutoResizeHeight = ac.AutoResizeHeight,
        IsError = false,
        Destroyed = false,
        WindowWidth = ac.WindowWidth,
        WindowHeight = ac.WindowHeight,
        BaseWindowHeight = ac.WindowHeight,
        WindowErrorHeight = ac.WindowHeight,
        ContentWidth = ac.ContentWidth,
        SidebarWidth = ac.SidebarWidth,
    }, New('ScreenGui', {
        Name = 'ObsidianLoading',
        DisplayOrder = 999,
        ResetOnSpawn = false,
    })

    ParentUI(ae)

    ad.ScreenGui = ae

    ae.DescendantRemoving:Connect(function(af)
        x:RemoveFromRegistry(af)
    end)

    local af = New('TextButton', {
        Name = 'Main',
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = function()
            return x:GetBetterColor(x.Scheme.BackgroundColor, -1)
        end,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromOffset(ad.ShowSidebar and (ad.ContentWidth + ad.SidebarWidth) or ad.WindowWidth, ad.WindowHeight),
        ClipsDescendants = true,
        Text = '',
        AutoButtonColor = false,
        Parent = ae,
    })

    x:AddOutline(af)
    table.insert(x.Corners, New('UICorner', {
        CornerRadius = UDim.new(0, x.CornerRadius),
        Parent = af,
    }))

    local ag = New('UIScale', {Parent = af})

    table.insert(x.Scales, ag)

    local ah, ai = New('Frame', {
        Name = 'Content',
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.new(0, ad.ContentWidth, 1, 0),
        Parent = af,
    }), New('Frame', {
        Name = 'SideBar',
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(ad.ContentWidth, 0),
        Size = UDim2.new(0, ad.ShowSidebar and ad.SidebarWidth or 0, 1, 0),
        ClipsDescendants = true,
        Visible = ad.ShowSidebar,
        Parent = af,
    })
    local aj = New('UICorner', {
        CornerRadius = UDim.new(0, x.CornerRadius),
        Parent = ai,
    })

    table.insert(x.Corners, aj)
    x:AddOutline(ai)

    local ak, al = New('Frame', {
        BackgroundColor3 = 'OutlineColor',
        BorderSizePixel = 0,
        Position = UDim2.fromOffset(0, 0),
        Size = UDim2.new(0, 1, 1, 0),
        Visible = ad.ShowSidebar,
        Parent = ai,
    }), New('Frame', {
        Name = 'TopBar',
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 0, 48),
        ZIndex = 2,
        Parent = ah,
    })

    x:MakeDraggable(af, al, true, true)

    local am = New('Frame', {
        BackgroundTransparency = 1,
        Size = UDim2.new(1, 0, 1, 0),
        Parent = al,
    })

    New('UIListLayout', {
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Left,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 6),
        Parent = am,
    })
    New('UIPadding', {
        PaddingLeft = UDim.new(0, 12),
        Parent = am,
    })

    if ac.Icon then
        local an = x:GetCustomIcon(ac.Icon)

        New('ImageLabel', {
            Image = an.Url,
            ImageRectOffset = an.ImageRectOffset,
            ImageRectSize = an.ImageRectSize,
            Size = ac.IconSize,
            Parent = am,
        })
    else
        New('TextLabel', {
            BackgroundTransparency = 1,
            Size = ac.IconSize,
            Text = ac.Title:sub(1, 1),
            TextScaled = true,
            Visible = false,
            Parent = am,
        })
    end

    local an = x:GetTextBounds(ac.Title, x.Scheme.Font, 20, am.AbsoluteSize.X - (ac.Icon and (ac.IconSize.X.Offset + 6) or 0) - 12)

    New('TextLabel', {
        BackgroundTransparency = 1,
        Size = UDim2.new(0, an, 1, 0),
        Text = ac.Title,
        TextSize = 20,
        Parent = am,
    })
    x:MakeLine(ah, {
        Position = UDim2.fromOffset(0, 48),
        Size = UDim2.new(1, 0, 0, 1),
    })

    local ao = New('Frame', {
        Name = 'InnerContent',
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, 49),
        Size = UDim2.new(1, 0, 1, -49),
        Parent = ah,
    })

    New('UIListLayout', {
        FillDirection = Enum.FillDirection.Vertical,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        Padding = UDim.new(0, 12),
        Parent = ao,
    })

    local ap, aq = New('Frame', {
        Name = 'IconHolder',
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(64, 64),
        Parent = ao,
    }), x:GetCustomIcon(ac.LoadingIcon)
    local ar, as = (New('ImageLabel', {
        Name = 'LoaderIcon',
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundTransparency = 1,
        Position = UDim2.fromScale(0.5, 0.5),
        Size = UDim2.fromScale(1, 1),
        Image = aq.Url,
        ImageRectOffset = aq.ImageRectOffset,
        ImageRectSize = aq.ImageRectSize,
        ImageColor3 = ac.LoadingIconColor or ((ac.LoadingIcon == y.Loading.LoadingIcon) and 'AccentColor' or 'WhiteColor'),
        Parent = ap,
    }))

    if ac.LoadingIconTweenTime > 0 then
        as = i:Create(ar, TweenInfo.new(ac.LoadingIconTweenTime, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {Rotation = 360})

        as:Play()
    end

    local at, au, av = New('TextLabel', {
        BackgroundTransparency = 1,
        AutomaticSize = ad.AutoResizeHeight and Enum.AutomaticSize.Y or Enum.AutomaticSize.XY,
        Size = ad.AutoResizeHeight and UDim2.new(1, -60, 0, 0) or UDim2.fromOffset(0, 0),
        Text = '',
        TextSize = 18,
        TextWrapped = ad.AutoResizeHeight,
        Parent = ao,
    }), New('TextLabel', {
        BackgroundTransparency = 1,
        AutomaticSize = ad.AutoResizeHeight and Enum.AutomaticSize.Y or Enum.AutomaticSize.XY,
        Size = ad.AutoResizeHeight and UDim2.new(1, -60, 0, 0) or UDim2.fromOffset(0, 0),
        Text = '',
        TextSize = 14,
        TextTransparency = 0.5,
        TextWrapped = ad.AutoResizeHeight,
        Parent = ao,
    }), New('Frame', {
        BackgroundColor3 = 'MainColor',
        Size = UDim2.new(0.7, 0, 0, 15),
        Parent = ao,
    })

    x:AddOutline(av)

    local aw, ax = New('Frame', {
        BackgroundColor3 = 'AccentColor',
        BorderSizePixel = 0,
        Size = UDim2.fromScale(0, 1),
        Parent = av,
    }), New('TextLabel', {
        BackgroundTransparency = 1,
        Size = UDim2.fromScale(1, 1),
        Text = '',
        TextSize = 14,
        ZIndex = 2,
        Parent = av,
    })

    New('UIStroke', {
        ApplyStrokeMode = Enum.ApplyStrokeMode.Contextual,
        Color = 'DarkColor',
        LineJoinMode = Enum.LineJoinMode.Miter,
        Parent = ax,
    })

    local ay = New('ScrollingFrame', {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        Size = UDim2.fromScale(1, 1),
        ScrollBarThickness = 2,
        ScrollBarImageColor3 = 'OutlineColor',
        Parent = ai,
    })
    local az = New('UIListLayout', {
        Padding = UDim.new(0, 8),
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = ay,
    })

    New('UIPadding', {
        PaddingBottom = UDim.new(0, 12),
        PaddingLeft = UDim.new(0, 12),
        PaddingRight = UDim.new(0, 12),
        PaddingTop = UDim.new(0, 12),
        Parent = ay,
    })

    local aA = {
        Elements = {},
        DependencyBoxes = {},
        Tabboxes = {},
        BoxHolder = ay,
        Container = ay,
        Resize = function(aA)
            ay.CanvasSize = UDim2.fromOffset(0, az.AbsoluteContentSize.Y + 24)
        end,
        Tab = {
            Elements = {},
            DependencyBoxes = {},
            DependencyGroupboxes = {},
            Tabboxes = {},
        },
    }

    az:GetPropertyChangedSignal'AbsoluteContentSize':Connect(function()
        aA:Resize()
    end)
    setmetatable(aA, aa)

    ad.Sidebar = aA

    local aB = New('Frame', {
        Name = 'Error',
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(0, 49),
        Size = UDim2.new(1, 0, 1, -49),
        ClipsDescendants = true,
        Visible = false,
        Parent = ah,
    })
    local aC, aD, aE, aF = New('TextLabel', {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(15, 15),
        Size = UDim2.new(1, -30, 0, 18),
        Text = 'Error',
        TextColor3 = 'RedColor',
        TextSize = 18,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = aB,
    }), New('TextLabel', {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(15, 39),
        Size = UDim2.new(1, -30, 1, -90),
        Text = 'Error Message',
        TextSize = 14,
        TextTransparency = 0.2,
        TextWrapped = true,
        TextXAlignment = Enum.TextXAlignment.Left,
        TextYAlignment = Enum.TextYAlignment.Top,
        Parent = aB,
    }), New('Frame', {
        BackgroundColor3 = 'OutlineColor',
        BackgroundTransparency = 0,
        BorderSizePixel = 0,
        AnchorPoint = Vector2.new(0.5, 0),
        Position = UDim2.new(0.5, 0, 1, -48),
        Size = UDim2.new(1, -30, 0, 1),
        Visible = false,
        Parent = aB,
    }), New('Frame', {
        AnchorPoint = Vector2.new(0.5, 1),
        BackgroundTransparency = 1,
        Position = UDim2.new(0.5, 0, 1, 0),
        Size = UDim2.new(1, 0, 0, 42),
        Visible = false,
        Parent = aB,
    })

    New('UIListLayout', {
        Padding = UDim.new(0, 8),
        FillDirection = Enum.FillDirection.Horizontal,
        HorizontalAlignment = Enum.HorizontalAlignment.Right,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Parent = aF,
    })
    New('UIPadding', {
        PaddingTop = UDim.new(0, 5),
        PaddingBottom = UDim.new(0, 15),
        PaddingRight = UDim.new(0, 15),
        Parent = aF,
    })

    function ad.UpdateLayout(aG)
        if ad.IsError then
            ad:RecalculateErrorHeight()
        end

        local aH = ad.ShowSidebar
        local aI, aJ = aH and (ad.ContentWidth + ad.SidebarWidth) or ad.WindowWidth, ad.IsError and ad.WindowErrorHeight or ad.WindowHeight

        if aH then
            ai.Visible = true
            ak.Visible = true
        end

        i:Create(af, x.TweenInfo, {
            Size = UDim2.fromOffset(aI, aJ),
        }):Play()
        i:Create(ai, x.TweenInfo, {
            Position = UDim2.fromOffset(ad.ContentWidth, 0),
            Size = UDim2.new(0, aH and ad.SidebarWidth or 0, 1, 0),
        }):Play()
        i:Create(ah, x.TweenInfo, {
            Size = UDim2.new(0, aH and ad.ContentWidth or ad.WindowWidth, 1, 0),
        }):Play()

        if not aH then
            task.delay(x.TweenInfo.Time, function()
                if not ad.ShowSidebar then
                    ai.Visible = false
                    ak.Visible = false
                end
            end)
        end
    end
    function ad.RecalculateLoadingHeight(aG)
        if not ad.AutoResizeHeight then
            return
        end

        local aH = 97 + ao.UIListLayout.AbsoluteContentSize.Y

        ad.WindowHeight = math.max(ad.BaseWindowHeight, aH)
    end
    function ad.SetMessage(aG, aH)
        at.Text = aH

        if ad.AutoResizeHeight then
            ad:RecalculateLoadingHeight()
            ad:UpdateLayout()
        end
    end
    function ad.SetDescription(aG, aH)
        au.Text = aH

        if ad.AutoResizeHeight then
            ad:RecalculateLoadingHeight()
            ad:UpdateLayout()
        end
    end
    function ad.SetLoadingIcon(aG, aH)
        local aI = x:GetCustomIcon(aH)

        ar.Image = aI.Url
        ar.ImageRectOffset = aI.ImageRectOffset
        ar.ImageRectSize = aI.ImageRectSize
    end
    function ad.SetLoadingIconTweenTime(aG, aH)
        if as then
            as:Cancel()
            as:Destroy()
        end
        if aH > 0 then
            as = i:Create(ar, TweenInfo.new(aH, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {Rotation = 360})

            as:Play()
        else
            ar.Rotation = 0
        end
    end
    function ad.SetLoadingIconColor(aG, aH)
        ar.ImageColor3 = aH
    end
    function ad.SetCurrentStep(aG, aH)
        ad.CurrentStep = math.clamp(aH, 0, ad.TotalSteps)

        local aI = ad.CurrentStep / ad.TotalSteps

        i:Create(aw, x.TweenInfo, {
            Size = UDim2.fromScale(aI, 1),
        }):Play()

        ax.Text = string.format('%d/%d', ad.CurrentStep, ad.TotalSteps)
    end
    function ad.SetTotalSteps(aG, aH)
        ad.TotalSteps = aH

        ad:SetCurrentStep(ad.CurrentStep)
    end
    function ad.SetWindowHeight(aG, aH)
        ad.WindowHeight = aH

        ad:UpdateLayout()
    end
    function ad.SetWindowWidth(aG, aH)
        ad.WindowWidth = aH

        ad:UpdateLayout()
    end
    function ad.SetContentWidth(aG, aH)
        ad.ContentWidth = aH

        ad:UpdateLayout()
    end
    function ad.SetSidebarWidth(aG, aH)
        ad.SidebarWidth = aH

        ad:UpdateLayout()
    end
    function ad.ShowSidebarPage(aG, aH)
        ad.ShowSidebar = aH

        ad:UpdateLayout()
    end
    function ad.ShowErrorPage(aG, aH)
        ad.IsError = aH
        ao.Visible = not aH
        aB.Visible = aH

        if ad.ShowSidebar then
            ad:ShowSidebarPage(not aH)
        else
            ad:UpdateLayout()
        end
    end
    function ad.RecalculateErrorHeight(aG)
        local aH = (ad.ShowSidebar and ad.ContentWidth or ad.WindowWidth) - 30
        local aI, aJ = x:GetTextBounds(aD.Text, x.Scheme.Font, 14, aH)

        aD.Size = UDim2.new(1, -30, 0, aJ)

        local aK = aF.Visible
        local aL = 88 + aJ + 15 + (aK and 48 or 0)

        ad.WindowErrorHeight = aL
    end
    function ad.SetErrorMessage(aG, aH)
        aD.Text = aH

        ad:UpdateLayout()
    end
    function ad.SetErrorButtons(aG, aH)
        assert(typeof(aH) == 'table', 'Buttons must be a table')

        for aI, aJ in aF:GetChildren()do
            if aJ:IsA'Frame' then
                aJ:Destroy()
            end
        end

        local aI = GetTableSize(aH) > 0

        aF.Visible = aI
        aE.Visible = aI

        for aJ, aK in aH do
            local aL, aM, aN, aO = New('Frame', {
                BackgroundTransparency = 1,
                Size = UDim2.fromOffset(0, 26),
                Parent = aF,
            }), 'MainColor', 'OutlineColor', aK.Variant or 'Primary'

            if aO == 'Primary' then
                aM = 'FontColor'
                aN = 'FontColor'
            elseif aO == 'Secondary' then
                aM = 'MainColor'
                aN = 'OutlineColor'
            elseif aO == 'Destructive' then
                aM = 'DestructiveColor'
                aN = 'DestructiveColor'
            elseif aO == 'Ghost' then
                aM = 'BackgroundColor'
                aN = 'BackgroundColor'
            end

            local aP = New('TextButton', {
                BackgroundColor3 = aM,
                BorderColor3 = aN,
                Size = UDim2.fromOffset(0, 26),
                Text = '',
                AutoButtonColor = false,
                Parent = aL,
            })

            x:AddOutline(aP)
            New('UICorner', {
                CornerRadius = UDim.new(0, 4),
                Parent = aP,
            })
            New('UIPadding', {
                PaddingLeft = UDim.new(0, 15),
                PaddingRight = UDim.new(0, 15),
                Parent = aP,
            })

            local aQ = x.Scheme.FontColor

            if aO == 'Primary' then
                aQ = x.Scheme.BackgroundColor
            elseif aO == 'Destructive' then
                aQ = Color3.new(1, 1, 1)
            end

            local aR = New('TextLabel', {
                BackgroundTransparency = 1,
                Size = UDim2.fromScale(1, 1),
                Text = aK.Title or aJ,
                TextColor3 = aQ,
                TextSize = 14,
                Parent = aP,
            })
            local aS = x:GetTextBounds(aR.Text, x.Scheme.Font, 14, 250)

            aL.Size = UDim2.fromOffset(aS + 30, 26)
            aP.Size = UDim2.fromOffset(aS + 30, 26)

            local aT = typeof(aM) == 'Color3' and aM or x.Scheme[aM]
            local aU = aO == 'Ghost' and x.Scheme.MainColor or x:GetBetterColor(aT, 10)

            aP.MouseEnter:Connect(function()
                i:Create(aP, x.TweenInfo, {BackgroundColor3 = aU}):Play()
            end)
            aP.MouseLeave:Connect(function()
                i:Create(aP, x.TweenInfo, {BackgroundColor3 = aT}):Play()
            end)
            aP.MouseButton1Click:Connect(function()
                if aK.Callback then
                    aK.Callback(ad)
                end
            end)
        end

        ad:UpdateLayout()
    end
    function ad.Destroy(aG)
        if as then
            as:Cancel()
        end

        ae:Destroy()

        ad.Destroyed = true
        x.ActiveLoading = nil

        if x.Toggle and x.Toggled == false and x.Unloaded ~= true then
            x:Toggle(true)
        end
    end

    ad.Continue = ad.Destroy

    if x.Toggle and x.Toggled and x.Unloaded ~= true then
        x:Toggle(false)
    end

    ad:SetCurrentStep(ad.CurrentStep)

    x.ActiveLoading = ad

    return ad
end

local function OnPlayerChange()
    if x.Unloaded then
        return
    end

    local ab, ac = GetPlayers(), GetPlayers(true)

    for ad, ae in s do
        if ae.Type == 'Dropdown' and ae.SpecialType == 'Player' then
            ae:SetValues(ae.ExcludeLocalPlayer and ac or ab)
        end
    end
end
local function OnTeamChange()
    if x.Unloaded then
        return
    end

    local ab = GetTeams()

    for ac, ad in s do
        if ad.Type == 'Dropdown' and ad.SpecialType == 'Team' then
            ad:SetValues(ab)
        end
    end
end

x:GiveSignal(c.PlayerAdded:Connect(OnPlayerChange))
x:GiveSignal(c.PlayerRemoving:Connect(OnPlayerChange))
x:GiveSignal(h.ChildAdded:Connect(OnTeamChange))
x:GiveSignal(h.ChildRemoved:Connect(OnTeamChange))

j().Library = x

return x
