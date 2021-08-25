
--- Glass initialization script.
--
-- @module init


if not core.global_exists("sounds") and not core.global_exists("default") then
	error("this mod requires either \"sounds\" or \"default\"")
end

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
	--"functions",
	"nodes",
	--"crafting",
}

for _, s in ipairs(scripts) do
	dofile(glass.modpath .. "/" .. s .. ".lua")
end
