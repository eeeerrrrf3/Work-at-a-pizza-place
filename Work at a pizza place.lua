local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Robojini/Tuturial_UI_Library/main/UI_Template_1"))()

local Window = Library.CreateLib("Topikhub", "RJTheme3")

local Tab = Window:NewTab("Hub free")

local Section = Tab:NewSection("Top scripts")

Section:NewButton("click tp", "Left CTRL + Click", function()
    local Player = game.Players.LocalPlayer 
local Mouse = Player:GetMouse() 
local UserInputService = game:GetService('UserInputService') 
 
local HoldingControl = false 
 
Mouse.Button1Down:connect(function() 
if HoldingControl then 
Player.Character:MoveTo(Mouse.Hit.p) 
end 
end) 
 
UserInputService.InputBegan:connect(function(Input, Processed) 
if Input.UserInputType == Enum.UserInputType.Keyboard then 
if Input.KeyCode == Enum.KeyCode.LeftControl then 
HoldingControl = true 
elseif Input.KeyCode == Enum.KeyCode.RightControl then 
HoldingControl = true 
end 
end 
end) 
 
UserInputService.InputEnded:connect(function(Input, Processed) 
if Input.UserInputType == Enum.UserInputType.Keyboard then 
if Input.KeyCode == Enum.KeyCode.LeftControl then 
HoldingControl = false 
elseif Input.KeyCode == Enum.KeyCode.RightControl then 
HoldingControl = false
end 
end
end)
end)

