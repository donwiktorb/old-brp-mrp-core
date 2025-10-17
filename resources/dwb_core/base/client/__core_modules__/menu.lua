Menu = class()

function Menu:Open(type, namespace, name, data, submit, cancel, change, close)
    return UI:Open(type, {
        title = data.title,
        name = name,
        align = data.align or 'center',
        elements = {
            data.elements
        }
    }, submit, cancel, change, close)
end

function Menu:Close(type, namespace, name)
    UI:Close(type, {
        name = name
    })
end

function Menu:CloseAll()
    UI:CloseAll()
end

function Menu:GetOpened(type, namespace, name)
    return UI:GetOpened(name)
end

function Menu:GetOpenedMenus()
    return UI:GetOpenedAll()
end

function Menu:IsOpen(type, namespace, name)
	return Menu:GetOpened(type, namespace, name) ~= nil
end
