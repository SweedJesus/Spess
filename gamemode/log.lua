--- Logging module.
-- Server message logging.
-- @module log.lua

--- Get log level.
-- Get the level of server message logging
-- @return log level.
function LogLevel() return GetConVar(SPS.CVAR.LOG_LEVEL):GetInt() end

--- Log message.
-- Write a message to the server log.
-- @param msg message string
-- @param lvl logging level
function LogMsg(msg, lvl)
	if (lvl <= LogLevel()) then
		Msg(msg)
	end
end

--- Log message (newline).
-- Write a message and newline to the server log.
-- @param msg message string
-- @param lvl logging level
function LogMsgN(msg, lvl)
	if (lvl <= LogLevel()) then
		MsgN(msg)
	end
end
