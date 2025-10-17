UI = class()
UI.CanOpen = true
UI.CanClose = true
UI.opened = {}
UI.current = {}
UI.forceFocus = {
  ["Teams"] = {
    cursor = true,
    doNotKeepInput = true,
  },
  ["Phone"] = {
    cursor = true,
    -- doNotKeepInput = false
    doNotKeepInput = true,
  },
  ["CarRadio"] = {
    cursor = true,
    doNotKeepInput = true,
  },
  ["Scratch"] = {
    cursor = true,
    doNotKeepInput = true,
  },
  ["Radio"] = {
    cursor = true,
    doNotKeepInput = true,
  },
  ["Tut"] = {
    cursor = true,
    doNotKeepInput = true,
  },
  ["Bank"] = {
    cursor = true,
    doNotKeepInput = true,
  },

  ["MenuPicker"] = {
    cursor = true,
  },
  ["MenuGrid"] = {
    cursor = true,
    doNotKeepInput = true,
  },
  ["Skills"] = {
    cursor = true,
    -- doNotKeepInput = true
  },
  ["MenuDialog"] = {
    cursor = true,
    doNotKeepInput = true,
  },
  ["Chat"] = {
    cursor = false,
  },
  ["Inventory"] = {
    cursor = true,
    doNotKeepInput = true,
  },
  ["MenuCenter"] = {
    cursor = true,
    doNotKeepInput = true,
  },
  ["Tablet"] = {
    cursor = true,
    doNotKeepInput = true,
  },
  ["MenuCategory"] = {
    cursor = true,
    doNotKeepInput = false,
  },

  ["MenuSide"] = {
    cursor = true,
    doNotKeepInput = true,
  },
  ["MenuExtra"] = {
    cursor = true,
    doNotKeepInput = true,
  },
}

--[[
    types:
        Menu
        MenuDialog
        MenuCircle
        MenuList
        Notify
        Bar
]]

function UI:newFocus(name, cursor)
  self.forceFocus[name] = {
    cursor = cursor,
  }
end

function UI:SetCanOpen(state)
  self.LastStateOpen = self.CanOpen
  self.CanOpen = state
end

function UI:RestoreCanOpen()
  self.CanOpen = self.LastStateOpen
end

function UI:SetCanClose(state)
  self.CanClose = state
end

function UI:ActiveInput(state)
  SetNuiFocusKeepInput(state)
end

function UI:IsAnyOpenWithFocus()
  for k, v in pairs(self.opened) do
    if self.forceFocus[v.type] then
      return true
    end
  end
end

function UI:GetOpenedAll()
  return self.opened
end

function UI:GetOpened(name)
  return self.opened[name]
end

function UI:IsOpen(name)
  return self.opened[name] ~= nil
end

function UI:IsAnyOpen()
  for k, v in pairs(self.opened) do
    return true
  end
end

function UI:Update(name, k, kv, v)
  if self.opened[name] then
    self.opened[name].update(k, kv, v)
  end
end

function UI:onSubmit(menu, cb)
  element.submit = cb
end

function UI:onCancel(menu, cb)
  element.cancel = cb
end

function UI:onChange(menu, cb)
  element.change = cb
end

