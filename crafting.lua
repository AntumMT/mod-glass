
--- Glass craft recipes.
--
-- @module crafting


--- Cooking Recipes.
--
-- @section cooking


--- Glass recipe.
--
-- @recipe glass:plain
-- @rtype cooking
-- @output 1
-- @input group:sand
core.register_craft({
	type = "cooking",
	output = "glass:plain",
	recipe = "group:sand",
})


--- Obsidian glass recipe.
--
-- @recipe glass:obsidian
-- @rtype cooking
-- @output 1
-- @input default:obsidian_shard
core.register_craft({
	type = "cooking",
	output = "glass:obsidian",
	recipe = "default:obsidian_shard",
})
