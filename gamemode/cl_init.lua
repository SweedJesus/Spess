--- Client initialization module.
-- Spess client machine initialization module.
-- @module cl_init.lua
T, C, L = {}, {}, {}
 
include( "shared.lua" )
include( "cl_hud.lua" )
include( "cl_job.lua" )
include( "cl_round.lua" )
include( "cl_util.lua" )
include( "skins/cl_spsderma.lua" )
include( "vgui/job_pref_main.lua" )

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

-- Create cvars
for k, v in pairs( T.Cvar ) do
	CreateClientConVar( k, unpack( v ) )
end

-- Get round state values
T.UpdateRoundStateValsFromGlobals()

-- Concommands
concommand.Add( "sps_job_preferences", T.JobPref.Toggle )

--- Game load hook.
function GM:Initialize()
	MsgN( "Spess client initializing..." )
	MsgN( string.format("Version %s", GAMEMODE.VERSION) )
end
