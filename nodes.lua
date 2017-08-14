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


--- Plain glass.
--
-- @node glass:plain
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

core.register_alias('default:glass', 'glass:plain')
core.register_alias('default:obsidian_glass', 'glass:obsidian')
