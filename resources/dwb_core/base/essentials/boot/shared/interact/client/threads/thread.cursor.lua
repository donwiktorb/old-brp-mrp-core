Key:onJustPressedAndReleased("LMENU", "Alt2", function()
	Interact.Cursor:OnAltPress()
end, function()
	Interact.Cursor:OnAltRelease()
end)

Key:onMouseJustPressed("MOUSE_RIGHT", "Menu myszka", function()
	Interact.Cursor:OnLeftClick()
end)
