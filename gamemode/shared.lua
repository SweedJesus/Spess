--- Shared objects module.
-- Defines objects shared between server and client machines (metadata, constants, etc.).
-- @module shared.lua

--- Gamemode global table.
-- @table GAMEMODE
-- @field NAME Gamemode name
-- @field AUTHOR Gamemode author
-- @field EMAIL Gamemode author email
-- @field WEBSITE Gamemode author website
-- @field VERSION Gamemode current version
GM.NAME = "SweedJesus"
GM.AUTHOR = "N/A"
GM.EMAIL = "N/A"
GM.WEBSITE = "N/A"
GM.VERSION = "2014-07-24"

--- Networking identifiers.
-- @table SPS.NET
-- @field ROUNDSTATE Send roundState value to a client or broadcast to all ('0')
-- @field ROLD Send role value to a client ('1')
SPS.NET = {
	ROUNDSTATE = '0',
	ROLE = '1'
}

--- Round status identifiers.
-- @table SPS.ROUND
-- @field WAIT Waiting for players (0)
-- @field PRE Pregame (1)
-- @field ACTIVE Round is in session (2)
-- @field POST Postgame (3)
SPS.ROUND = {
	WAIT = 0,
	PRE = 1,
	ACTIVE = 2,
	POST = 3
}

--- Timer identifiers.
-- @table SPS.TIMER
-- @field WAITINGFORPLAYERS Wait for players loop ('0')
-- @field PREROUND Pre-round setup countdown ('1')
SPS.TIMER = {
	WAIT = '0',
	WAIT2PRE = '1'
}

--- Get the round state name.
-- Get the name of the server current round state.
-- @return round state name
function GetRoundStateText(state)
	if (state == SPS.ROUND.WAIT) then
		-- local text = "WAITING"
		-- if timer.Exists(SPS.TIMER.WAIT2PRE) then
		-- 	text = text .. " : " .. tostring(timer.TimeLeft())
		-- end
		-- return text
		return timer.TimeLeft(SPS.TIMER.WAIT2PRE)
	elseif (state == SPS.ROUND.PRE) then
		return "Pre-Game"
	elseif (state == SPS.ROUND.ACTIVE) then
		return "Active Game"
	else -- state == SPS.ROUND.POST
		return "Post-Game"
	end
end
