private_lua_ship_machine_methods.add_comptime_command = function(self_obj, command)
    self_obj.docker_file = self_obj.docker_file .. "RUN " .. command .. "\n"
end

private_lua_ship_machine_methods.add_runtime_command = function(self_obj, command)
    self_obj.docker_file = self_obj.docker_file .. "CMD [" .. command .. "]\n"
end

private_lua_ship_machine_methods.copy = function(self_obj, host_data, machine_dest)

end
