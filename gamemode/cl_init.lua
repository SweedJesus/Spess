--- Client initialization module.
-- Client machine initialization for Spess.
-- @module cl_init.lua
SPS = {}

--- Font identifiers.
-- @table SPS.FONT
-- @field ROUND Round status ('0')
SPS.FONT = {
	ROUND_STATE = '0'
}

--- Colors.
-- @table SPS.COLOR
-- @field HUD_PANEL_BACKGROUND Background color for HUD panels.
SPS.COLOR = {
	HUD_PANEL_BACKGROUND = Color(50, 60, 70, 191),
	HUD_TEXT = Color(255, 255, 255, 255)
}
 
include("cl_hud.lua")
include("cl_util.lua")
include("shared.lua")

--- Initialize client gamemode.
-- Initialize the client for spess.
function GM:Initialize()
	MsgN("Spess client initializing...")
	MsgN(string.format("Version %s", GAMEMODE.VERSION))

	GAMEMODE.roundState = SPS.ROUND.WAIT
end

local function ReceiveRoundState()
	local o = GAMEMODE.roundState
	GAMEMODE.roundState = net.ReadUInt(3)

	if o != GAMEMODE.roundState then
		-- RoundStateChange(o, GAMEMODE.roundState)
	end

	MsgN("Round state: " .. GAMEMODE.roundState)
end
net.Receive(SPS.NET.ROUNDSTATE, ReceiveRoundState)
