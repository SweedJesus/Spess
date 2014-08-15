--- Client job module.
-- Client player job control and receiving module.
-- @module cl_role.lua

job = {}

local jobTiers = {
	["Command"] = 1,
	["Security"] = 2,
	["Engineering"] = 3,
	["Science"] = 4,
	["Medical"] = 5,
	["Supply"] = 6,
	["Service"] = 7,
	["Miscellaneous"] = 8
}

function job.AddJob( jobName, department )
	local combo = vgui.Create( "DComboBox" )
	combo.OnSelect = function( panel, index, value )
		combo.Index = index
	end
	combo:AddChoice( "NEVER" )
	combo:AddChoice( "LOW" )
	combo:AddChoice( "MEDIUM" )
	combo:AddChoice( "HIGH" )
	combo:ChooseOptionID( 1 )

	local line = job.JobPrefMenu.ListView:AddLine( jobName, department, combo )
	line.GetColumnText = function( self, i )
		if ( i == 1 ) then
			return self.Columns[ i ].Value
		elseif ( i == 2 ) then
			return jobTiers[ self.Columns[ i ]:GetText() ]
		else
			return self.Columns[ i ].Index
		end
	end
end

function job.UpdateJobs()
	for _, v in ipairs( job.JobPrefMenu.ListView.Lines ) do
		MsgN( v:GetColumnText( 1 ) )
	end
end

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

local function ReceiveJobPreferenceRequest()
	log.MsgN( "Job preference request received.", 2 )
	job.ShowJobPrefMenu()
end
net.Receive( T.NET.JOB_PREF, ReceiveJobPreferenceRequest )
