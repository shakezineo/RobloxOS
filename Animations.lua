local Anim = {}
local tweenS = game.TweenService

	function Anim.Expand(target:CanvasGroup, time:number, easemode:Enum.EasingStyle, TargetSize:number)
		
			if target:FindFirstChild("UIScale") then
				local Scale = target:FindFirstChild("UIScale")
				if TargetSize<=Scale.Scale then
					warn("The target size is lower or equal to the current size")
				end
					if target:IsA("CanvasGroup") then
						local Scale = target:FindFirstChild("UIScale")
						local Tinfo = TweenInfo.new(time,easemode,Enum.EasingDirection.Out)
						local Tween = tweenS:Create(Scale,Tinfo,{Scale=TargetSize})
						Tween:Play()
						return Tween
					else
						warn("The specified target is not a CanvasGroup. Current target is a ".. target.ClassName)
						return
					end
				
			else
				warn("The specified target must have an UIScale parented to it")	
				return
			end
		
	end

	function Anim.Collapse(target:CanvasGroup, time:number, easemode:Enum.EasingStyle, TargetSize:number)

		if target:FindFirstChild("UIScale") then
			local Scale = target:FindFirstChild("UIScale")
			if TargetSize>=Scale.Scale then
				warn("The target size is higher or equal to the current size")
			end
				if target:IsA("CanvasGroup") then
					local Scale = target:FindFirstChild("UIScale")
					local Tinfo = TweenInfo.new(time,easemode,Enum.EasingDirection.In)
					local Tween = tweenS:Create(Scale,Tinfo,{Scale=TargetSize})
					Tween:Play()
					return Tween
				else
					warn("The specified target is not a CanvasGroup. Current target is a ".. target.ClassName)
					return
				end
			
		else
			warn("The specified target has to have an UIScale parented to it")	
			return
		end
	end

function Anim.FadeBlack(time:number, yield:boolean?, GuiToDisable:ScreenGui?, GuiToEnable:ScreenGui?)
	time = time/2
	local target = script.Parent.Parent.Parent.Parent.Parent.TheBigBlack.Frame
	if yield==true then
		local Tinfo = TweenInfo.new(time,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
		tweenS:Create(target,Tinfo,{BackgroundTransparency=0}):Play()
		wait(time)
		if GuiToDisable then
			GuiToDisable.Enabled = false
		end
		if GuiToEnable then
			GuiToEnable.Enabled=true
		end
		tweenS:Create(target,Tinfo,{BackgroundTransparency=1}):Play()
		wait(time)
	else
		task.spawn(function()
			local Tinfo = TweenInfo.new(time,Enum.EasingStyle.Linear,Enum.EasingDirection.Out)
			tweenS:Create(target,Tinfo,{BackgroundTransparency=0}):Play()
			wait(time)
			if GuiToDisable then
				GuiToDisable.Enabled = false
			end
			if GuiToEnable then
				GuiToEnable.Enabled=true
			end
			tweenS:Create(target,Tinfo,{BackgroundTransparency=1}):Play()
		end)
	end
end

function Anim.FadeTransparency(target:CanvasGroup, time:number, TargetTrans:number)
	if TargetTrans==target.GroupTransparency then
			warn("The target transparency is equal to the current transparency")
	else
			if target:IsA("CanvasGroup") then
				local Scale = target:FindFirstChild("UIScale")
				local Tinfo = TweenInfo.new(time,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut)
				local Tween = tweenS:Create(target,Tinfo,{GroupTransparency=TargetTrans})
				Tween:Play()
				return Tween
			else
				warn("The specified target is not a CanvasGroup. Current target is a ".. target.ClassName)
				return
			end
	end
end

return Anim
