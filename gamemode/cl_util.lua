--- Client utility module.
-- Module for client utility functions.
-- @module util.lua

local fonts = {
	"Trebuchet18",
	"Trebuchet24",
	"HudHintTextLarge",
	"HudHintTextSmall",
	"CenterPrintText",
	"HudSelectionText",
	"CloseCaption_Normal",
	"CloseCaption_Bold",
	"CloseCaption_BoldItalic",
	"ChatFont",
	"TargetID",
	"TargetIDSmall",
	-- "HL2MPTypeDeath",
	"BudgetLabel",
	"DermaDefault",
	"DermaDefaultBold",
	"DermaLarge"
}

local w = 1180
local h = 460
local t_dy = 28

function DrawFontTest()
	draw.RoundedBoxEx(
		8,
		5,
		surface.ScreenHeight()/2-h/2,
		w,
		h,
		SPS.COLOR.HUD_PANEL_BACKGROUND,
		false, true, false, true)

	for i, v in ipairs(fonts) do
		draw.SimpleText(
			"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890-=!@#$%^&*()_+",
			v,
			20,
			surface.ScreenHeight()/2-(#fonts*t_dy/2)+(i*t_dy),
			HUD_TEXT,
			TEXT_ALIGN_LEFT,
			TEXT_ALIGN_TOP)
	end
end
