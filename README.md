```
Names = {    "Dark",
    "Darker",
    "Light",
    "Aqua",
    "Amethyst",
    "Rose",
    "Golden",
    "DarkPurple",
    "Dark Halloween",
    "Light Halloween",
    "Dark Typewriter",
    "Jungle",
    "Midnight",
    "Neon Glow",
    "Neon Green",
    "Neon Pink",
    "Sunrise",
    "Galaxy",
    "Pastel",
    "Crimson",
    "Sunset",
    "Oceanic",
    "Minimalist",
    "Cyberpunk"
}



    Names = {
        "Lunar Glow",
        "Lunar Dusk",
        "Abyss Eclipse",
        "Ocean Depths",
        "Forest Canopy",
        "Sunset Horizon",
        "Midnight Violet",
        "Arctic Frost",
        "Ruby Ember",
        "Emerald Glow",
        "Sapphire Dream",
        "Golden Dawn",
        "Amethyst Mist",
        "Crimson Tide",
        "Neon Pulse",
        "Cyber Mint",
        "Desert Sand",
        "Lavender Fields",
        "Obsidian Edge",
        "Coral Reef"
    },

Preview:
just try it im so lazy af

# Oioioi
oioioi
```
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/CodeE4X-dev/Library/refs/heads/main/AtoniumRemake.lua"))()
local Window = Library:new()
```
```
local Tab = Window:create_tab("Tab", "rbxassetid://LOGO_IMAGE_ID")
```
```
Tab:create_toggle({
    name = "Toggle",
    flag = "toggle",
    section = "left",
    enabled = false,
    callback = function(state)
    --script
    end
})
```
```
Tab:create_slider({
    name = "Slider"
    flag = "slider",
    value = 50,
    section = "left",
    minimum_value = 0,
    maximum_value = 100,
    callback = function(value)
    --script
    end
})
```
```
Tab:create_button({
    name = "Buttun",
    section = "left"
    callback = function()
        print("Tombol diklik!")
    end
})
```
```
Tab:create_dropdown({
    name = "Dropdown",
    flag = "dropdown",
    section = "left",
    option = "1",
    options = {"1", "2", "3"},
    callback = function(selected)
        --script
    end
})
```
```
Tab:create_textbox({
    name = "Textbox",
    flag = "textbox",
    section = "left",
    value = "",
    callback = function(text)
        --section
    end
})
```
```
Tab:create_keybind({
    name = "Keybind",
    flag = "keybind",
    section = "left",
    keycode = Enum.KeyCode.F,
    callback = function(key)
        print("Keybind ditekan:", key)
    end
})
```
```
Tab:create_title({
    name = "",
    section = "left"
    
})
```
```
Tab:create_paragraph({
    name = "",
    section = "left",
    description = ""
    
})
```
```
Tab:create_image({
    section = "left",
    image = "rbxassetid://",
    imageSize = Vector2.new(215, 150),
    description = ""
})
```
