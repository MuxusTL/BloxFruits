local plr = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local Runservice = game:GetService("RunService")
local httpservice = game:GetService("HttpService")
local Mouse = plr:GetMouse()
local TweenService = game:GetService("TweenService")
local SitinkScreen = Instance.new("ScreenGui")
SitinkScreen.Name = "Andz"
SitinkScreen.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
local Andz = {}
local CoreGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local function MakeDraggable(topbarobject, object)
	local Dragging = nil
	local DragInput = nil
	local DragStart = nil
	local StartPosition = nil

	local function Update(input)
		local Delta = input.Position - DragStart
		local pos =
			UDim2.new(
				StartPosition.X.Scale,
				StartPosition.X.Offset + Delta.X,
				StartPosition.Y.Scale,
				StartPosition.Y.Offset + Delta.Y
			)
		object.Position = pos
	end

	topbarobject.InputBegan:Connect(
		function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				Dragging = true
				DragStart = input.Position
				StartPosition = object.Position

				input.Changed:Connect(
					function()
						if input.UserInputState == Enum.UserInputState.End then
							Dragging = false
						end
					end
				)
			end
		end
	)

	topbarobject.InputChanged:Connect(
		function(input)
			if
				input.UserInputType == Enum.UserInputType.MouseMovement or
				input.UserInputType == Enum.UserInputType.Touch
			then
				DragInput = input
			end
		end
	)

	uis.InputChanged:Connect(
		function(input)
			if input == DragInput and Dragging then
				Update(input)
			end
		end
	)
end

function Andz:AddNotification(NotifyConfig)
	NotifyConfig = NotifyConfig or {}
	NotifyConfig.Title = NotifyConfig.Title or ""
	NotifyConfig.Description = NotifyConfig.Description or ""
	NotifyConfig.Time = NotifyConfig.Time or 5
	local NotifyFunc = {}
	local Notification = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local Title = Instance.new("TextLabel")
	local UIPadding = Instance.new("UIPadding")
	local Desc = Instance.new("TextLabel")
	local UIPadding_2 = Instance.new("UIPadding")
	local Close = Instance.new("Frame")
	local CloseButton = Instance.new("ImageButton")
	spawn(function()
		if not CoreGui:FindFirstChild("NotifyGui") then
			local NotifyGui = Instance.new("ScreenGui")
			NotifyGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			NotifyGui.Name = "NotifyGui"
			NotifyGui.Parent = CoreGui
		end
		if not CoreGui.NotifyGui:FindFirstChild("NotifyLayout") then
			local NotifyLayout = Instance.new("Frame")
			NotifyLayout.AnchorPoint = Vector2.new(1, 1)
			NotifyLayout.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			NotifyLayout.BackgroundTransparency = 0.9990000128746033
			NotifyLayout.BorderColor3 = Color3.fromRGB(0, 0, 0)
			NotifyLayout.BorderSizePixel = 0
			NotifyLayout.Position = UDim2.new(1, -30, 1, -30)
			NotifyLayout.Size = UDim2.new(0, 300, 1, -30)
			NotifyLayout.Name = "NotifyLayout"
			NotifyLayout.Parent = CoreGui.NotifyGui
			local Count = 0
			CoreGui.NotifyGui.NotifyLayout.ChildRemoved:Connect(
				function()
					Count = 0
					for i, v in CoreGui.NotifyGui.NotifyLayout:GetChildren() do
						Count = Count + 1
						TweenService:Create(
							v,
							TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut),
							{Position = UDim2.new(0, 0, 1, -((v.Size.Y.Offset + 12) * Count))}
						):Play()

					end
				end
			)
		end
		local NotifyPosHeigh = 0
		for i, v in CoreGui.NotifyGui.NotifyLayout:GetChildren() do
			NotifyPosHeigh = -(v.Position.Y.Offset) + v.Size.Y.Offset + 12
		end

		Notification.Name = "Notification"
		Notification.Parent = CoreGui.NotifyGui.NotifyLayout
		Notification.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
		Notification.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Notification.BorderSizePixel = 0
		Notification.Position = UDim2.new(0, 0, 1, -(NotifyPosHeigh))
		Notification.Size = UDim2.new(0, 280, 0, 66)

		UICorner.CornerRadius = UDim.new(0, 4)
		UICorner.Parent = Notification

		Title.Name = "Title"
		Title.Parent = Notification
		Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Title.BackgroundTransparency = 1.000
		Title.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Title.BorderSizePixel = 0
		Title.Size = UDim2.new(1, 0, 0, 20)
		Title.Font = Enum.Font.GothamBold
		Title.Text = NotifyConfig.Title
		Title.TextColor3 = Color3.fromRGB(255, 255, 255)
		Title.TextSize = 14.000
		Title.TextXAlignment = Enum.TextXAlignment.Left

		UIPadding.Parent = Title
		UIPadding.PaddingLeft = UDim.new(0, 7)
		UIPadding.PaddingTop = UDim.new(0, 5)

		Desc.Name = "Desc"
		Desc.Parent = Notification
		Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Desc.BackgroundTransparency = 1.000
		Desc.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Desc.BorderSizePixel = 0
		Desc.Position = UDim2.new(-0.000641087128, 0, 0.330302835, 0)
		Desc.Size = UDim2.new(1.02600002, 0, 0, 44)
		Desc.Font = Enum.Font.GothamBold
		Desc.Text = NotifyConfig.Description
		Desc.TextColor3 = Color3.fromRGB(170, 170, 170)
		Desc.TextSize = 12.000
		Desc.TextWrapped = true
		Desc.TextXAlignment = Enum.TextXAlignment.Left
		Desc.TextYAlignment = Enum.TextYAlignment.Top

		UIPadding_2.Parent = Desc
		UIPadding_2.PaddingLeft = UDim.new(0, 7)

		Close.Name = "Close"
		Close.Parent = Notification
		Close.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Close.BackgroundTransparency = 1.000
		Close.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Close.BorderSizePixel = 0
		Close.Position = UDim2.new(0.917999983, 4, 0.0299999993, 0)
		Close.Size = UDim2.new(0, 15, 0, 15)

		CloseButton.Name = "CloseButton"
		CloseButton.Parent = Close
		CloseButton.Active = false
		CloseButton.BackgroundTransparency = 1.000
		CloseButton.Position = UDim2.new(-0.13333334, 0, -0.13333334, 0)
		CloseButton.Selectable = false
		CloseButton.Size = UDim2.new(0, 20, 0, 20)
		CloseButton.Image = "rbxassetid://2777727756"

		local waitbruh = false
		function NotifyFunc:Close()
			if waitbruh then
				return false
			end
			waitbruh = true
			TweenService:Create(
				Notification,
				TweenInfo.new(tonumber(0.5), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
				{Position = UDim2.new(0, 330, 0, 200)}
			):Play()
			task.wait(tonumber(0.5) / 1.2)
			Notification:Destroy()
		end
		CloseButton.MouseButton1Click:Connect(
			function()
				NotifyFunc:Close()
			end
		)
		TweenService:Create(
			Notification,
			TweenInfo.new(tonumber(0.5), Enum.EasingStyle.Back, Enum.EasingDirection.InOut),
			{Position = UDim2.new(0.714, -200, 0.8, 0)}
		):Play()
		task.wait(tonumber(NotifyConfig.Time))
		NotifyFunc:Close()
		return NotifyFunc
	end)
