script.Parent.IsFocused.Value=true
local db = false
script.Parent.UsableArea.ExplorerScript.Enabled=true
for i,v in pairs(script.Parent.Parent:GetChildren()) do
	v.IsFocused.Value=false
end
script.Parent.IsFocused.Value=true
local max = false
script.Parent.TitleBar.Buttons.Close.MouseButton1Click:Connect(function()
	if db==false then
		db=true
		local animModule=script.Parent.ApiFolder.Value.Animations
		local anim = require(animModule)
		anim.Collapse(script.Parent,.3,Enum.EasingStyle.Quart,.8)
		anim.FadeTransparency(script.Parent,.3,1)
		script.Parent.Parent.Parent.Taskbar.AppContainer:FindFirstChild(script.Parent.Name).App:TweenPosition(UDim2.new(.512,0,1.5, 0),Enum.EasingDirection.In,Enum.EasingStyle.Back,.5,false)
		wait(.5)
		script.Parent.Parent.Parent.Taskbar.AppContainer:FindFirstChild(script.Parent.Name):Destroy()
		script.Parent.SourceFile.Value:Destroy()
	end
end)

script.Parent.TitleBar.Buttons.Min.MouseButton1Click:Connect(function()
	if db==false then
		db=true
		
		local animModule=script.Parent.ApiFolder.Value.Animations
		local anim = require(animModule)
		anim.Collapse(script.Parent,.3,Enum.EasingStyle.Quart,.8)
		anim.FadeTransparency(script.Parent,.3,1)
		wait(.4)
		script.Parent.Visible=false
		db=false
	end
end)

script.Parent.TitleBar.Buttons.Max.MouseButton1Click:Connect(function()
	if db==false then
		db=true
		if not max then
			max=true
			local animModule=script.Parent.ApiFolder.Value.Animations
			local anim = require(animModule)
			local taskSize=script.Parent.ApiFolder.Value.Parent.Parent.Taskbar.Size.Y.Offset
			script.Parent:TweenSizeAndPosition(UDim2.new(1,0,1,0),UDim2.new(.5,0,.5,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,.3,true)
			wait(.3)
		else
			max=false
			local animModule=script.Parent.ApiFolder.Value.Animations
			local anim = require(animModule)
			script.Parent:TweenSizeAndPosition(UDim2.new(0, 1031,0, 525),UDim2.new(.5,0,.477,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quart,.3,true)
			wait(.3)
		end
		db=false
	end
end)

script.Parent.DragBegin:Connect(function()
	for i,v in pairs(script.Parent.Parent:GetChildren()) do
		v.IsFocused.Value=false
	end
	script.Parent.IsFocused.Value=true
end)

script.Parent.SourceFile.Value.Destroying:Connect(function()
	script.Parent:Destroy()
end)

