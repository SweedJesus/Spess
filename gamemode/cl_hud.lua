--- Client HUD module.
-- Client HUD (heads up display) control.
-- @module cl_hud.lua
-- @todo Transition from Draw library to Surface library once texture elements come into play.

local textRoundStatus = {
	text = "ROUND STATUS",
	font = SPS.FONT.ROUND_STATE,
	x = surface.ScreenWidth()/2,
	y = 25,
	xalign = TEXT_ALIGN_CENTER,
	yalign = TEXT_ALIGN_TOP,
	color = HUD_FONT
}

SPS.FONT.ROUND_STATE = "Trebuchet24"

--- Paint HUD backgrounds.
-- Paint backgrounds for HUD elements.
local function HUDPaintBackgrounds()
	-- Round status background
	draw.RoundedBoxEx(
		8,
		surface.ScreenWidth()/2-100,
		5,
		200,
		30,
		SPS.COLOR.HUD_PANEL_BACKGROUND,
		false, false, true, true)
end

--- Paint HUD foregrounds.
-- Paint foregrounds for HUD elements.
local function HUDPaintForegrounds()
	-- Round status text
	draw.SimpleText(
		GetRoundStateText(GAMEMODE.roundState),
		SPS.FONT.ROUND_STATE,
		surface.ScreenWidth()/2,
		20,
		HUD_TEXT,
		TEXT_ALIGN_CENTER,
		TEXT_ALIGN_CENTER)
end

function GM:HUDPaint()
	HUDPaintBackgrounds()
	HUDPaintForegrounds()
	-- DrawFontTest()
end
