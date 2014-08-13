local PANEL = {}

function PANEL:Init()
	self:SetSkin( "SPSDermaSkin" )
	self:Center()
	-- self:MakePopup()
	-- self:SetVisible( true )
	-- self:SetDraggable( true )
	-- self:SetScreenLock( true )
	-- self:ShowCloseButton( true )
	-- self:SetKeyboardInputEnabled( false )
	-- self:SetMouseInputEnabled( true )

	-- self.button = vgui.Create("DButton", self)
	-- self.button:SetText("Click me")
	-- self.button:SetContentAlignment(9)
	-- self.button:SetPos(10, 40)

	-- Pre-round progress bar
	self.Progress = vgui.Create( "DProgress", self )
	-- self.Progress:Dock( BOTTOM )
end

function PANEL:Close()
	T.JobPref.Hide()
end

function PANEL:OnMousePressed()
	self.Dragging = { gui.MouseX() - self.x, gui.MouseY() - self.y }
	self:MouseCapture( true )
end

function PANEL:OnMouseReleased()
	self.Dragging = nil
	self:MouseCapture( false )
end

function PANEL:Think()
	-- local mousex = math.Clamp ( gui.MouseX(), 1, ScrW() - 1 )
	-- local mousey = math.Clamp ( gui.MouseY(), 1, ScrH() - 1 )

	-- if ( self.Dragging ) then
	-- 	local x = mousex - self.Dragging[1]
	-- 	local y = mousey - self.Dragging[2]
	-- end

	if (T.roundState == T.ROUND.PRE) then
		local fraction = ( CurTime() - T.roundStart ) / ( T.roundEnd - T.roundStart )
		self.Progress:SetFraction( fraction )
	else
		self.Progress:SetFraction( 0 )
	end
end

function PANEL:Paint( w, h )
	derma.SkinHook( "Paint", "Frame", self, w, h )
end

function PANEL:PerformLayout()
	self:SetSize( 400, 300 )

	self.Progress:SetSize( self:GetWide() - 10, 25 )
	self.Progress:SetPos( 5, self:GetTall() - 30 )
end

vgui.Register( "JobPref", PANEL, "Panel" )

T.JobPref = {}
T.JobPref.vgui = vgui.Create( "JobPref" )
local p = T.JobPref.vgui

-- Show job preference menu panel.
function T.JobPref.Show()
	p:SetVisible( true )
end

-- Show job preference menu panel.
function T.JobPref.Hide()
	p:SetVisible( false )
end

function T.JobPref.Toggle()
	p:ToggleVisible()
end
