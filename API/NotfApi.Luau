local Anim=require(script.Parent.Animations)
local Tray=script.Parent.Parent.Parent.NotificationTray
local NotfApi = {}
local function lol(Title:string, Desc:string,IconId:number?)
	local NotfClone = Tray.UIListLayout.NotificationTemplate:Clone()
	NotfClone.Frame.Usable.Title.Text=Title
	NotfClone.Frame.Usable.Body.Text=Desc
	NotfClone.Name=Title
	NotfClone.Destruct.Enabled=true
	if IconId then
		NotfClone.Frame.Usable.Icon.Image="rbxassetid://"..tostring(IconId)
	end
	NotfClone.Parent=Tray
	NotfClone.Frame:TweenPosition(UDim2.new(0,0,0,0),"Out","Quart",.3,true)
	local audioclone = script.Notification:Clone()
	audioclone.Parent=script.Parent.Parent.Parent.RbxSoundSystem
	audioclone:Play()
	wait(audioclone.TimeLength)
	audioclone:Destroy()
	--audioclone.Ended:Connect(function() audioclone:Destroy() end)

end
function NotfApi.ShowNotification(Title:string, Desc:string,IconId:number?)
	task.spawn(lol,Title,Desc,IconId)
end

return NotfApi