Section:NewButton("Auto Farm", "ButtonInfo", function()
    getupvalues = getupvalues or debug.getupvalues
setupvalue = setupvalue or debug.setupvalue
if not (getrawmetatable and getupvalues and setupvalue and (getreg or debug.getregistry)) then
	local h = Instance.new("Hint",workspace)
	h.Text = "Incompatible exploit."
	wait(3)
	h:Destroy()
	return
end
local settings = {refill_at=0, refill_end=60, deliver_at=24, stay_in_kitchen=true}
local doCashier,doBoxer,doCook,doSupplier,doDelivery = true,true,true,true,true
if readfile then
	pcall(function()
		local new = game:GetService("HttpService"):JSONDecode(readfile("PizzaFarm.txt"))
		--corruption?
		local doOverwrite=false
		for k,v in pairs(new) do
			if settings[k]==nil then
				doOverwrite=true
				new[k]=nil
			end
		end
		for k,v in pairs(settings) do
			if new[k]==nil then
				doOverwrite=true
				new[k]=v
			end
		end
		--use input
		if doOverwrite then
			warn("Settings overwritten")
			writefile("PizzaFarm.txt",game:GetService("HttpService"):JSONEncode(new))
		end
		settings = new
	end)
end

if getconnections then
	for _,c in next,getconnections(game:GetService("ScriptContext").Error) do
		c:Disable()
	end
end

local player = game:GetService("Players").LocalPlayer
local ffc = game.FindFirstChild
local RNG = Random.new()
local network
local character,root,humanoid
do
	local reg = (getreg or debug.getregistry)()
	for i=1,#reg do
		local f = reg[i]
		if type(f)=="function" then
		    for k,v in next,getupvalues(f) do
				if typeof(v)=="Instance" then
				    if v.Name=="CashOut" then
					    setupvalue(f,k,{MouseButton1Click={wait=function()end,Wait=function()end}})
				    elseif v.Name=="StickerName" then
				        setupvalue(f,k,nil)
				    end
				end
			end
    		if tostring(getfenv(f).script) == "Music" then
    		    local consts = getconstants(f)
    		    local loc=false
		        for ci,c in next,consts do
		            if c == "location changed" then
		                loc=true
		            elseif loc and c == "SendData" then
		                setconstant(f,ci,"ExplodeString")
		                break
		            end
		        end
    		end
		elseif type(f)=="table" and rawget(f,"FireServer") and rawget(f,"BindEvents") then
			network = f
		end
	end
end
assert(network,"failed to find network")
--//gui
Create = function(class,parent,props)
	local new = Instance.new(class)
	for k,v in next,props do
		new[k]=v
	end
	new.Parent = parent
	return new
end
gui=Create("ScreenGui",game.CoreGui,{Name="Farm", ZIndexBehavior="Sibling"})
main=Create("Frame",gui,{Name="main", Draggable=true, Active=true, Size=UDim2.new(0,350,0,100), Position=UDim2.new(.335,0,0.02,0), BackgroundColor3=Color3.new(0.098,0.098,0.098)})
topbar=Create("Frame",main,{Name="topbar", Size=UDim2.new(1,0,0.15,0), BackgroundColor3=Color3.new(0.255,0.255,0.255)})
closeBtn=Create("TextButton",topbar,{Name="closeBtn", TextWrapped=true, Size=UDim2.new(0.03,0,1,0), TextColor3=Color3.new(1,1,1), Text="X", BackgroundTransparency=1, 
	Font="GothamSemibold", Position=UDim2.new(0.96,0,0,0), TextSize=14, TextScaled=true, BackgroundColor3=Color3.new(1,1,1)})
titleLbl=Create("TextLabel",topbar,{Name="titleLbl", TextWrapped=true, Size=UDim2.new(0.5,0,1,0), Text="Pizza Factory", TextSize=14, Font="GothamSemibold", 
	BackgroundTransparency=1, Position=UDim2.new(0.25,0,0,0), TextColor3=Color3.new(1,1,1), BackgroundColor3=Color3.new(1,1,1)})
saveBtn=Create("ImageButton",topbar,{Name="saveBtn", Image="rbxassetid://55687833", Size=UDim2.new(0.05,0,1,0), Position=UDim2.new(0.01,0,0,0), BackgroundTransparency=1, BackgroundColor3=Color3.new(), Visible=writefile~=nil})
settings_1=Create("Frame",main,{Name="settings", BackgroundTransparency=1, Size=UDim2.new(0.97,0,0.75,0), Position=UDim2.new(0.025,0,0.2,0), BackgroundColor3=Color3.new(1,1,1)})
Layout=Create("UIGridLayout",settings_1,{VerticalAlignment="Center", SortOrder="LayoutOrder", HorizontalAlignment="Center", CellPadding=UDim2.new(0.01,0,0.1,0), CellSize=UDim2.new(0.325,0,0.26,0)})
cashier=Create("Frame",settings_1,{Name="cashier", LayoutOrder=4, BackgroundTransparency=1, Size=UDim2.new(0,100,0,100), BackgroundColor3=Color3.new(1,1,1)})
Label=Create("TextLabel",cashier,{TextWrapped=true, Size=UDim2.new(0.6,0,1,0), Text="Cashier", TextSize=14, TextXAlignment="Left", Font="SourceSans", 
	BackgroundTransparency=1, Position=UDim2.new(0.4,0,0,0), TextColor3=Color3.new(1,1,1), TextScaled=true, BackgroundColor3=Color3.new(1,1,1)})
cashierBtn=Create("ImageButton",cashier,{Name="cashierBtn", ImageTransparency=1, BorderSizePixel=0, Size=UDim2.new(0.38,0,1,0), BackgroundColor3=Color3.new(0.392,0.392,0.392)})
cashierSlider=Create("Frame",cashierBtn,{Name="slider", Size=UDim2.new(0.5,-4,1,-4), Position=UDim2.new(doCashier and 0.5 or 0,2,0,2), BorderSizePixel=0, BackgroundColor3=Color3.new(0.784,0.784,0.784)})
kitchen=Create("Frame",settings_1,{Name="kitchen", LayoutOrder=9, BackgroundTransparency=1, Size=UDim2.new(0,100,0,100), BackgroundColor3=Color3.new(1,1,1)})
Label_2=Create("TextLabel",kitchen,{TextWrapped=true, Size=UDim2.new(0.6,0,1,0), Text="Deliver At:", TextSize=14, TextXAlignment="Right", Font="SourceSans", 
	BackgroundTransparency=1, TextColor3=Color3.new(1,1,1), TextScaled=true, BackgroundColor3=Color3.new(1,1,1)})
deliverAtBox=Create("TextBox",kitchen,{Name="deliverAtBox", TextWrapped=true, Size=UDim2.new(0.25,0,1,0), Text=tostring(settings.deliver_at), TextSize=50, TextColor3=Color3.new(), 
	Font="Code", Position=UDim2.new(0.62,0,0,0), TextScaled=true, BackgroundColor3=Color3.new(0.784,0.784,0.784)})
refillEnd=Create("Frame",settings_1,{Name="refillEnd", LayoutOrder=8, BackgroundTransparency=1, Size=UDim2.new(0,100,0,100), BackgroundColor3=Color3.new(1,1,1)})
refillEndBox=Create("TextBox",refillEnd,{Name="refillEndBox", TextWrapped=true, Size=UDim2.new(0.25,0,1,0), Text=tostring(settings.refill_end), TextSize=50, TextColor3=Color3.new(), 
	Font="Code", Position=UDim2.new(0.62,0,0,0), TextScaled=true, BackgroundColor3=Color3.new(0.784,0.784,0.784)})
Label_3=Create("TextLabel",refillEnd,{TextWrapped=true, Size=UDim2.new(0.6,0,1,0), Text="Refill End:", TextSize=14, TextXAlignment="Right", Font="SourceSans", 
	BackgroundTransparency=1, TextColor3=Color3.new(1,1,1), TextScaled=true, BackgroundColor3=Color3.new(1,1,1)})
refillAt=Create("Frame",settings_1,{Name="refillAt", LayoutOrder=7, BackgroundTransparency=1, Size=UDim2.new(0,100,0,100), BackgroundColor3=Color3.new(1,1,1)})
Label_4=Create("TextLabel",refillAt,{TextWrapped=true, Size=UDim2.new(0.5,0,1,0), Text="Refill At:", TextSize=14, TextXAlignment="Right", Font="SourceSans", 
	BackgroundTransparency=1, TextColor3=Color3.new(1,1,1), TextScaled=true, BackgroundColor3=Color3.new(1,1,1)})
refillAtBox=Create("TextBox",refillAt,{Name="refillAtBox", TextWrapped=true, Size=UDim2.new(0.25,0,1,0), Text=tostring(settings.refill_at), TextSize=50, TextColor3=Color3.new(), 
	Font="Code", Position=UDim2.new(0.52,0,0,0), TextScaled=true, BackgroundColor3=Color3.new(0.784,0.784,0.784)})
supplier=Create("Frame",settings_1,{Name="supplier", LayoutOrder=6, BackgroundTransparency=1, Size=UDim2.new(0,100,0,100), BackgroundColor3=Color3.new(1,1,1)})
Label_5=Create("TextLabel",supplier,{TextWrapped=true, Size=UDim2.new(0.6,0,1,0), Text="Supplier", TextSize=14, TextXAlignment="Left", Font="SourceSans", 
	BackgroundTransparency=1, Position=UDim2.new(0.4,0,0,0), TextColor3=Color3.new(1,1,1), TextScaled=true, BackgroundColor3=Color3.new(1,1,1)})
supplierBtn=Create("ImageButton",supplier,{Name="supplierBtn", ImageTransparency=1, BorderSizePixel=0, Size=UDim2.new(0.38,0,1,0), BackgroundColor3=Color3.new(0.392,0.392,0.392)})
supplierSlider=Create("Frame",supplierBtn,{Name="slider", Size=UDim2.new(0.5,-4,1,-4), Position=UDim2.new(doSupplier and 0.5 or 0,2,0,2), BorderSizePixel=0, BackgroundColor3=Color3.new(0.784,0.784,0.784)})
delivery=Create("Frame",settings_1,{Name="delivery", LayoutOrder=5, BackgroundTransparency=1, Size=UDim2.new(0,100,0,100), BackgroundColor3=Color3.new(1,1,1)})
Label_6=Create("TextLabel",delivery,{TextWrapped=true, Size=UDim2.new(0.6,0,1,0), Text="Delivery", TextSize=14, TextXAlignment="Left", Font="SourceSans", 
	BackgroundTransparency=1, Position=UDim2.new(0.4,0,0,0), TextColor3=Color3.new(1,1,1), TextScaled=true, BackgroundColor3=Color3.new(1,1,1)})
deliveryBtn=Create("ImageButton",delivery,{Name="deliveryBtn", ImageTransparency=1, BorderSizePixel=0, Size=UDim2.new(0.38,0,1,0), BackgroundColor3=Color3.new(0.392,0.392,0.392)})
deliverySlider=Create("Frame",deliveryBtn,{Name="slider", Size=UDim2.new(0.5,-4,1,-4), Position=UDim2.new(doDelivery and 0.5 or 0,2,0,2), BorderSizePixel=0, BackgroundColor3=Color3.new(0.784,0.784,0.784)})
boxer=Create("Frame",settings_1,{Name="boxer", LayoutOrder=2, BackgroundTransparency=1, Size=UDim2.new(0,100,0,100), BackgroundColor3=Color3.new(1,1,1)})
boxerLbl=Create("TextLabel",boxer,{TextWrapped=true, Size=UDim2.new(0.6,0,1,0), Text="Boxer", TextSize=14, TextXAlignment="Left", Font="SourceSans", 
	BackgroundTransparency=1, Position=UDim2.new(0.4,0,0,0), TextColor3=Color3.new(1,1,1), TextScaled=true, BackgroundColor3=Color3.new(1,1,1)})
boxerBtn=Create("ImageButton",boxer,{Name="boxerBtn", ImageTransparency=1, BorderSizePixel=0, Size=UDim2.new(0.38,0,1,0), BackgroundColor3=Color3.new(0.392,0.392,0.392)})
boxerSlider=Create("Frame",boxerBtn,{Name="slider", Size=UDim2.new(0.5,-4,1,-4), Position=UDim2.new(doBoxer and 0.5 or 0,2,0,2), BorderSizePixel=0, BackgroundColor3=Color3.new(0.784,0.784,0.784)})
cook=Create("Frame",settings_1,{Name="cook", LayoutOrder=3, BackgroundTransparency=1, Size=UDim2.new(0,100,0,100), BackgroundColor3=Color3.new(1,1,1)})
cookLbl=Create("TextLabel",cook,{TextWrapped=true, Size=UDim2.new(0.6,0,1,0), Text="Cook", TextSize=14, TextXAlignment="Left", Font="SourceSans", 
	BackgroundTransparency=1, Position=UDim2.new(0.4,0,0,0), TextColor3=Color3.new(1,1,1), TextScaled=true, BackgroundColor3=Color3.new(1,1,1)})
cookBtn=Create("ImageButton",cook,{Name="cookBtn", ImageTransparency=1, BorderSizePixel=0, Size=UDim2.new(0.38,0,1,0), BackgroundColor3=Color3.new(0.392,0.392,0.392)})
cookSlider=Create("Frame",cookBtn,{Name="slider", Size=UDim2.new(0.5,-4,1,-4), Position=UDim2.new(doCook and 0.5 or 0,2,0,2), BorderSizePixel=0, BackgroundColor3=Color3.new(0.784,0.784,0.784)})
toggleAll=Create("Frame",settings_1,{Name="toggleAll", LayoutOrder=1, BackgroundTransparency=1, Size=UDim2.new(0,100,0,100), BackgroundColor3=Color3.new(1,1,1)})
switch=Create("Frame",toggleAll,{Name="switch", BackgroundTransparency=1, Size=UDim2.new(0.75,0,1,0), BackgroundColor3=Color3.new(1,1,1)})
allOffBtn=Create("ImageButton",switch,{Name="allOffBtn", ImageTransparency=1, BorderSizePixel=0, Size=UDim2.new(0.5,0,1,0), BackgroundColor3=Color3.new(0.235,0.235,0.235)})
allOnBtn=Create("ImageButton",switch,{Name="allOnBtn", ImageTransparency=1, BorderSizePixel=0, Size=UDim2.new(0.5,0,1,0), Position=UDim2.new(0.5,0,0,0), BackgroundColor3=Color3.new(0.333,0.333,0.333)})
toggleAllSlider=Create("Frame",switch,{Name="slider", Size=UDim2.new(0.1,0,1,4), Position=UDim2.new(0.45,0,0,-2), BorderSizePixel=0, BackgroundColor3=Color3.new(0.784,0.784,0.784)})
messageLbl=Create("TextLabel",topbar,{Name="messageLbl", Size=UDim2.new(0.5,0,1,0), Text="Saved.", TextSize=14, Font="GothamSemibold", BackgroundTransparency=1, 
	Position=UDim2.new(0.07,0,0,0), TextColor3=Color3.new(1,1,1), Visible=false, TextXAlignment="Left"})
camframe=Create("Frame",gui,{Name="camframe", BackgroundTransparency=1, Size=UDim2.new(0,120,0,40), Position=UDim2.new(0.5,-320,0,-38), BackgroundColor3=Color3.new(0.118,0.118,0.118)})
rightCamBtn=Create("ImageButton",camframe,{Name="rightCamBtn", Image="rbxassetid://144168163", Size=UDim2.new(0.333,0,1,0), Rotation=180, Position=UDim2.new(0.666,0,0,0), BackgroundTransparency=1, 
	BackgroundColor3=Color3.new(1,1,1)})
leftCamBtn=Create("ImageButton",camframe,{Name="leftCamBtn", Image="rbxassetid://144168163", Size=UDim2.new(0.333,0,1,0), BackgroundTransparency=1, BackgroundColor3=Color3.new(1,1,1)})
centerCamBtn=Create("ImageButton",camframe,{Name="centerCamBtn", Image="rbxassetid://58282192", Size=UDim2.new(0.333,0,1,0), Position=UDim2.new(0.333,0,0,0), BackgroundTransparency=1, BackgroundColor3=Color3.new(1,1,1)})
creditLbl=Create("TextLabel",main,{Position=UDim2.new(0,0,1,5),Size=UDim2.new(0,100,0,15),BackgroundTransparency=1,TextColor3=Color3.new(1,1,1),Text="by Topikhub",TextScaled=true,TextStrokeTransparency=.8})

local function toggleCashier(bool)
	if bool~=nil then
		doCashier=bool
	else
		doCashier = not doCashier
	end
	cashierSlider:TweenPosition(UDim2.new(doCashier and 0.5 or 0,2,0,2),nil,"Sine",0.1,true)
end
local function toggleCook(bool)
	if bool~=nil then
		doCook=bool
	else
		doCook = not doCook
	end
	cookSlider:TweenPosition(UDim2.new(doCook and 0.5 or 0,2,0,2),nil,"Sine",0.1,true)
end
local function toggleBoxer(bool)
	if bool~=nil then
		doBoxer=bool
	else
		doBoxer = not doBoxer
	end
	boxerSlider:TweenPosition(UDim2.new(doBoxer and 0.5 or 0,2,0,2),nil,"Sine",0.1,true)
end
local function toggleDelivery(bool)
	if bool~=nil then
		doDelivery=bool
	else
		doDelivery = not doDelivery
	end
	deliverySlider:TweenPosition(UDim2.new(doDelivery and 0.5 or 0,2,0,2),nil,"Sine",0.1,true)
end
local function toggleSupplier(bool)
	if bool~=nil then
		doSupplier=bool
	else
		doSupplier = not doSupplier
	end
	supplierSlider:TweenPosition(UDim2.new(doSupplier and 0.5 or 0,2,0,2),nil,"Sine",0.1,true)
end
cashierBtn.MouseButton1Click:Connect(toggleCashier)
cookBtn.MouseButton1Click:Connect(toggleCook)
boxerBtn.MouseButton1Click:Connect(toggleBoxer)
deliveryBtn.MouseButton1Click:Connect(toggleDelivery)
supplierBtn.MouseButton1Click:Connect(toggleSupplier)
allOffBtn.InputBegan:Connect(function()
	if game:GetService("UserInputService"):IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
		toggleCashier(false)
		toggleCook(false)
		toggleBoxer(false)
		toggleDelivery(false)
		toggleSupplier(false)
		toggleAllSlider:TweenPosition(UDim2.new(0,0,0,-2),nil,"Sine",0.1,true)
		wait(1)
		if toggleAllSlider.Position.X.Scale<.01 then
			toggleAllSlider:TweenPosition(UDim2.new(0.45,0,0,-2),nil,"Sine",0.1,true)
		end
	end
end)
allOnBtn.InputBegan:Connect(function()
	if game:GetService("UserInputService"):IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
		toggleCashier(true)
		toggleCook(true)
		toggleBoxer(true)
		toggleDelivery(true)
		toggleSupplier(true)
		toggleAllSlider:TweenPosition(UDim2.new(0.9,0,0,-2),nil,"Sine",0.1,true)
		wait(1)
		if toggleAllSlider.Position.X.Scale>.88 then
			toggleAllSlider:TweenPosition(UDim2.new(0.45,0,0,-2),nil,"Sine",0.1,true)
		end
	end
end)
local oldRefillAt=refillAtBox.Text
refillAtBox:GetPropertyChangedSignal("Text"):Connect(function()
	if #refillAtBox.Text>2 or refillAtBox.Text:match("%D") then
		refillAtBox.Text = oldRefillAt
	end
	oldRefillAt = refillAtBox.Text
end)
refillAtBox.FocusLost:Connect(function()
	if tonumber(refillAtBox.Text) then
		settings.refill_at=tonumber(refillAtBox.Text)
	end
	refillAtBox.Text=tostring(settings.refill_at)
end)
local oldRefillEnd=refillEndBox.Text
refillEndBox:GetPropertyChangedSignal("Text"):Connect(function()
	if #refillEndBox.Text>2 or refillEndBox.Text:match("%D") then
		refillEndBox.Text = oldRefillEnd
	end
	oldRefillEnd = refillEndBox.Text
end)
refillEndBox.FocusLost:Connect(function()
	if tonumber(refillEndBox.Text) then
		settings.refill_end=tonumber(refillEndBox.Text)
	end
	refillEndBox.Text=tostring(settings.refill_end)
end)
local oldDeliverAt=deliverAtBox.Text
deliverAtBox:GetPropertyChangedSignal("Text"):Connect(function()
	if #deliverAtBox.Text>2 or deliverAtBox.Text:match("%D") then
		deliverAtBox.Text = oldDeliverAt
	end
	oldDeliverAt = deliverAtBox.Text
end)
deliverAtBox.FocusLost:Connect(function()
	if tonumber(deliverAtBox.Text) then
		settings.deliver_at=tonumber(deliverAtBox.Text)
	end
	deliverAtBox.Text=tostring(settings.deliver_at)
end)
closeBtn.MouseButton1Click:Connect(function()
    gui:Destroy()
    doCashier,doBoxer,doCook,doSupplier,doDelivery = false,false,false,false,false
end)
closeBtn.MouseEnter:Connect(function() closeBtn.TextColor3=Color3.new(.9,0,0) end)
closeBtn.MouseLeave:Connect(function() closeBtn.TextColor3=Color3.new(1,1,1) end)
saveBtn.MouseButton1Click:Connect(function()
	if writefile and messageLbl.Visible==false then
		writefile("PizzaFarm.txt",game:GetService("HttpService"):JSONEncode(settings))
		messageLbl.Visible=true
		wait(2)
		messageLbl.Visible=false
	end
end)
local cameraArray = {CFrame.new(23,14,65,0.629,0.386,-0.674,-0,0.867,0.497,0.777,-0.313,0.545),CFrame.new(39,15,83,-0.571,0.392,-0.720,-0,0.878,0.478,0.820,0.273,-0.502),CFrame.new(40,20,-38,-0.801,-0.229,0.552,-0,0.923,0.384,-0.598,0.307,-0.739),CFrame.new(51,15,-25,-0.707,0.338,-0.620,0,0.878,0.478,0.707,0.338,-0.620),CFrame.new(47,12,21,0.026,0.323,-0.945,-0,0.946,0.323,0.999,-0.008,0.024)}
local cameraIndex = 0
centerCamBtn.MouseButton1Click:Connect(function()
	cameraIndex = 0
	workspace.CurrentCamera.CameraType = "Custom"
end)
leftCamBtn.MouseButton1Click:Connect(function()
	cameraIndex = cameraIndex - 1
	if cameraIndex < 0 then
		cameraIndex = #cameraArray
	end
	if cameraIndex == 0 then
		workspace.CurrentCamera.CameraType="Custom"
	else
		local cf = cameraArray[cameraIndex]
		workspace.CurrentCamera.CameraType="Scriptable"
		workspace.CurrentCamera:Interpolate(cf,cf+cf.lookVector*10,0.5)
	end
end)
rightCamBtn.MouseButton1Click:Connect(function()
	cameraIndex = cameraIndex + 1
	if cameraIndex > #cameraArray then
		cameraIndex = 0
		workspace.CurrentCamera.CameraType="Custom"
	else
		local cf = cameraArray[cameraIndex]
		workspace.CurrentCamera.CameraType="Scriptable"
		workspace.CurrentCamera:Interpolate(cf,cf+cf.lookVector*10,0.5)
	end
end)

--//subroutines
local supplyCounts = {TomatoSauce=99,Cheese=99,Sausage=99,Pepperoni=99,Dough=99,Box=99,Dew=99}
for name in pairs(supplyCounts) do
	local lbl = workspace.SupplyCounters[name=="Dew" and "CounterMountainDew" or "Counter"..name].a.SG.Counter
	supplyCounts[name]=tonumber(lbl.Text)
	lbl.Changed:Connect(function()
		supplyCounts[name]=tonumber(lbl.Text)
	end)
end

local function FindFirstCustomer()
	local children = workspace.Customers:GetChildren()
	for i=1,#children do
		local c = children[i]
		if ffc(c,"Head") and ffc(c,"Humanoid") and c.Head.CFrame.Z<102 and ffc(c.Head,"Dialog") and ffc(c.Head.Dialog,"Correct") and ((c.Humanoid.SeatPart and c.Humanoid.SeatPart.Anchored) or (c.Humanoid.SeatPart==nil and (c.Head.Velocity.Z^2)^.5<.0001)) then
			local dialog = c.Head.Dialog.Correct.ResponseDialog or ''
			local order = "MountainDew"
			if dialog:sub(-8)=="instead." then
				dialog = dialog:sub(-30)
			end
			if dialog:find("pepperoni",1,true) then
				order = "PepperoniPizza"
			elseif dialog:find("sausage",1,true) then
				order = "SausagePizza"
			elseif dialog:find("cheese",1,true) then
				order = "CheesePizza"
			end
			return c,order
		end
	end
end

local boxPtick=0
local boxDtick=0
local function FindBoxes()
	local c,o,f
	local children = workspace.AllBox:GetChildren()
	for i=1,#children do
		local b = children[i]
		if ffc(b,"HasPizzaInside") or ffc(b,"Pizza") then
			if c==nil and b.Name=="BoxClosed" and b.Anchored==false and not b.HasPizzaInside.Value then
				c=b
			elseif o==nil and b.Name=="BoxOpen" and b.Anchored==false and not b.Pizza.Value then
				o=b
			elseif f==nil and (b.Name=="BoxOpen" and b.Pizza.Value) or (b.Name=="BoxClosed" and b.HasPizzaInside.Value) then
				f=b
			end
			if c and o and f then
				return c,o,f
			end
		end
	end
	return c,o,f
end
local function FindBoxingFoods()
	local p,d
	local children = workspace.BoxingRoom:GetChildren()
	for i=1,#children do
		local f = children[i]
		if not f.Anchored then
			if p==nil and f.Name=="Pizza" then
				p=f
			elseif d==nil and f.Name=="Dew" then
				d=f
			end
			if p and d then
				return p,d
			end
		end
	end
	return p,d
end

local orderDict={["3540529228"]="Cheese",["3540530535"]="Sausage",["3540529917"]="Pepperoni",["2512571151"]="Dew",["2512441325"]="Dew"}
local cookingDict = {Cheese=0,Sausage=0,Pepperoni=0,Dew=0}
local cookPtick=0
local cookDtick=0
local cookWarned=false
local boxerWarned=false
local function getOrders()
	local orders={}
	local tempCookingDict = {}
	for i,v in pairs(cookingDict) do tempCookingDict[i]=v end
	local children = workspace.Orders:GetChildren()
	for i=1,#children do
		local o = orderDict[children[i].SG.ImageLabel.Image:match("%d+$")]
		if o then
			if tempCookingDict[o]>0 then
				--ignores oven pizzas, so new orders are priority
				tempCookingDict[o]=tempCookingDict[o]-1
			elseif (o=="Dew" and #workspace.AllMountainDew:GetChildren()>0) or (supplyCounts[o]>0 and supplyCounts.TomatoSauce>0 and supplyCounts.Cheese>0) then
				--need supplies
				orders[#orders+1]=o
			end
		end
	end
	return orders
end
local function FindFirstDew()
	local children = workspace.AllMountainDew:GetChildren()
	for i=1,#children do
		local d = children[i]
		if (ffc(d,"IsBurned")==nil or d.IsBurned.Value==false) and not d.Anchored then
			return d
		end
	end
end
local function FindBadDew()
	local children = workspace.AllMountainDew:GetChildren()
	for i=1,#children do
		local d = children[i]
		if (ffc(d,"IsBurned")==nil or d.IsBurned.Value==false) and d.Position.X > 53 and d.Position.Z > 50 and not d.Anchored then
			return d
		end
	end
end
local function FindDoughAndWithout(str)
	local goodraw,p,raw,trash
	local children = workspace.AllDough:GetChildren()
	for i = #children, 2, -1 do --shuffle
		local j = RNG:NextInteger(1, i)
		children[j], children[i] = children[i], children[j]
	end
	for i=1,#children do
		local d = children[i]
		if d.Anchored==false and #d:GetChildren()>9 then
			if d.IsBurned.Value or d.HasBugs.Value or d.Cold.Value or (d.BrickColor.Name=="Bright orange" and ffc(d,"XBillboard")) then
				if trash==nil and d.Position.Y > 0 and ((d.Position*Vector3.new(1,0,1))-Vector3.new(47.90, 0, 72.49)).Magnitude > 1 then
					trash=d
				end
			elseif p==nil and d.BrickColor.Name=="Bright orange" then
				p=d
			elseif goodraw==nil and d.Position.X<55 and d.BrickColor.Name=="Brick yellow" and ((str and not ffc(d.SG.Frame,str)) or (str==nil and ffc(d.SG.Frame,"Sausage")==nil and ffc(d.SG.Frame,"Pepperoni")==nil)) then
				--prefers flat
				if d.Mesh.Scale.Y<1.1 then
					goodraw=d
				else
					raw=d
				end
			end
			if goodraw and p and trash then
				return goodraw,p,trash
			end
		end
	end
	return goodraw or raw,p,trash
end
local function getOvenNear(pos)
	local children = workspace.Ovens:GetChildren()
	for i=1,#children do
		if ffc(children[i],"Bottom") and (children[i].Bottom.Position-pos).magnitude < 1.5 then
			return children[i]
		end
	end
end
local function getDoughNear(pos)
	local children = workspace.AllDough:GetChildren()
	for i=1,#children do
		if (children[i].Position-pos).magnitude < 1.5 then
			return children[i]
		end
	end
end
local function isFullyOpen(oven)
	return oven.IsOpen.Value==true and (oven.Door.Meter.RotVelocity.Z^2)^.5<.0001
end

local bcolorToSupply = {["Dark orange"]="Sausage",["Bright blue"]="Pepperoni",["Bright yellow"]="Cheese",["Bright red"]="TomatoSauce",["Dark green"]="Dew",["Brick yellow"]="Dough",["Light stone grey"]="Box",["Really black"]="Dew"}
local supplyButtons = {}
for i,v in ipairs(workspace.SupplyButtons:GetChildren()) do
	supplyButtons[i] = v.Unpressed
end
table.sort(supplyButtons,function(a,b) return a.Position.X < b.Position.X end)
local delTick = 0
local function FindAllDeliveryTools(parent)
	local t = {}
	local children = parent:GetChildren()
	for i=1,#children do
		local v = children[i]
		if v.ClassName=="Tool" and v.Name:match("^%u%d$") and ffc(v,"Handle") and ffc(v,"House") and (parent~=workspace or (v.Handle.Position-Vector3.new(54.45, 4.02, -16.56)).Magnitude < 30) then
			t[#t+1] = v
		end
	end
	return t
end
local function getHousePart(address)
    local houses = workspace.Houses:GetChildren()
    for i=1,#houses do
        local h = houses[i]
        if ffc(h,"Address") and h.Address.Value==address and ffc(h,"GivePizza",true) then
            return ffc(h,"GivePizza",true)
        end
    end
end
local function onCharacterAdded(char)
	if not char then return end
	character=char
	root = character:WaitForChild("HumanoidRootPart")
	humanoid = character:WaitForChild("Humanoid")
	humanoid:SetStateEnabled("FallingDown",false)
end
onCharacterAdded(player.Character or player.CharacterAdded:Wait())
player.CharacterAdded:Connect(onCharacterAdded)

local function smoothTP2(cf)
	local cf0 = (cf-cf.p) + root.Position + Vector3.new(0,4,0)
	local diff = cf.p - root.Position
	local oldg = workspace.Gravity
	workspace.Gravity = 0
	for i=0,diff.Magnitude,0.9 do
		humanoid.Sit=false
		root.CFrame = cf0 + diff.Unit * i
		root.Velocity,root.RotVelocity=Vector3.new(),Vector3.new()
		wait()
	end
	root.CFrame = cf
	workspace.Gravity = oldg
end
local function smoothTP(cf)
    game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = cf
end
for _,o in ipairs(workspace.Ovens:GetChildren()) do
	if ffc(o,"Bottom") then
		o.Bottom.CanTouch = false
	end
end
local function tryCook()
	for zz=1,18 do
		local order = getOrders()[1]
		local topping
		if order=="Pepperoni" or order=="Sausage" then topping=order end
		local cookD = FindFirstDew()
		local badD = FindBadDew()
		local raw,cookP,trash
		if topping then
			--pepperoni order avoids sausage dough and vice verca
			raw,cookP,trash = FindDoughAndWithout(topping=="Pepperoni" and "Sausage" or "Pepperoni")
		else
			raw,cookP,trash = FindDoughAndWithout()
		end
		local ovens = workspace.Ovens:GetChildren()
		for i=#ovens,1,-1 do
		    if #ovens[i]:GetChildren() < 10 then
		        table.remove(ovens,i)
		    end
		end
		for i = #ovens, 2, -1 do --shuffle
			local j = RNG:NextInteger(1, i)
			ovens[j], ovens[i] = ovens[i], ovens[j]
		end
		if doCook then
			local didsomething=false
			--move final pizza
			if cookP and tick()-cookPtick>0.8 then
				local oven = getOvenNear(cookP.Position)
				if oven==nil or oven.IsOpen.Value then
					cookPtick=tick()
					didsomething=true
					if (root.Position-Vector3.new(36.64, 3.80, 54.11)).magnitude>9 then  smoothTP(CFrame.new(36.64, 3.80, 54.11)) wait(.1) end
					network:FireServer("UpdateProperty", cookP, "CFrame", CFrame.new(RNG:NextNumber(56,57),4.1,38))
				end
			end
			if order then
				if order=="Dew" and cookD and tick()-cookDtick>0.8 then
					--move dew if ordered
					cookDtick=tick()
					didsomething=true
					if (root.Position-Vector3.new(36.64, 3.80, 54.11)).magnitude>9 then  smoothTP(CFrame.new(36.64, 3.80, 54.11)) wait(.1) end
					network:FireServer("UpdateProperty", cookD, "CFrame", CFrame.new(53,4.68,36.5))
				elseif order~="Dew" and raw and raw.Parent and supplyCounts[order]>0 and supplyCounts.TomatoSauce>0 and supplyCounts.Cheese>0 then
					--make pizza
					if raw.Mesh.Scale.Y>1.5 then
						if (root.Position-Vector3.new(36.64, 3.80, 54.11)).magnitude>9 then  smoothTP(CFrame.new(36.64, 3.80, 54.11)) wait(.1) end
						didsomething=true
						network:FireServer("UpdateProperty", raw, "CFrame", CFrame.new(RNG:NextNumber(29.6,44.6),3.7,RNG:NextNumber(42.5,48.5)))
						wait()
						network:FireServer("SquishDough", raw)
					else
						--make sure it will have an oven
						local oven
						for _,o in ipairs(ovens) do
							if isFullyOpen(o) then
								local other = getDoughNear(o.Bottom.Position)
								if other==nil or not (other.BrickColor.Name=="Bright orange" and ffc(other.SG.Frame,"TomatoSauce") and ffc(other.SG.Frame,"MeltedCheese")) then
									if other then
										--replace mistaken dough
										didsomething=true
										if (root.Position-Vector3.new(36.64, 3.80, 54.11)).magnitude>9 then  smoothTP(CFrame.new(36.64, 3.80, 54.11)) wait(.1) end
										network:FireServer("UpdateProperty", other, "CFrame", CFrame.new(RNG:NextNumber(29.6,44.6),3.7,RNG:NextNumber(42.5,48.5)))
										wait()
									end
									oven=o
									break
								end
							end
						end
						if oven and raw.Parent==workspace.AllDough then
							--make
							if (root.Position-Vector3.new(36.64, 3.80, 54.11)).magnitude>9 then  smoothTP(CFrame.new(36.64, 3.80, 54.11)) wait(.1) end
							didsomething=true
							network:FireServer("AddIngredientToPizza", raw,"TomatoSauce")
							network:FireServer("AddIngredientToPizza", raw,"Cheese")
							network:FireServer("AddIngredientToPizza", raw,topping)
							network:FireServer("UpdateProperty", raw, "CFrame", oven.Bottom.CFrame+Vector3.new(0,0.7,0))
							oven.Door.ClickDetector.Detector:FireServer()
							--mark as cooking
							cookingDict[order]=cookingDict[order]+1
							local revoked=false
							spawn(function()
								raw.AncestryChanged:Wait()
								if not revoked then
									cookingDict[order]=cookingDict[order]-1
									revoked=true
								end
							end)
							delay(40, function()
								if not revoked then
									cookingDict[order]=cookingDict[order]-1
									revoked=true
								end
							end)
						end
					end
				end
			end
			--open unnecessarily closed ovens
			for _,o in ipairs(ovens) do
				local bar = o.Door.Meter.SurfaceGui.ProgressBar.Bar
				if o.IsOpen.Value==false and (o.IsCooking.Value==false or (Vector3.new(bar.ImageColor3.r,bar.ImageColor3.g,bar.ImageColor3.b)-Vector3.new(.871,.518,.224)).magnitude>.1) then
					didsomething=true
					if (root.Position-Vector3.new(36.64, 3.80, 54.11)).magnitude>9 then  smoothTP(CFrame.new(36.64, 3.80, 54.11)) wait(.1) end
					o.Door.ClickDetector.Detector:FireServer()
					break
				end
			end
			--trash
			if badD then
				didsomething=true
				if (root.Position-Vector3.new(36.64, 3.80, 54.11)).magnitude>9 then  smoothTP(CFrame.new(36.64, 3.80, 54.11)) wait(.1) end
				network:FireServer("UpdateProperty", badD, "CFrame", CFrame.new(RNG:NextNumber(28,30), 1.7, RNG:NextNumber(55,57)))
			end
			if trash and (trash.IsBurned.Value==false or getOvenNear(trash.Position)==nil or getOvenNear(trash.Position).IsOpen.Value) then
				--closed oven breaks if you take burnt out of it
				didsomething=true
				if (root.Position-Vector3.new(36.64, 3.80, 54.11)).magnitude>9 then  smoothTP(CFrame.new(36.64, 3.80, 54.11)) wait(.1) end
				network:FireServer("UpdateProperty", trash, "CFrame", CFrame.new(47.90, 7.00, 72.49, 1, 0, -0, 0, 0, 1, 0, -1, 0))
			end
			if didsomething then wait(0.5) else break end
		else
			break
		end
	end
end
wait(1)
--//main loop
while gui.Parent do
	wait(0.9)
	humanoid.Sit=false
	if RNG:NextInteger(1,20)==1 then
        game:GetService("VirtualInputManager"):SendKeyEvent(true,"Z",false,game)
        wait()
        game:GetService("VirtualInputManager"):SendKeyEvent(false,"Z",false,game)
	end
	for zz=1,3 do
		local c,order = FindFirstCustomer()
		if doCashier and c and order then
			local reg = 3
			if c.Head.Position.X < 50 then
			    reg = 2
			elseif c.Head.Position.X < 70 then
			    reg = 1
			end
			if (root.Position-Vector3.new(50.30, 3.80, 83.24)).magnitude>9 then smoothTP(CFrame.new(50.30, 3.80, 83.24)) wait(.1) end
			network:FireServer("OrderComplete", c, order, workspace["Register"..reg])
			wait(0.3)
		else
			break
		end
	end
	tryCook()
	for zz=1,7 do
		if doBoxer then
			local didsomething = false
			local boxP,boxD = FindBoxingFoods()
			local closedBox,openBox,fullBox = FindBoxes()
			if boxD and tick()-boxDtick>0.8 then
				boxDtick=tick()
				didsomething=true
				if (root.Position-Vector3.new(58.74, 3.80, 12.400)).magnitude>9 then  smoothTP(CFrame.new(58.74, 3.80, 12.40))wait(.1) continue end
				network:FireServer("UpdateProperty", boxD, "CFrame", CFrame.new(63,4.9,-1,-1,0,0,0,1,0,0,0,-1))
			end
			if fullBox then
				if fullBox.Name=="BoxOpen" then
					didsomething=true
					if (root.Position-Vector3.new(58.74, 3.80, 12.400)).magnitude>9 then  smoothTP(CFrame.new(58.74, 3.80, 12.40))wait(.1) continue end
					network:FireServer("CloseBox", fullBox)
					--will be moved next loop
				elseif tick()-boxPtick>0.8 then
					didsomething=true
					if (root.Position-Vector3.new(58.74, 3.80, 12.400)).magnitude>9 then  smoothTP(CFrame.new(58.74, 3.80, 12.40))wait(.1) continue end
					network:FireServer("UpdateProperty", fullBox, "CFrame", CFrame.new(68.2,4.4,RNG:NextNumber(-3,-2),-1,0,0,0,1,0,0,0,-1))
					boxPtick=tick()
				end
			end
			if closedBox and not openBox then
				didsomething=true
				if (root.Position-Vector3.new(58.74, 3.80, 12.400)).magnitude>9 then  smoothTP(CFrame.new(58.74, 3.80, 12.40))wait(.1) continue end
				network:FireServer("UpdateProperty", closedBox, "CFrame", CFrame.new(RNG:NextNumber(62.5,70.5),3.5,RNG:NextNumber(11,25)))
				wait()
				network:FireServer("OpenBox", closedBox)
			end
			if openBox and boxP then
				didsomething=true
				if (root.Position-Vector3.new(58.74, 3.80, 12.400)).magnitude>9 then  smoothTP(CFrame.new(58.74, 3.80, 12.40))wait(.1) continue end
				network:FireServer("UpdateProperty", boxP, "Anchored", true)
				network:FireServer("UpdateProperty", openBox, "Anchored", true)
				wait()
				network:FireServer("UpdateProperty", boxP, "CFrame", openBox.CFrame+Vector3.new(0,-2,0))
				wait()
				network:FireServer("AssignPizzaToBox", openBox, boxP)
			end
			if didsomething then wait(0.5) else break end
		else
			break
		end
	end
	if doDelivery then
		local wstools = FindAllDeliveryTools(workspace)
		if #wstools > 1 or (wstools[1] and ffc(wstools[1].Handle,"X10")) then
			--get tools
			if (root.Position-Vector3.new(54.45, 4.02, -15)).magnitude>9 then smoothTP(CFrame.new(54.45, 4.02, -15)) wait(.1) end
			for i=1,#wstools do
				if wstools[i].Parent == workspace then
					humanoid:EquipTool(wstools[i])
					wait()
				end
			end
			wait(0.3)
			local t = FindAllDeliveryTools(character)
    		for i=1,#t do
    			t[i].Parent = player.Backpack
    		end
    		wait(0.1)
    		if ffc(character,"RightHand") and ffc(character.RightHand,"RightGrip") then
    			character.RightHand.RightGrip:Destroy()
    		end
		end
		local bptools = FindAllDeliveryTools(player.Backpack)
		if #bptools >= settings.deliver_at and #bptools > 0 and tick()-delTick > 30 then
			--deliver to houses
			table.sort(bptools,function(a,b)
				a,b=tostring(a),tostring(b)
				if (a:sub(1,1)=="B" and b:sub(1,1)=="B") then
					return a < b
				end
				return a > b
			end)
			local fatass=false
			for i=1,#bptools do
				if not doDelivery then
					break
				end
				humanoid.Sit=false
				local tool = bptools[i]
				local giver = getHousePart(tool.Name)
				local ogp = giver.Position
				if giver then
					if (giver.Position-root.Position).Magnitude > 9 then
						smoothTP(giver.CFrame+Vector3.new(0,7,0))
						if giver.Parent==nil or (giver.Position-ogp).Magnitude>1 then
							giver = getHousePart(tool.Name) or giver
							smoothTP(giver.CFrame+Vector3.new(0,7,0))
						end
						pcall(function() tool.Parent = character end)
						wait(1.2)
						local t = FindAllDeliveryTools(character)
                		for i=1,#t do
                		    if t[i] ~= tool then
                			    t[i].Parent = player.Backpack
                			end
                		end
						wait(2)
						fatass=false
					else
						if fatass then
							wait(0.2)
						else
							wait(0.7)
						end
						pcall(function() tool.Parent = character end)
						wait()
						fatass=true
					end
				end
			end
			delTick = tick()
		end
	end
	tryCook()
	if doSupplier then
		local refill=false
		for s,c in pairs(supplyCounts) do
			if c <= settings.refill_at then
				refill=true
				break
			end
		end
		if refill then
			local oldcf = root.CFrame
			local waiting = false
			local waitingTick = 0
			local lastBox
			while doSupplier do
				--check if refill is done otherwise hit buttons
				local fulfilled=true
				local boxes = workspace.AllSupplyBoxes:GetChildren()
				for yy=1,2 do
				local needtp=true
				local realc = 0
				for _,btn in ipairs(supplyButtons) do
				    local s = bcolorToSupply[btn.BrickColor.Name]
					if supplyCounts[s] < settings.refill_end then
						local count = 0
						if #boxes > 30 then
							for i=1,#boxes do
								local box = boxes[i]
								if bcolorToSupply[box.BrickColor.Name]==s and box.Anchored==false and box.Position.Z < -940 then
									count=count+1
								end
							end
						end
						if count < 2 then
							if needtp then
							    needtp=false
								smoothTP(btn.CFrame + Vector3.new(0,3,2.5))
								wait(0.1)
							end
							if not doSupplier then break end
							root.CFrame = btn.CFrame + Vector3.new(0,3,0)
							wait(0.1)
							realc=realc+1
						end
						fulfilled=false
					end
				end
				wait(0.2)
				if yy == 1 and realc < 3 then
				    wait(0.6)
				end
				end
				if fulfilled or not (doSupplier) then
					break
				end
				smoothTP(CFrame.new(8,12.4,-1020))
				if not doSupplier then break end
				--check if can finish waiting for boxes to move
				if waiting and (lastBox.Position.X>42 or tick()-waitingTick>6) then
					waiting=false
					if lastBox.Position.X<42 then
						--clear boxes if stuck
						smoothTP(CFrame.new(20.5,8,-35))
						wait(0.1)
						local boxes = workspace.AllSupplyBoxes:GetChildren()
						for i=1,#boxes do
							local box = boxes[i]
							if box.Anchored==false and box.Position.Z>-55 then
								network:FireServer("UpdateProperty", box, "CFrame", CFrame.new(RNG:NextNumber(0,40),RNG:NextNumber(-10,-30),-70))
								wait()
							end
						end
						wait(0.1)
					end
				end
				if not waiting then
					--move boxes
					if root.Position.Z > -900 then smoothTP(CFrame.new(8,12.4,-1020)) end
					wait(0.1)
					lastBox=nil
					local j=0
					local boxes = workspace.AllSupplyBoxes:GetChildren()
					for i=1,#boxes do
						local box = boxes[i]
						if box.Anchored==false and box.Position.Z < -940 and bcolorToSupply[box.BrickColor.Name] and supplyCounts[bcolorToSupply[box.BrickColor.Name]]<settings.refill_end then
							box.CFrame = CFrame.new(38-4.3*math.floor(j/2),5,-7-5*(j%2))
							network:FireServer("UpdateProperty", box, "CFrame", box.CFrame)
							lastBox=box
							j=j+1
							if j>13 then break end
						end
					end
					if lastBox then
						waiting=true
						waitingTick=tick()
					end
				end
			end
			--smoothTP(oldcf)
		end
	end
end
end)

Section:NewButton("Admin Menu", "ButtonInfo", function()
    local a=loadstring(game:HttpGet("https://raw.githubusercontent.com/miroeramaa/TurtleLib/main/TurtleUiLib.lua"))()local e=a:Window("ADMINtopik")e:Button("Become Manager",function()local f=game:GetService("Teams").Manager:GetPlayers()[1]if f.Character.Humanoid.Sit then game:GetService("StarterGui"):SetCore("SendNotification",{Title="Make Manager Script",Text="Failed Because Manager is Sitting",Duration=5})return end;yes=game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame;pcall(function()local g={[1]="QuitJob",[2]=game:GetService("Players").LocalPlayer}game:GetService("ReplicatedStorage").ManagerChannel:FireServer(unpack(g))local g={[1]=true}workspace.MessageService.DialogButtonPressed:FireServer(unpack(g))workspace.CurrentCamera.CameraSubject=game.Workspace.Street2;local g={[1]="GiveItem",[2]=495886176}game:GetService("ReplicatedStorage").PlayerChannel:FireServer(unpack(g))game.Players.LocalPlayer.Character.Humanoid.Name=1;local h=game.Players.LocalPlayer.Character["1"]:Clone()h.Parent=game.Players.LocalPlayer.Character;h.Name="Humanoid"wait(0.1)game.Players.LocalPlayer.Character["1"]:Destroy()workspace.CurrentCamera.CameraSubject=game.Workspace.Street2;game.Players.LocalPlayer.Character.Animate.Disabled=true;wait(0.1)game.Players.LocalPlayer.Character.Animate.Disabled=false;game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType="None"wait(.20)local i="PaintBucket"for j,k in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren())do if k:IsA("Tool")and k.Name==i then k.Parent=game:GetService("Players").LocalPlayer.Character end end;game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(f.Character.HumanoidRootPart.Position)wait(.05)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(f.Character.HumanoidRootPart.Position)wait(.05)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(f.Character.HumanoidRootPart.Position)wait(.05)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(f.Character.HumanoidRootPart.Position)wait(.05)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(f.Character.HumanoidRootPart.Position)wait(.05)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(f.Character.HumanoidRootPart.Position)wait(.05)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(f.Character.HumanoidRootPart.Position)wait(2)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(11.819767951965,1.1243584156036,21.870401382446)wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(11.819767951965,1.1243584156036,21.870401382446)wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(11.819767951965,1.1243584156036,21.870401382446)wait(2)game.Players.LocalPlayer.Character:Destroy()wait(2)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(23.7,2.59944,6.5)wait(.50)game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState("Jumping")wait(.20)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=yes;game.Players.LocalPlayer.PlayerGui.MainGui.Menu.Backpack.Tools.Shortcut:Destroy()end)end)e:Box("Kill Player",function(l,m)if m and game.Players[l]then if game.Players[l].Character.Humanoid.Sit then game:GetService("StarterGui"):SetCore("SendNotification",{Title="Kill Player Script",Text="Failed Because Player is Sitting",Duration=5})return end;yes=game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame;pcall(function()local g={[1]="GiveItem",[2]=495886176}game:GetService("ReplicatedStorage").PlayerChannel:FireServer(unpack(g))wait(.20)game.Players.LocalPlayer.Character.Humanoid.Name=1;local h=game.Players.LocalPlayer.Character["1"]:Clone()h.Parent=game.Players.LocalPlayer.Character;h.Name="Humanoid"wait(0.1)game.Players.LocalPlayer.Character["1"]:Destroy()workspace.CurrentCamera.CameraSubject=game.Players[l].Character;game.Players.LocalPlayer.Character.Animate.Disabled=true;wait(0.1)game.Players.LocalPlayer.Character.Animate.Disabled=false;game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType="None"wait(.20)local i="PaintBucket"for j,k in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren())do if k:IsA("Tool")and k.Name==i then k.Parent=game:GetService("Players").LocalPlayer.Character end end;game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[l].Character.HumanoidRootPart.CFrame;wait(.10)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[l].Character.HumanoidRootPart.CFrame;wait(.10)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[l].Character.HumanoidRootPart.CFrame;wait(.10)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[l].Character.HumanoidRootPart.CFrame;wait(.10)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[l].Character.Head.CFrame;wait(.10)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[l].Character.HumanoidRootPart.CFrame;wait(.10)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[l].Character.HumanoidRootPart.CFrame;wait(.10)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[l].Character.Head.CFrame;wait(.10)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[l].Character.HumanoidRootPart.CFrame;wait(1)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(85.092697143555,-39.80192565918,434.20581054688)wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(85.092697143555,-39.80192565918,434.20581054688)wait(5)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=yes end)end;wait(4)game.Players.LocalPlayer.PlayerGui.MainGui.Menu.Backpack.Tools.Shortcut:Destroy()end)e:Box("Skydive Player",function(n,m)if m and game.Players[n]then if game.Players[n].Character.Humanoid.Sit then game:GetService("StarterGui"):SetCore("SendNotification",{Title="Skydive Player Script",Text="Failed Because Player is Sitting",Duration=5})return end;yes=game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame;pcall(function()local g={[1]="GiveItem",[2]=495886176}game:GetService("ReplicatedStorage").PlayerChannel:FireServer(unpack(g))wait(.20)workspace.CurrentCamera.CameraSubject=game.Workspace.Street2;game.Players.LocalPlayer.Character.Humanoid.Name=1;local h=game.Players.LocalPlayer.Character["1"]:Clone()h.Parent=game.Players.LocalPlayer.Character;h.Name="Humanoid"wait(0.1)game.Players.LocalPlayer.Character["1"]:Destroy()workspace.CurrentCamera.CameraSubject=game.Players[n].Character;game.Players.LocalPlayer.Character.Animate.Disabled=true;wait(0.1)game.Players.LocalPlayer.Character.Animate.Disabled=false;game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType="None"wait(.20)local i="PaintBucket"for j,k in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren())do if k:IsA("Tool")and k.Name==i then k.Parent=game:GetService("Players").LocalPlayer.Character end end;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[n].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[n].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[n].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[n].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[n].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[n].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[n].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[n].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[n].Character.HumanoidRootPart.CFrame;wait(1)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(-742.62884521484,64574.03125,393.12066650391)wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(-742.62884521484,64574.03125,393.12066650391)wait(5)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=yes end)end;wait(4)workspace.CurrentCamera.CameraSubject=game.Players.LocalPlayer.Character;game.Players.LocalPlayer.PlayerGui.MainGui.Menu.Backpack.Tools.Shortcut:Destroy()end)e:Box("Bring Player",function(o,p)if p and game.Players[o]then if game.Players[o].Character.Humanoid.Sit then game:GetService("StarterGui"):SetCore("SendNotification",{Title="Bring Player Script",Text="Failed Because Player is Sitting",Duration=5})return end;yes=game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame;pcall(function()local g={[1]="GiveItem",[2]=495886176}game:GetService("ReplicatedStorage").PlayerChannel:FireServer(unpack(g))wait(.20)game.Players.LocalPlayer.Character.Humanoid.Name=1;local h=game.Players.LocalPlayer.Character["1"]:Clone()h.Parent=game.Players.LocalPlayer.Character;h.Name="Humanoid"wait(0.1)game.Players.LocalPlayer.Character["1"]:Destroy()workspace.CurrentCamera.CameraSubject=game.Players[o].Character;game.Players.LocalPlayer.Character.Animate.Disabled=true;wait(0.1)game.Players.LocalPlayer.Character.Animate.Disabled=false;game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType="None"wait(.20)local i="PaintBucket"for j,k in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren())do if k:IsA("Tool")and k.Name==i then k.Parent=game:GetService("Players").LocalPlayer.Character end end;game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[o].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[o].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[o].Character.Head.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[o].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[o].Character.Head.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[o].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[o].Character.HumanoidRootPart.CFrame;wait(.05)wait(1)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=yes end)end;wait(5)game.Players.LocalPlayer.PlayerGui.MainGui.Menu.Backpack.Tools.Shortcut:Destroy()game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=yes end)e:Box("Kick Player",function(q,r)if r then if game.Players[q]then if game.Players[q].Character.Humanoid.Sit then game:GetService("StarterGui"):SetCore("SendNotification",{Title="Kick Player Script",Text="Failed Because Player is Sitting",Duration=5})return end;pcall(function()workspace.CurrentCamera.CameraSubject=game.Workspace.Street2;yes=game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame;local g={[1]="GiveItem",[2]=495886176}game:GetService("ReplicatedStorage").PlayerChannel:FireServer(unpack(g))wait(.20)game.Players.LocalPlayer.Character.Humanoid.Name=1;local h=game.Players.LocalPlayer.Character["1"]:Clone()h.Parent=game.Players.LocalPlayer.Character;h.Name="Humanoid"wait(0.1)game.Players.LocalPlayer.Character["1"]:Destroy()workspace.CurrentCamera.CameraSubject=game.Workspace.Street2;workspace.CurrentCamera.CameraSubject=game.Workspace.Street2;game.Players.LocalPlayer.Character.Animate.Disabled=true;wait(0.1)game.Players.LocalPlayer.Character.Animate.Disabled=false;game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType="None"wait(.70)local i="PaintBucket"for j,k in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren())do if k:IsA("Tool")and k.Name==i then k.Parent=game:GetService("Players").LocalPlayer.Character end end;game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[q].Character.Head.CFrame;game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[q].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[q].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[q].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[q].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[q].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[q].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[q].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[q].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[q].Character.HumanoidRootPart.CFrame;wait(1)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(81.148887634277,-0.07208026945591,-286.22467041016)wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(80.7802,0.20001,-284.692)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(81.148887634277,-0.07208026945591,-286.22467041016)wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(80.7802,0.20001,-284.692)wait(.08)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(81.148887634277,-0.07208026945591,-286.22467041016)wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(80.7802,0.20001,-284.692)wait(1)game.Players.LocalPlayer.Character:Destroy()wait(4)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=yes end)end;wait(5)game.Players.LocalPlayer.PlayerGui.MainGui.Menu.Backpack.Tools.Shortcut:Destroy()if game.Players[q].Character~=nil then game:GetService("StarterGui"):SetCore("SendNotification",{Title="Kick Player Script",Text=game.Players[q].Name.."   was died while kicking him, Try Kick him again",Duration=5})return end end end)e:Box("Make Manager",function(s,t)if t and game.Players[s]then if game.Players[s].Character.Humanoid.Sit then game:GetService("StarterGui"):SetCore("SendNotification",{Title="Make Manager Script",Text="Failed Because Target Player is Sitting",Duration=5})return end;local u=game:GetService("Teams").Manager:GetPlayers()[1]if u.Character.Humanoid.Sit then game:GetService("StarterGui"):SetCore("SendNotification",{Title="Make Manager Script",Text="You can't Make Player Manager because Current Manager is Sitting",Duration=5})return end;pcall(function()yes=game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame;workspace.CurrentCamera.CameraSubject=game.Workspace.Street2;local g={[1]="GiveItem",[2]=495886176}game:GetService("ReplicatedStorage").PlayerChannel:FireServer(unpack(g))game.Players.LocalPlayer.Character.Humanoid.Name=1;local h=game.Players.LocalPlayer.Character["1"]:Clone()h.Parent=game.Players.LocalPlayer.Character;h.Name="Humanoid"wait(0.1)game.Players.LocalPlayer.Character["1"]:Destroy()workspace.CurrentCamera.CameraSubject=game.Workspace.Street2;game.Players.LocalPlayer.Character.Animate.Disabled=true;wait(0.1)game.Players.LocalPlayer.Character.Animate.Disabled=false;game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType="None"wait(.20)local i="PaintBucket"for j,k in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren())do if k:IsA("Tool")and k.Name==i then k.Parent=game:GetService("Players").LocalPlayer.Character end end;game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(u.Character.HumanoidRootPart.Position)wait(.05)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(u.Character.HumanoidRootPart.Position)wait(.05)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(u.Character.HumanoidRootPart.Position)wait(.05)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(u.Character.HumanoidRootPart.Position)wait(.05)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(u.Character.HumanoidRootPart.Position)wait(.05)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(u.Character.HumanoidRootPart.Position)wait(.05)game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(u.Character.HumanoidRootPart.Position)wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(11.819767951965,1.1243584156036,21.870401382446)wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(11.819767951965,1.1243584156036,21.870401382446)wait(1)game.Players.LocalPlayer.Character:Destroy()wait(4)workspace.CurrentCamera.CameraSubject=game.Workspace.Street2;game.Players.LocalPlayer.PlayerGui.MainGui.Menu.Backpack.Tools.Shortcut:Destroy()local g={[1]="GiveItem",[2]=495886176}game:GetService("ReplicatedStorage").PlayerChannel:FireServer(unpack(g))wait(.20)game.Players.LocalPlayer.Character.Humanoid.Name=1;local h=game.Players.LocalPlayer.Character["1"]:Clone()h.Parent=game.Players.LocalPlayer.Character;h.Name="Humanoid"wait(0.1)game.Players.LocalPlayer.Character["1"]:Destroy()workspace.CurrentCamera.CameraSubject=game.Workspace.Street2;game.Players.LocalPlayer.Character.Animate.Disabled=true;wait(0.1)game.Players.LocalPlayer.Character.Animate.Disabled=false;game.Players.LocalPlayer.Character.Humanoid.DisplayDistanceType="None"wait(.20)local i="PaintBucket"for j,k in pairs(game:GetService("Players").LocalPlayer.Backpack:GetChildren())do if k:IsA("Tool")and k.Name==i then k.Parent=game:GetService("Players").LocalPlayer.Character end end;game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[s].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[s].Character.HumanoidRootPart.CFrame;wait(.05)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[s].Character.HumanoidRootPart.CFrame;wait(.10)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=game.Players[s].Character.HumanoidRootPart.CFrame;workspace.ManagerChair.Seat.CFrame=CFrame.new(2300.7,2.59944,6.5)wait(1)for j=1,100 do game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(23.7,2.59944,6.5)end;wait(5)game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=yes;wait(2)workspace.ManagerChair.Seat.CFrame=CFrame.new(23.7,2.59944,6.5)end)end;wait(4)game.Players.LocalPlayer.PlayerGui.MainGui.Menu.Backpack.Tools.Shortcut:Destroy()end)e:Toggle("Sit All Players",false,function(v)if not game.JointsService:FindFirstChild("Tot Slide")then workspace.MessageService.Dialog.Dialog:Fire("Script Warning","You Need Have ''Tot Slide'' In Your House, Costs 380 Coin, ReExecute Script after you Put It","ok","",true,true)else getgenv().trinbbbbbkets=v;while true do wait(.60)if getgenv().trinbbbbbkets then pcall(function()for j,w in pairs(game.Players:GetPlayers())do for j,k in pairs(game:GetService("JointsService"):GetDescendants())do if k:IsA("RemoteEvent")and k.Name=="TouchEvent"or k.Parent=="Tot Slide"then k:FireServer(w.Character.HumanoidRootPart,game:GetService("JointsService")["Tot Slide"].Trip)for j,x in pairs(game.Workspace.Customers:GetChildren())do k:FireServer(x:FindFirstChildOfClass("Humanoid"),game:GetService("JointsService")["Tot Slide"].Trip)end end end end end)end end end end)e:Toggle("Anti-Oven Fire",false,function(y)getgenv().heee=y;while true do wait(.40)if getgenv().heee then pcall(function()for j,k in pairs(game.Players:GetPlayers())do local g={[1]=k.Character.UpperTorso}workspace.GameService.ExtinguishFire:FireServer(unpack(g))for j,k in pairs(game.Workspace.AllDough:GetChildren())do local g={[1]=k}workspace.GameService.ExtinguishFire:FireServer(unpack(g))end end end)end end end)e:Toggle("Break Leaderboard",false,function(z)getgenv().nnnnnnnnnnnn=z;while true do wait()if getgenv().nnnnnnnnnnnn then pcall(function()game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Cashier")game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Cook")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Delivery")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Supplier")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","On Break")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Cashier")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Cook")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Delivery")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Supplier")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","On Break")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Cook")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Delivery")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Cook")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Delivery")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Cashier")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Supplier")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","On Break")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Cook")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Delivery")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Supplier")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","On Break")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Cook")wait(.02)game:GetService("ReplicatedStorage").PlayerChannel:FireServer("ChangeJob","Delivery")game.Players.LocalPlayer.Character.Pants:Destroy()game.Players.LocalPlayer.Character.Shirt:Destroy()end)end end end)e:Label("UnAnchor Commands",Color3.fromRGB(127,143,166))e:Toggle("UnAnchor Trees",false,function(A)getgenv().nhekee=A;while true do wait(.50)if getgenv().nhekee then pcall(function()for j,k in pairs(game.Workspace.Trees:GetDescendants())do if k.Name=="Tree"or k.Name=="DeadTree"then workspace.Main.UprootTree:FireServer(k)end end end)end end end)e:Toggle("UnAnchor Mailboxes",false,function(B)getgenv().hekee=B;while true do wait(1)if getgenv().hekee then pcall(function()for j,k in pairs(game.Workspace.Houses:GetDescendants())do if k.Name=="Mailbox"and k.Parent:IsA("Model")then local g={[1]=k.Parent}workspace.Main.KnockMailbox:FireServer(unpack(g))end end end)end end end)c:Button("Clown Head",function()local g={[1]="LoadAvatarAsset",[2]=4272833564,[3]="HatAccessory"}game:GetService("ReplicatedStorage").PlayerChannel:FireServer(unpack(g))end)c:Button("Amogus Head",function()local g={[1]="LoadAvatarAsset",[2]=6532372710,[3]="HatAccessory"}game:GetService("ReplicatedStorage").PlayerChannel:FireServer(unpack(g))end)c:Button("Sus Head",function()local g={[1]="LoadAvatarAsset",[2]=6564572490,[3]="HatAccessory"}game:GetService("ReplicatedStorage").PlayerChannel:FireServer(unpack(g))end)c:Button("Smile1 Head",function()local g={[1]="LoadAvatarAsset",[2]=6711806832,[3]="HatAccessory"}game:GetService("ReplicatedStorage").PlayerChannel:FireServer(unpack(g))end)c:Button("Smile2 Head",function()local g={[1]="LoadAvatarAsset",[2]=6809319263,[3]="HatAccessory"}game:GetService("ReplicatedStorage").PlayerChannel:FireServer(unpack(g))end)c:Button("1 Eye Head",function()local g={[1]="LoadAvatarAsset",[2]=6773734422,[3]="HatAccessory"}game:GetService("ReplicatedStorage").PlayerChannel:FireServer(unpack(g))end)c:Box("Custom Hat",function(C,D)if D then local g={[1]="LoadAvatarAsset",[2]=tonumber(C),[3]="HatAccessory"}game:GetService("ReplicatedStorage").PlayerChannel:FireServer(unpack(g))end end)c:Button("Reset Outfit",function()local g={[1]="ResetAvatarAppearance",[2]=true}game:GetService("ReplicatedStorage").PlayerChannel:FireServer(unpack(g))end)c:Slider("Walkspeed",16,120,5,function(E)game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed=E end)c:Slider("JumpPower",50,300,20,function(E)game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower=E end)e:Button("Bring Trees Mailboxes",function()if getgenv().nhekee or getgenv().hekee then local F={}local G={}for H,I in pairs(workspace:GetDescendants())do if game.Players.LocalPlayer.Character:FindFirstChild('Head')and I:IsA("BasePart"or"UnionOperation"or"Model")and I.Anchored==false and not I:IsDescendantOf(game.Players.LocalPlayer.Character)and I.Name=="Torso"==false and I.Name=="Head"==false and I.Name=="Right Arm"==false and I.Name=="Left Arm"==false and I.Name=="Right Leg"==false and I.Name=="Left Leg"==false and I.Name=="HumanoidRootPart"==false then for j,w in pairs(I:GetChildren())do if w:IsA("BodyPosition")or w:IsA("BodyGyro")then w:Destroy()end end;local J=Instance.new("BodyPosition")J.Parent=I;J.MaxForce=Vector3.new(math.huge,math.huge,math.huge)table.insert(F,J)if not table.find(G,I)then table.insert(G,I)end end end;for j,w in pairs(F)do w.Position=game.Players.LocalPlayer.Character.Head.Position end;wait(1)for j,k in pairs(G)do for j,w in pairs(k:GetChildren())do if w:IsA("BodyPosition")or w:IsA("BodyGyro")then w:Destroy()end end end;G={}else workspace.MessageService.Dialog.Dialog:Fire("Bring Script Warning","Enable UnAnchor Trees and UnAnchor Mailboxes","ok","",true,true)end end)c:Toggle("Noclip",false,function(K)getgenv().trfffffinketcs=K;game:GetService("RunService").RenderStepped:Connect(function()if getgenv().trfffffinketcs then game.Players.LocalPlayer.Character.Humanoid:ChangeState(11)end end)end)c:Button("Rejoin Server",function()game:GetService("TeleportService"):Teleport(game.PlaceId)end)c:Button("Reset Character",function()game.Players.LocalPlayer.Character:Remove()end)b:Label("UnAnchored Fun Script",Color3.fromRGB(127,143,166))b:Button("0 Gravity Unanchored Things",function()spawn(function()while true do game.Players.LocalPlayer.MaximumSimulationRadius=math.pow(math.huge,math.huge)*math.huge;game.Players.LocalPlayer.SimulationRadius=math.pow(math.huge,math.huge)*math.huge;game:GetService("RunService").Stepped:wait()end end)local function L(I)if I:FindFirstChild("BodyForce")then return end;local M=Instance.new("BodyForce")M.Force=I:GetMass()*Vector3.new(0,workspace.Gravity,0)M.Parent=I end;for j,k in ipairs(workspace:GetDescendants())do if k:IsA("Part")and k.Anchored==false then if not k:IsDescendantOf(game.Players.LocalPlayer.Character)then L(k)end end end;workspace.DescendantAdded:Connect(function(I)if I:IsA("Part")and I.Anchored==false then if not I:IsDescendantOf(game.Players.LocalPlayer.Character)then L(I)end end end)end)b:Button("Spin Teleport Unanchored [E]",function()local N=game:GetService("UserInputService")local O=game:GetService("Players").LocalPlayer:GetMouse()local P=Instance.new("Folder",game:GetService("Workspace"))local Q=Instance.new("Part",P)local R=Instance.new("Attachment",Q)Q.Anchored=true;Q.CanCollide=false;Q.Transparency=1;local S=O.Hit+Vector3.new(0,5,0)local T=coroutine.create(function()settings().Physics.AllowSleep=false;while game:GetService("RunService").RenderStepped:Wait()do for H,U in next,game:GetService("Players"):GetPlayers()do if U~=game:GetService("Players").LocalPlayer then U.MaximumSimulationRadius=0;sethiddenproperty(U,"SimulationRadius",0)end end;game:GetService("Players").LocalPlayer.MaximumSimulationRadius=math.pow(math.huge,math.huge)setsimulationradius(math.huge)end end)coroutine.resume(T)local function V(k)if k:IsA("Part")and k.Anchored==false and k.Parent:FindFirstChild("Humanoid")==nil and k.Parent:FindFirstChild("Head")==nil and k.Name~="Handle"then O.TargetFilter=k;for H,W in next,k:GetChildren()do if W:IsA("BodyAngularVelocity")or W:IsA("BodyForce")or W:IsA("BodyGyro")or W:IsA("BodyPosition")or W:IsA("BodyThrust")or W:IsA("BodyVelocity")or W:IsA("RocketPropulsion")then W:Destroy()end end;if k:FindFirstChild("Attachment")then k:FindFirstChild("Attachment"):Destroy()end;if k:FindFirstChild("AlignPosition")then k:FindFirstChild("AlignPosition"):Destroy()end;if k:FindFirstChild("Torque")then k:FindFirstChild("Torque"):Destroy()end;k.CanCollide=false;local X=Instance.new("Torque",k)X.Torque=Vector3.new(100000,100000,100000)local Y=Instance.new("AlignPosition",k)local Z=Instance.new("Attachment",k)X.Attachment0=Z;Y.MaxForce=9999999999999999;Y.MaxVelocity=math.huge;Y.Responsiveness=200;Y.Attachment0=Z;Y.Attachment1=R end end;for H,k in next,game:GetService("Workspace"):GetDescendants()do V(k)end;game:GetService("Workspace").DescendantAdded:Connect(function(k)V(k)end)N.InputBegan:Connect(function(_,a0)if _.KeyCode==Enum.KeyCode.E and not a0 then S=O.Hit+Vector3.new(0,5,0)end end)spawn(function()while game:GetService("RunService").RenderStepped:Wait()do R.WorldCFrame=S end end)end)b:Label("Server-Side 1",Color3.fromRGB(127,143,166))b:Box("FE Play Song",function(a1,a2)if a2 then getgenv().audioId=a1;getgenv().soundVolume=10;local a3=game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Menu.Emotions;local a4=game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Menu.Emotions.ScrollingFrame.List;local a5=game:GetService("Players").LocalPlayer.PlayerGui.MainGui.Menu.Emotions.ScrollingFrame.List.Template;local a6={["Name"]='Clap',["GroupColor"]='Bright blue'}local a7={["Sleep"]={["SoundLooped"]=true,["R15"]=4308418502,["FaceId"]=66329905,["Object"]='Sleep',["Name"]='Sleep',["R6"]=868450390,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["Volume"]=soundVolume,["MovementCancel"]=true},["Bye"]={["Name"]='Bye',["R6"]=154179312,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308390587,["Object"]='Bye'},["Point"]={["Name"]='Point',["R6"]=154188723,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308408568,["Object"]='Point'},["Bathtub"]={["Name"]='Bathtub',["R6"]=1799552363,["Priority"]='Enum.AnimationPriority.Core',["R15"]=1794938782,["Object"]='Bathtub'},["Glee"]={["Object"]='Glee',["Name"]='Glee',["FaceId"]=27802003,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308399012,["R6"]=154159852},["Coffin"]={["Name"]='Coffin',["MovementCancel"]=true,["R15"]=2506115448,["Priority"]='Enum.AnimationPriority.Action',["Object"]='Coffin',["R6"]=2506141081},["Twist"]={["Name"]='Twist',["MovementCancel"]=true,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308333353,["Object"]='Twist'},["ToolHold"]={["Name"]='ToolHold',["R6"]=182393478,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308323620,["Object"]='ToolHold'},["Confused"]={["Object"]='Confused',["Name"]='Confused',["FaceId"]=120250454,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308393154,["R6"]=154183110},["DrinkSmoothie"]={["Object"]='DrinkSmoothie',["Priority"]='Enum.AnimationPriority.Action',["Name"]='DrinkSmoothie',["R15"]=3339779154},["DrinkCoffee"]={["Object"]='DrinkCoffee',["Priority"]='Enum.AnimationPriority.Action',["Name"]='DrinkCoffee',["R15"]=3339576493},["Shocked"]={["Object"]='Shocked',["Name"]='Shocked',["FaceId"]=1601874588,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["R15"]=1602091152,["R6"]=1620310558},["Laugh"]={["Object"]='Laugh',["Name"]='Laugh',["FaceId"]=32063242,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308402710,["R6"]=154166518},["Idle"]={["Name"]='Idle',["Weight"]=0.4,["R15"]=507766388,["Priority"]='Enum.AnimationPriority.Core',["Object"]='Idle',["R6"]=180435571},["Jump"]={["Name"]='Jump',["Weight"]=0.7,["R15"]=507765000,["Priority"]='Enum.AnimationPriority.Core',["Object"]='Jump',["R6"]=125750702},["Sad"]={["Object"]='Sad',["Name"]='Sad',["FaceId"]=76690153,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308410706,["R6"]=153230853},["Run"]={["Name"]='Run',["Weight"]=1,["R15"]=507767714,["Priority"]='Enum.AnimationPriority.Core',["Object"]='Run',["R6"]=180426354},["Swim"]={["Name"]='Swim',["R6"]=865902879,["Priority"]='Enum.AnimationPriority.Core',["R15"]=507784897,["Object"]='Swim'},["SwimIdle"]={["Name"]='SwimIdle',["Weight"]=0.5,["R15"]=507785072,["Priority"]='Enum.AnimationPriority.Core',["Object"]='SwimIdle',["R6"]=865918502},["ConfusionOrb"]={["Name"]='ConfusionOrb',["R6"]=866550588,["Priority"]='Enum.AnimationPriority.Action',["R15"]=866541157,["Object"]='ConfusionOrb'},["Punch"]={["Name"]='Punch',["R6"]=3175899997,["Priority"]='Enum.AnimationPriority.Action',["R15"]=3175791062,["Object"]='Punch'},["Amazed"]={["Object"]='Amazed',["Name"]='Amazed',["FaceId"]=45528113,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["R15"]=154174346,["R6"]=154174346},["Walk"]={["Name"]='Walk',["Weight"]=0.6,["R15"]=507777826,["Priority"]='Enum.AnimationPriority.Core',["Object"]='Walk',["R6"]=180426354},["Swing"]={["Name"]='Swing',["MovementCancel"]=true,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308330448,["Object"]='Swing'},["Shuffle"]={["Name"]='Shuffle',["MovementCancel"]=true,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308343244,["Object"]='Shuffle'},["Whistle"]={["Object"]='Whistle',["Name"]='Whistle',["Weight"]=0.4,["R15"]=4308430737,["Priority"]='Enum.AnimationPriority.Action',["R6"]=180435571,["FaceId"]=22877631},["Cheer"]={["Object"]='Cheer',["Name"]='Cheer',["FaceId"]=27802003,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["R15"]=507770677,["R6"]=129423030},["Evil"]={["Object"]='Evil',["Name"]='Evil',["FaceId"]=1604383339,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308438228,["R6"]=1620296629},["HipHop"]={["Name"]='HipHop',["MovementCancel"]=true,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308346808,["Object"]='HipHop'},["Dance2"]={["Name"]='Dance2',["MovementCancel"]=true,["R15"]=507776043,["Priority"]='Enum.AnimationPriority.Action',["Object"]='Dance2',["R6"]=182436842},["Dance3"]={["Name"]='Dance3',["MovementCancel"]=true,["R15"]=507777268,["Priority"]='Enum.AnimationPriority.Action',["Object"]='Dance3',["R6"]=182436935},["SitSeat"]={["Name"]='SitSeat',["Weight"]=0.99,["R15"]=2506281703,["Priority"]='Enum.AnimationPriority.Core',["Object"]='SitSeat',["R6"]=178130996},["Think"]={["Object"]='Think',["Name"]='Think',["FaceId"]=209715003,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308415882,["R6"]=154185274},["Wave"]={["Name"]='Wave',["R6"]=128777973,["Priority"]='Enum.AnimationPriority.Action',["R15"]=507770239,["Object"]='Wave'},["Eat"]={["Object"]='Eat',["Priority"]='Enum.AnimationPriority.Action',["Name"]='Eat',["R15"]=3343204532},["Fall"]={["Name"]='Fall',["Weight"]=0.7,["R15"]=507767968,["Priority"]='Enum.AnimationPriority.Core',["Object"]='Fall',["R6"]=180436148},["ThrowCoin"]={["Name"]='ThrowCoin',["R6"]=156055482,["Priority"]='Enum.AnimationPriority.Action',["R15"]=867194400,["Object"]='ThrowCoin'},["Easy"]={["Name"]='Easy',["MovementCancel"]=true,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308337079,["Object"]='Easy'},["Driving"]={["Name"]='Driving',["Weight"]=0.99,["R15"]=866020346,["Priority"]='Enum.AnimationPriority.Core',["Object"]='Driving',["R6"]=178130996},["Sit"]={["Name"]='Sit',["MovementCancel"]=true,["R15"]=4308421826,["Priority"]='Enum.AnimationPriority.Action',["Object"]='Sit',["R6"]=868508890},["SleepSeat"]={["SoundLooped"]=true,["R15"]=4308318405,["FaceId"]=66329905,["Object"]='SleepSeat',["Name"]='SleepSeat',["R6"]=869468579,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["Volume"]=soundVolume,["MovementCancel"]=true},["Marashin"]={["Name"]='Marashin',["MovementCancel"]=true,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308362239,["Object"]='Marashin'},["Scared"]={["Object"]='Scared',["Name"]='Scared',["FaceId"]=47206380,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308413393,["R6"]=154170755},["Clap"]={["Name"]='Clap',["R6"]=868730451,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308424082,["Object"]='Clap'},["HipHop2"]={["Name"]='HipHop2',["MovementCancel"]=true,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308356261,["Object"]='HipHop2'},["Die"]={["Object"]='Die',["R15"]=4308443969,["Name"]='Die',["MovementCancel"]=true,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["R6"]=1620270981,["FaceId"]=1604616024},["Disgust"]={["Object"]='Disgust',["Name"]='Disgust',["FaceId"]=1598203828,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308435046,["R6"]=1620305485},["Hi"]={["Name"]='Hi',["R6"]=154179312,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308390587,["Object"]='Hi'},["Flair"]={["Name"]='Flair',["MovementCancel"]=true,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308358633,["Object"]='Flair'},["Dance"]={["Name"]='Dance',["MovementCancel"]=true,["R15"]=507771019,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["Object"]='Dance',["R6"]=182435998},["Climb"]={["Name"]='Climb',["R6"]=180436334,["Priority"]='Enum.AnimationPriority.Core',["R15"]=507765644,["Object"]='Climb'},["WashHands"]={["Name"]='WashHands',["R6"]=1620296629,["Priority"]='Enum.AnimationPriority.Action',["R15"]=1799726387,["Object"]='WashHands'},["ScaredOpeingPumpkin"]={["Object"]='ScaredOpeingPumpkin',["Name"]='ScaredOpeingPumpkin',["FaceId"]=47206380,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Idle',["R15"]=867226524,["R6"]=154170755},["Angry"]={["Object"]='Angry',["Name"]='Angry',["FaceId"]=14020216,["SoundId"]=audioId,["Priority"]='Enum.AnimationPriority.Action',["R15"]=4308387518,["R6"]=154168543}}local a8=game:GetService("Workspace").Main.LoadSoundsIntoHead;for a9,aa in pairs(game:service'Players'.LocalPlayer.Character.Head:GetChildren())do if aa:IsA'Sound'then aa:Destroy()end end;a8:FireServer(a7)wait(.75)game:GetService("Players").LocalPlayer.PlayerGui.UIEvents.ListItemPressed:Fire(a3,a4,a5,a6)end end)b:Toggle("FE Spam Sounds",false,function(ab)getgenv().hit=ab;while wait()do if getgenv().hit then for j,k in pairs(game.Workspace:GetDescendants())do if k:IsA("Sound")then k:Play()end end end end end)b:Toggle("Spam Boxes",false,function(ac)getgenv().trin1eeeeeekets=ac;while true do wait(.20)if getgenv().trin1eeeeeekets then pcall(function()for H,k in pairs(workspace.SupplyButtons:GetDescendants())do if k:IsA("TouchTransmitter")then firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,k.Parent,0)wait()firetouchinterest(game.Players.LocalPlayer.Character.HumanoidRootPart,k.Parent,1)end end end)end end end)b:Label("Auto Farm",Color3.fromRGB(127,143,166))b:Button("Autofarm Gui",function()loadstring(game:HttpGet("https://gist.githubusercontent.com/TurkOyuncu99/9b9d62e9068d795f708c51551d439d21/raw/84a28a8d1fc501b9d200e8a2bd7cc831df0fbacf/gistfile1.txt",true))()end)d:Label("Teleport Area",Color3.fromRGB(127,143,166))d:Button("Starting Zone",function()game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(49,3,198)end)d:Button("Cashier Area",function()game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(48,4,80)end)d:Button("Cook Area",function()game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(42,4,61)end)d:Button("Boxer Area",function()game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(55,4,31)end)d:Button("Supplier Area",function()game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(8,13,-1020)end)d:Button("Delivery Area",function()game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(64,4,-17)end)d:Button("Manager Area",function()game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(23.7,2.59944,6.5)end)d:Box("Goto Player",function(ad,ae)if ae and game.Players[ad]then game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=CFrame.new(game.Players[ad].Character.HumanoidRootPart.Position)end end)b:Button("Anti Vote Kick",function()game:GetService("RunService").Heartbeat:Connect(function()if game.Players.LocalPlayer.PlayerGui.MainGui.Prompts.Ban.KickPlayer.Text==game.Players.LocalPlayer.Name then game:GetService("TeleportService"):Teleport(game.PlaceId)end end)end)a:Keybind("Tab")pcall(function()for j,k in pairs(game:GetDescendants())do if k:IsA("Model")and k.Name=="Tot Slide"and k:FindFirstChildWhichIsA"RemoteEvent"then k.Parent=game.JointsService end end;workspace.MessageService.Dialog.Dialog:Fire("Important","Made By ameicaa","ok","",true,true)game.Workspace["Teleport to Party Island"]:Destroy()game.ReplicatedStorage.LibraryFolder.ErrorLoggerLocal:Destroy()game.Workspace.Main.DataStoreError:Destroy()game.Workspace.Main.RecordLocalError:Destroy()game:GetService("RunService").RenderStepped:Connect(function()game.Players.LocalPlayer.PlayerGui.MainGui.Other.PaintBucketColorPicker.Visible=false;game.Players.LocalPlayer.PlayerGui.MainGui.Notifications.PaintBucketHelp.Visible=false;game.Players.LocalPlayer.PlayerGui.MainGui.Notifications.DoubleTime.Visible=false end)while wait(20)do for j,k in pairs(game:GetService("Players"):GetChildren())do if k.Name~=game:GetService("Players").LocalPlayer.Name and k.DisplayName~=k.Name then k.Name=k.DisplayName end end end end)
end)

local main = Window:NewTab("Player")
local mainSection = main:NewSection("Power chits")


mainSection:NewTextBox("Chat Spamer", "", function(txt)
    print(txt)
        local args = {
        [1] = txt,
        [2] = false
    }
    
    workspace.Main.Chatted:FireServer(unpack(args))
    workspace.Main.Chatted:FireServer(unpack(args))
    workspace.Main.Chatted:FireServer(unpack(args))
    workspace.Main.Chatted:FireServer(unpack(args))
    workspace.Main.Chatted:FireServer(unpack(args))
    workspace.Main.Chatted:FireServer(unpack(args))
    workspace.Main.Chatted:FireServer(unpack(args))
    workspace.Main.Chatted:FireServer(unpack(args))
    workspace.Main.Chatted:FireServer(unpack(args))
    workspace.Main.Chatted:FireServer(unpack(args))
    workspace.Main.Chatted:FireServer(unpack(args))
    workspace.Main.Chatted:FireServer(unpack(args))
    workspace.Main.Chatted:FireServer(unpack(args))
    workspace.Main.Chatted:FireServer(unpack(args))
    workspace.Main.Chatted:FireServer(unpack(args))

end)

mainSection:NewSlider("Walkspeed", "Changes the walkspeed", 250, 16, function(v)
     game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = v
end)

mainSection:NewSlider("Jumppower", "Changes the jumppower", 250, 50, function(v)
    game.Players.LocalPlayer.Character.Humanoid.JumpPower = v
end)

local Teleport = Window:NewTab("Teleport")
     local TeleportSection = Teleport:NewSection("Teleports")

     TeleportSection:NewButton("Home", "teleport to your house", function()
         local args = {
         [1] = "TeleportHome"
     }

     game:GetService("ReplicatedStorage").PlayerChannel:FireServer(unpack(args))
         print("Clicked")
     end)

     TeleportSection:NewButton("Starting Zone", "teleport your Starting Zone", function()
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(49, 3, 198)
         print("Clicked")
     end)

     TeleportSection:NewButton("Cashier Area", "teleport your Cashier Area", function()
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(48, 4, 80)
         print("Clicked")
     end)

     TeleportSection:NewButton("Cook Area", "teleport your Cook Area", function()
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(42, 4, 61)
     end)


     TeleportSection:NewButton("Manager Area", "teleport your Manager Area", function()
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(37, 4, 3)
         print("Clicked")
     end)

     TeleportSection:NewButton("Boxer Area", "teleport your Boxer Area", function()
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(55, 4, 31)
         print("Clicked")
     end)

     TeleportSection:NewButton("Supplier Area", "teleport your Supplier Area", function()
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(8, 13, -1020)
         print("Clicked")
     end)

     TeleportSection:NewButton("Delivery Area", "teleport your Delivery Area", function()
         game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(64, 4, -17)
         print("Clicked")
     end)

local Settings = Window:NewTab("Settings")
local SettingsSection = Settings:NewSection("Settings")

SettingsSection:NewButton("FPS", "ButtonInfo", function()
    local decalsyeeted = true -- Leaving this on makes games look shitty but the fps goes up by at least 20.
local g = game
local w = g.Workspace
local l = g.Lighting
local t = w.Terrain
t.WaterWaveSize = 0
t.WaterWaveSpeed = 0
t.WaterReflectance = 0
t.WaterTransparency = 0
l.GlobalShadows = false
l.FogEnd = 9e9
l.Brightness = 0
settings().Rendering.QualityLevel = "Level01"
for i,v in pairs(g:GetDescendants()) do
 if v:IsA("Part") or v:IsA("Union") or v:IsA("MeshPart") then
 v.Material = "Plastic"
v.Reflectance = 0
elseif v:IsA("Decal") and decalsyeeted then 
v.Transparency = 1
elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then 
v.Lifetime = NumberRange.new(0)
 end
end
end)
