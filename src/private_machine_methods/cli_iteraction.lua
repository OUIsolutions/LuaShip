private_lua_ship_machine_methods.save_to_file = function(self_obj, filename)
    private_lua_ship.open(filename, "w"):write(self_obj.docker_file):close()
end

private_lua_ship_machine_methods.build = function(self_obj, name)
    if not name then
        name = "sha" .. private_lua_ship.sha256(self_obj.docker_file)
    end
    local filename = name .. ".Dockerfile"
    private_lua_ship_machine_methods.save_to_file(self_obj, filename)
    local command = self_obj.contanizer .. " build -t " .. name .. " -f " .. filename .. " .  --quiet"
    local ok = private_lua_ship.os_execute(command)
    if not ok then
        private_lua_ship.error("unable to execute command:\n" .. command)
    end
    private_lua_ship.os_remove(filename)
end
private_lua_ship_machine_methods.start(self_obj,)
