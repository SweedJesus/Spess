--- Server round module.
-- Server round state control and broadcasting module.
-- @module round.lua

round = {}
round.currentState = nil
round.currentStart = nil
round.currentEnd = nil

local function HaveEnoughPlayers()
	local ready = 0
	for _, ply in pairs(player.GetAll()) do
		if (IsValid(ply)) then
			ready = ready + 1
		end
	end
	return ready >= GetConVar(T.CVAR.WAIT_MIN_PLAYERS):GetInt()
end

local function WaitHelper()
	log.Msg("Checking player count... ", T.LOG.VERBOSE)
	if (HaveEnoughPlayers()) then
		log.MsgN("enough, moving to preround.", T.LOG.VERBOSE)
		timer.Create(T.TIMER.ROUND, 3, 1, round.StartPre)
	else
		log.MsgN("not enough.", T.LOG.VERBOSE)
	end
end

--- Set round state to waiting.
function round.StartWait()
	log.MsgN("Round state changed to waiting.", 2)
	-- Values
	round.SetRoundStateValues(T.ROUND.WAIT, CurTime(), 0)
	-- Timers
	timer.Destroy(T.TIMER.ROUND)
	timer.Create(T.TIMER.ROUND, 2, 0, WaitHelper)
	-- Send
	round.SendRoundStateValues()
end

--- Set round state to pre-round.
function round.StartPre()
	log.MsgN("Round state changed to pre-round.", 2)
	-- Values
	local preSeconds = GetConVarNumber(T.CVAR.PRE_SECONDS)
	local curTime = CurTime()
	round.SetRoundStateValues(T.ROUND.PRE, curTime, curTime + preSeconds)
	-- Timers
	timer.Destroy(T.TIMER.ROUND)
	timer.Create(T.TIMER.ROUND, preSeconds, 1, round.StartActive)
	-- Send
	round.SendRoundStateValues()
	job.SendJobPreferenceRequest()
end

--- Set round state to active.
function round.StartActive()
	log.MsgN("Round state changed to active.", 2)
	-- Values
	round.SetRoundStateValues(T.ROUND.ACTIVE, CurTime(), 0)
	-- Timers
	timer.Destroy(T.TIMER.ROUND)
	-- Send
	round.SendRoundStateValues()
end

--- Set round state to post-round.
function round.StartPost()
	log.MsgN( "Round state changed to post-round.", 2 )
	-- Values
	local postSeconds = GetConVarNumber( T.CVAR.PRE_SECONDS )
	local curTime = CurTime()
	round.SetRoundStateValues( T.ROUND.POST, curTime, curTime + postSeconds )
	-- Timers
	timer.Destroy( T.TIMER.ROUND )
	timer.Create( T.TIMER.ROUND, postSeconds, 1, function()
		if ( not HaveEnoughPlayers() ) then
			round.StartWait()
		else
			round.StartPre()
		end
	end )
	-- Send
	round.SendRoundStateValues()
end

--- Set round state values.
function round.SetRoundStateValues(_state, _start, _end)
	round.currentState = _state
	round.currentStart = _start
	round.currentEnd = _end
	round.UpdateGlobalRoundStateValues()
end

--- Upldate global round state values.
function round.UpdateGlobalRoundStateValues()
	SetGlobalInt(T.GLOBAL_VAR.ROUND, T.currentState)
	SetGlobalFloat(T.GLOBAL_VAR.ROUND_START, T.currentStart)
	SetGlobalFloat(T.GLOBAL_VAR.ROUND_END, T.currentEnd)
end

--- Send round state change values.
function round.SendRoundStateValues(_ply)
	net.Start(T.NET.ROUND_CHANGE)
	net.WriteUInt(round.currentState, 2)
	net.WriteFloat(round.currentStart)
	net.WriteFloat(round.currentEnd)
	if (IsValid(_ply)) then
		net.Send(_ply)
	else
    net.Broadcast()
	end
end
	