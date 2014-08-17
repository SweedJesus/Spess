local wide, tall = 350, 400

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
local numDepartments = 8

local PANEL = {}

local function AddJobLine( key, jobName, department )
	local line

	local pref = vgui.Create( "DComboBox" )
	pref:AddChoice( "NEVER" )
	pref:AddChoice( "LOW" )
	pref:AddChoice( "MEDIUM" )
	pref:AddChoice( "HIGH" )
	pref:ChooseOptionID( 1 )
	pref.OnSelect = function( panel, index, value )
		line.Preference = index
		job.Preferences[ line.JobKey ] = line.Preference
	end

	line = job.JobPrefMenu.ListView:AddLine( jobName, department, pref )
	line.JobKey = key
	line.JobName = jobName
	line.Department = department
	line.Preference = 1 -- Default NEVER

	line.Combo = pref

	local oldPaint = line.Paint
	line.Paint = function( self, w, h )
		oldPaint( self, w, h )
		if ( departments[ line.Department ] ) then
			draw.RoundedBox( 0, 0, 0, w, h, departments[ line.Department ][2] )
		end
	end

	line.GetColumnText = function( self, i )
		if ( i == 1 ) then
			-- Sort by job name
			return self.Columns[ i ].Value
		elseif ( i == 2 ) then
			-- Sort by department tier
			local s = self.Columns[ i ]:GetText()
			if ( departments[ s ] ) then
				return departments[ s ][1]
			else
			  return numDepartments + 1
			end
		elseif ( i == 3 ) then
			-- Sort by job preference
			return self.Preference
		end
	end
end

function PANEL:Init()
	self:SetVisible( false )
	self:SetTitle( "Job Preference Menu" )
	self:SetSize( wide, tall )
	self:SetScreenLock( true )
	self:ShowCloseButton( true )
	self:MakePopup()

	self.ListView = vgui.Create( "DListView", self )
	self.ListView:SetSize( wide-10, tall-65 )
	self.ListView:SetPos( 5, 30 )
	self.ListView:AddColumn( "Job Name" )
	self.ListView:AddColumn( "Department" )
	self.ListView:AddColumn( "Preference" )
	self.ListView.OnClickLine = function()end

	self.ButtonOkay = vgui.Create( "DButton", self )
	self.ButtonOkay:SetText( "Send" )
	self.ButtonOkay:SetSize( 80, 25 )
	self.ButtonOkay:SetPos( wide-85, tall-30 )
	self.ButtonOkay.DoClick = function()
		job.SendJobPrefs()
		-- self:Close()
	end

	self.Progress = vgui.Create( "DProgress", self )
	self.Progress:SetSize( wide-95, 25 )
	self.Progress:SetPos( 5, tall-30 )
end

function PANEL:Close()
	job.HideJobPrefMenu()
end

function PANEL:Think()
	DFrame.Think( self )

	if (round.currentState == T.ROUND.PRE) then
		local fraction = ( CurTime() - round.currentStart ) / ( round.currentEnd - round.currentStart )
		self.Progress:SetFraction( fraction )
	else
		self.Progress:SetFraction( 0 )
	end
end

vgui.Register( "JobPrefMenu", PANEL, "DFrame" )
job.JobPrefMenu = vgui.Create( "JobPrefMenu" )
for k, v in pairs( job.Jobs ) do
	AddJobLine( k, v.name, v.department )
end
