--- Client job module.
-- @module cl_role.lua

job = {}
job.Jobs = {}
job.Preferences = {}

function job.ShowJobPrefMenu()
	log.MsgN( "Showing JobPrefMenu.", 2 )
	for k, v in pairs( job.JobPrefMenu.ListView.Lines ) do
		local pref = job.Preferences [ v.JobKey ]
		v.Preference = pref
		v.Combo:ChooseOptionID( pref )
	end
	job.JobPrefMenu:Center()
	job.JobPrefMenu:SetVisible( true )
end

function job.HideJobPrefMenu()
	log.MsgN( "Hiding JobPrefMenu.", 2 )
	job.JobPrefMenu:SetVisible( false )
end

function job.ToggleJobPrefMenu()
	if ( not job.JobPrefMenu:IsVisible() ) then
		job.ShowJobPrefMenu()
	else
		job.HideJobPrefMenu()
	end
end

function job.SendJobPrefs()
	log.MsgN( "Job preferences sent.", 2 )
	net.Start( T.NET.JOB_PREF )
	for k, v in pairs( job.Jobs ) do
		net.WriteUInt( job.Preferences[ k ], 3 )
	end
	net.SendToServer()
end

local function ReceiveJobPrefRequest()
	log.MsgN( "Job preference request received.", 2 )
	for k, v in pairs( job.Jobs ) do
		job.Preferences[ k ] = net.ReadUInt( 3 )
	end
	job.ShowJobPrefMenu()
end
net.Receive( T.NET.JOB_PREF, ReceiveJobPrefRequest )

include( "jobs.lua" )
for k, v in pairs( job.Jobs ) do
	job.Preferences[ k ] = 1
end
