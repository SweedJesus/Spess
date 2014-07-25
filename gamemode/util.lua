--- Utility module.
-- Module for utility functions.
-- @module util.lua

util = util or {}

-- Localize commonly used tables and functions for speed
local math = math
local string = string
local table = table
local pairs = pairs

-- Hello, world!
function util.HelloWorld(ply)
	local text = "Hello, world!"
	if IsValid(ply) then
		ply:PrintMessage(HUD_PRINTTALK, text)
	else
	    Msg(text)
	end
end
