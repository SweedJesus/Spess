--- Client job module.
-- @module cl_role.lua

job = {}
job.Jobs = {}
job.Preferences = {}

function job.ShowJobPrefMenu()
	log.MsgN( "Showing JobPrefMenu.", 2 )
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

local function ReceiveJobPrefRequest()
	log.MsgN( "Job preference request received.", 2 )
	job.ShowJobPrefMenu()
end
net.Receive( T.NET.JOB_PREF, ReceiveJobPrefRequest )

function job.SendJobPref()
	log.MsgN( "Job preferences sent.", 2 )
	net.Start( T.NET.JOB_PREF )
	for k, v in pairs( job.Jobs ) do
		net.WriteUInt( job.Preferences[ k ] or 1, 3 )
	end
	net.SendToServer()
end

include( "jobs.lua" )
include( "../vgui/job_pref_menu.lua" )
