private_lua_ship_machine_methods.add_comptime_command = function(self_obj, command)
    self_obj.docker_file = self_obj.docker_file .. "RUN " .. command .. "\n"
end

private_lua_ship_machine_methods.add_runtime_command = function(self_obj, command)
    self_obj.docker_file = self_obj.docker_file .. "CMD " .. command .. "\n"
end

private_lua_ship_machine_methods.env = function(self_obj, key, value)
    self_obj.docker_file = self_obj.docker_file .. "ENV " .. key .. " " .. value .. "\n"
end

private_lua_ship_machine_methods.copy = function(self_obj, host_data, machine_dest)
    self_obj.docker_file = self_obj.docker_file .. "COPY " .. host_data .. " " .. machine_dest .. "\n"
end
