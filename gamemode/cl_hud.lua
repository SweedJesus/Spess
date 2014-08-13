--- Client HUD module.
-- Client HUD (heads up display) control.
-- @module cl_hud.lua
-- @todo Transition from Draw library to Surface library once texture elements come into play.

local colorHudBackground	= Color( 100, 100, 100, 255 )
local colorHudText				= Color( 255, 255, 255, 255 )

local fontHudText	= "Trebuchet24"

--- Paint HUD backgrounds.
local function HUDPaintBackgrounds()
	-- Round status background
	draw.RoundedBoxEx( 8, surface.ScreenWidth() / 2 - 100, 5, 200, 30, colorHudBackground, false, false, true, true)
end

--- Paint HUD foregrounds.
local function HUDPaintForegrounds()
	local s
	if ( T.roundState == 0 ) then
		s = "Waiting..."
	elseif ( T.roundState == 1 ) then
		s = os.date( "Pre-Round %M:%S", math.Round(T.roundEnd - CurTime() ) )
	elseif ( T.roundState == 2 ) then
		s = os.date( "Active  %M:%S", ( CurTime() - T.roundStart ) )
	elseif ( T.roundState == 3 ) then
		s = os.date( "Post-Round %M:%S", math.Round( T.roundEnd - CurTime() ) )
	end

	-- Round state/time text
	draw.SimpleText( s, fontHudText, surface.ScreenWidth() / 2, 20, colorHudText, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER )
end

function GM:HUDPaint()
	HUDPaintBackgrounds()
	HUDPaintForegrounds()
	-- T.DrawFontTest()
end
