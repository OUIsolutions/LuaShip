private_lua_ship.create_machine = function(start_image)
    local self_obj                = {}
    self_obj.docker_file          = "FROM: " .. start_image .. "\n"
    self_obj.add_comptime_command = function(command)
        private_lua_ship_machine_methods.add_comptime_command(self_obj, command)
    end

    self_obj.add_runtime_command  = function(command)
        private_lua_ship_machine_methods.add_runtime_command(self_obj, command)
    end

    self_obj.copy                 = function(host_data, machine_dest)
        private_lua_ship_machine_methods.copy(self_obj, host_data, machine_dest)
    end

    self_obj.save_to_file         = function(filename)
        private_lua_ship_machine_methods.save_to_file(self_obj, filename)
    end
    return self_obj
end

if io then
    if io.open then
        private_lua_ship.open = io.open
    end
end
