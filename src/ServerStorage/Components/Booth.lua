local booth = {}

local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ChatService = game:GetService("Chat")

local tweenInfo = TweenInfo.new(
	2.5, 
	Enum.EasingStyle.Bounce, 
	Enum.EasingDirection.Out, 
	-1,  
	true, 
	1
)

function booth.new(object)
	local self = {}
	setmetatable(self, {__index = booth}) 

	local ProximityPrompt = Instance.new("ProximityPrompt") 
	ProximityPrompt.Enabled = true
	ProximityPrompt.HoldDuration = 0.3
	ProximityPrompt.ActionText = "Claim Booth"
	ProximityPrompt.Parent = object.ProxPart 

	local SurfaceGui = Instance.new("SurfaceGui") 
	SurfaceGui.Face = "Back"
	SurfaceGui.Enabled = true
	SurfaceGui.Parent = object.Header 

	local FrameGui = Instance.new("Frame")  
	FrameGui.Size = UDim2.new(1, 0, 1, 0)
	FrameGui.BackgroundTransparency = 1
	FrameGui.Parent = SurfaceGui

	local TextGui = Instance.new("TextLabel") 
	TextGui.Name = "TextGui"
	TextGui.Size = UDim2.new(1, 0, 1, 0)
	TextGui.Font = Enum.Font.FredokaOne
	TextGui.BackgroundTransparency = 1
	TextGui.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	TextGui.TextColor3 = Color3.fromRGB(255, 255, 255)
	TextGui.Text = "Empty"
	TextGui.TextScaled = true
	TextGui.Parent = FrameGui

	local BillboardGui = Instance.new("BillboardGui")
	BillboardGui.Size = UDim2.new(1, 0, 1.2, 0)
	BillboardGui.StudsOffset = Vector3.new(-1.5, 5, 0)
	BillboardGui.Parent = object.Header

	local BillboardText = Instance.new("TextLabel")
	BillboardText.Name = "OwnerText"
	BillboardText.Size = UDim2.new(4, 0, 1, 0)
	BillboardText.Font = Enum.Font.FredokaOne
	BillboardText.TextStrokeTransparency = 0.9
	BillboardText.TextColor3 = Color3.fromRGB(255, 255, 255)
	BillboardText.Text = "Claim Booth!"
	BillboardText.TextScaled = true
	BillboardText.BackgroundTransparency = 1
	BillboardText.Parent = BillboardGui

	local Claimed = Instance.new("ObjectValue")
	Claimed.Value = nil
	Claimed.Parent = object

	local Tween = TweenService:Create(BillboardText, tweenInfo, { Size = UDim2.new(3.5, 0, 4, 0) })
	Tween:Play()

	self.SurfaceGui = SurfaceGui
	self.BillboardGui = BillboardGui
	self.ProximityPrompt = ProximityPrompt
	self.Owner = Claimed
	self.TextAnimation = Tween
	self.Model = object
	self.BoothText = TextGui

	return self
end

function booth:claim(player)

	if self.Owner.Value == nil then
		local ownerText = self.BillboardGui.OwnerText
		ownerText.Text = "Owned by:  " .. player.Name
		ownerText.TextColor3 = Color3.fromRGB(203, 203, 203)

		self.TextAnimation:Cancel()
		self.ProximityPrompt.ActionText = "Edit"
		self.Owner.Value = player
	else
		return false
	end
end

function booth:reset()
	local ownerText = self.BillboardGui.OwnerText
	ownerText.Text = "Claim Booth!"
	ownerText.TextColor3 = Color3.fromRGB(255, 255, 255)

	self.Owner.Value = nil
	self.TextAnimation:Play()
	self.ProximityPrompt.ActionText = "Claim Booth"
	print("Booth has been reset ", self.Model)
end

function booth:setName(text)
	if self.Owner.Value then
		local FilteredText = ChatService:FilterStringForBroadcast(text, self.Owner.Value)
		self.BoothText.Text = FilteredText

		return FilteredText
	end
end

return booth