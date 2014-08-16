local PANEL = {}

local wide, tall = 350, 400

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
	self.ButtonOkay:SetText( "Okay" )
	self.ButtonOkay:SetSize( 80, 25 )
	self.ButtonOkay:SetPos( wide-85, tall-30 )
	self.ButtonOkay.DoClick = function()
		-- self:Close()
		job.UpdateJobs()
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

local jobs = {
	-- Command
	{ "Captain", "Command" },
	{ "Head of Personnel", "Command" },

	-- Security
	{ "Head of Security", "Security" },
	{ "Warden", "Security" },
	{ "Security Officer", "Security" },
	{ "Detective", "Security" },

	-- Engineering
	{ "Chief Engineer", "Engineering" },
	{ "Station Engineer", "Engineering" },
	{ "Atmospheric Technician", "Engineering" },

	-- Science
	{ "Research Director", "Science" },
	{ "Scientist", "Science" },
	{ "Roboticist", "Science" },

	-- Medical
	{ "Chief Medical Officer", "Medical" },
	{ "Medical Doctor", "Medical" },
	{ "Chemist", "Medical" },
	{ "Geneticist", "Medical" },
	{ "Virologist", "Medical" },

	-- Supply
	{ "Quartermaster", "Supply" },
	{ "Cargo Technician", "Supply" },
	{ "Shaft Miner", "Supply" },

	-- Service
	{ "Janitor", "Service" },
	{ "Bartender", "Service" },
	{ "Chef", "Service" },
	{ "Botanist", "Service" },

	-- Miscellaneous
	{ "Assistant", "Miscellaneous" },
	{ "Clown", "Miscellaneous" },
	{ "Mime", "Miscellaneous" },
	{ "Chaplain", "Miscellaneous" },
	{ "Librarian", "Miscellaneous" },
	{ "Lawyer", "Miscellaneous" },
	{ "Generic Job", "Miscellaneous" }
}

for _, v in ipairs( jobs ) do
	job.AddJob( unpack( v ) )
end
