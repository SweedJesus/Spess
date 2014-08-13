--- Server initialization module.
-- Spess server machine initialization module.
-- @module init.lua
T, C, L = {}, {}, {}

-- Files to send to clients
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_hud.lua" )
AddCSLuaFile( "cl_job.lua" )
AddCSLuaFile( "cl_round.lua" )
AddCSLuaFile( "cl_util.lua" )
AddCSLuaFile( "skins/cl_spsderma.lua" )
AddCSLuaFile( "vgui/job_pref_main.lua" )

include( "shared.lua" )
include( "job.lua" )
include( "round.lua" )

--- Server cvar identifiers.
-- @table T.CVAR
T.CVAR = {
	LOG_LEVEL 				= "sps_log_level",
	WAIT_MIN_PLAYERS 	= "sps_wait_min_players",
	PRE_SECONDS 			= "sps_preround_seconds",
	POST_SECONDS 			= "sps_postround_seconds",
}

--- Server cvar arguments.
-- @table T.CVAR_ARGS
T.CVAR_ARGS = {
	[T.CVAR.LOG_LEVEL] 				= {"2", nil, nil},
	[T.CVAR.WAIT_MIN_PLAYERS] = {"1", nil, nil},
	[T.CVAR.PRE_SECONDS] 			= {"10", nil, nil},
	[T.CVAR.POST_SECONDS] 		= {"2", nil, nil}
}

--- Timer identifiers.
-- @table T.TIMER
T.TIMER = {
	ROUND = '0'
}

-- Add network strings
for k, v in pairs(T.NET) do
	util.AddNetworkString(v)
end

-- Create cvars
for k, v in pairs(T.CVAR_ARGS) do
	CreateConVar(k, unpack(v))
end

--- Server gamemode initialization.
function GM:Initialize()
	MsgN("Spess server initializing...")
	MsgN(string.format("Version %s", GAMEMODE.VERSION))
	math.randomseed(os.time())

	T.SetRoundStateWait()
end

--- Cvar replication.
function T.SyncGlobals()
end

concommand.Add( "sps_round_wait", T.SetRoundStateWait )
concommand.Add( "sps_round_pre", T.SetRoundStatePre )
concommand.Add( "sps_round_active", T.SetRoundStateActive )
concommand.Add( "sps_round_post", T.SetRoundStatePost )
