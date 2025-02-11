local ship = require("LuaShip")
imagem = ship.create_machine("alpine:latest")
imagem.provider = "podman"
imagem.add_comptime_command("apk update")
imagem.add_comptime_command("apk add --no-cache gcc musl-dev curl")
imagem.add_runtime_command("gcc /teste/teste.c -o /teste/teste.out")
imagem.start({
    flags={
        "--memory=200m",
        "--network=host"
    },
    volumes={
        {".","/teste"}
    }
})
