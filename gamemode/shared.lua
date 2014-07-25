--- Shared objects module.
-- Defines objects shared between server and client machines (metadata, constants, etc.).
-- @module shared.lua

local C = {}

--- Metadata.
-- @section

--- Gamemode global table.
-- @table GAMEMODE
-- @field Name Gamemode author
-- @field Email Gamemode author email
-- @field Website Gamemode author website
-- @field Version Gamemode current version
GM.Name = "SweedJesus"
GM.Author = "N/A"
GM.Email = "N/A"
GM.Website = "N/A"
GM.Version = "2014-07-24"

--- Constants.
-- @section

--- Round status constants (2 bits)
-- @table Round
-- @field WAIT Waiting for players (0)
-- @field PRE Pre-round (1)
-- @field ACTIVE Round is in session (2)
-- @field POST Post-round (3)
Round = {
	[WAIT] = 0,
	[PRE] = 1,
	[ACTIVE] = 2,
	[POST] = 3
}

--- Networking identifier constants (char)
-- @table Net
-- @field ROUNDSTATE Send roundState value to a client or broadcast to all ('0')
-- @field ROLD Send role value to a client ('1')
Net = {
	[ROUNDSTATE] = '0',
	[ROLE] = '1'
}

--- Timer identifier constants (char)
-- @table Timer
-- @field WAITINGFORPLAYERS Wait for players loop ('0')
-- @field PREROUND Pre-round setup countdown ('1')
Timer = {
	[WAIT] = '0',
	[WAIT2PRE] = '1'
}

--- Console command tokens (string)
-- @table ConCmd
-- @field HELLO_WORLD "sps_hello_world"
-- @field GET_ROUND_STATE "sps_get_round_state"
ConCmd = {
	[HELLO_WORLD] = "sps_hello_world",
	[GET_ROUND_STATE] = "sps_get_round_state"
}
