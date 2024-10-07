local anim = require(script.Parent.Parent.System.API.Animations)

script.Parent.Parent.Taskbar.AppContainer.ChildAdded:Connect(function(v)
	local icon:TextButton = v.App
	icon.MouseButton1Click:Connect(function()
		local foreground = script.Parent.Parent.ForegroundApps
		for i,v in pairs(foreground:GetChildren()) do
			v.IsFocused.Value=false
		end
			foreground:FindFirstChild(v.Name).IsFocused.Value=true
			foreground:FindFirstChild(v.Name).Visible=true
			anim.Expand(foreground:FindFirstChild(v.Name),.3,Enum.EasingStyle.Quart,1)
			anim.FadeTransparency(foreground:FindFirstChild(v.Name),.25,0)
	end)
	icon:TweenPosition(UDim2.new(.512,0,0.475, 0),Enum.EasingDirection.Out,Enum.EasingStyle.Back,.5,true)
end)

script.Parent.Parent.Taskbar:GetPropertyChangedSignal("Position"):Connect(function()
	if script.Parent.Parent.Taskbar.Position.Y.Offset~=0 then
		script.Parent.Parent.ForegroundApps:TweenSize(UDim2.fromScale(1,1),"Out","Quart",.3,true)
	else
		script.Parent.Parent.ForegroundApps:TweenSize(UDim2.new(1,0,1,-51),"Out","Quart",.3,true)
	end
end)
