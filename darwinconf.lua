---@class Darwin
darwin = darwin
local project = darwin.create_project("lua_ship")
project.add_lua_code("private_lua_ship = {}")
project.add_lua_code("private_lua_ship_machine_methods = {}")
local files = darwin.dtw.list_files_recursively("src", true)
for _, file in ipairs(files) do
    project.add_lua_file(file)
end
project.add_lua_file("types.lua")

project.generate_lua_file({ output = "LuaShip.lua" })
