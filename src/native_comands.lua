if io then
    if io.open then
        private_lua_ship.open = io.open
    end
end
if os then
    if os.execute then
        private_lua_ship.os_execute = os.execute
    end
    if os.remove then
        private_lua_ship.os_remove = os.remove
    end
end
private_lua_ship.error = error

if string then
    private_lua_ship.string = string
end 