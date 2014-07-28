--- Round control module.
-- Controls and broadcasts the server round state.
-- @module round.lua

--- Send a round state value.
-- Send a specified round state to a single player or broadcast.
-- @param state Round state value to send
-- @param ply Player to send to, or none to broadcast
-- @return player
function SendRoundState(state, ply)
	net.Start(SPS.NET.ROUNDSTATE)
	net.WriteUInt(state, 3)
	return ply and net.Send(ply) or net.Broadcast()
end

--- Set server round state.
-- Set the server round state and broadcast.
-- @param state New round state value
function SetRoundState(state)
	LogMsgN(string.format("Game round state set to %s", state), SPS.LOG.VERBOSE)
	GAMEMODE.roundState = state
	SendRoundState(state)
end

-- Check for enough players.
local function EnoughPlayers()
	local ready = 0
	for _, ply in pairs(player.GetAll()) do
		if IsValid(ply) then
			ready = ready + 1
		end
	end
	return ready >= GetConVar(SPS.CVAR.MIN_PLAYERS):GetInt()
end

-- Waiting for players timer helper.
local function WaitForPlayersHelper()
	LogMsg("Checking player count... ", SPS.LOG.VERBOSE)
	if GAMEMODE.roundState == SPS.ROUND.WAIT and EnoughPlayers() then
		timer.Stop(SPS.TIMER.WAIT)

		-- Transition from round state wait to pregame
		timer.Create(SPS.TIMER.WAIT2PRE, 3, 1, StartPregame)

		LogMsgN("enough, moving to pregame.", SPS.LOG.VERBOSE)
	else
		LogMsgN("not enough.", SPS.LOG.VERBOSE)
	end
end

--- Start waiting for players.
-- Set round state to `ROUND_WAIT` and start a looping timer, checking for player count to reach a base amount.
function StartWaitingForPlayers()
	LogMsgN("Starting round wait state.", SPS.LOG.BRIEF)
	SetRoundState(SPS.ROUND.WAIT)

	if not timer.Start(SPS.TIMER.WAIT) then
		timer.Create(SPS.TIMER.WAIT, 3, 0, WaitForPlayersHelper)
	end
end

--- Start round pregame.
function StartPregame()
	LogMsgN("Starting round pregame state.", SPS.LOG.BRIEF)
	SetRoundState(SPS.ROUND.PRE)

	timer.Stop(SPS.TIMER.WAIT2PRE)
end

--- Start round active.
function StartActive()
	LogMsgN("Starting round active state.", SPS.LOG.BRIEF)
	SetRoundState(SPS.ROUND.ACTIVE)
end

--- Start round postgame.
function StartPostgame()
	LogMsgN("Starting round postgame state.", SPS.LOG.BRIEF)
	SetRoundState(SPS.ROUND.POST)
end
	