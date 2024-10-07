local Mouse = {}
local mouseImage = script.Parent.Parent.Parent.Parent.Mouse

function Mouse.HideMouse()
	mouseImage.LocalScript.Enabled=false
	mouseImage.Visible = false
end

function Mouse.ShowMouse()
	mouseImage.Visible = true
	mouseImage.LocalScript.Enabled=true
	game.UserInputService.MouseIconEnabled=false
end

function Mouse.ChangeIcon(ImageID:string)
	if ImageID==nil then
		mouseImage.Image="rbxassetid://18509462276"
	else
		mouseImage.Image="rbxassetid://"..tostring(ImageID)
	end
end

return Mouse
