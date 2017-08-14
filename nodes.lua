--[[ LICENSE HEADER
  
  GNU Lesser General Public License version 2.1+
  
  Copyright © 2017 Perttu Ahola (celeron55) <celeron55@gmail.com>
  Copyright © 2017 Minetest developers & contributors
  
  See: docs/license-LGPL-2.1.txt
]]


--- Glass nodes.
--
-- @module nodes


-- Boilerplate to support localized strings if intllib mod is installed.
local S
if core.global_exists('intllib') then
	if intllib.make_gettext_pair then
		S = intllib.make_gettext_pair()
	else
		S = intllib.Getter()
	end
else
	S = function(s) return s end
end


local function dig_glass(pos, node, digger)
	local inv = digger:get_inventory()
	local can_dig = not core.is_protected(pos, digger:get_player_name()) and inv:room_for_item('main', node.name)
	
	if digger:is_player() then
		local meta = core.get_meta(pos)
		
		if can_dig then
			-- FIXME: Make a copy of InvRef to test room for dye
			inv:add_item('main', node.name)
			
			if meta then
				local dye = meta:get_string('dye')
				
				if dye and dye ~= '' then
					-- Don't allow players to dig node if no room for dye in inventory
					can_dig = inv:room_for_item('main', dye)
					
					if not can_dig then
						-- Remove added node from inventory
						inv:remove_item('main', node.name)
					else
						inv:add_item('main', dye)
					end
				end
			end
		end
	end
	
	if can_dig then
		core.remove_node(pos)
	end
end


--- Plain glass.
--
-- @node glass:plain
if not core.global_exists('unifieddyes') and not core.get_modpath('unifieddyes') then
	-- Non-colorable glass
	core.register_node('glass:plain', {
		description = S('Glass'),
		drawtype = 'glasslike_framed_optional',
		tiles = {'glass_plain.png', 'glass_plain_detail.png'},
		paramtype = 'light',
		paramtype2 = 'glasslikeliquidlevel',
		sunlight_propagates = true,
		is_ground_content = false,
		groups = {cracky=3, oddly_breakable_by_hand=3},
		sounds = glass.node_sounds(),
	})
else
	-- Colorable glass
	core.register_node('glass:plain', {
		description = S('Glass'),
		drawtype = 'glasslike_framed_optional',
		tiles = {'glass_plain.png', 'glass_plain_detail.png'},
		paramtype = 'light',
		paramtype2 = 'colorwallmounted',
		palette = 'unifieddyes_palette_colorwallmounted.png',
		sunlight_propagates = true,
		is_ground_content = false,
		groups = {cracky=3, oddly_breakable_by_hand=3, ud_param2_colorable=1},
		sounds = glass.node_sounds(),
		on_dig = dig_glass,
	})
end

core.register_alias('glass', 'glass:plain')
core.register_alias('glass:glass', 'glass:plain')


--- Obsidian glass.
--
-- @node glass:obsidian
core.register_node('glass:obsidian', {
	description = S('Obsidian Glass'),
	drawtype = 'glasslike_framed_optional',
	tiles = {'glass_obsidian.png', 'glass_obsidian_detail.png'},
	paramtype = 'light',
	paramtype2 = 'glasslikeliquidlevel',
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {cracky=3, oddly_breakable_by_hand=3},
	sounds = glass.node_sounds(),
})
core.register_alias('obsidian_glass', 'glass:obsidian')


-- Compatibility

if core.get_modpath('default') then
	core.unregister_item('default:glass')
	core.unregister_item('default:obsidian_glass')
end

core.register_alias_force('default:glass', 'glass:plain')
core.register_alias_force('default:obsidian_glass', 'glass:obsidian')
