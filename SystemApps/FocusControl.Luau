game["Run Service"].RenderStepped:Connect(function()
	for i,v:CanvasGroup in pairs(script.Parent.Parent.ForegroundApps:GetChildren()) do
		if v:IsA("CanvasGroup") then
			v.ZIndex=2
			if v.IsFocused.Value == true then
				v.ZIndex=3
			end
		end
	end
end)
