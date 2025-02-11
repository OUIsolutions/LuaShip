# LuaShip Documentation
## [Download Link](https://github.com/OUIsolutions/LuaShip/releases/download/0.0.1/LuaShip.lua)
LuaShip is a Lua library for managing containerized build environments. It provides a simple interface for creating and managing container images, executing commands, and handling file operations.

## Core Features

- Container image management with support for Docker and Podman
- File copying between host and container
- Environment variable configuration
- Build-time command execution
- Flexible container start options

## API Reference

### LuaShip Module

#### `create_machine(distro: string): LuaShipMachine`
Creates a new container machine instance based on the specified distribution.

**Parameters:**
- `distro`: Base container image (e.g., "alpine:latest")

**Returns:**
- A new `LuaShipMachine` instance

### LuaShipMachine
#### Properties

##### `provider: "podman" | "docker"`
Specifies the container runtime to use. Must be either "podman" or "docker".

##### `docker_file: string`
Reference to the generated Dockerfile string.

#### Methods

##### `add_comptime_command(command: string)`
Adds a command to be executed during image build time.

**Parameters:**
- `command`: Shell command to execute

##### `copy(host_data: string, dest_data: string)`
Copies files from host to container.

**Parameters:**
- `host_data`: Source path on host
- `dest_data`: Destination path in container

##### `env(name: string, value: string)`
Sets an environment variable in the container.

**Parameters:**
- `name`: Environment variable name
- `value`: Environment variable value

##### `save_to_file(filename: string)`
Saves the Dockerfile configuration to a file.

**Parameters:**
- `filename`: Target filename for the Dockerfile

##### `start(props: LuaShipStartProps)`
Starts the container with the specified configuration.

**Parameters:**
- `props`: Configuration object with the following properties:
  - `flags`: Array of container runtime flags (e.g., `["--memory=200m"]`)
  - `volumes`: Array of volume mappings `[["host_path", "container_path"]]`
  - `command`: Command to execute when starting the container

## Example Usage

```lua
local ship = require("LuaShip")

-- Create a new container machine
local image = ship.create_machine("alpine:latest")

-- Configure container runtime
image.provider = "podman"

-- Add build-time commands
image.add_comptime_command("apk update")
image.add_comptime_command("apk add --no-cache gcc musl-dev curl")

-- Copy files
image.copy("source.c", "source.c")

-- Start container with specific configuration
image.start({
    flags = {
        "--memory=200m",
        "--network=host"
    },
    volumes = {
        { ".", "/output" }
    },
    command = "gcc --static source.c -o /output/binary"
})
```

## Configuration

The following functions can be configured by the user to customize behavior:

- `LuaShip.open`: Customize file opening operations
- `LuaShip.os_execute`: Customize system command execution
- `LuaShip.os_remove`: Customize file removal operations
- `LuaShip.error`: Customize error handling

These functions can be overridden to implement custom logging, error handling, or system interaction behaviors.
