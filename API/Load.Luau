local Load = {}
function Load.Load(assetsToLoad)
	local CP = game:GetService("ContentProvider")
	for i,v in pairs(assetsToLoad) do
		if v:IsA("ImageLabel") or v:IsA("ImageButton") then
			CP:PreloadAsync({v.Image})
		else
			CP:PreloadAsync({v})
		end
	end
end

function Load.LoadTable(Table)
	local CP = game:GetService("ContentProvider")
	for i,v in pairs(Table) do
			CP:PreloadAsync({v})
	end
end
return Load
