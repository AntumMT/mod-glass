--[[ LICENSE HEADER
  
  MIT Licensing
  
  Copyright © 2017 Jordan Irwin
  
  See: LICENSE.txt
]]

--- Glass initialization script.
--
-- @module init


glass = {}
glass.name = core.get_current_modname()
glass.path = core.get_modpath(glass.name)


local scripts = {
	'functions',
}

for _, s in ipairs(scripts) do
	dofile(glass.path .. '/' .. s .. '.lua')
end
