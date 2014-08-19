--- Client job module.

job = {}
job.Jobs = {}
job.Preferences = {}

function job.UpdateJubPrefMenu()
	for k, v in pairs( job.Jobs ) do
		local pref = job.Preferences[ k ]
		job.JobPrefMenu[ k ].Preference = pref
		job.JobPrefMenu[ k ].Combo:ChooseOptionID( pref )
	end
end

--- Show job preferences menu.
function job.ShowJobPrefMenu()
	log.MsgN( "Showing JobPrefMenu.", 2 )
	-- for k, v in pairs( job.JobPrefMenu.ListView.Lines ) do
	-- 	local pref = job.Preferences [ v.JobKey ]
	-- 	v.Preference = pref
	-- 	v.Combo:ChooseOptionID( pref )
	-- end
	job.JobPrefMenu:Center()
	job.JobPrefMenu:SetVisible( true )
end

--- Hide job preferences menu.
function job.HideJobPrefMenu()
	log.MsgN( "Hiding JobPrefMenu.", 2 )
	job.JobPrefMenu:SetVisible( false )
end

--- Toggle job preferences menu.
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
		local pref = net.ReadUInt( 3 )
		job.Preferences[ k ] = pref
	end
	job.UpdateJubPrefMenu()
	job.ShowJobPrefMenu()
end
net.Receive( T.NET.JOB_PREF, ReceiveJobPrefRequest )

include( "jobs.lua" )
for k, v in pairs( job.Jobs ) do
	job.Preferences[ k ] = 1
end
