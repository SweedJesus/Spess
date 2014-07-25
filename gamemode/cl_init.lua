--- Client initialization module.
-- Run on a client machine as it connects to a Garry's Mod server running the Spess gamemode.
-- @module cl_init.lua

include("shared.lua")
include("util.lua")

--- Console command functions.
-- @table conCommands
-- @field sps_hello_world Utility hello world test function.
-- @field sps_get_round_state Display the current server round state.
local conCommands = {
	[ConCmd.HELLO_WORLD] = util.HelloWorld,

	[ConCmd.GET_ROUND_STATE] = function(ply)
		local roundState = GetRoundState()
		local text = "Round state: %s\n"
		if (roundState == ROUND_WAIT) then
			text = string.format(text, "waiting")
		elseif (roundState == ROUND_PRE) then
			text = string.format(text, "pre-round")
		elseif (roundState == ROUND_ACTIVE) then
			text = string.format(text, "active")
		else -- roundState == ROUND_POST
			text = string.format(text, "post-round")
		end
		if (IsValid(ply)) then 
			ply:PrintMessage(HUD_PRINTTALK, text)
		else
		    Msg(text)
		end
	end,


}

--- Initialize client gamemode
-- Run on a client machine as it connects to a Garry's Mod server running the Spess gamemode.
function GM:Initialize()
	MsgN("Spess client initializing...")

	InitConCommands()
end

--- Initialize client console commands
-- Give some console functions to clients.
function InitConCommands()
	for k, v in pairs(conCommands) do
		concommand.Add(k, v)
	end
end

--- Get round state
-- Get the global round state value (server has to have synced globals).
-- @treturn int round state
function GetRoundState() return GAMEMODE.roundState end
