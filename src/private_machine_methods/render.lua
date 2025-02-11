private_lua_ship_machine_methods.save_to_file = function(self_obj, filename)
    private_lua_ship.open(filename, "w"):write(self_obj.docker_file)
end
