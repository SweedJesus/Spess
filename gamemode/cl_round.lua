--- Client round module.
-- Client round state control and receiving module.
-- @module cl_round.lua

-- SPS_E_* = Event

local function RoundStateChangeHook()
	T.JobPref.Hide()
end
hook.Add( "SPS_E_RoundChanged", "SPS_E_RoundChangedHook", RoundStateChangeHook )

function T.UpdateRoundStateValsFromGlobals()
	local newState = GetGlobalInt( T.GLOBAL_VAR.ROUND )
	if ( T.roundState ~= newState ) then
		hook.Run( "SPS_E_RoundChanged", newState )
	end
	T.roundState = newState
	T.roundStart = GetGlobalFloat( T.GLOBAL_VAR.ROUND_START )
	T.roundEnd = GetGlobalFloat( T.GLOBAL_VAR.ROUND_END )
	T.LogMsgN( "Round state updated to "..T.roundState..'.', 2 )
	T.LogMsgN( "Round start updated to "..T.roundStart..'.', 2 )
	T.LogMsgN( "Round end updated to "..T.roundEnd..'.', 2 )
end

local function ReceiveRoundStateChange()
	T.LogMsgN( "Recieved round state change message.", 2 )
	local newState = net.ReadUInt( 2 )
	if ( T.roundState ~= newState ) then
		hook.Run( "SPS_E_RoundChanged", newState )
	end
	T.roundState = newState
	T.roundStart = net.ReadFloat()
	T.roundEnd = net.ReadFloat()
	T.LogMsgN( "Round state updated to "..T.roundState..'.', 2 )
	T.LogMsgN( "Round start updated to "..T.roundStart..'.', 2 )
	T.LogMsgN( "Round end updated to "..T.roundEnd..'.', 2 )
end
net.Receive( T.NET.ROUND_CHANGE, ReceiveRoundStateChange )
