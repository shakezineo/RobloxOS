local Context = {}
	local Arch=require(script.Parent.UniversalRoxArch)
	function Context.ShowContext(Options)
	local menu = script.Parent.Parent.Parent.Apps.Context:Clone()
	local opt=Options
		_G.ContextOptions=Options
		Arch.OpenApp(menu)
	end
return Context
