--- Client initialization module.
-- Spess client machine initialization module.
-- @module cl_init.lua
T, C, L = {}, {}, {}

T.Color = {}
T.Color.vgui = Color( 50, 50, 53, 255 )

--- Event identifiers.
-- @table T.EVENT
T.EVENT = {
	ROUND_CHANGED = "SPS_E_RoundChanged"
}

--- Hook identifiers.
-- @table T.HOOK
T.HOOK = {
	ROUND_CHANGED = "SPS_E_RoundChangedHook"
}

--- Panel identifiers.
-- @table T.PANEL
T.PANEL = {
	JOB_PREF = "SPSJobPref"
}

--- Server cvar identifiers.
-- @table T.CVAR
T.CVAR = {
	LOG_LEVEL = "sps_log_level"
}

--- Font identifiers.
-- @table T.FONT
T.FONT = {
	HUD = "Trebuchet24"
	-- ROUND_STATE = "MyFont"
}

--- Default client cvars values.
-- @table T.Cvar
T.Cvar = {
	[ T.CVAR.LOG_LEVEL ] = { "2", nil, nil },
}

-- Include files
include( "shared.lua" )
include( "cl_hud.lua" )
include( "cl_util.lua" )

include( "log/log.lua" )

include( "round/cl_round.lua" )

include( "job/cl_job.lua" )

include( "derma/cl_derma.lua" )

-- include( "vgui/job_pref_menu_rad.lua" )

-- Create cvars
for k, v in pairs( T.Cvar ) do
	CreateClientConVar( k, unpack( v ) )
end

-- Get round state values
round.UpdateFromGlobals()

-- Concommands
concommand.Add( "sps_job_pref_menu", job.ToggleJobPrefMenu )
concommand.Add( "sps_jobs", function()
	PrintTable( job.GetJobsTable() )
end )
concommand.Add( "sps_job_prefs", function()
	PrintTable( job.Preferences )
end )

--- Game load hook.
function GM:Initialize()
	MsgN( "Spess client initializing..." )
	MsgN( string.format("Version %s", GAMEMODE.VERSION) )
end
