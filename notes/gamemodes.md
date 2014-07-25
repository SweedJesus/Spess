# Garry's Mod gamemode creation notes
Garry's Mod gamemodes are essentially a folder with a `.txt` file descripting the mod (base game, name, map prefix, some settings) and `.lua` files defining the mod functionality. When Garry's Mod starts up, it scans the gamemodes directory for gamemode subdirectories and tries to load them if they have a text file describing your gamemode.

Gamemodes are stored in:
``` Shell
...\SteamLibrary\steamapps\common\GarrysMod\garrysmod\gamemodes\
```

## Fundamental files
For any gamemode there must be a `"game-mode-name".txt` file which describes your gamemode and a `gamemode` subdirectory, both in the top level your gamemode's directory within `...\garrysmod\gamemodes\`.

e.g.
``` Shell
...\garrysmod\gamemodes\"my-game-mode"\mygame.txt
...\garrysmod\gamemodes\"my-game-mode"\gamemode\
```

Within `gamemodes\"game-mode-name"\gamemode\` must be the files `init.lua` for server gamemode initialization, `cl_init.lua` for client gamemode initialization and `shared.lua` for defining gamemode metadata and common functions/constants/enumerations/etc. for both server side and client side.

e.g.
``` Shell
...\garrysmod\gamemodes\"my-game-mode"\gamemode\init.lua
...\garrysmod\gamemodes\"my-game-mode"\gamemode\cl_init.lua
...\garrysmod\gamemodes\"my-game-mode"\gamemode\shared.lua
```

## My gamemode boiler plate
### mygame.txt
``` Json
"MyGame"
{
	"base"				"base"
	"title"				"MyGame"
	"maps"				"^mg_"
	"menusystem"	"1"

	"settings"
	{
	
	}
}
```

### init.lua
``` Lua
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )

include( "shared.lua" )

-- Server game mode initialization
function GM:Initialize()
end
```

### cl_init.lua
``` Lua
include( "shared.lua" )

-- Client gamemode initialization
function GM:Initialize()
end
```

### shared.lua
``` Lua
GM.Name = "My Game"
GM.Author = "My username"
GM.Email = "My email"
GM.Website = "My website"
GM.Version = "YYYY-MM-DD"
```
