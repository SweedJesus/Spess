--- Client job module.
-- Client player job control and receiving module.
-- @module cl_role.lua

job = {}

local departments = {
	["Command"] 			= { 1, Color( 156, 195, 227, 100 ) },
	["Security"] 			= { 2, Color( 231, 151, 151, 100 ) },
	["Engineering"] 	= { 3, Color( 237, 181, 146, 100 ) },
	["Science"] 			= { 4, Color( 176, 152, 230, 100 ) },
	["Medical"] 			= { 5, Color( 230, 152, 216, 100 ) },
	["Supply"] 				= { 6, Color( 242, 250, 133, 100 ) },
	["Service"] 			= { 7, Color( 158, 244, 139, 100 ) },
	["Miscellaneous"] = { 8, Color( 191, 191, 191, 100 ) }
}

function job.AddJob( jobName, department )

	local line

	-- Preference combo box
	local pref = vgui.Create( "DComboBox" )
	pref:AddChoice( "NEVER" )
	pref:AddChoice( "LOW" )
	pref:AddChoice( "MEDIUM" )
	pref:AddChoice( "HIGH" )
	pref:ChooseOptionID( 1 )
	pref.OnSelect = function( panel, index, value )
		line.Preference = index
	end

	-- OR Preference radio check boxes
	-- local pref = vgui.Create( "JobPrefMenuRadios" )

	line = job.JobPrefMenu.ListView:AddLine( jobName, department, pref )
	line.JobName = jobName
	line.Department = department
	line.Preference = 1 -- Default NEVER

	line.Paint = function( self, w, h )
		draw.RoundedBox( 0, 0, 0, w, h, departments[ line.Department ][2] )
	end

	line.GetColumnText = function( self, i )
		if ( i == 1 ) then
			return self.Columns[ i ].Value
		elseif ( i == 2 ) then
			return departments[ self.Columns[ i ]:GetText() ][1]
		elseif ( i == 3 ) then
			return self.Preference
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
