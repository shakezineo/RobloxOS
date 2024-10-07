local Anim=require(script.Parent.Animations)

local Arch = {}

function Arch.OpenApp(ClonedAppFile:StringValue,Forwarding:any?,yieldToClose:boolean?)
	local errappClone = ClonedAppFile
	local uis = game.UserInputService
	if ClonedAppFile.Value == "rox" or ClonedAppFile.Value=="rsh" then
		if ClonedAppFile.Value=="rsh" then
			
		else
			if Forwarding then
				if errappClone.appFrame:FindFirstChild("Forwarding") then
					local forw = errappClone.appFrame:FindFirstChild("Forwarding")
					forw.Value=Forwarding
				end
			end
			errappClone.appFrame.GroupTransparency=1
			errappClone.Parent=script.Parent.Parent.Parent.BackgroundApps
			errappClone.Name=errappClone.Name..#script.Parent.Parent.Parent.ForegroundApps:GetChildren()
			errappClone.appFrame.AppScript.Enabled=true
			errappClone.appFrame.UIScale.Scale=.8
			if errappClone.appFrame:FindFirstChild("AppIcon") then
				errappClone.appFrame.AppIcon.Visible=true
				errappClone.appFrame.AppIcon.Name=errappClone.Name
				errappClone.appFrame:FindFirstChild(errappClone.Name).Parent=script.Parent.Parent.Parent.Taskbar.AppContainer
			end
			errappClone.appFrame.SourceFile.Value=errappClone
			errappClone.appFrame.Name=errappClone.Name
			errappClone:FindFirstChild(errappClone.Name).Parent=script.Parent.Parent.Parent.ForegroundApps
			
			Anim.Expand(script.Parent.Parent.Parent.ForegroundApps:WaitForChild(errappClone.Name),.3,Enum.EasingStyle.Quart,1)
			Anim.FadeTransparency(script.Parent.Parent.Parent.ForegroundApps:WaitForChild(errappClone.Name),.25,0)
			if yieldToClose==true then
				errappClone.Destroying:Wait()
			end
		end
	else
		error("File type not supported.")
	end
end

return Arch
