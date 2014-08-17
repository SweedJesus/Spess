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

math.randomseed(os.time())

--- Get log level.
-- @return log level.
function GetLogLevel()
	return GetConVarNumber( T.CVAR.LOG_LEVEL )
end

--- Get the round state identifier.
-- @return round state name
function T.GetRoundState()
	return GetGlobalInt( T.GLOBAL_VAR.ROUND )
end

function T.GetRoundEnd()
	return GetGlobalInt( T.roundEnd )
end

function PrintTable( t, indent, tDone )
	tDone = tDone or {}
	indent = indent or 0

	local count = 0
	local keys = {}
	local maxLength = 0
	for k, _ in pairs( t ) do
		table.insert( keys, k )
		if ( #tostring( k ) > maxLength ) then
			maxLength = #tostring( k )
		end
	end
	table.sort( keys, function( a, b )
		return tostring(a) < tostring(b)
	end )

	for i = 1, #keys do
		count = count + 1
		local k = keys[ i ]
		local v = t[ k ]
		k = tostring( k )
		Msg( '\n'..string.rep( '\t', indent )..'['..k.."] "..string.rep('.', maxLength - #k ).." = " )
		if ( istable( v ) and not tDone[ v ] ) then
			tDone[ v ] = true
			Msg( '{' )
			if ( PrintTable( v, indent + 1, tDone ) > 0 ) then
				Msg( '\n'..string.rep( '\t', indent ).."}" )
			else
				Msg( " }" )
			end
		else
			if ( isstring( v ) ) then
				Msg( '"'..tostring( v )..'"' )
			else
				Msg( tostring( v ) )
			end
		end
	end
	if ( indent > 0 ) then
		return count
	else
		MsgN()
	end
end
