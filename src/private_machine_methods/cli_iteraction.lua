private_lua_ship_machine_methods.save_to_file = function(self_obj, filename)
    private_lua_ship.open(filename, "w"):write(self_obj.docker_file)
end

private_lua_ship_machine_methods.build = function(self_obj, name)
    if not name then
        name = private_lua_ship.sha256(self_obj.docker_file)
    end
    local filename = name .. ".Dockerfile"
    private_lua_ship_machine_methods.save_to_file(self_obj, filename)
    private_lua_ship.os_execute(
        self_obj.contanizer .. " -t " .. name .. "-f " .. filename .. " ."
    )
    private_lua_ship.os_execute(filename)
end
