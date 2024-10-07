local uis = game.UserInputService
local capture = game.CaptureService
local function what()
	
end
game.GuiService.ScreenshotHud.HideCoreGuiForCaptures=true
local function TakeScreenshot()
	capture:CaptureScreenshot(function(ready)
		local sshotframe=script.Parent.Parent.System.SShotFrame
		script.SShot:Play()

		sshotframe.ImageLabel.Image=ready
		sshotframe.ImageLabel.ImageTransparency=1
		sshotframe.Size=UDim2.fromScale(1,1)
		sshotframe.Position=UDim2.fromScale(.5,.5)
		sshotframe.Visible=true
		wait(.15)
		game.TweenService:Create(sshotframe.ImageLabel,TweenInfo.new(.4),{ImageTransparency=0}):Play()
		sshotframe:TweenSize(UDim2.new(.15,0,.15,0),Enum.EasingDirection.Out,Enum.EasingStyle.Quint,.5,true)
		sshotframe:TweenPosition(UDim2.new(0.914, 0,0.088, 0),Enum.EasingDirection.Out,Enum.EasingStyle.Sine,.4,true)
		local screenshotimage=script.Screenshot:Clone()
		screenshotimage.Parent=script.Parent.Parent.Desktop.DesktopShortcuts
		screenshotimage.Image=ready
		screenshotimage.Name="Screenshot"
		sshotframe.ImageLabel.MouseButton1Click:Connect(function()
			uis.MouseIconEnabled=true
			--capture:PromptShareCapture(ready,"Taken on RobloxOS",what,what)
			capture:PromptSaveCapturesToGallery({ready},what)
			uis.MouseIconEnabled=false
		end)
		wait(6)
		sshotframe:TweenPosition(UDim2.new(0.914, 0,-.5, 0),Enum.EasingDirection.In,Enum.EasingStyle.Quart,.5)
		wait(.5)
		sshotframe.Visible=false
		sshotframe.ImageLabel.ImageTransparency=1
		sshotframe.Size=UDim2.fromScale(1,1)
		sshotframe.Position=UDim2.fromScale(.5,.5)
	end)
end
uis.InputBegan:Connect(function(input)
	if input.KeyCode==Enum.KeyCode.Print or input.KeyCode==Enum.KeyCode.Insert then
		TakeScreenshot()
	end
end)

uis.TouchPinch:Connect(function(pos)
	print(#pos)
	if #pos>=2 then
		TakeScreenshot()
	end
end)
