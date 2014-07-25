--- Server initialization module.
-- Run on a server machine to host the Spess gamemode for Garry's Mod.
-- @module init.lua

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include("shared.lua")
include("util.lua")

-- Add network strings
-- See shared for keys/values
util.AddNetworkString(Net.ROUNDSTATE)
util.AddNetworkString(Net.ROLE)

--- Server gamemode initialization.
-- Initializes the server for our Spess gamemode.
function GM:Initialize()
	MsgN("Spess gamemode server initializing...")
	GAMEMODE.ShowVersion()

	-- Map and server config defaults
	GAMEMODE.roundState = ROUND_PRE

	-- Initialize PRNG
	math.randomseed(os.time())

	-- Start waiting for players
	WaitForPlayers()
end

--- Display gamemode version.
-- Simply displays the version of our Spess gamemode to a specified player as a chat message or to all players as a console message.
-- @param ply Player to display gamemode version to
function GM:ShowVersion(ply)
	local text = Format("This is Spess version %s\n", GAMEMODE.Version)
	if IsValid(ply) then
		ply:PrintMessage(HUD_PRINTTALK, text)
	else
	    Msg(text)
	end
end

--- Convar replication.
-- Because convar replication (server to client) is apparently broken in GMod.
function GM:SyncGlobals()
end

--- Send a round state value.
-- Send a specified round state to a single player or broadcast.
-- @param state Round state value to send
-- @param ply Player to send to, or none to broadcast
-- @return Player table `ply`
function SendRoundState(state, ply)
	net.Start(NET_SPS_ROUNDSTATE)
	net.WriteUInt(state, 2)
	return ply and net.Send(ply) or net.Broadcast()
end

--- Set server round state.
-- Set the server round state and broadcast.
-- @param state New round state value
function SetRoundState(state)
	GAMEMODE.round_state = state
	SendRoundState(state)
	MsgN(string.format("Game round state set to %s", state))
end

-- Check for enough players.
local function EnoughPlayers()
	return false
end

-- Waiting for players timer helper.
local function WaitForPlayersHelper()
	if GetRoundState() == C.WAIT and EnoughPlayers() then
		-- Transition from round state wait to pregame
		timer.Create(Timer.WAIT2PRE, 1, 1, SetupRoundPregame)

		-- Stop waiting for players timer
		timer.Stop(Timer.WAIT)
	end
end

--- Start waiting for players.
-- Set round state to `ROUND_WAIT` and start a looping timer, checking for player count to reach a base amount.
function WaitForPlayers()
	SetRoundState(ROUND_WAIT)

	if not timer.Start(Timer.WAIT) then
		timer.Create(Timer.WAIT, 2, 0, WaitForPlayersHelper)
	end
end

--- Setup round state pregame.
function SetupRoundPregame()
end

--- Setup round state active.
function SetupRoundActive()
end

--- Setup round state postgame.
function SetupRoundPostgame()
end
	