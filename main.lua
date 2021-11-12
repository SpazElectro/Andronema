local UserInput = game:GetService("UserInputService")

local Window = {}
Window.__index = Window

local Tab = {}
Tab.__index = Tab

local Label = {}
Label.__index = Label

local Toggle = {}
Toggle.__index = Toggle

local ToggleOff = 6031068433
local ToggleOn = 6031068426

local Slider = {}
Slider.__index = Slider

local TextBox = {}
TextBox.__index = TextBox

local BuiltInThemes = {
	Moonlight = {
		MainFrame = Color3.fromRGB(45, 45, 63),
		TopBar = Color3.fromRGB(30, 30, 42),
		TabBar = Color3.fromRGB(30, 30, 42),
		Label = Color3.fromRGB(67, 67, 95),
		LabelHighlighted = Color3.fromRGB(49, 49, 70),
		Button = Color3.fromRGB(67, 67, 95),
		Toggle = Color3.fromRGB(67, 67, 95),
		TextBox = Color3.fromRGB(67, 67, 95),
		Slider = Color3.fromRGB(67, 67, 95)
	}
}

table.freeze(BuiltInThemes)
for _, colors in pairs(BuiltInThemes) do table.freeze(colors) end

local function util_lerp(a, b, f)
	return a + f * (b - a)
end

export type WindowType = {
	Create: typeof(Window.Create),
	CreateTab: typeof(Window.CreateTab),
	IsDestroyed: typeof(Window.IsDestroyed)
}

export type TabType = {
	CreateLabel: typeof(Tab.CreateLabel),
	CreateButton: typeof(Tab.CreateButton),
	CreateToggle: typeof(Tab.CreateToggle),
	CreateSlider: typeof(Tab.CreateSlider),
	CreateTextBox: typeof(Tab.CreateTextBox),
}

export type LabelType = {
	Update: typeof(Label.Update)
}

export type ToggleType = {
	SetState: typeof(Toggle.SetState)
}

export type SliderType = {
	SetValue: typeof(Slider.SetValue)
}

export type TextBoxType = {
	SetText: typeof(TextBox.SetText)
}

local GUI_NAME = "Andronema"

