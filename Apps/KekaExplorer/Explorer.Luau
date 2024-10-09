local Desktop=script.Desktop
local AdBar = script.Parent.Addres.Text
local content = script.Parent.Content
local Filetemp=content.UIGridLayout.UnkFileTemp
local Foldertemp=content.UIGridLayout.Folder
local Shelltemp=content.UIGridLayout.Script
local CurDir=script.CurrentDir
local apifolder = script.Parent.Parent.ApiFolder.Value
local forwarding=script.Parent.Parent.Forwarding.Value
local rox = require(apifolder.UniversalRoxArch)
if forwarding then
	CurDir.Value=forwarding
end
local function Update()
	AdBar.Text=CurDir.Value:GetFullName():gsub("[%.]","/")

	for i,v in pairs(content:GetChildren()) do
		if v:IsA("ImageButton") then
			v:Destroy()
		end
	end
	
	for i,v in pairs(CurDir.Value:GetChildren()) do

		if v.ClassName~="Folder" and content.UIGridLayout:FindFirstChild(v.ClassName) then
			local FClone = content.UIGridLayout[v.ClassName]:Clone()
			FClone.Name=v.Name
			FClone.TextLabel.Text=FClone.Name
			FClone.Parent=content
			FClone.LayoutOrder=1
			if v:IsA("ImageLabel") or v:IsA("ImageButton") then
				FClone.Image=v.Image
			end
			
		elseif v:FindFirstChild("Type") then

			if v.Type.Value=="screenshot" then
				local FClone = content.UIGridLayout.Screenshot:Clone()
				FClone.Name=v.Name
				FClone.TextLabel.Text=FClone.Name
				FClone.Parent=content
				FClone.LayoutOrder=0
				if v:IsA("ImageLabel") or v:IsA("ImageButton")  then
					FClone.Image=v.Image
				end
			end	
		elseif v:IsA("StringValue") then
			if v.Value=="rox" then
				local FClone = content.UIGridLayout.App:Clone()
				FClone.Name=v.Name
				FClone.TextLabel.Text=FClone.Name
				FClone.Parent=content
				FClone.LayoutOrder=0
				if v.appFrame:FindFirstChild("AppIcon") then
					FClone.Image=v.appFrame.AppIcon.App.Icon.Image
				end
				
			end
		
		elseif v:GetChildren()[1] or v.ClassName=="Folder"then
				local FClone = Foldertemp:Clone()
				FClone.Name=v.Name
				FClone.TextLabel.Text=FClone.Name
				FClone.Parent=content
				FClone.LayoutOrder=0
				if v:IsA("ImageLabel") or v:IsA("ImageButton")  then
					FClone.Image=v.Image
				end
			
		else
			local FClone = Filetemp:Clone()
			FClone.Name=v.Name
			FClone.TextLabel.Text=FClone.Name
			FClone.Parent=content
			FClone.LayoutOrder=1
			if v:IsA("ImageLabel") or v:IsA("ImageButton") then
				FClone.Image=v.Image
			end

		end
		
	end
	local FClone = Foldertemp:Clone()
	FClone.Name="Back"
	FClone.TextLabel.Text="Go Back"
	FClone.Parent=content
	FClone.LocalScript:Destroy()
	for i,v in pairs(content:GetChildren()) do
		if v:IsA("ImageButton") then
			if v.Type.Value == "Folder" then
				v.MouseButton1Click:Connect(function()
					if CurDir.Value.Name=="RobloxOS 2" then
						if v.Name=="Back" then
							
						else
							CurDir.Value=game:FindFirstChild(v.Name)
						end
					else
						if v.Name=="Back" then
							CurDir.Value=CurDir.Value.Parent
						else
							CurDir.Value=CurDir.Value:FindFirstChild(v.Name)
						end
					end

					Update()
				end)
			elseif v.Type.Value=="Sound" then
				v.MouseButton1Click:Connect(function()
					local id = string.split(CurDir.Value:FindFirstChild(v.Name).SoundId,"/")
					
					local app = apifolder.Parent.Parent.Apps.UMPT:Clone()
					rox.OpenApp(app,tonumber(id[#id]))
				end)
				
			elseif v.Type.Value=="screenshot" or CurDir.Value:FindFirstChild(v.Name):IsA("ImageButton") or CurDir.Value:FindFirstChild(v.Name):IsA("ImageLabel") then
				v.MouseButton1Click:Connect(function()
					local id = CurDir.Value:FindFirstChild(v.Name).Image

					local app = apifolder.Parent.Parent.System.SystemApps.ImageViewer:Clone()
					rox.OpenApp(app,id)
				end)

			elseif v.Type.Value=="App" or CurDir.Value:FindFirstChild(v.Name):IsA("StringValue") then
				if CurDir.Value:FindFirstChild(v.Name).Value=="rox" then
					v.MouseButton1Click:Connect(function()
						local app = CurDir.Value:FindFirstChild(v.Name):Clone()
						rox.OpenApp(app)
					end)
				end
			
			end

		end
	end
	
end
Update()
local event1 = CurDir.Value.ChildAdded:Connect(Update)
local event2=CurDir.Value.ChildRemoved:Connect(Update)
local event3 = CurDir.Value.AncestryChanged:Connect(Update)

local currentSelectedFile

script.Parent.RightClicked.Event:Connect(function(file:Instance)
	currentSelectedFile=file
end)

game.ReplicatedStorage.ChosenContextOption.Event:Connect(function()
	local ChosenOption = _G.ChosenContextOption
	local RecievedOptions =_G.ContextOptions
	

	
		if RecievedOptions[1]=="Explorer" then
			if ChosenOption == 'Delete' then
				if currentSelectedFile then
					CurDir.Value:FindFirstChild(currentSelectedFile.Name):Destroy()
				end
			elseif ChosenOption=='Rename' then
				local RenPanel = apifolder.Parent.Parent.Apps.RenamePanel
				rox.OpenApp(RenPanel:Clone(),CurDir.Value:FindFirstChild(currentSelectedFile.Name),true)
				Update()
			elseif ChosenOption=="Properties" then
				local PropPanel = apifolder.Parent.Parent.Apps.PropertiesPanel
				rox.OpenApp(PropPanel:Clone(),CurDir.Value:FindFirstChild(currentSelectedFile.Name),true)
					Update()
			elseif ChosenOption=="Save" then
					game.CaptureService:PromptSaveCapturesToGallery({CurDir.Value:FindFirstChild(currentSelectedFile.Name).Image},Update)
			elseif ChosenOption=="Share" then
					game.CaptureService:PromptShareCapture(CurDir.Value:FindFirstChild(currentSelectedFile.Name).Image,"Taken on RobloxOS",Update,Update)
		elseif ChosenOption=='Explore App' then
			local RenPanel = apifolder.Parent.Parent.Apps.RenamePanel
			rox.OpenApp(apifolder.Parent.Parent.Apps.KekaExplorer:Clone(),CurDir.Value:FindFirstChild(currentSelectedFile.Name))
			Update()
			end
		end
	
end)

CurDir.Changed:Connect(function()
	event3:Disconnect()
	event2:Disconnect()
	event1:Disconnect()
	 event1 = CurDir.Value.ChildAdded:Connect(Update)
	event2=CurDir.Value.ChildRemoved:Connect(Update)
	event3 = CurDir.Value.AncestryChanged:Connect(Update)
end)
