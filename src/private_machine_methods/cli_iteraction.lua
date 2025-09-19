private_lua_ship_machine_methods.save_to_file = function(self_obj, filename)
    private_lua_ship.open(filename, "w"):write(self_obj.docker_file):close()
end

private_lua_ship_machine_methods.build        = function(self_obj, name)
    if not name then
        name = "sha" .. private_lua_ship.sha256(self_obj.docker_file)
    end
    local filename = self_obj.cache_folder .. "/" .. name .. ".Dockerfile"
    private_lua_ship_machine_methods.save_to_file(self_obj, filename)

    local redirect = ""
    if self_obj.quiet then
        redirect = " > /dev/null 2>&1 "
    end


    local command = self_obj.provider .. " build -t " .. name .. " -f " .. filename .. " . " .. redirect
    local ok = private_lua_ship.os_execute(command)
    if not ok then
        private_lua_ship.error("unable to execute command:\n" .. command)
    end
    private_lua_ship.os_remove(filename)
    return name
end

private_lua_ship_machine_methods.create_start_command = function(self_obj, props)
    if props.rebuild == nil then
        props.rebuild = true
    end
    local name = props.name
    if props.rebuild then
        name = private_lua_ship_machine_methods.build(self_obj, props.name)
    end
    if not props.flags then
        props.flags = {}
    end
    local command = self_obj.provider .. " run "
    
    
    for i = 1, #props.flags do
        local current_flag = props.flags[i]
        command = command .. current_flag .. " "
    end

    if not props.volumes then
        props.volumes = {}
    end
    for i = 1, #props.volumes do
        local current_volume = props.volumes[i]
        command = command .. "-v " .. current_volume[1] .. ":" .. current_volume[2] .. ":z "
    end
    command = command .. name
    if props.command then

        local format_command = function(command_props)
            local formmated_command = ""
            if type(command_props) == "string" then
                formmated_command = private_lua_ship.string.gsub(command_props, '"', '\\"')
            end
            return formmated_command
        end

        local formmated = format_command(props.command)

        if type(props.command) == "table" then
            local concat = ""
            for i=1, #props.command do
                if i > 1 then
                    concat = " && "
                end
                formmated = formmated .. concat ..  format_command(props.command[i])
            end

        end

        command = command .. ' sh -c "' .. formmated .. '"'
    end
    return command
end


private_lua_ship_machine_methods.start        = function(self_obj, props)
    local command = private_lua_ship_machine_methods.create_start_command(self_obj, props)
    if not command then
        private_lua_ship.error("unable to create start command")
    end
    local ok = private_lua_ship.os_execute(command)
    if not ok then
        private_lua_ship.error("unable to execute command:\n" .. command)
    end
end
