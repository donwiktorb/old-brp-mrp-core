UI = class(false, false, false, User)


UI.current = {}
function UI:Open(type, uiData, data, onSubmit, onCancel, onChanged)
    data.onSubmit = onSubmit
    data.onCancel = onCancel
    data.onChanged = onChanged
    self.current[uiData and uiData.name or type] = data
    self.currentUI = data
    self.currentUIData = uiData


    Event:TriggerNet('dwb:ui:open', self.source, type, uiData, data)
end

function UI:OnSubmit(data, menu)
    local index = menu.data and menu.data.name or menu.type
    self.current[index].onSubmit(data,menu)
end

function UI:OnCancel(data, menu)
    local index = menu.data and menu.data.name or menu.type
    self.current[index].onCancel(data,menu)
end

function UI:OnChanged(data, menu)
    local index = menu.data and menu.data.name or menu.type
    self.current[index].onChanged(data,menu)
end

User:OnLoaded(function(self)
    self.ui = UI(self)
end)

Event:Register('dwb:ui:submit', function(source, xPlayer,data, menu)
    xPlayer.ui:OnSubmit(data, menu)
end, true)

Event:Register('dwb:ui:cancel', function(source, xPlayer,data, menu)
    xPlayer.ui:OnChanged(data, menu)
end, true)

Event:Register('dwb:ui:changed', function(source, xPlayer,data, menu)
    xPlayer.ui:OnChanged(data, menu)
end, true)

