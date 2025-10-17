local GuiTimer = 0

local function timerCheck()
  return (GetGameTimer() - GuiTimer) > 150
end

Key:onJustReleased("RETURN", "Menu kliknij", function()
  if timerCheck() then
    UI:Submit()
    GuiTimer = GetGameTimer()
  end
end)

Key:onPressed("BACK", "Menu anuluj", function()
  if timerCheck() then
    UI:Back()
    GuiTimer = GetGameTimer()
  end
end)

Key:onPressed("UP", "W górę", function()
  if timerCheck() then
    UI:Up()
    GuiTimer = GetGameTimer()
  end
end)

Key:onPressed("DOWN", "W dół", function()
  if timerCheck() then
    UI:Down()
    GuiTimer = GetGameTimer()
  end
end)

Key:onJustReleased("ESCAPE", "Menu anuluj", function()
  if UI:IsAnyOpen() then
    DisableControlAction(0, 200, true)
    if timerCheck() then
      UI:Back()
      GuiTimer = GetGameTimer()
    end
  end
end)

Key:onPressed("LEFT", "W lewo", function()
  if timerCheck() then
    UI:Left()
    GuiTimer = GetGameTimer()
  end
end)

Key:onPressed("RIGHT", "W prawo", function()
  if timerCheck() then
    UI:Right()
    GuiTimer = GetGameTimer()
  end
end)

RegisterNUICallback("menu_submit", function(data, cb)
  local name = data.menu and data.menu.name or data.name
  local menu = UI:GetOpened(name)
  if menu then
    menu.submit(data, menu)
  end
  cb({})
end)

RegisterNUICallback("menu_context", function(data, cb)
  local name = data.menu and data.menu.name or data.name
  local menu = UI:GetOpened(name)
  if menu and menu.context then
    menu.context(data, menu)
  end
  cb({})
end)

RegisterNUICallback("menu_cancel", function(data, cb)
  local name = data.menu and data.menu.name or data.name
  local menu = UI:GetOpened(name)
  if menu then
    menu.cancel(data, menu)
  end
  cb({})
end)

RegisterNUICallback("menu_change", function(data, cb)
  local name = data.menu and data.menu.name or data.name
  local menu = UI:GetOpened(name)
  if menu then
    if menu.setElements and data.menu and data.menu.elements then
      menu.setElements(data.menu.elements)
    end
    if menu.change then
      menu.change(data, menu)
    end
  end
  cb({})
end)