end

function Andz:AddWindows(cf)
	cf = {}
	cf.Title = cf.Title or ""
	cf.Logo = cf.Logo or ""
	cf["Enable Loading Ui"] = cf["Enable Loading Ui"] or false
	cf["Time to load ui"] = cf["Time to load ui"] or 5

	local SitinkGUI = Instance.new("ScreenGui")
	local Main = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local TopTab = Instance.new("Frame")
	local LogoHub = Instance.new("Frame")
	local UICorner_2 = Instance.new("UICorner")
	local LogoId = Instance.new("ImageLabel")
	local UICorner_3 = Instance.new("UICorner")
	local LeftArrowTab = Instance.new("ImageLabel")
	local TabList = Instance.new("Frame")
	local UICorner_4 = Instance.new("UICorner")
	local List = Instance.new("ScrollingFrame")
	local UIListLayout = Instance.new("UIListLayout")
	local UIPadding = Instance.new("UIPadding")
	local RightArrrowTab = Instance.new("ImageLabel")
	local ChannelContainer = Instance.new("Frame")
	local UICorner_7 = Instance.new("UICorner")
	local DropShadowHolder = Instance.new("Frame")
	local DropShadow = Instance.new("ImageLabel")
	local ClickkGUI = Instance.new("Frame")
	local UICorner_35 = Instance.new("UICorner")
	local c = Instance.new("TextButton")
	local DropShadowHolder_2 = Instance.new("Frame")
	local DropShadow_2 = Instance.new("ImageLabel")
	local Loading = Instance.new("Frame")
	local UICorner_36 = Instance.new("UICorner")
	local DropShadowHolder_3 = Instance.new("Frame")
	local DropShadow_3 = Instance.new("ImageLabel")
	local Title_17 = Instance.new("TextLabel")
	local LoadingFrame = Instance.new("Frame")
	local Load = Instance.new("Frame")
	local TextLabel = Instance.new("TextLabel")

	DropShadowHolder.Name = "DropShadowHolder"
	DropShadowHolder.Parent = Main
	DropShadowHolder.BackgroundTransparency = 1.000
	DropShadowHolder.BorderSizePixel = 0
	DropShadowHolder.Size = UDim2.new(1, 0, 1, 0)
	DropShadowHolder.ZIndex = 0

	DropShadow.Name = "DropShadow"
	DropShadow.Parent = DropShadowHolder
	DropShadow.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	DropShadow.BackgroundTransparency = 1.000
	DropShadow.BorderSizePixel = 0
	DropShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow.Size = UDim2.new(1, 47, 1, 47)
	DropShadow.ZIndex = 0
	DropShadow.Image = "rbxassetid://6014261993"
	DropShadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	DropShadow.ImageTransparency = 0.500
	DropShadow.ScaleType = Enum.ScaleType.Slice
	DropShadow.SliceCenter = Rect.new(49, 49, 450, 450)

	ClickkGUI.Name = "ClickkGUI"
	ClickkGUI.Parent = SitinkGUI
	ClickkGUI.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
	ClickkGUI.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ClickkGUI.BorderSizePixel = 0
	ClickkGUI.Position = UDim2.new(0.0855721384, 0, 0.139676109, 0)
	ClickkGUI.Size = UDim2.new(0, 45, 0, 45)

	UICorner_35.Parent = ClickkGUI

	c.Name = "c"
	c.Parent = ClickkGUI
	c.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	c.BackgroundTransparency = 1.000
	c.BorderColor3 = Color3.fromRGB(0, 0, 0)
	c.BorderSizePixel = 0
	c.Size = UDim2.new(1, 0, 1, 0)
	c.Font = Enum.Font.GothamBold
	c.Text = "OFF"
	c.TextColor3 = Color3.fromRGB(255, 255, 255)
	c.TextSize = 13.000
	c.MouseButton1Click:Connect(function()
		if c.Text == "OFF" then
			Main.Visible = false
			c.Text = "ON"
		elseif c.Text == "ON" then
			c.Text = "OFF"
			Main.Visible = true
		end
	end)

	DropShadowHolder_2.Name = "DropShadowHolder"
	DropShadowHolder_2.Parent = ClickkGUI
	DropShadowHolder_2.BackgroundTransparency = 1.000
	DropShadowHolder_2.BorderSizePixel = 0
	DropShadowHolder_2.Size = UDim2.new(1, 0, 1, 0)
	DropShadowHolder_2.ZIndex = 0

	DropShadow_2.Name = "DropShadow"
	DropShadow_2.Parent = DropShadowHolder_2
	DropShadow_2.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow_2.BackgroundTransparency = 1.000
	DropShadow_2.BorderSizePixel = 0
	DropShadow_2.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow_2.Size = UDim2.new(1, 47, 1, 47)
	DropShadow_2.ZIndex = 0
	DropShadow_2.Image = "rbxassetid://6014261993"
	DropShadow_2.ImageColor3 = Color3.fromRGB(0, 0, 0)
	DropShadow_2.ImageTransparency = 0.500
	DropShadow_2.ScaleType = Enum.ScaleType.Slice
	DropShadow_2.SliceCenter = Rect.new(49, 49, 450, 450)

	Loading.Name = "Loading"
	Loading.Parent = SitinkGUI
	Loading.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
	Loading.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Loading.BorderSizePixel = 0
	Loading.Position = UDim2.new(0.268656731, 0, 0.230769232, 0)
	Loading.Size = UDim2.new(0, 440, 0, 243)

	UICorner_36.CornerRadius = UDim.new(0, 2)
	UICorner_36.Parent = Loading

	DropShadowHolder_3.Name = "DropShadowHolder"
	DropShadowHolder_3.Parent = Loading
	DropShadowHolder_3.BackgroundTransparency = 1.000
	DropShadowHolder_3.BorderSizePixel = 0
	DropShadowHolder_3.Size = UDim2.new(1, 0, 1, 0)
	DropShadowHolder_3.ZIndex = 0

	DropShadow_3.Name = "DropShadow"
	DropShadow_3.Parent = DropShadowHolder_3
	DropShadow_3.AnchorPoint = Vector2.new(0.5, 0.5)
	DropShadow_3.BackgroundTransparency = 1.000
	DropShadow_3.BorderSizePixel = 0
	DropShadow_3.Position = UDim2.new(0.5, 0, 0.5, 0)
	DropShadow_3.Size = UDim2.new(1, 47, 1, 47)
	DropShadow_3.ZIndex = 0
	DropShadow_3.Image = "rbxassetid://6015897843"
	DropShadow_3.ImageColor3 = Color3.fromRGB(0, 0, 0)
	DropShadow_3.ImageTransparency = 0.500
	DropShadow_3.ScaleType = Enum.ScaleType.Slice
	DropShadow_3.SliceCenter = Rect.new(49, 49, 450, 450)

	Title_17.Name = "Title"
	Title_17.Parent = Loading
	Title_17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Title_17.BackgroundTransparency = 1.000
	Title_17.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Title_17.BorderSizePixel = 0
	Title_17.Position = UDim2.new(0, 0, 0.094650209, 0)
	Title_17.Size = UDim2.new(0, 440, 0, 80)
	Title_17.Font = Enum.Font.GothamBold
	Title_17.Text = cf.Title .. " Loading..."
	Title_17.TextColor3 = Color3.fromRGB(255, 255, 255)
	Title_17.TextSize = 28.000

	LoadingFrame.Name = "LoadingFrame"
	LoadingFrame.Parent = Loading
	LoadingFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LoadingFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LoadingFrame.BorderSizePixel = 0
	LoadingFrame.Position = UDim2.new(0.0500000007, 0, 0.732510269, 0)
	LoadingFrame.Size = UDim2.new(0, 400, 0, 40)

	Load.Name = "Load"
	Load.Parent = LoadingFrame
	Load.BackgroundColor3 = Color3.fromRGB(48, 79, 255)
	Load.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Load.BorderSizePixel = 0
	Load.Size = UDim2.new(0, 0, 1, 0)

	TextLabel.Parent = Loading
	TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextLabel.BackgroundTransparency = 1.000
	TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TextLabel.BorderSizePixel = 0
	TextLabel.Position = UDim2.new(0.2590909, 0, 00.544444448, 0)
	TextLabel.Size = UDim2.new(0, 200, 0, 50)
	TextLabel.Font = Enum.Font.GothamBold
	TextLabel.Text = "Player Name : " .. plr.Name
	TextLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
	TextLabel.TextSize = 20.000

	SitinkGUI.Name = "SitinkGUI"
	SitinkGUI.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

	Main.Visible = false
	Load:TweenSize(UDim2.new(0, 400, 1, 0),"Out","Quad",3,true)
	wait(3)
	Loading.Visible = false
	Main.Visible = true

	Main.Name = "Main"
	Main.Parent = SitinkGUI
	Main.AnchorPoint = Vector2.new(0, 1)
	Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	Main.BorderColor3 = Color3.fromRGB(0, 0, 0)
	Main.BorderSizePixel = 0
	Main.Position = UDim2.new(0.265671641, 0, 0.963562727, 0)
	Main.Size = UDim2.new(0, 459, 0, 333)

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = Main

	TopTab.Name = "Top Tab"
	TopTab.Parent = Main
	TopTab.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
	TopTab.BackgroundTransparency = 1.000
	TopTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TopTab.BorderSizePixel = 0
	TopTab.Position = UDim2.new(0, 0, 0, 10)
	TopTab.Size = UDim2.new(1, 0, 0, 50)

	LogoHub.Name = "Logo Hub"
	LogoHub.Parent = TopTab
	LogoHub.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LogoHub.BackgroundTransparency = 1.000
	LogoHub.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LogoHub.BorderSizePixel = 0
	LogoHub.Position = UDim2.new(0, 12, 0, 1)
	LogoHub.Size = UDim2.new(0, 40, 0, 40)

	UICorner_2.CornerRadius = UDim.new(1, 0)
	UICorner_2.Parent = LogoHub

	LogoId.Name = "Logo Id"
	LogoId.Parent = LogoHub
	LogoId.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LogoId.BackgroundTransparency = 1.000
	LogoId.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LogoId.BorderSizePixel = 0
	LogoId.Size = UDim2.new(1, 0, 1, 0)
	LogoId.Image = "rbxassetid://18763227055"

	UICorner_3.CornerRadius = UDim.new(1, 0)
	UICorner_3.Parent = LogoId

	LeftArrowTab.Name = "Left Arrow Tab"
	LeftArrowTab.Parent = TopTab
	LeftArrowTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	LeftArrowTab.BackgroundTransparency = 1.000
	LeftArrowTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
	LeftArrowTab.BorderSizePixel = 0
	LeftArrowTab.Position = UDim2.new(0, 60, 0, 15)
	LeftArrowTab.Size = UDim2.new(0, 12, 0, 12)
	LeftArrowTab.Image = "http://www.roblox.com/asset/?id=18763282134"

	TabList.Name = "TabList"
	TabList.Parent = TopTab
	TabList.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	TabList.BackgroundTransparency = 0.800
	TabList.BorderColor3 = Color3.fromRGB(0, 0, 0)
	TabList.BorderSizePixel = 0
	TabList.Position = UDim2.new(0, 78, 0, 7)
	TabList.Size = UDim2.new(0, 360, 0, 28)

	UICorner_4.CornerRadius = UDim.new(0, 2)
	UICorner_4.Parent = TabList

	List.Name = "List"
	List.Parent = TabList
	List.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	List.BackgroundTransparency = 1.000
	List.BorderColor3 = Color3.fromRGB(0, 0, 0)
	List.BorderSizePixel = 0
	List.Selectable = false
	List.Size = UDim2.new(1, 0, 1, 0)
	List.CanvasSize = UDim2.new(2, 0, 0, 0)
	List.ScrollBarThickness = 0
	game:GetService("RunService").Stepped:Connect(function()
		pcall(function()
			List.CanvasSize = UDim2.new(0,UIListLayout.AbsoluteContentSize.Y + 20,0,0)
		end)
	end)

	UIListLayout.Parent = List
	UIListLayout.FillDirection = Enum.FillDirection.Horizontal
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 3)

	UIPadding.Parent = List
	UIPadding.PaddingBottom = UDim.new(0, 1)
	UIPadding.PaddingLeft = UDim.new(0, 4)
	UIPadding.PaddingRight = UDim.new(0, 4)
	UIPadding.PaddingTop = UDim.new(0, 1)

	RightArrrowTab.Name = "Right Arrrow Tab"
	RightArrrowTab.Parent = TopTab
	RightArrrowTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	RightArrrowTab.BackgroundTransparency = 1.000
	RightArrrowTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
	RightArrrowTab.BorderSizePixel = 0
	RightArrrowTab.Position = UDim2.new(1, -17, 0, 15)
	RightArrrowTab.Rotation = -180.000
	RightArrrowTab.Size = UDim2.new(0, 12, 0, 12)
	RightArrrowTab.Image = "http://www.roblox.com/asset/?id=18763282134"

	ChannelContainer.Name = "Channel Container"
	ChannelContainer.Parent = Main
	ChannelContainer.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
	ChannelContainer.BorderColor3 = Color3.fromRGB(0, 0, 0)
	ChannelContainer.BorderSizePixel = 0
	ChannelContainer.Position = UDim2.new(0, 0, 0, 60)
	ChannelContainer.Size = UDim2.new(1, 0, 1, -50)

	UICorner_7.CornerRadius = UDim.new(0, 4)
	UICorner_7.Parent = ChannelContainer

	MakeDraggable(TopTab, Main)
	local AddTabFunc = {}
	function AddTabFunc:AddTab(cf)
		cf = cf or {}
		cf.Name = cf.Name or ""

		local TabDisable = Instance.new("Frame")
		local UICorner_6 = Instance.new("UICorner")
		local NameTab_2 = Instance.new("TextLabel")
		local Click_2 = Instance.new("TextButton")
		local Channel = Instance.new("Frame")
		local UICorner_8 = Instance.new("UICorner")
		local Right = Instance.new("Frame")
		local List_2 = Instance.new("ScrollingFrame")
		local Left = Instance.new("Frame")
		local List_5 = Instance.new("ScrollingFrame")
		local UIListLayout_222222 = Instance.new("UIListLayout")
		local UIListLayout_22222 = Instance.new("UIListLayout")
		local UIPadding = Instance.new("UIPadding")
		local UIPadding2 = Instance.new("UIPadding")

		TabDisable.Name = "Tab Disable"
		TabDisable.Parent = List
		TabDisable.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
		TabDisable.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabDisable.BorderSizePixel = 0
		TabDisable.Size = UDim2.new(0, 100, 0, 26)

		UICorner_6.CornerRadius = UDim.new(0, 5)
		UICorner_6.Parent = TabDisable

		NameTab_2.Name = "Name Tab"
		NameTab_2.Parent = TabDisable
		NameTab_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		NameTab_2.BackgroundTransparency = 1.000
		NameTab_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		NameTab_2.BorderSizePixel = 0
		NameTab_2.Size = UDim2.new(1, 0, 1, 0)
		NameTab_2.Font = Enum.Font.GothamBold
		NameTab_2.Text = cf.Name
		NameTab_2.TextColor3 = Color3.fromRGB(200, 200, 200)
		NameTab_2.TextSize = 13.000

		Click_2.Name = "Click"
		Click_2.Parent = TabDisable
		Click_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		Click_2.BackgroundTransparency = 1.000
		Click_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Click_2.BorderSizePixel = 0
		Click_2.Size = UDim2.new(1, 0, 1, 0)
		Click_2.Font = Enum.Font.SourceSans
		Click_2.Text = ""
		Click_2.TextColor3 = Color3.fromRGB(0, 0, 0)
		Click_2.TextSize = 14.000

		Left.Name = "Left"
		Left.Parent = Channel
		Left.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		Left.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Left.BorderSizePixel = 0
		Left.Position = UDim2.new(0, 5, 0, 2)
		Left.ClipsDescendants = true
		Left.Size = UDim2.new(0, 220, 1, -7)

		List_5.Name = "List"
		List_5.Parent = Left
		List_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		List_5.BackgroundTransparency = 1.000
		List_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
		List_5.BorderSizePixel = 0
		List_5.Selectable = false
		List_5.Size = UDim2.new(1, 0, 1, 0)
		List_5.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
		List_5.ScrollBarThickness = 1
		List_5.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Left
		game:GetService("RunService").Stepped:Connect(function()
			pcall(function()
				List_5.CanvasSize = UDim2.new(0,0,0,UIListLayout_22222.AbsoluteContentSize.Y + 20)
			end)
		end)

		UIPadding.Parent = List_5
        UIPadding.PaddingBottom = UDim.new(0, 3)
        UIPadding.PaddingLeft = UDim.new(0, 5)
        UIPadding.PaddingRight = UDim.new(0, 5)
        UIPadding.PaddingTop = UDim.new(0, 3)

		UIListLayout_22222.Parent = List_5
		UIListLayout_22222.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_22222.Padding = UDim.new(0, 5)

		Channel.Name = "Channel"
		Channel.Parent = ChannelContainer
		Channel.BackgroundColor3 = Color3.fromRGB(49, 49, 49)
		Channel.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Channel.BorderSizePixel = 0
		Channel.Size = UDim2.new(1, 0, 1, 0)

		UICorner_8.Parent = Channel

		Right.Name = "Right"
		Right.Parent = Channel
		Right.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
		Right.BorderColor3 = Color3.fromRGB(0, 0, 0)
		Right.BorderSizePixel = 0
		Right.ClipsDescendants = true
		Right.Position = UDim2.new(0, 230, 0, 2)
		Right.Size = UDim2.new(0, 225, 1, -7)

		List_2.Name = "List"
		List_2.Parent = Right
		List_2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		List_2.BackgroundTransparency = 1.000
		List_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
		List_2.BorderSizePixel = 0
		List_2.ClipsDescendants = false
		List_2.Selectable = false
		List_2.Size = UDim2.new(1, 0, 1, 0)
		List_2.ScrollBarThickness = 1
		game:GetService("RunService").Stepped:Connect(function()
			pcall(function()
				List_2.CanvasSize = UDim2.new(0,0,0,UIListLayout_222222.AbsoluteContentSize.Y + 20)
			end)
		end)

		UIPadding2.Parent = List_2
        UIPadding2.PaddingBottom = UDim.new(0, 3)
        UIPadding2.PaddingLeft = UDim.new(0, 5)
        UIPadding2.PaddingRight = UDim.new(0, 5)
        UIPadding2.PaddingTop = UDim.new(0, 3)

		UIListLayout_222222.Parent = List_2
		UIListLayout_222222.SortOrder = Enum.SortOrder.LayoutOrder
		UIListLayout_222222.Padding = UDim.new(0, 5)

		Click_2.MouseButton1Click:Connect(function()
			for i, v in pairs(ChannelContainer:GetChildren()) do
				if v.Name == "Channel" then
					v.Visible = false
				end
				Channel.Visible = true
			end
			for i, v in pairs(List:GetChildren()) do
				for r, b in pairs(v:GetChildren()) do
					if b:IsA("TextLabel") then
						b.TextColor3 = Color3.fromRGB(100, 100, 100)
					end
				end
			end
			for i, v in pairs(List:GetChildren()) do
				if v.Name == "Tab Disable" then
					TweenService:Create(v, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(60, 60, 60)}):Play()
				end
			end
			NameTab_2.TextColor3 = Color3.fromRGB(255, 255, 255)
			TweenService:Create(TabDisable, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(94, 94, 94)}):Play()
			TabDisable.BackgroundColor3 = Color3.fromRGB(89, 89, 89)
		end)

		local defaults = false
		if defaults == false then
			defaults = true
			NameTab_2.TextColor3 = Color3.fromRGB(100, 100, 100)
			ChannelContainer.Visible = true
			TabDisable.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
			Channel.Visible = false
		end
		local TabFunc = {}
		function TabFunc:AddSection(choosetab, ConfigSection)
			ConfigSection = ConfigSection or {}
			ConfigSection.Title = ConfigSection.Title or ""

			local Section = Instance.new("Frame")
			local TopTitle = Instance.new("Frame")
			local Line = Instance.new("Frame")
			local SectionTitle = Instance.new("TextLabel")
			local List_3 = Instance.new("Frame")
			local UIListLayout_2 = Instance.new("UIListLayout")
			local UIPadding_999 = Instance.new("UIPadding")
			local UIPadding_9999 = Instance.new("UIPadding")

			if choosetab == "Left" then
				ParentFeature = List_5
			elseif choosetab == "Right" then
				ParentFeature = List_2
			end

			Section.Name = "Section"
			Section.Parent = ParentFeature
			Section.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
			Section.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Section.BorderSizePixel = 0
			Section.Size = UDim2.new(1, 0, 0, 226)

			TopTitle.Name = "TopTitle"
			TopTitle.Parent = Section
			TopTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			TopTitle.BackgroundTransparency = 1.000
			TopTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			TopTitle.BorderSizePixel = 0
			TopTitle.Size = UDim2.new(1, 0, 0, 35)

			Line.Name = "Line"
			Line.Parent = TopTitle
			Line.BackgroundColor3 = Color3.fromRGB(48, 120, 255)
			Line.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Line.BorderSizePixel = 0
			Line.Position = UDim2.new(0, -3, 0, 0)
			Line.Size = UDim2.new(1, 0, 0, 1)

			SectionTitle.Name = "Section Title"
			SectionTitle.Parent = TopTitle
			SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionTitle.BackgroundTransparency = 1.000
			SectionTitle.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionTitle.BorderSizePixel = 0
			SectionTitle.Size = UDim2.new(1, 0, 1, 0)
			SectionTitle.Font = Enum.Font.GothamBold
			SectionTitle.Text = ConfigSection.Title
			SectionTitle.TextColor3 = Color3.fromRGB(170, 170, 170)
			SectionTitle.TextSize = 12.000
			SectionTitle.TextXAlignment = Enum.TextXAlignment.Left

			UIPadding_999.Parent = TopTitle
			UIPadding_999.PaddingLeft = UDim.new(0, 7)

			List_3.Name = "List"
			List_3.Parent = Section
			List_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			List_3.BackgroundTransparency = 1.000
			List_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
			List_3.BorderSizePixel = 0
			List_3.Position = UDim2.new(0, 0, 0, 35)
			List_3.Size = UDim2.new(1, 0, 1, -62)

			UIListLayout_2.Parent = List_3
			UIListLayout_2.SortOrder = Enum.SortOrder.LayoutOrder
			UIListLayout_2.Padding = UDim.new(0, 3)

			UIPadding_9999.Parent = List_3
			UIPadding_9999.PaddingLeft = UDim.new(0, 3)
			UIPadding_9999.PaddingRight = UDim.new(0, 3)

			local function AdjustSectionHeight()
				local contentHeight = UIListLayout_2.AbsoluteContentSize.Y
				Section.Size = UDim2.new(1, 0, 0, contentHeight + 48)
			end

			UIListLayout_2:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(AdjustSectionHeight)
			AdjustSectionHeight()

			local SectionFunc = {}
			function SectionFunc:AddSeperator(ConfigSeperator)

				local Seperator = Instance.new("Frame")
				local TextLabel = Instance.new("TextLabel")

				Seperator.Name = "Seperator"
				Seperator.Parent = List_3
				Seperator.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Seperator.BackgroundTransparency = 1.000
				Seperator.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Seperator.BorderSizePixel = 0
				Seperator.Size = UDim2.new(1, 0, 0, 45)

				TextLabel.Parent = Seperator
				TextLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.BackgroundTransparency = 1.000
				TextLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
				TextLabel.BorderSizePixel = 0
				TextLabel.Size = UDim2.new(1, 0, 1, 0)
				TextLabel.Font = Enum.Font.GothamBold
				TextLabel.Text = "< " .. ConfigSeperator .. " >"
				TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextLabel.TextSize = 13.000
			end
			function SectionFunc:AddParagraph(ParagraphConfig)
				ParagraphConfig = ParagraphConfig or {}
				ParagraphConfig.Title = ParagraphConfig.Title or ""
				ParagraphConfig.Description = ParagraphConfig.Description or ""

				local Paragraph = Instance.new("Frame")
				local UICorner_35 = Instance.new("UICorner")
				local Title_17 = Instance.new("TextLabel")
				local UIPadding_20 = Instance.new("UIPadding")
				local Desc = Instance.new("TextLabel")
				local UIPadding_21 = Instance.new("UIPadding")
				local ParaFunc = {}

				Paragraph.Name = "Paragraph"
				Paragraph.Parent = List_3
				Paragraph.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
				Paragraph.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Paragraph.BorderSizePixel = 0
				Paragraph.Size = UDim2.new(1, 0, 0, 47)

				UICorner_35.CornerRadius = UDim.new(0, 4)
				UICorner_35.Parent = Paragraph

				Title_17.Name = "Title"
				Title_17.Parent = Paragraph
				Title_17.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title_17.BackgroundTransparency = 1.000
				Title_17.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title_17.BorderSizePixel = 0
				Title_17.Position = UDim2.new(0, 0, 0, 2)
				Title_17.Size = UDim2.new(1, 0, 0, 0)
				Title_17.Font = Enum.Font.GothamBold
				Title_17.Text = ParagraphConfig.Title
				Title_17.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title_17.TextSize = 13.000
				Title_17.TextXAlignment = Enum.TextXAlignment.Left

				UIPadding_20.Parent = Title_17
				UIPadding_20.PaddingLeft = UDim.new(0, 7)

				if ParagraphConfig.Description ~= nil and ParagraphConfig.Description ~= "" then
					Desc.Name = "Desc"
					Desc.Parent = Paragraph
					Desc.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					Desc.BackgroundTransparency = 1.000
					Desc.BorderColor3 = Color3.fromRGB(0, 0, 0)
					Desc.BorderSizePixel = 0
					Desc.Position = UDim2.new(0, 0, 0, 21)
					Desc.Size = UDim2.new(1, 0, 0, 35)
					Desc.Font = Enum.Font.GothamBold
					Desc.Text = ParagraphConfig.Description
					Desc.TextColor3 = Color3.fromRGB(64, 121, 255)
					Desc.TextSize = 12.000
					Desc.TextWrapped = true
					Desc.TextXAlignment = Enum.TextXAlignment.Left
					Desc.TextYAlignment = Enum.TextYAlignment.Top

					UIPadding_21.Parent = Desc
					UIPadding_21.PaddingLeft = UDim.new(0, 7)
					UIPadding_21.PaddingTop = UDim.new(0, 2)
				end

				if ParagraphConfig.Description == nil or ParagraphConfig.Description == "" then
					Paragraph.Size = UDim2.new(1, 0, 0, 20)
				end

				function ParaFunc:SetDesc(accaccacc)
					Desc.Text = accaccacc
				end
				function ParaFunc:SetTitle(aca)
					Title_17.Text = aca
				end
				return ParaFunc
			end
			function SectionFunc:AddButton(ConfigsButton)
				ConfigsButton = ConfigsButton or {}
				ConfigsButton.Name = ConfigsButton.Name or ""
				ConfigsButton.Callback = ConfigsButton.Callback or function() end

				local Button = Instance.new("Frame")
				local UICorner_17 = Instance.new("UICorner")
				local Title_4 = Instance.new("TextLabel")
				local Click_3 = Instance.new("TextButton")

				Button.Name = "Button"
				Button.Parent = List_3
				Button.BackgroundColor3 = Color3.fromRGB(60, 106, 255)
				Button.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Button.BorderSizePixel = 0
				Button.Size = UDim2.new(1, 0, 0, 18)

				UICorner_17.CornerRadius = UDim.new(0, 3)
				UICorner_17.Parent = Button

				Title_4.Name = "Title"
				Title_4.Parent = Button
				Title_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title_4.BackgroundTransparency = 1.000
				Title_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title_4.BorderSizePixel = 0
				Title_4.Size = UDim2.new(1, 0, 1, 0)
				Title_4.Font = Enum.Font.GothamBold
				Title_4.Text = ConfigsButton.Name
				Title_4.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title_4.TextSize = 13.000

				Click_3.Name = "Click"
				Click_3.Parent = Button
				Click_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Click_3.BackgroundTransparency = 1.000
				Click_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Click_3.BorderSizePixel = 0
				Click_3.Size = UDim2.new(1, 0, 1, 0)
				Click_3.Font = Enum.Font.SourceSans
				Click_3.Text = ""
				Click_3.TextColor3 = Color3.fromRGB(0, 0, 0)
				Click_3.TextSize = 14.000
				Click_3.MouseButton1Click:Connect(function()
					Button.BackgroundColor3 = Color3.fromRGB(170, 170, 170)
					TweenService:Create(Button, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(60, 106, 255)}):Play()
					ConfigsButton.Callback()
				end)
			end
			function SectionFunc:AddToggle(ConfigsToggle)
				ConfigsToggle = ConfigsToggle or {}
				ConfigsToggle.Name = ConfigsToggle.Name or ""
				ConfigsToggle.Default = ConfigsToggle.Default or false
				ConfigsToggle.Callback = ConfigsToggle.Callback or function ()
					-- nil
				end

				local Toggle1_2 = Instance.new("Frame")
				local UICorner_24 = Instance.new("UICorner")
				local Title_10 = Instance.new("TextLabel")
				local UIPadding_13 = Instance.new("UIPadding")
				local Check_4 = Instance.new("Frame")
				local UICorner_25 = Instance.new("UICorner")
				local IconCheck_4 = Instance.new("ImageLabel")
				local Click_8 = Instance.new("TextButton")
				local ToggleFunc = {}

				Toggle1_2.Name = "Toggle1"
				Toggle1_2.Parent = List_3
				Toggle1_2.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
				Toggle1_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Toggle1_2.BorderSizePixel = 0
				Toggle1_2.Size = UDim2.new(1, 0, 0, 32)

				UICorner_24.CornerRadius = UDim.new(0, 3)
				UICorner_24.Parent = Toggle1_2

				Title_10.Name = "Title"
				Title_10.Parent = Toggle1_2
				Title_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title_10.BackgroundTransparency = 1.000
				Title_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title_10.BorderSizePixel = 0
				Title_10.Size = UDim2.new(0, 180, 1, 0)
				Title_10.Font = Enum.Font.GothamBold
				Title_10.Text = ConfigsToggle.Name
				Title_10.TextColor3 = Color3.fromRGB(144, 144, 144)
				Title_10.TextSize = 13.000
				Title_10.TextXAlignment = Enum.TextXAlignment.Left

				UIPadding_13.Parent = Title_10
				UIPadding_13.PaddingLeft = UDim.new(0, 7)

				Check_4.Name = "Check"
				Check_4.Parent = Toggle1_2
				Check_4.BackgroundColor3 = Color3.fromRGB(16, 16, 16)
				Check_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Check_4.BorderSizePixel = 0
				Check_4.Position = UDim2.new(0.878504694, 0, 0.1875, 0)
				Check_4.Size = UDim2.new(0, 20, 0, 20)

				UICorner_25.CornerRadius = UDim.new(0, 4)
				UICorner_25.Parent = Check_4

				IconCheck_4.Name = "IconCheck"
				IconCheck_4.Parent = Check_4
				IconCheck_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				IconCheck_4.BackgroundTransparency = 1.000
				IconCheck_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
				IconCheck_4.BorderSizePixel = 0
				IconCheck_4.Position = UDim2.new(0.100000001, 0, 0.100000001, 0)
				IconCheck_4.Size = UDim2.new(0, 15, 0, 15)
				IconCheck_4.Image = "rbxassetid://18779743304"
				IconCheck_4.ImageTransparency = 1.000

				Click_8.Name = "Click"
				Click_8.Parent = Toggle1_2
				Click_8.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Click_8.BackgroundTransparency = 1.000
				Click_8.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Click_8.BorderSizePixel = 0
				Click_8.Size = UDim2.new(1, 0, 1, 0)
				Click_8.Font = Enum.Font.SourceSans
				Click_8.Text = ""
				Click_8.TextColor3 = Color3.fromRGB(0, 0, 0)
				Click_8.TextSize = 14.000


				function ToggleFunc:Set(Value)
					if Value then
						TweenService:Create(Check_4, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(57, 153, 255)}):Play()
						TweenService:Create(IconCheck_4, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 0}):Play()
						Title_10.TextColor3 = Color3.fromRGB(255, 255, 255)
					else
						TweenService:Create(Check_4, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {BackgroundColor3 = Color3.fromRGB(16, 16, 16)}):Play()
						TweenService:Create(IconCheck_4, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {ImageTransparency = 1.000}):Play()
						Title_10.TextColor3 = Color3.fromRGB(170, 170, 170)
					end
					Toggled = Value
					ConfigsToggle.Callback(Toggled)
				end

				Toggled = ConfigsToggle.Default
				ToggleFunc:Set(ConfigsToggle.Default)

				Click_8.MouseButton1Click:Connect(function()
					Toggled = not Toggled
					ToggleFunc:Set(Toggled)
				end)
				return ToggleFunc
			end
			function SectionFunc:AddSlider(ConfigSlider)
				ConfigSlider = ConfigSlider or {}
				ConfigSlider.Name = ConfigSlider.Name or ""
				ConfigSlider.Max = ConfigSlider.Max or 300
				ConfigSlider.Min = ConfigSlider.Min or 100
				ConfigSlider.Default = ConfigSlider.Default or 50
				ConfigSlider.Callback = ConfigSlider.Callback or function() end

				local Slider = Instance.new("Frame")
				local Title_3 = Instance.new("TextLabel")
				local UIPadding_5 = Instance.new("UIPadding")
				local ValueCac = Instance.new("TextBox")
				local UICorner_13 = Instance.new("UICorner")
				local DraggableFrame = Instance.new("Frame")
				local UICorner_14 = Instance.new("UICorner")
				local Draggable = Instance.new("Frame")
				local UICorner_15 = Instance.new("UICorner")
				local Cricle = Instance.new("Frame")
				local UICorner_16 = Instance.new("UICorner")
				local SliderFunc = {Value = ConfigSlider.Default}

				Slider.Name = "Slider"
				Slider.Parent = List_3
				Slider.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
				Slider.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Slider.BorderSizePixel = 0
				Slider.Size = UDim2.new(1, 0, 0, 55)

				Title_3.Name = "Title"
				Title_3.Parent = Slider
				Title_3.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title_3.BackgroundTransparency = 1.000
				Title_3.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title_3.BorderSizePixel = 0
				Title_3.Position = UDim2.new(0, 0, 0, 2)
				Title_3.Size = UDim2.new(0, 170, 0, 20)
				Title_3.Font = Enum.Font.GothamBold
				Title_3.Text = ConfigSlider.Name
				Title_3.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title_3.TextSize = 13.000
				Title_3.TextXAlignment = Enum.TextXAlignment.Left

				UIPadding_5.Parent = Title_3
				UIPadding_5.PaddingLeft = UDim.new(0, 7)
				UIPadding_5.PaddingTop = UDim.new(0, 2)

				ValueCac.Name = "ValueCac"
				ValueCac.Parent = Slider
				ValueCac.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
				ValueCac.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ValueCac.BorderSizePixel = 0
				ValueCac.Position = UDim2.new(1, -53, 0, 4)
				ValueCac.Size = UDim2.new(0, 50, 0, 15)
				ValueCac.Font = Enum.Font.GothamBold
				ValueCac.PlaceholderColor3 = Color3.fromRGB(255, 255, 255)
				ValueCac.Text = ConfigSlider.Default
				ValueCac.TextColor3 = Color3.fromRGB(255, 255, 255)
				ValueCac.TextSize = 13.000

				UICorner_13.Parent = ValueCac

				DraggableFrame.Name = "DraggableFrame"
				DraggableFrame.Parent = Slider
				DraggableFrame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				DraggableFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				DraggableFrame.BorderSizePixel = 0
				DraggableFrame.Position = UDim2.new(0.0233644862, 0, 0.545454562, 0)
				DraggableFrame.Size = UDim2.new(0, 203, 0, 4)

				UICorner_14.Parent = DraggableFrame

				Draggable.Name = "Draggable"
				Draggable.Parent = DraggableFrame
				Draggable.BackgroundColor3 = Color3.fromRGB(71, 142, 255)
				Draggable.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Draggable.BorderSizePixel = 0
				Draggable.Size = UDim2.new(0, 101, 0, 4)

				UICorner_15.Parent = Draggable

				Cricle.Name = "Cricle"
				Cricle.Parent = Draggable
				Cricle.AnchorPoint = Vector2.new(1, 0.5)
				Cricle.BackgroundColor3 = Color3.fromRGB(71, 142, 255)
				Cricle.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Cricle.BorderSizePixel = 0
				Cricle.Position = UDim2.new(1.079, -2, 0.5, -1)
				Cricle.Size = UDim2.new(0, 15, 0, 15)

				UICorner_16.CornerRadius = UDim.new(1, 0)
				UICorner_16.Parent = Cricle

				local Dragging = false
				local function Round(Number, Factor)
					local Result = math.floor(Number/Factor + (math.sign(Number) * 0.5)) * Factor
					if Result < 0 then Result = Result + Factor end
					return Result
				end
				function SliderFunc:Set(Value)
					Value = math.clamp(Round(Value, 1), ConfigSlider.Min, ConfigSlider.Max)
					SliderFunc.Value = Value
					ValueCac.Text = tostring(Value)
					TweenService:Create(
						Draggable,
						TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{Size = UDim2.fromScale((Value - ConfigSlider.Min) / (ConfigSlider.Max - ConfigSlider.Min), 1)}
					):Play()
				end
				DraggableFrame.InputBegan:Connect(function(Input)
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then 
						Dragging = true 
					end 
				end)
				DraggableFrame.InputEnded:Connect(function(Input) 
					if Input.UserInputType == Enum.UserInputType.MouseButton1 then 
						Dragging = false 
						ConfigSlider.Callback(SliderFunc.Value)
					end 
				end)
				uis.InputChanged:Connect(function(Input)
					if Dragging and Input.UserInputType == Enum.UserInputType.MouseMovement then 
						local SizeScale = math.clamp((Input.Position.X - DraggableFrame.AbsolutePosition.X) / DraggableFrame.AbsoluteSize.X, 0, 1)
						SliderFunc:Set(ConfigSlider.Min + ((ConfigSlider.Max - ConfigSlider.Min) * SizeScale)) 
					end
				end)
				ValueCac:GetPropertyChangedSignal("Text"):Connect(function()
					local Valid = ValueCac.Text:gsub("[^%d]", "")
					if Valid ~= "" then
						local ValidNumber = math.min(tonumber(Valid), ConfigSlider.Max)
						ValueCac.Text = tostring(ValidNumber)
					else
						ValueCac.Text = tostring(Valid)
					end
				end)
				ValueCac.FocusLost:Connect(function()
					if ValueCac.Text ~= "" then
						SliderFunc:Set(tonumber(ValueCac.Text))
					else
						SliderFunc:Set(0)
					end
				end)
				SliderFunc:Set(tonumber(ConfigSlider.Default))

			end
			function SectionFunc:AddDropdown(ConfigDropDown)
				ConfigDropDown = ConfigDropDown or {}
				ConfigDropDown.Name = ConfigDropDown.Name or ""
				ConfigDropDown.Options = ConfigDropDown.Options or {}
				ConfigDropDown.Default = ConfigDropDown.Default or ""
				ConfigDropDown.Callback = ConfigDropDown.Callback or function() end

				local Dropdown = Instance.new("Frame")
				local UICorner_18 = Instance.new("UICorner")
				local Title_5 = Instance.new("TextLabel")
				local UIPadding_6 = Instance.new("UIPadding")
				local Icon = Instance.new("ImageLabel")
				local ListFrame = Instance.new("Frame")
				local List_4 = Instance.new("ScrollingFrame")
				local UIPadding_7 = Instance.new("UIPadding")
				local Click_10 = Instance.new("TextButton")
				local UIListLayout_3 = Instance.new("UIListLayout")
				local DropFunc = {}

				Dropdown.Name = "Dropdown"
				Dropdown.Parent = List_3
				Dropdown.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
				Dropdown.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Dropdown.BorderSizePixel = 0
				Dropdown.ClipsDescendants = true
				Dropdown.Position = UDim2.new(0, 0, 00.583766228, 0)
				Dropdown.Size = UDim2.new(1, 0, 0, 35)

				UICorner_18.CornerRadius = UDim.new(0, 3)
				UICorner_18.Parent = Dropdown

				Title_5.Name = "Title"
				Title_5.Parent = Dropdown
				Title_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Title_5.BackgroundTransparency = 1.000
				Title_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Title_5.BorderSizePixel = 0
				Title_5.Size = UDim2.new(0, 190, 0, 35)
				Title_5.Font = Enum.Font.GothamBold
				Title_5.Text = ConfigDropDown.Name .. " : " .. ConfigDropDown.Default
				Title_5.TextColor3 = Color3.fromRGB(255, 255, 255)
				Title_5.TextSize = 13.000
				Title_5.TextXAlignment = Enum.TextXAlignment.Left

				UIPadding_6.Parent = Title_5
				UIPadding_6.PaddingLeft = UDim.new(0, 7)

				Icon.Name = "Icon"
				Icon.Parent = Dropdown
				Icon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Icon.BackgroundTransparency = 1.000
				Icon.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Icon.BorderSizePixel = 0
				Icon.Position = UDim2.new(1, -23, 0, 10)
				Icon.Rotation = -90.000
				Icon.Size = UDim2.new(0, 15, 0, 15)
				Icon.Image = "rbxassetid://18765551159"

				ListFrame.Name = "ListFrame"
				ListFrame.Parent = Dropdown
				ListFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ListFrame.BackgroundTransparency = 1.000
				ListFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
				ListFrame.BorderSizePixel = 0
				ListFrame.Position = UDim2.new(0, 0, 0, 35)
				ListFrame.Size = UDim2.new(1, 0, 0, 77)

				List_4.Name = "List_4"
				List_4.Parent = ListFrame
				List_4.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				List_4.BackgroundTransparency = 1.000
				List_4.BorderColor3 = Color3.fromRGB(0, 0, 0)
				List_4.BorderSizePixel = 0
				List_4.Selectable = false
				List_4.Size = UDim2.new(1, 0, 1, 0)
				List_4.CanvasSize = UDim2.new(2, 0, 0, 0)
				List_4.ScrollBarThickness = 0
				game:GetService("RunService").Stepped:Connect(function()
					pcall(function()
						List_4.CanvasSize = UDim2.new(0,0,0,UIListLayout_3.AbsoluteContentSize.Y + 20)
					end)
				end)

				UIPadding_7.Parent = List_4
				UIPadding_7.PaddingLeft = UDim.new(0, 4)
				UIPadding_7.PaddingRight = UDim.new(0, 4)
				UIPadding_7.PaddingTop = UDim.new(0, 7)

				UIListLayout_3.Parent = List_4
				UIListLayout_3.SortOrder = Enum.SortOrder.LayoutOrder
				UIListLayout_3.Padding = UDim.new(0, 5)

				Click_10.Name = "Click"
				Click_10.Parent = Dropdown
				Click_10.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Click_10.BackgroundTransparency = 1.000
				Click_10.BorderColor3 = Color3.fromRGB(0, 0, 0)
				Click_10.BorderSizePixel = 0
				Click_10.Size = UDim2.new(1, 0, 0, 35)
				Click_10.Font = Enum.Font.SourceSans
				Click_10.Text = ""
				Click_10.TextColor3 = Color3.fromRGB(0, 0, 0)
				Click_10.TextSize = 14.000

				local Dropped = false
				function DropFunc:Add(ac)
					for i, v in next, ac do
						local Option1 = Instance.new("Frame")
						local UICorner_20 = Instance.new("UICorner")
						local Title_7 = Instance.new("TextLabel")
						local UIPadding_9 = Instance.new("UIPadding")
						local Click_5 = Instance.new("TextButton")

						Option1.Name = "Option 1"
						Option1.Parent = List_4
						Option1.BackgroundColor3 = Color3.fromRGB(87, 140, 255)
						Option1.BackgroundTransparency = 1.000
						Option1.BorderColor3 = Color3.fromRGB(0, 0, 0)
						Option1.BorderSizePixel = 0
						Option1.Position = UDim2.new(-0.0327102803, 0, 0.0571428575, 0)
						Option1.Size = UDim2.new(1, 0, 0, 20)

						UICorner_20.CornerRadius = UDim.new(0, 4)
						UICorner_20.Parent = Option1

						Title_7.Name = "Title"
						Title_7.Parent = Option1
						Title_7.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						Title_7.BackgroundTransparency = 1.000
						Title_7.BorderColor3 = Color3.fromRGB(0, 0, 0)
						Title_7.BorderSizePixel = 0
						Title_7.Size = UDim2.new(1, 0, 1, 0)
						Title_7.Font = Enum.Font.GothamBold
						Title_7.Text = tostring(v)
						Title_7.TextColor3 = Color3.fromRGB(255, 255, 255)
						Title_7.TextSize = 13.000
						Title_7.TextXAlignment = Enum.TextXAlignment.Left

						UIPadding_9.Parent = Title_7
						UIPadding_9.PaddingLeft = UDim.new(0, 7)

						Click_5.Name = "Click"
						Click_5.Parent = Option1
						Click_5.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						Click_5.BackgroundTransparency = 1.000
						Click_5.BorderColor3 = Color3.fromRGB(0, 0, 0)
						Click_5.BorderSizePixel = 0
						Click_5.Size = UDim2.new(1, 0, 1, 0)
						Click_5.Font = Enum.Font.SourceSans
						Click_5.Text = ""
						Click_5.TextColor3 = Color3.fromRGB(0, 0, 0)
						Click_5.TextSize = 14.000

						Click_5.MouseButton1Click:Connect(function()
							for i, v in next, List_4:GetChildren() do
								if v:IsA("Frame") then
									v.BackgroundTransparency = 1.000
								end
							end
							Option1.BackgroundTransparency = 0
							Dropdown:TweenSize(UDim2.new(1, 0, 0, 35),"Out","Quad",.3,true)
							TweenService:Create(Icon, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = -180.000}):Play()
							Dropped = false
							Title_5.Text = ConfigDropDown.Name .. " : " .. Title_7.Text
							ConfigDropDown.Callback(Title_7.Text)
						end)
					end
				end

				function DropFunc:Set(acc)
					for i, v in pairs(List_4:GetChildren()) do
						if v.Name == "Option 1" then
							if v.Title_7.Text == acc then
								Dropdown:TweenSize(UDim2.new(1, 0, 0., 35),"Out","Quad",.3,true)
								Dropped = false
								TweenService:Create(Icon, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = -180.000}):Play()
								Title_17.Text = ConfigDropDown.Name .. " : " .. v.Title_7.Text
								ConfigDropDown.Callback(v.Title_7.Text)
							end
						end
					end
				end

				function DropFunc:Refresh(Option)
					for i, v in pairs(List_4:GetChildren()) do
						if v.Name == "Option 1" then
							v:Destroy()
						end
					end
					Dropped = false
					DropFunc:Add(Option)
					Title_17.Text = ConfigDropDown.Name .. " :"
				end

				Click_10.MouseButton1Click:Connect(function()
					if Dropped == false then
						TweenService:Create(Icon, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = -90.000}):Play()
						Dropdown:TweenSize(UDim2.new(1, 0, 0.35, 35),"Out","Quad",.3,true)
						Dropped = true
					else
						Dropdown:TweenSize(UDim2.new(1, 0, 0, 35),"Out","Quad",.3,true)
						TweenService:Create(Icon, TweenInfo.new(.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {Rotation = -180.000}):Play()
						Dropped = false
					end
				end)

				DropFunc:Refresh(ConfigDropDown.Options)
				ConfigDropDown.Callback(ConfigDropDown.Default)
				return DropFunc
			end
			return SectionFunc
		end
		return TabFunc
	end
	return AddTabFunc
end

return Andz