function Window:Create(title: string, theme, coreGui)
	if coreGui == nil then coreGui = true end

	local parent = coreGui and game.CoreGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")
	local colors

	if parent:FindFirstChild(GUI_NAME) then
		parent[GUI_NAME]:Destroy()
	end

	if typeof(theme) == "table" then
		colors = theme
	elseif typeof(theme) == "string" then
		colors = BuiltInThemes[theme]
	else
		colors = BuiltInThemes.Moonlight
	end

	local screenGui = Instance.new("ScreenGui")
	local mainFrame = Instance.new("Frame")
	local mainFrameUICorner = Instance.new("UICorner")
	local mainFrameShadow = Instance.new("ImageLabel")

	local topBarFrame = Instance.new("Frame")
	local topBarUICorner = Instance.new("UICorner")
	local titleTextLabel = Instance.new("TextLabel")
	local closeImageButton = Instance.new("ImageButton")

	local tabBarFrame = Instance.new("ScrollingFrame")
	local tabBarFrameUICorner = Instance.new("UICorner")
	local tabBarFrameUIGridLayout = Instance.new("UIGridLayout")

	local tabs = Instance.new("Folder")

	mainFrame.Name = "Main"
	mainFrame.Parent = screenGui
	mainFrame.BackgroundColor3 = colors.MainFrame
	mainFrame.BorderSizePixel = 0
	mainFrame.Position = UDim2.new(0.393801957, 0, 0.326380372, 0)
	mainFrame.Size = UDim2.new(0, 404, 0, 282)

	mainFrameUICorner.CornerRadius = UDim.new(0.0199999996, 1)
	mainFrameUICorner.Parent = mainFrame

	mainFrameShadow.Name = "Shadow"
	mainFrameShadow.Parent = mainFrame
	mainFrameShadow.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	mainFrameShadow.BackgroundTransparency = 1.000
	mainFrameShadow.Position = UDim2.new(-0.055555556, 0, -0.0496453904, 0)
	mainFrameShadow.Size = UDim2.new(0, 448, 0, 311)
	mainFrameShadow.Image = "rbxassetid://5554236805"
	mainFrameShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)

	topBarFrame.Name = "TopBar"
	topBarFrame.Parent = mainFrame
	topBarFrame.BackgroundColor3 = colors.TopBar
	topBarFrame.Size = UDim2.new(0, 404, 0, 32)

	topBarUICorner.CornerRadius = UDim.new(0.200000003, 1)
	topBarUICorner.Parent = topBarFrame

	titleTextLabel.Parent = topBarFrame
	titleTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	titleTextLabel.BackgroundTransparency = 1.000
	titleTextLabel.Position = UDim2.new(0.0262425486, 0, 0, 0)
	titleTextLabel.Size = UDim2.new(0, 120, 0, 29)
	titleTextLabel.Font = Enum.Font.GothamSemibold
	titleTextLabel.Text = title
	titleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	titleTextLabel.TextSize = 14.000
	titleTextLabel.TextXAlignment = Enum.TextXAlignment.Left

	closeImageButton.Parent = topBarFrame
	closeImageButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	closeImageButton.BackgroundTransparency = 1.000
	closeImageButton.Position = UDim2.new(0.931999981, 0, 0.172000006, 0)
	closeImageButton.Size = UDim2.new(0, 19, 0, 19)
	closeImageButton.Image = "rbxassetid://6031094678"

	tabBarFrame.Name = "TabBar"
	tabBarFrame.Parent = mainFrame
	tabBarFrame.BackgroundColor3 = colors.TabBar
	tabBarFrame.Position = UDim2.new(0, 0, 0.102836877, 0)
	tabBarFrame.Size = UDim2.new(0, 404, 0, 22)
	tabBarFrame.ScrollingDirection = Enum.ScrollingDirection.X
	tabBarFrame.BorderSizePixel = 0
	tabBarFrame.ScrollBarThickness = 3

	tabBarFrameUICorner.CornerRadius = UDim.new(0.0500000007, 1)
	tabBarFrameUICorner.Parent = tabBarFrame

	tabBarFrameUIGridLayout.Parent = tabBarFrame
	tabBarFrameUIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tabBarFrameUIGridLayout.CellSize = UDim2.new(0, 90, 0, 20)

	tabBarFrameUIGridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		tabBarFrame.CanvasSize = UDim2.fromOffset(tabBarFrameUIGridLayout.AbsoluteContentSize.X, 0)
	end)

	tabs.Name = "Tabs"
	tabs.Parent = mainFrame

	local dragToggle = nil
	local dragSpeed = .5
	local dragInput = nil
	local dragStart = nil
	local dragPos = nil

	mainFrame.InputBegan:Connect(function(input: InputObject)
		if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) then
			dragToggle = true
			dragStart = input.Position
			dragPos = mainFrame.Position

			input.Changed:Connect(function()
				if (input.UserInputState == Enum.UserInputState.End) then
					dragToggle = false
				end
			end)
		end
	end)

	mainFrame.InputChanged:Connect(function(input: InputObject)
		if (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
			dragInput = input
		end
	end)

	game:GetService("UserInputService").InputChanged:Connect(function(input: InputObject)
		if (input == dragInput and dragToggle) then
			local Delta = input.Position - dragStart
			local Position = UDim2.new(dragPos.X.Scale, dragPos.X.Offset + Delta.X, dragPos.Y.Scale, dragPos.Y.Offset + Delta.Y)
			game:GetService("TweenService"):Create(mainFrame, TweenInfo.new(.25), {Position = Position}):Play()
		end
	end)

	closeImageButton.MouseButton1Click:Connect(function()
		screenGui:Destroy()
	end)

	screenGui.Parent = parent
	return setmetatable({screenGui = screenGui, colors = colors}, Window)
end

function Window:IsDestroyed()
	return not self.screenGui
end

function Window:CreateTab(title: string)
	local tab = Instance.new("ScrollingFrame")
	local tabUIGridLayout = Instance.new("UIGridLayout")
	local tabTextButton = Instance.new("TextButton")
	local tabTextButtonUICorner = Instance.new("UICorner")

	tab.Name = "Tab"
	tab.Active = true
	tab.BackgroundTransparency = 1
	tab.BorderSizePixel = 0
	tab.Position = UDim2.new(0.0262425486, 0, 0.209219858, 0)
	tab.Size = UDim2.new(0, 387, 0, 215)
	tab.ScrollBarThickness = 3
	tab.Visible = false

	tabUIGridLayout.Parent = tab
	tabUIGridLayout.SortOrder = Enum.SortOrder.LayoutOrder
	tabUIGridLayout.CellSize = UDim2.new(0, 376, 0, 25)

	tabUIGridLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		tab.CanvasSize = UDim2.fromOffset(tabUIGridLayout.AbsoluteContentSize.X, tabUIGridLayout.AbsoluteContentSize.Y)
	end)

	tabTextButton.BackgroundColor3 = Color3.fromRGB(67, 67, 95)
	tabTextButton.BackgroundTransparency = 1.000
	tabTextButton.BorderColor3 = Color3.fromRGB(27, 42, 53)
	tabTextButton.BorderSizePixel = 0
	tabTextButton.Size = UDim2.new(0, 97, 0, 20)
	tabTextButton.Font = Enum.Font.Gotham
	tabTextButton.TextColor3 = Color3.fromRGB(255, 255, 255)
	tabTextButton.TextSize = 13.000
	tabTextButton.Text = title

	tabTextButtonUICorner.CornerRadius = UDim.new(0.09, 1)
	tabTextButtonUICorner.Parent = tabTextButton

	local tabindex = #self.screenGui.Main.Tabs:GetChildren() + 1

	tabTextButton.MouseButton1Click:Connect(function()
		self:__SetCurrentTab(tabindex)
	end)

	tabTextButton.Parent = self.screenGui.Main.TabBar
	tab.Parent = self.screenGui.Main.Tabs

	if self.currentTab == nil then
		self:__SetCurrentTab(1)
	end

	return setmetatable({frame = tab, colors = self.colors}, Tab)