function UI:Open(type, data, s, c, ch, cl, force)
  if type == "Menu" or type == "MenuDialog" then
    if not data.align then
      data.align = "center"
    end
  end
  -- if not self.CanOpen and data.name ~= 'ambu-help' then return end
  if not self.CanOpen and not force and not data.forceOpen then
    return
  end
  if self.opened[data.name] then
    local element = self.opened[data.name]

    element.submit = s
    element.cancel = c
    element.change = ch
    element.rawClose = cl

    element.close = function(manual)
      UI:Close(type, data)
      if cl then
        cl()
      end
    end

    if not element.cancel then
      element.cancel = element.close
    end

    element.setTitle = function(title)
      element.data.title = title
      SendNUIMessage({
        action = "open",
        type = type,
        data = {
          update = true,
          name = element.data.name,
          title = element.data.title,
        },
      })
    end

    element.updateElements = function(elements)
      element.data.elements = elements
      SendNUIMessage({
        action = "open",
        type = type,
        data = {
          update = true,
          name = element.data.name,
          elements = element.data.elements,
        },
      })
    end

    element.updateData = function(key, val)
      element.data[key] = val
      local item = {
        action = "open",
        type = type,
        data = element.data,
      }
      SendNUIMessage(item)
    end

    element.update2 = function(elements)
      for k, v in pairs(elements) do
        element.data[k] = v
      end

      SendNUIMessage({
        action = "open",
        type = type,
        data = elements,
      })
    end

    element.update = function(key, kv, val)
      for k, v in pairs(element.data.elements) do
        if element.data.elements[k][key] == kv then
          for k2, v2 in pairs(val) do
            element.data.elements[k][k2] = v2
          end
        end
      end
      SendNUIMessage({
        action = "open",
        type = type,
        data = {
          update = true,
          name = element.data.name,
          elements = element.data.elements,
        },
      })
    end

    if type == "Menu" then
      self.current = {
        name = data.name,
        type = type,
      }
    end

    data.update = true

    SendNUIMessage({
      action = "open",
      type = type,
      data = data,
    })

    for k, v in pairs(self.forceFocus) do
      if k == type then
        SendNUIMessage({
          type = type,
          action = "setFocus",
          focus = true,
        })

        SetNuiFocus(true, v.cursor)
        SetNuiFocusKeepInput(not v.doNotKeepInput)
      end
    end

    return element
  end

  local element = {
    type = type,
    data = data,
    submit = s,
    cancel = c,
    change = ch,
    cl = cl,
  }

  function element:onSubmit(cb)
    self.submit = cb
  end

  function element:onChange(cb)
    self.change = cb
  end

  function element:onContext(cb)
    self.context = cb
  end

  function element:onCancel(cb)
    self.cancel = cb
  end

  function element:onClose(cb)
    self.cl = cb
  end

  element.rawClose = element.cl

  element.close = function(manual)
    UI:Close(type, data)
    if element.cl then
      element.cl()
    end
  end

  if not element.cancel then
    element.cancel = element.close
  end

  element.setTitle = function(title)
    element.data.title = title
    SendNUIMessage({
      action = "open",
      type = type,
      data = {
        update = true,
        name = element.data.name,
        title = element.data.title,
      },
    })
  end

  element.updateElements = function(elements)
    element.data.elements = elements
    SendNUIMessage({
      action = "open",
      type = type,
      data = {
        update = true,
        name = element.data.name,
        elements = element.data.elements,
      },
    })
  end
  element.update2 = function(elements)
    for k, v in pairs(elements) do
      element.data[k] = v
    end

    SendNUIMessage({
      action = "open",
      type = type,
      data = elements,
    })
  end

  element.updatePageElement = function(id, id2, data)
    for k, v in pairs(data) do
      element.data.pages[id][id2][k] = v
    end
    SendNUIMessage({
      action = "updatePageElement",
      type = type,
      data = {
        pageId = id,
        elementId = id2,
        data = data,
      },
    })
  end

  element.updateMessage = function(id, data)
    element.data.messages[id + 1] = data
    SendNUIMessage({
      action = "updateMessage",
      type = type,
      data = {
        messageId = id,
        data = data,
      },
    })
  end

  element.refresh = function()
    SendNUIMessage({
      action = "open",
      type = type,
      data = element.data,
    })
  end

  element.update4 = function(keys, value)
    local current = element.data

    for k, v in pairs(keys) do
      if k < #keys then
        current = current[v]
      else
        current[k] = value
      end
    end

    SendNUIMessage({
      action = "open",
      type = type,
      data = element.data,
    })
  end

  element.updateData = function(key, val)
    if not val then
      for k, v in pairs(key) do
        element.data[k] = v
      end
    else
      element.data[key] = val
    end
    local item = {
      action = "open",
      type = type,
      data = element.data,
    }
    SendNUIMessage(item)
  end

  element.update = function(key, kv, val)
    for k, v in pairs(element.data.elements) do
      if element.data.elements[k][key] == kv then
        for k2, v2 in pairs(val) do
          element.data.elements[k][k2] = v2
        end
      end
    end
    SendNUIMessage({
      action = "open",
      type = type,
      data = {
        oldupdate = true,
        key = key,
        value = kv,
        data = val,
        name = element.data.name,
        -- elements = element.data.elements
      },
    })
  end

  if type == "Menu" then
    self.current = {
      name = data.name,
      type = type,
    }
  end

  SendNUIMessage({
    action = "open",
    type = type,
    data = data,
  })

  for k, v in pairs(self.forceFocus) do
    if k == type then
      SendNUIMessage({
        type = type,
        action = "setFocus",
        focus = true,
      })

      SetNuiFocus(true, v.cursor)
      SetNuiFocusKeepInput(not v.doNotKeepInput)
    end
  end

  if data.focus then
    SetNuiFocus(true, data.focus.cursor)
    SetNuiFocusKeepInput(not data.focus.doNotKeepInput)
  end

  if data.name then
    self.opened[data.name] = element
  end

  return element
