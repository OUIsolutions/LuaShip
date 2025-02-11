private_lua_ship.create_machine = function(start_image)
    local self_obj                = {}
    self_obj.contanizer           = "docker"
    self_obj.docker_file          = "FROM  " .. start_image .. "\n"
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

    self_obj.build                = function(name)
       return  private_lua_ship_machine_methods.build(self_obj, name)
    end
    self_obj.start                = function(props)
        private_lua_ship_machine_methods.start(self_obj, props)
    end

    return self_obj
end
