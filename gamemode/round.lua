--- Server round module.
-- Server round state control and broadcasting module.
-- @module round.lua

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
	T.LogMsg("Checking player count... ", T.LOG.VERBOSE)
	if (HaveEnoughPlayers()) then
		T.LogMsgN("enough, moving to preround.", T.LOG.VERBOSE)
		timer.Create(T.TIMER.ROUND, 3, 1, T.SetRoundStatePre)
	else
		T.LogMsgN("not enough.", T.LOG.VERBOSE)
	end
end

--- Set round state to waiting.
function T.SetRoundStateWait()
	T.LogMsgN("Round state changed to waiting.", 2)
	-- Values
	T.SetRoundStateValues(T.ROUND.WAIT, CurTime(), 0)
	-- Timers
	timer.Destroy(T.TIMER.ROUND)
	timer.Create(T.TIMER.ROUND, 2, 0, WaitHelper)
	-- Send
	T.SendRoundStateValues()
end

--- Set round state to pre-round.
function T.SetRoundStatePre()
	T.LogMsgN("Round state changed to pre-round.", 2)
	-- Values
	local preSeconds = GetConVarNumber(T.CVAR.PRE_SECONDS)
	local curTime = CurTime()
	T.SetRoundStateValues(T.ROUND.PRE, curTime, curTime + preSeconds)
	-- Timers
	timer.Destroy(T.TIMER.ROUND)
	timer.Create(T.TIMER.ROUND, preSeconds, 1, T.SetRoundStateActive)
	-- Send
	T.SendRoundStateValues()
	job.SendJobPreferenceRequest()
end

--- Set round state to active.
function T.SetRoundStateActive()
	T.LogMsgN("Round state changed to active.", 2)
	-- Values
	T.SetRoundStateValues(T.ROUND.ACTIVE, CurTime(), 0)
	-- Timers
	timer.Destroy(T.TIMER.ROUND)
	-- Send
	T.SendRoundStateValues()
end

--- Set round state to post-round.
function T.SetRoundStatePost()
	T.LogMsgN("Round state changed to post-round.", 2)
	-- Values
	local postSeconds = GetConVarNumber(T.CVAR.PRE_SECONDS)
	local curTime = CurTime()
	T.SetRoundStateValues(T.ROUND.POST, curTime, curTime + postSeconds)
	-- Timers
	timer.Destroy(T.TIMER.ROUND)
	timer.Create(T.TIMER.ROUND, post_seconds, 1, StartActive)
	-- Send
	T.SendRoundStateValues()
end

--- Set round state values.
function T.SetRoundStateValues(_state, _start, _end)
	T.roundState = _state
	T.roundStart = _start
	T.roundEnd = _end
	T.UpdateGlobalRoundStateValues()
end

--- Upldate global round state values.
function T.UpdateGlobalRoundStateValues()
	SetGlobalInt(T.GLOBAL_VAR.ROUND, T.roundState)
	SetGlobalFloat(T.GLOBAL_VAR.ROUND_START, T.roundStart)
	SetGlobalFloat(T.GLOBAL_VAR.ROUND_END, T.roundEnd)
end

--- Send round state change values.
function T.SendRoundStateValues(_ply)
	net.Start(T.NET.ROUND_CHANGE)
	net.WriteUInt(T.roundState, 2)
	net.WriteFloat(T.roundStart)
	net.WriteFloat(T.roundEnd)
	if (IsValid(_ply)) then
		net.Send(_ply)
	else
    net.Broadcast()
	end
end
	