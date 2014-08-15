round = {}
round.currentState = nil
round.currentStart = nil
round.currentEnd = nil

function round.Update( newState, newStart, newEnd )
	if ( ( round.currentState == T.ROUND.PRE ) and ( newState ~= T.ROUND.PRE ) ) then
		job.HideJobPrefMenu()
	end
	round.currentState = newState
	round.currentStart = newStart
	round.currentEnd = newEnd
	log.MsgN( "Round state updated to "..round.currentState..'.', 2 )
	log.MsgN( "Round start updated to "..round.currentStart..'.', 2 )
	log.MsgN( "Round end updated to "..round.currentEnd..'.', 2 )
end

function round.UpdateFromGlobals()
	round.Update(
		GetGlobalInt( T.GLOBAL_VAR.ROUND ),
		GetGlobalFloat( T.GLOBAL_VAR.ROUND_START ),
		GetGlobalFloat( T.GLOBAL_VAR.ROUND_END ) )
end

local function ReceiveRoundStateChange()
	log.MsgN( "Recieved round state change message.", 2 )
	round.Update(
		net.ReadUInt( 2 ),
		net.ReadFloat(),
		net.ReadFloat() )
end
net.Receive( T.NET.ROUND_CHANGE, ReceiveRoundStateChange )
