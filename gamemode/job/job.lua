--- Server job module.
-- @module job.lua

job = {}
job.Jobs = {}
job.Preferences = {}

--- Send job preference request.
function job.SendJobPrefRequest( ply )
	log.Msg( "Sending job preference request to ", 2 )
	net.Start( T.NET.JOB_PREF )
	if ( IsValid( ply ) ) then
		log.MsgN( ply:Name()..'.', 2 )
		net.Send( ply )
	else
		log.MsgN( "all players.", 2 )
		net.Broadcast()
	end
end

local function ReceiveJobPrefs( len, ply )
	log.MsgN( Format( "Received job preferences from %s.", ply:Name() ), 2 )
	-- job.Preferences[ UniqueID ]
end
net.Receive( T.NET.JOB_PREF, ReceiveJobPrefs )

include( "jobs.lua" )
