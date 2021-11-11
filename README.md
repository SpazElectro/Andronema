# Andronema
A Roblox UI Library you can use for your scripts, both roblox studio and exploits are supported.

Example of usage (Executor)
```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/WhoIsDanix/Andronema/master/main.lua"))

local window = Library:Create("Window Title")
local tab = window:CreateTab("Tab Title")

tab:CreateLabel("Hello World!")
```

Example of usage (Roblox Studio)
```lua
-- Create new module script and paste code from main.lua
local Library = require(path_to_module)

-- Or you can use HttpService
-- local HttpService = game:GetService("HttpService")
-- local Library = loadstring(HttpService:GetAsync("https://raw.githubusercontent.com/WhoIsDanix/Andronema/master/main.lua"))

local window = Library:Create("Window Title")
local tab = window:CreateTab("Tab Title")

tab:CreateLabel("Hello World!")
```