end

function Window:__SetCurrentTab(tabindex: number)
	if self.currentTab then
		self.currentTab.Visible = false
	end

	self.currentTab = self.screenGui.Main.Tabs:GetChildren()[tabindex]
	self.currentTab.Visible = true
end

function Tab:CreateLabel(text: string, highlight: boolean)
	local label = Instance.new("Frame")
	local labelUICorner = Instance.new("UICorner")
	local labelTextLabel = Instance.new("TextLabel")
	local labelImage = Instance.new("ImageLabel")

	label.Name = "Label"
	label.BackgroundColor3 = highlight and self.colors.LabelHighlighted or self.colors.Label
	label.Position = UDim2.new(0, 0, -0.0141843967, 0)
	label.Size = UDim2.new(0, 100, 0, 100)

	labelUICorner.CornerRadius = UDim.new(0.0900000036, 1)
	labelUICorner.Parent = label

	labelTextLabel.Parent = label
	labelTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	labelTextLabel.BackgroundTransparency = 1.000
	labelTextLabel.Position = UDim2.new(0.0265442859, 0, 0, 0)
	labelTextLabel.Size = UDim2.new(0, 366, 0, 25)
	labelTextLabel.Font = Enum.Font.Gotham
	labelTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	labelTextLabel.TextSize = 13.000
	labelTextLabel.TextWrapped = true
	labelTextLabel.TextXAlignment = Enum.TextXAlignment.Left
	labelTextLabel.Text = text

	labelImage.Parent = label
	labelImage.BackgroundTransparency = 1.000
	labelImage.BorderSizePixel = 0
	labelImage.Position = UDim2.new(0.941197634, 0, 0.119999975, 0)
	labelImage.Size = UDim2.new(0, 19, 0, 19)
	labelImage.Image = "http://www.roblox.com/asset/?id=6035078890"
	labelImage.ImageTransparency = 0.300

	label.Parent = self.frame
	return setmetatable({label = label}, Label)
end

function Label:Update(newtext: string)
	self.label.TextLabel.Text = newtext
end

