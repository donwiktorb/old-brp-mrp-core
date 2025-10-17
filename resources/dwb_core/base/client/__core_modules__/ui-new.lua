if true then
  return
end
Menu = class(nil, nil, function(self, type, data, submitCb, cancelCb, changeCb, closeCb)
  self.type = type
  self.data = data
  self.name = data.name
  self.cancelCb = cancelCb or self.Close
  self.changeCb = changeCb
  self.submitCb = submitCb
  self.closeCb = closeCb
end)

function Menu:Update(key, value)
  if value then
    if type(value) == "table" then
      self.data[key] = value
    end
  else
    self.data = key
    self.name = self.data["name"]
  end

  self.data.isUpdate = true

  BUI:Send({
    action = "open",
    type = self.type,
    data = self.data,
  })

  self.data.isUpdate = nil
end

function Menu:Close()
  BUI:Close(self.name)
end

Menu.close = Menu.Close
Menu.update = Menu.Update

BUI = class()
BUI.opened = {}
BUI.current = nil

function BUI:Send(data)
  SendNuiMessage(json.encode(data))
end

function BUI:IsOpen(name)
  for k, v in pairs(self.opened) do
    if v.name == name then
      return true
    end
  end
end

function BUI:GetOpened(name)
  for k, v in pairs(self.opened) do
    if v.name == name then
      return v, k
    end
  end
end

function BUI:Open(type, data, submitCb, cancelCb, changeCb, closeCb)
  local name = data.name
  local openedMenu, openedMenuIdx = self:GetOpened(name)
  local menu = openedMenu or Menu(type, data, submitCb, cancelCb, changeCb, closeCb)

  self.current = menu

  data.isUpdate = data.isUpdate or isOpened
  data.log = true

  if not openedMenu then
    table.insert(self.opened, menu)
  end

  self:Send({
    action = "open",
    type = type,
    data = data,
  })

  --SendNBUIMessage({
  --  type = type,
  --  action = "setFocus",
  --  focus = true,
  --})
end

function BUI:On(name, func)
  RegisterNBUICallback(name, function(data, cb)
    local val = func(data)
    cb(val or {})
  end)
end

function BUI:Close(name, oldData)
  if oldData then
    name = oldData.name
  end
  local menu, menuIndex = self:GetOpened(name)
  print(menu, name)
  if menu then
    if self.current == menu then
      self.current = self.opened[menuIndex - 1]
    end

    if menu.closeCb then
      menu.closeCb()
    end

    table.remove(self.opened, menuIndex)
    self:Send({
      action = "close",
      type = menu.type,
      data = menu.data,
    })
  end
end

function BUI:CloseAll()
  for k, v in pairs(self.opened) do
    self:Close(v.name)
  end
end

function BUI:Submit()
  self:Send({
    type = self.current.type,
    action = "submit",
    data = {
      name = self.current.name,
    },
  })
end

function BUI:Right()
  self:Send({
    type = self.current.type,
    action = "scrollSide",
    data = {
      name = self.current.name,
      right = true,
    },
  })
end

function BUI:Down()
  self:Send({
    type = self.current.type,
    action = "scroll",
    data = {
      name = self.current.name,
    },
  })
end

function BUI:IsAnyOpenWithFocus()
  if true then
    return
  end
  for k, v in pairs(self.opened) do
    if self.forceFocus[v.type] then
      return true
    end
  end
end

function BUI:Up()
  self:Send({
    type = self.current.type,
    action = "scroll",
    data = {
      name = self.current.name,
      up = true,
    },
  })
end

function BUI:Back()
  self:Send({
    data = {
      name = self.current.name,
    },
    type = self.current.type,
    action = "cancel",
  })
end

function BUI:Left()
  self:Send({
    data = {

      name = self.current.name,
    },
    type = self.current.type,
    action = "scrollSide",
  })
end

function BUI:Action(type, name, action, data)
  SendNuiMessage(json.encode({
    name = data.name,
    type = type,
    action = action,
    data = data or {},
  }))
end
