--[[ LICENSE HEADER

  GNU Lesser General Public License version 2.1+

  Copyright © 2017 Perttu Ahola (celeron55) <celeron55@gmail.com>
  Copyright © 2017 Minetest developers & contributors

  See: docs/license-LGPL-2.1.txt
]]


--- Glass nodes.
--
-- @module nodes


local S = core.get_translator()


local enable_colors = core.global_exists('unifieddyes') or core.get_modpath('unifieddyes')


if enable_colors then
	local to_color = {
		'default:glass',
		'default:glass_cube',
		'default:glass_doublepanel',
		'default:glass_halfstair',
		'default:glass_innerstair',
		'default:glass_micropanel',
		'default:glass_microslab',
		'default:glass_nanoslab',
		'default:glass_outerstair',
		'default:glass_panel',
		'default:glass_thinstair',
		'default:obsidian_glass',
		'default:obsidian_glass_cube',
		'default:obsidian_glass_doublepanel',
		'default:obsidian_glass_halfstair',
		'default:obsidian_glass_innerstair',
		'default:obsidian_glass_micropanel',
		'default:obsidian_glass_microslab',
		'default:obsidian_glass_nanoslab',
		'default:obsidian_glass_outerstair',
		'default:obsidian_glass_panel',
		'default:obsidian_glass_thinstair',
	}

	local next = next
	for _, old_glass in ipairs(to_color) do

		local glass_def = {}
		for k, v in pairs(core.registered_nodes[old_glass]) do
			glass_def[k] = v
		end

		if next(glass_def) == nil then
			core.log('warning', old_glass .. ' not registered, skipping ...')
			goto continue
		end

		glass_def.paramtype2 = 'color'
		glass_def.palette = 'unifieddyes_palette_extended.png'
		glass_def.groups['ud_param2_colorable'] = 1
		glass_def.on_dig = unifieddyes.on_dig

		-- unregister old node
		core.registered_nodes[old_glass] = nil

		-- register new node
		core.register_node(':' .. old_glass, glass_def)


		::continue::
	end

	-- backward compat (1.0)
	if core.registered_nodes['default:glass'] then
		core.register_alias('glass:plain', 'default:glass')
	end
	if core.registered_nodes['default:obsidian_glass'] then
		core.register_alias('glass:obsidian', 'default:obsidian_glass')
	end
end
