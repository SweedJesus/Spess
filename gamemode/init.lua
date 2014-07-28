--- Server initialization module.
-- Server machine initialization for Spess.
-- @module init.lua
SPS = {}

--- Logging identifiers.
-- @table SPS.NET
-- @field NONE No message logging (0)
-- @field BRIEF Brief message logging (1)
-- @field VERBOSE Verbose message logging (2)
SPS.LOG = {
	NONE = 0,
	BRIEF = 1,
	VERBOSE = 2
}

--- Console variable (cvars) strings.
-- @table SPS.CVAR
-- @field MIN_PLAYERS Minimum players to start pre-round ("sps\_min\_players").
SPS.CVAR = {
	LOG_LEVEL = "sps_log_level",
	MIN_PLAYERS = "sps_minimum_players",
	PRE_SECONDS = "sps_preround_seconds"
}

--- Server cvars.
-- Server console variables stored in value/type pairs.
-- @table ServerCvars
-- @field MIN_PLAYERS Minimum ("sps_minimum_players").
Cvars = {
	[SPS.CVAR.LOG_LEVEL] = {"2", nil, nil},
	[SPS.CVAR.MIN_PLAYERS] = {"2", nil, nil},
	[SPS.CVAR.PRE_SECONDS] = {"30", nil, nil}
}

-- Files to send to clients
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("cl_hud.lua")
AddCSLuaFile("cl_util.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("log.lua")
include("round.lua")

-- Add network strings
util.AddNetworkString(SPS.NET.ROUNDSTATE)
util.AddNetworkString(SPS.NET.ROLE)

--- Server gamemode initialization.
-- Initialize the server for Spess.
function GM:Initialize()
	MsgN("Spess server initializing...")
	MsgN(string.format("Version %s", GAMEMODE.VERSION))

	math.randomseed(os.time())

	GAMEMODE.roundState = SPS.ROUND.WAIT

	-- Create cvars
	for k, v in pairs(Cvars) do
		CreateConVar(k, unpack(v))
	end

	StartWaitingForPlayers()
end

--- Cvar replication.
-- Because cvar replication (server to client) is apparently broken in GMod.
function GM:SyncGlobals()
end
