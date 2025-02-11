private_lua_ship.create_machine = function(start_image)
    local self_obj       = {}
    self_obj.docker_file = "FROM: " .. start_image .. "\n"
end