end

function UI:Submit()
  SendNUIMessage({
    name = self.current.name,
    type = self.current.type,
    action = "submit",
  })
end

function UI:Right()
  SendNUIMessage({
    name = self.current.name,
    type = self.current.type,
    action = "scrollSide",
    data = {
      right = true,
    },
  })
end

function UI:Down()
  SendNUIMessage({
    name = self.current.name,
    type = self.current.type,
    action = "scroll",
  })
end

function UI:Up()
  SendNUIMessage({
    name = self.current.name,
    type = self.current.type,
    action = "scroll",
    data = {
      up = true,
    },
  })
end

function UI:Back()
  SendNUIMessage({
    name = self.current.name,
    type = self.current.type,
    action = "cancel",
  })
end

function UI:Left()
  SendNUIMessage({
    name = self.current.name,
    type = self.current.type,
    action = "scrollSide",
  })
end

function UI:On(name, func)
  RegisterNUICallback(name, function(data, cb)
    local val = func(data)
    cb(val or {})
  end)
end

function UI:Action(type, name, action, data)
  -- SendNUIMessage({
  --     name = data.name,
  --     type = type,
  --     action = action,
  --     data = data or {}
  -- })
  SendNuiMessage(json.encode({
    name = data.name,
    type = type,
    action = action,
    data = data or {},
  }))
end

function UI:ToggleFocus(cursor, input)
  SetNuiFocus(true, cursor)
  SetNuiFocusKeepInput(not input)
end

function UI:Close(type, data)
  if not UI.CanClose and not data.forceClose then
    return
  end
  for k, v in pairs(self.forceFocus) do
    if k == type then
      SendNUIMessage({
        type = type,
        action = "setFocus",
        focus = false,
      })

      SetNuiFocus(false)
    end
  end

  SendNUIMessage({
    action = "close",
    type = type,
    data = data,
  })

  local latest = false

  for k, v in pairs(self.opened) do
    if (data and k == data.name) or (not data and v.type == type) then
      self.opened[k] = nil
      local latest
      for k, v in pairs(self.opened) do
        latest = k
      end
      if self.opened[latest] then
        self.current = {
          name = self.opened[latest].name,
          type = self.opened[latest].type,
        }
      else
        self.current = {}
      end
    end
  end
end

function UI:CloseAll(...)
  local closed = false
  if not UI.CanClose then
    return
  end
  local args = { ... }
  if args[1] then
    for k, v in pairs(args) do
      -- if v.type ~= 'Bar' then
      v.close()
      -- end
    end
    closed = true
  else
    for k, v in pairs(self.opened) do
      if not v.data or not v.data.autoClose then
        -- if v.type ~= 'Bar' then
        UI:Close(v.type, v.data)
      end
      -- end
    end
    closed = true
  end
  while not closed do
    Wait(0)
  end
end
