
--- Glass nodes.
--
-- @module nodes


local S = core.get_translator()


local colored = core.global_exists("unifieddyes") ~= nil
local glass_sounds = core.global_exists("sounds") and sounds.node_glass() or nil

local base_def = {
	drawtype = "glasslike_framed_optional",
	paramtype = "light",
	paramtype2 = colored and "color" or "glasslikeliquidlevel",
	palette = colored and "unifieddyes_palette_extended.png" or nil,
	sunlight_propagates = true,
	is_ground_content = false,
	sounds = glass_sounds,
	groups = {
		cracky = 3,
		oddly_breakable_by_hand = 3,
		ud_param2_colorable = colored and 1 or nil,
		glass = 1,
	},
}

local nodes = {
	plain = {
		description = S("Glass"),
		tiles = {"glass_plain.png", "glass_plain_detail.png"},
		recipe = "group:sand",
	},
	streakless = {
		description = S("Streakless Glass"),
		tiles = {"glass_streakless.png", "glass_streakless_detail.png"},
		recipe = "glass:plain",
	},
	obsidian = {
		description = S("Obsidian Glass"),
		tiles = {"glass_obsidian.png", "glass_obsidian_detail.png"},
		recipe = core.registered_items["default:obsidian_shard"] and "default:obsidian_shard" or nil,
	},
}

for name, def in pairs(nodes) do
	for k, v in pairs(base_def) do
		def[k] = v
	end

	core.register_node("glass:" .. name, def)

	if def.recipe then
		core.register_craft({
			type = "cooking",
			output = "glass:" .. name,
			recipe = def.recipe,
		})
	end
end


if core.settings:get_bool("glass.override_default", true) then
	local glass_overrides = {
		["default:glass"] = "glass:plain",
		["default:obsidian_glass"] = "glass:obsidian",
	}

	for glass_old, glass_new in pairs(glass_overrides) do
		if core.registered_nodes[glass_old] then
			core.unregister_item(glass_old)
			core.clear_craft({output=glass_old})
		end

		core.register_alias(glass_old, glass_new)
	end
end
