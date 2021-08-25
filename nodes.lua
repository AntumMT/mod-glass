
--- Glass nodes.
--
-- @module nodes


local S = core.get_translator()


local glass_nodes = {
	-- default
	{
		name = "default:glass",
		description = S("Glass"),
		tiles = {"glass_plain.png", "glass_plain_detail.png"},
	},
	{
		name = "default:obsidian_glass",
		description = S("Obsidian Glass"),
		tiles = {"glass_obsidian.png", "glass_obsidian_detail.png"},
	},
	-- stairs
	{
		name = "stairs:stair_glass",
	},
	{
		name = "stairs:stair_inner_glass",
	},
	{
		name = "stairs:stair_outer_glass",
	},
	{
		name = "stairs:slab_glass",
	},
	{
		name = "stairs:stair_obsidian_glass",
	},
	{
		name = "stairs:stair_inner_obsidian_glass",
	},
	{
		name = "stairs:stair_outer_obsidian_glass",
	},
	{
		name = "stairs:slab_obsidian_glass",
	},
	-- ???
	{
		name = "default:glass_cube",
	},
	{
		name = "default:glass_doublepanel",
	},
	{
		name = "default:glass_micropanel",
	},
	{
		name = "default:glass_microslab",
	},
	{
		name = "default:glass_nanoslab",
	},
	{
		name = "default:glass_panel",
	},
	{
		name = "default:obsidian_glass_cube",
	},
	{
		name = "default:obsidian_glass_doublepanel",
	},
	{
		name = "default:obsidian_glass_micropanel",
	},
	{
		name = "default:obsidian_glass_microslab",
	},
	{
		name = "default:obsidian_glass_nanoslab",
	},
	{
		name = "default:obsidian_glass_panel",
	},
	-- xpanes
	--[[ FIXME:
				- overriding paramtype2 = "facedir" causes ugly connections
				- connected nodes change color
	{
		name = "xpanes:pane_flat",
		description = S("Glass Pane"),
		paramtype2 = "facedir",
		drawtype = "nodebox",
		tiles = {
			"glass_plain_edge.png",
			"glass_plain_edge.png",
			"glass_plain_edge.png",
			"glass_plain_edge.png",
			"glass_plain.png",
			"glass_plain.png",
		},
		inventory_image = "default_glass.png",
		wield_image = "default_glass.png",
		node_box = {
			type = "fixed",
			fixed = {
				{-1/2, -1/2, -1/32, 1/2, 1/2, 1/32},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-1/2, -1/2, -1/32, 1/2, 1/2, 1/32},
			},
		},
		connect_sides = {"left", "right"},
		groups = {cracky=3, oddly_breakable_by_hand=3, pane=1},
		craft = {
			recipe = {
				{"default:glass", "default:glass", "default:glass"},
				{"default:glass", "default:glass", "default:glass"},
			},
		},
	},
	]]
}


local next = next
for _, gn in ipairs(glass_nodes) do
	if not gn.name or gn.name:trim() == "" then
		glass.log("error", "cannot register node without \"name\" attribute")
	else
		local node = core.registered_nodes[gn.name]

		if node then
			glass.log("info", "overriding node \"" .. gn.name .. "\" to be colorable")

			local groups = node.groups
			groups["ud_param2_colorable"] = 1

			core.override_item(gn.name, {
				paramtype2 = "color",
				palette = "unifieddyes_palette_extended.png",
				groups = groups,
				on_dig = unifieddyes.on_dig,
			})
		elseif gn.tiles then
			glass.log("info", "registering colorable node \"" .. gn.name .. "\"")

			local def = {
				description = gn.description,
				drawtype = gn.drawtype or "glasslike_framed_optional",
				tiles = gn.tiles,
				inventory_image = gn.inventory_image,
				wield_image = gn.wield_image,
				node_box = gn.node_box,
				selection_box = gn.selection_box,
				connect_sides = gn.connect_sides,
				--use_texture_alpha = "clip",
				paramtype = "light",
				--paramtype2 = gn.paramtype2 or "color",
				paramtype2 = "color",
				palette = "unifieddyes_palette_extended.png",
				sunlight_propagates = true,
				is_ground_content = false,
				groups = gn.groups or {cracky=3, oddly_breakable_by_hand=3},
				sounds = sounds.node_glass(),
				on_dig = unifieddyes.on_dig,
			}

			def.groups["ud_param2_colorable"] = 1

			core.register_node(":" .. gn.name, def)

			if gn.craft then
				core.unregister_craft({recipe=gn.craft.recipe})

				local craft_def = {
					output = gn.craft.output or gn.name,
					recipe = gn.craft.recipe,
				}
				if gn.craft.count then craft_def.output = craft_def.output .. " " .. gn.craft.count end

				core.register_craft(craft_def)
			end
		end
	end
end

-- backward compat (1.0)
if core.registered_nodes["default:glass"] then
	core.register_alias("glass:plain", "default:glass")
end
if core.registered_nodes["default:obsidian_glass"] then
	core.register_alias("glass:obsidian", "default:obsidian_glass")
end
