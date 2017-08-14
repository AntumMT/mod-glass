--- Glass functions.
--
-- @module functions


--- Sounds
--
-- @section sounds


--- Retrieves sounds for glass nodes.
--
-- @function glass.node_sounds
-- @tparam table table
function glass.node_sounds(table)
	table = table or {}
	table.footstep = table.footstep or {name='glass_footstep', gain=0.3}
	table.dig = table.dig or {name='glass_footstep', gain=0.5}
	table.dug = table.dug or {name='glass_break', gain=1.0}
	
	default.node_sound_defaults(table)
	return table
end
