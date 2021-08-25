
glass = {}
glass.modname = core.get_current_modname()
glass.modpath = core.get_modpath(glass.modname)

function glass.log(lvl, msg)
		if not msg then
			msg = lvl
			lvl = nil
		end

		msg = "[" .. glass.modname .. "] " .. msg
		if not lvl then
			core.log(msg)
		else
			core.log(lvl, msg)
		end
end


local scripts = {
	"nodes",
}

for _, script in ipairs(scripts) do
	dofile(glass.modpath .. "/" .. script .. ".lua")
end
