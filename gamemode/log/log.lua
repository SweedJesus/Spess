log = {}

--- Log message.
-- @param msg message string
-- @param lvl logging level
function log.Msg(msg, lvl)
	if (lvl <= GetLogLevel()) then
		Msg(msg)
	end
end

--- Log message (newline).
-- @param msg message string
-- @param lvl logging level
function log.MsgN(msg, lvl)
	if (lvl <= GetLogLevel()) then
		MsgN(msg)
	end
end