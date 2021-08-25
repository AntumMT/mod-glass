
--- Glass functions.
--
-- @module functions


--- Sounds
--
-- @section sounds


--- Retrieves sounds for glass nodes.
--
-- @function glass.node_sounds
-- @tparam tbl table
function glass.node_sounds(tbl)
	tbl = tbl or {}
	tbl.footstep = tbl.footstep or {name="glass_footstep", gain=0.3}
	tbl.dig = tbl.dig or {name="glass_footstep", gain=0.5}
	tbl.dug = tbl.dug or {name="glass_break", gain=1.0}

	default.node_sound_defaults(tbl)
	return tbl
end
