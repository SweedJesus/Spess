--- Server job module.
-- @module job.lua

job = {}

-- Example job metatable:
-- Name
-- Description
-- Team
-- Security access level

-- Register a job.
-- @param name Class name of job to create.
-- @param mtable Table containing the job information.
function job.Register( name, table )
end

--- Send job preference request.
function job.SendJobPreferenceRequest( _ply )
	T.LogMsg( "Sending job preference request to ", 2 )
	net.Start( T.NET.JOB_PREF )
	if ( IsValid( _ply ) ) then
		T.LogMsgN( _ply:Name()..'.', 2 )
		net.Send(_ply)
	else
		T.LogMsgN( "all players.", 2 )
		net.Broadcast()
	end
end