function Tab:CreateButton(text: string, callback)
	local button = Instance.new("TextButton")
	local buttonUICorner = Instance.new("UICorner")
	local buttonTextLabel = Instance.new("TextLabel")
	local buttonImageLabel = Instance.new("ImageLabel")

	button.Name = "Button"
	button.BackgroundColor3 = self.colors.Button
	button.BorderSizePixel = 0
	button.Size = UDim2.new(0, 200, 0, 50)
	button.Font = Enum.Font.Gotham
	button.Text = " "
	button.TextColor3 = Color3.fromRGB(255, 255, 255)
	button.TextSize = 13.000

	buttonUICorner.CornerRadius = UDim.new(0.09, 1)
	buttonUICorner.Parent = button

	buttonTextLabel.Parent = button
	buttonTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	buttonTextLabel.BackgroundTransparency = 1.000
	buttonTextLabel.Position = UDim2.new(0.0265442859, 0, 0, 0)
	buttonTextLabel.Size = UDim2.new(0, 366, 0, 25)
	buttonTextLabel.Font = Enum.Font.Gotham
	buttonTextLabel.Text = text
	buttonTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	buttonTextLabel.TextSize = 13.000
	buttonTextLabel.TextWrapped = true
	buttonTextLabel.TextXAlignment = Enum.TextXAlignment.Left

	buttonImageLabel.Parent = button
	buttonImageLabel.BackgroundTransparency = 1.000
	buttonImageLabel.BorderSizePixel = 0
	buttonImageLabel.Position = UDim2.new(0.940150976, 0, 0.11999999, 0)
	buttonImageLabel.Size = UDim2.new(0, 19, 0, 19)
	buttonImageLabel.Image = "http://www.roblox.com/asset/?id=6026568225"
	buttonImageLabel.ImageTransparency = 0.300

	button.MouseButton1Click:Connect(callback)
	button.Parent = self.frame

	return button
end

function Tab:CreateToggle(text: string, state: boolean, callback)
	local toggle = Instance.new("Frame")
	local toggleUICorner = Instance.new("UICorner")
	local toggleTextLabel = Instance.new("TextLabel")
	local toggleImageLabel = Instance.new("ImageLabel")
	local toggleImageButton = Instance.new("ImageButton")

	toggle.Name = "Toggle"
	toggle.BackgroundColor3 = self.colors.Toggle
	toggle.Size = UDim2.new(0, 100, 0, 100)

	toggleUICorner.CornerRadius = UDim.new(0.0900000036, 1)
	toggleUICorner.Parent = toggle

	toggleTextLabel.Parent = toggle
	toggleTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	toggleTextLabel.BackgroundTransparency = 1.000
	toggleTextLabel.Position = UDim2.new(0.0265442859, 0, 0, 0)
	toggleTextLabel.Size = UDim2.new(0, 366, 0, 25)
	toggleTextLabel.Font = Enum.Font.Gotham
	toggleTextLabel.Text = text
	toggleTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	toggleTextLabel.TextSize = 13.000
	toggleTextLabel.TextWrapped = true
	toggleTextLabel.TextXAlignment = Enum.TextXAlignment.Left

	toggleImageLabel.Parent = toggle
	toggleImageLabel.BackgroundTransparency = 1.000
	toggleImageLabel.BorderSizePixel = 0
	toggleImageLabel.Position = UDim2.new(0.939878464, 0, 0.119999997, 0)
	toggleImageLabel.Size = UDim2.new(0, 19, 0, 19)
	toggleImageLabel.Image = "http://www.roblox.com/asset/?id=6031068430"
	toggleImageLabel.ImageTransparency = 0.300

	toggleImageButton.Name = "Toggle"
	toggleImageButton.Parent = toggle
	toggleImageButton.BackgroundTransparency = 1.000
	toggleImageButton.BorderSizePixel = 0
	toggleImageButton.Position = UDim2.new(0.829032242, 0, 0.0799999982, 0)
	toggleImageButton.Size = UDim2.new(0, 20, 0, 20)
	toggleImageButton.Image = "rbxassetid://"..(state and ToggleOn or ToggleOff)

	local toggleobj = setmetatable({state = state, toggle = toggle, callback = callback}, Toggle)

	toggleImageButton.MouseButton1Click:Connect(function()
		toggleobj:SetState(not toggleobj.state)
	end)

	toggle.Parent = self.frame
	return toggleobj
end

function Toggle:SetState(state: boolean)
	self.state = state
	
	if self.callback then
		self.callback(state)
	end
	
	self.toggle.Toggle.Image = "rbxassetid://"..(state and ToggleOn or ToggleOff)
