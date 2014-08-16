--- Server initialization module.
-- Spess server machine initialization module.
-- @module init.lua
T, C, L = {}, {}, {}

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

-- Send include files to clients
AddCSLuaFile( "shared.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "cl_hud.lua" )
AddCSLuaFile( "cl_util.lua" )

AddCSLuaFile( "log/log.lua" )

AddCSLuaFile( "round/cl_round.lua" )

AddCSLuaFile( "job/cl_job.lua")

AddCSLuaFile( "derma/cl_derma.lua" )

AddCSLuaFile( "vgui/job_pref_menu.lua" )
AddCSLuaFile( "vgui/job_pref_menu_rad.lua" )

-- Include files
include( "shared.lua" )
include( "log/log.lua" )
include( "job/job.lua")
include( "round/round.lua" )

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

	round.StartWait()
end

--- Cvar replication.
function T.SyncGlobals()
end

concommand.Add( "sps_round", function( ply, sCmd, args )
	local state = args[ 1 ]
	if ( ( state == '1' ) or ( state == "wait" ) ) then
		round.StartWait()
	elseif ( state == '2' ) then
		round.StartPre()
	elseif ( state == '3' ) then
		round.StartActive()
	elseif ( state == '4' ) then
		round.StartPost()
	else
		log.MsgN( Format( "Unknown round state \"%s\"", state ), 0 )
	end
end )

concommand.Add( "sps_jobs", function()
	PrintTable( job.GetJobsTable() )
end )
