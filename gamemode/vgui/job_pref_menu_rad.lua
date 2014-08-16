local PANEL = {}

function PANEL:Init()
	self.RadNever = vgui.Create( "DCheckBox", self )
	self.RadLow = vgui.Create( "DCheckBox", self )
	self.RadMedium = vgui.Create( "DCheckBox", self )
	self.RadHigh = vgui.Create( "DCheckBox", self )

	local rads = {
		self.RadNever,
		self.RadLow,
		self.RadMedium,
		self.RadHigh
	}

	local function RadOnChange( self, bVal )
		for _, v in ipairs( rads ) do
			if ( self ~= v ) then
				v:SetChecked( false )
			end
		end
	end

	self.RadNever:Dock( LEFT )
	self.RadNever.OnChange = RadOnChange

	self.RadLow:Dock( LEFT )
	self.RadLow.OnChange = RadOnChange

	self.RadMedium:Dock( LEFT )
	self.RadMedium.OnChange = RadOnChange

	self.RadHigh:Dock( LEFT )
	self.RadHigh.OnChange = RadOnChange
end

vgui.Register( "JobPrefMenuRadios", PANEL, "DPanel" )