end

function Tab:CreateSlider(text: string, minvalue: number, maxvalue: number, value: number, callback)
	if value < minvalue or value > maxvalue then
		return error("Value can't be less than minimum value or higher than maximum value")
	end

	local slider = Instance.new("Frame")
	local sliderUICorner = Instance.new("UICorner")
	local sliderTextLabel = Instance.new("TextLabel")

	local sliderFrame = Instance.new("Frame")
	local sliderFrameUICorner = Instance.new("UICorner")
	local sliderImageButton = Instance.new("ImageButton")
	local sliderValue = Instance.new("TextLabel")
	local sliderImage = Instance.new("ImageLabel")

	slider.Name = "Slider"
	slider.Parent = self.frame
	slider.BackgroundColor3 = self.colors.Slider
	slider.Position = UDim2.new(0, 0, -0.0141843967, 0)
	slider.Size = UDim2.new(0, 100, 0, 100)

	sliderUICorner.CornerRadius = UDim.new(0.0900000036, 1)
	sliderUICorner.Parent = slider

	sliderTextLabel.Parent = slider
	sliderTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	sliderTextLabel.BackgroundTransparency = 1.000
	sliderTextLabel.Position = UDim2.new(0.0265442859, 0, 0, 0)
	sliderTextLabel.Size = UDim2.new(0, 366, 0, 25)
	sliderTextLabel.Font = Enum.Font.Gotham
	sliderTextLabel.Text = text
	sliderTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	sliderTextLabel.TextSize = 13.000
	sliderTextLabel.TextWrapped = true
	sliderTextLabel.TextXAlignment = Enum.TextXAlignment.Left

	sliderFrame.Parent = slider
	sliderFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 54)
	sliderFrame.Position = UDim2.new(0.577000022, 0, 0.360000014, 0)
	sliderFrame.Size = UDim2.new(0, 114, 0, 5)

	sliderFrameUICorner.CornerRadius = UDim.new(32, 1)
	sliderFrameUICorner.Parent = sliderFrame

	sliderImageButton.Parent = sliderFrame
	sliderImageButton.BackgroundTransparency = 1.000
	sliderImageButton.BorderSizePixel = 0
	sliderImageButton.Position = UDim2.new(-0.00877192989, 0, -1, 0)
	sliderImageButton.Size = UDim2.new(0, 16, 0, 16)
	sliderImageButton.Image = "http://www.roblox.com/asset/?id=6031625146"

	sliderValue.Name = "Value"
	sliderValue.Parent = sliderFrame
	sliderValue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	sliderValue.BackgroundTransparency = 1.000
	sliderValue.Position = UDim2.new(-0.340803713, 0, -1, 0)
	sliderValue.Size = UDim2.new(0, 38, 0, 16)
	sliderValue.Font = Enum.Font.Gotham
	sliderValue.Text = value
	sliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
	sliderValue.TextSize = 13.000
	sliderValue.TextWrapped = true
	sliderValue.TextXAlignment = Enum.TextXAlignment.Left

	sliderImage.Parent = slider
	sliderImage.BackgroundTransparency = 1.000
	sliderImage.BorderSizePixel = 0
	sliderImage.Position = UDim2.new(0.941197634, 0, 0.119999975, 0)
	sliderImage.Size = UDim2.new(0, 19, 0, 19)
	sliderImage.Image = "http://www.roblox.com/asset/?id=6031233863"
	sliderImage.ImageTransparency = 0.300

	local sliderobj = setmetatable({imagebutton = sliderImageButton, slidervalue = sliderValue, callback = callback, minvalue = minvalue, maxvalue = maxvalue}, Slider)
	sliderobj:SetValue(value)

	local dragging = false

	sliderImageButton.MouseButton1Down:Connect(function()
		dragging = true
	end)

	UserInput.InputChanged:Connect(function()
		if dragging then
			local mousePos = UserInput:GetMouseLocation() + Vector2.new(0, 36)
			local relPos = mousePos - sliderFrame.AbsolutePosition
			local precent = math.clamp(relPos.X / sliderFrame.AbsoluteSize.X, 0, 1)
			local newvalue = util_lerp(minvalue, maxvalue, precent)

			sliderImageButton.Position = UDim2.new(precent, 0, sliderImageButton.Position.Y.Scale, 0)
			sliderValue.Text = newvalue
			
			if self.callback then
				callback(newvalue)
			end
		end
	end)

	UserInput.InputEnded:Connect(function(input: InputObject)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = false
		end
	end)

	return sliderobj
