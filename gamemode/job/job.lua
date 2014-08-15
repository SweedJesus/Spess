--- Server job module.
-- @module job.lua

job = {}
job.Jobs = {}
job.JobPreferences = {}

-- Register a job.
-- @param name Class name of job to create.
-- @param mtable Table containing the job information.
function job.Register( name, jobTable )
	assert( istable( table ) )

	if ( not job.Jobs[ name ] ) then

		job.Jobs[ name ] = { }

		job.Jobs[ name ].name = jobTable.name

		job.Jobs[ name ].description = jobTable.description

		job.Jobs[ name ].faction = jobTable.faction

		job.Jobs[ name ].department = jobTable.department

		job.Jobs[ name ].supervisor = jobTable.supervisor

		job.Jobs[ name ].access = table.Copy( jobTable.access )
		-- job.Jobs[ name ].access 			= { }
		-- for _, v in ipairs( jobTable.access ) do
		-- 	table.insert(job.Jobs[ name ].access, v)
		-- end

	else
		log.MsgN( Format( "Job \"%s\" already registered.", name ), 2 )
	end
end

function job.GetJobsTable()
	return table.Copy( job.Jobs )
end

--- Send job preference request.
function job.SendJobPreferenceRequest( _ply )
	log.Msg( "Sending job preference request to ", 2 )
	net.Start( T.NET.JOB_PREF )
	if ( IsValid( _ply ) ) then
		log.MsgN( _ply:Name()..'.', 2 )
		net.Send(_ply)
	else
		log.MsgN( "all players.", 2 )
		net.Broadcast()
	end
end

local function ReceiveJobPreferences()
	
end
net.Receive( T.NET.JOB_PREF, ReceiveJobPreferences )

include( "jobs.lua" )
