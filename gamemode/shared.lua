--- Shared objects module.
-- Defines objects shared between server and client machines (metadata, constants, functions, etc.).
-- @module shared.lua

--- Gamemode metadata.
-- @table GAMEMODE
-- @field NAME Gamemode name
-- @field AUTHOR Gamemode author
-- @field EMAIL Gamemode author email
-- @field WEBSITE Gamemode author website
-- @field VERSION Gamemode current version
GM.NAME 		= "SweedJesus"
GM.AUTHOR 	= "N/A"
GM.EMAIL 		= "N/A"
GM.WEBSITE 	= "N/A"
GM.VERSION 	= "2014-07-24"

--- Shared variable identifiers.
-- @table T.GLOBAL_VAR
T.GLOBAL_VAR 	= {
	ROUND 			= "sps_round",
	ROUND_START = "sps_round_start",
	ROUND_END 	= "sps_round_end"
}

--- Logging identifiers.
-- @table T.LOG
T.LOG = {
	ALLWAYS = 0,
	BRIEF 	= 1,
	VERBOSE = 2
}

--- Net transmission identifiers/package sizes.
-- @table T.NET
T.NET = {
	ROUND_CHANGE 	= '0',
	JOB_PREF 			= '1',
	JOB 					= '2'
}

--- Round status identifiers.
-- @table T.ROUND
T.ROUND = {
	WAIT 		= 0,
	PRE 		= 1,
	ACTIVE 	= 2,
	POST 		= 3
}

--- Get log level.
-- @return log level.
function T.GetLogLevel()
	return GetConVarNumber(T.CVAR.LOG_LEVEL)
end

--- Get the round state identifier.
-- @return round state name
function T.GetRoundState()
	return GetGlobalInt(T.GLOBAL_VAR.ROUND)
end

function T.GetRoundEnd()
	return GetGlobalInt(T.roundEnd)
end

--- Log message.
-- @param msg message string
-- @param lvl logging level
function T.LogMsg(msg, lvl)
	if (lvl <= T.GetLogLevel()) then
		Msg(msg)
	end
end

--- Log message (newline).
-- @param msg message string
-- @param lvl logging level
function T.LogMsgN(msg, lvl)
	if (lvl <= T.GetLogLevel()) then
		MsgN(msg)
	end
end
