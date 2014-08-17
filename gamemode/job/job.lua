--- Server job module.
-- @module job.lua

job = {}
job.Jobs = {}
job.Preferences = {}

local function SendJobPrefRequestHelper( ply )
	net.Start( T.NET.JOB_PREF )
	if ( job.Preferences[ ply:Name() ] ) then
		for k, v in pairs( job.Jobs ) do
			net.WriteUInt( job.Preferences[ ply:Name() ][ k ] or 1, 3 )
		end
	else
		for k, v in pairs( job.Jobs ) do
			net.WriteUInt( 1, 3 )
		end
	end
	net.Send( ply )
end

--- Send job preference request.
function job.SendJobPrefRequest( ply )
	log.Msg( "Sending job preference request to ", 2 )
	if ( IsValid( ply ) ) then
		log.MsgN( ply:Name()..'.', 2 )
		SendJobPrefRequestHelper( ply )
	else
		log.MsgN( "all players.", 2 )
		for _, ply in ipairs( player.GetAll() ) do
			SendJobPrefRequestHelper( ply )
		end
	end
end

local function ReceiveJobPrefs( len, ply )
	log.MsgN( Format( "Received job preferences from %s.", ply:Name() ), 2 )
	job.Preferences[ ply:Name() ] = job.Preferences[ ply:Name() ] or {}
	for k, v in pairs( job.Jobs ) do
		local pref = net.ReadUInt( 3 )
		job.Preferences[ ply:Name() ][ k ] = pref
	end
end
net.Receive( T.NET.JOB_PREF, ReceiveJobPrefs )

include( "jobs.lua" )