end

function Slider:SetValue(newvalue: number)
	if newvalue < self.minvalue or newvalue > self.maxvalue then
		return error("Value can't be less than minimum value or higher than maximum value")
	end

	self.imagebutton.Position = UDim2.new((newvalue - self.minvalue) / (self.maxvalue - self.minvalue), 0, self.imagebutton.Position.Y.Scale, 0)
	self.slidervalue.Text = newvalue
	
	if self.callback then
		self.callback(newvalue)
	end
end

function Tab:CreateTextBox(text: string, value: string, callback)
	local mainFrame = Instance.new("Frame")
	local mainFrameUICorner = Instance.new("UICorner")
	local mainFrameTextLabel = Instance.new("TextLabel")
	local mainFrameImageLabel = Instance.new("ImageLabel")
	local mainFrameTextBox = Instance.new("TextBox")
	local mainFrameTextBoxUICorner = Instance.new("UICorner")

	mainFrame.Name = "TextBox"
	mainFrame.Parent = self.frame
	mainFrame.BackgroundColor3 = self.colors.TextBox
	mainFrame.Position = UDim2.new(-0.0103359176, 0, -0.00886524841, 0)
	mainFrame.Size = UDim2.new(0, 100, 0, 100)

	mainFrameUICorner.CornerRadius = UDim.new(0.0900000036, 1)
	mainFrameUICorner.Parent = mainFrame

	mainFrameTextLabel.Parent = mainFrame
	mainFrameTextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	mainFrameTextLabel.BackgroundTransparency = 1.000
	mainFrameTextLabel.Position = UDim2.new(0.0265442859, 0, 0, 0)
	mainFrameTextLabel.Size = UDim2.new(0, 366, 0, 25)
	mainFrameTextLabel.Font = Enum.Font.Gotham
	mainFrameTextLabel.Text = text
	mainFrameTextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	mainFrameTextLabel.TextSize = 13.000
	mainFrameTextLabel.TextWrapped = true
	mainFrameTextLabel.TextXAlignment = Enum.TextXAlignment.Left

	mainFrameImageLabel.Parent = mainFrame
	mainFrameImageLabel.BackgroundTransparency = 1.000
	mainFrameImageLabel.BorderSizePixel = 0
	mainFrameImageLabel.Position = UDim2.new(0.942538083, 0, 0.119999997, 0)
	mainFrameImageLabel.Size = UDim2.new(0, 19, 0, 19)
	mainFrameImageLabel.Image = "http://www.roblox.com/asset/?id=6034818398"
	mainFrameImageLabel.ImageTransparency = 0.300

	mainFrameTextBox.Parent = mainFrame
	mainFrameTextBox.BackgroundColor3 = Color3.fromRGB(38, 38, 54)
	mainFrameTextBox.BorderSizePixel = 0
	mainFrameTextBox.Position = UDim2.new(0.577127635, 0, 0.119999997, 0)
	mainFrameTextBox.Size = UDim2.new(0, 114, 0, 19)
	mainFrameTextBox.Font = Enum.Font.SourceSans
	mainFrameTextBox.PlaceholderColor3 = Color3.fromRGB(178, 178, 178)
	mainFrameTextBox.PlaceholderText = "Text Here"
	mainFrameTextBox.Text = value
	mainFrameTextBox.TextColor3 = Color3.fromRGB(234, 234, 234)
	mainFrameTextBox.TextSize = 14.000
	mainFrameTextBox.TextWrapped = true

	mainFrameTextBoxUICorner.CornerRadius = UDim.new(0.0900000036, 1)
	mainFrameTextBoxUICorner.Parent = mainFrameTextBox

	mainFrameTextBox.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			if callback then
				callback(mainFrameTextBox.Text)
			end
			
			mainFrameTextBox.Text = ""
		end
	end)

	return setmetatable({textBox = mainFrameTextBox}, TextBox)
end

function TextBox:SetText(newtext: string)
	self.textBox.Text = newtext
end

return Window
