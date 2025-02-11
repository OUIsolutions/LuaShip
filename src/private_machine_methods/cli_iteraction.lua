private_lua_ship_machine_methods.save_to_file = function(self_obj, filename)
    private_lua_ship.open(filename, "w"):write(self_obj.docker_file):close()
end

private_lua_ship_machine_methods.build = function(self_obj, name)
    if not name then
        name = "sha" .. private_lua_ship.sha256(self_obj.docker_file)
    end
    local filename = name .. ".Dockerfile"
    private_lua_ship_machine_methods.save_to_file(self_obj, filename)
    local command = self_obj.provider .. " build -t " .. name .. " -f " .. filename .. " .  --quiet"
    local ok = private_lua_ship.os_execute(command)
    if not ok then
        private_lua_ship.error("unable to execute command:\n" .. command)
    end
    private_lua_ship.os_remove(filename)
    return name
end
private_lua_ship_machine_methods.start  = function(self_obj,props)
    if not props.rebuild then
        props.rebuild = true 
    end 
    local name = props.name
    if props.rebuild then
        name = private_lua_ship_machine_methods.build(self_obj,props.name)
    end
    if not props.flags then
        props.flags = {}
    end
    local command = self_obj.provider .. " run -d "
    for i=1,#props.flags do
        local current_flag = props.flags[i]
        command = command .. "--"..current_flag[1]
        if current_flag[2] then
            command = command .. " "..current_flag[2].." "
        else
            command = command .. " "
        end
    end
    if not props.volumes then
        props.volumes = {}
    end
    for i=1,#props.volumes do
        local current_volume = props.volumes[i]
        command = command .. "-v "..current_volume[1]..":"..current_volume[2]..":z "
    end
    command = command .. name
    print(command)

end 