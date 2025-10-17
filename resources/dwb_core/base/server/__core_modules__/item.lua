Item = class()
Item.OnItemUse = {}

Item.CustomItems = {}
function Item:Get(name)
    return DWB.Items[name]
end

function Item:Add(xPlayer, data)
    for k, v in pairs(self.CustomItems) do
        if v.type and data.type == v.type or v.name and data.name == v.name then
            if v.OnAdd then v:OnAdd(xPlayer, data) end
        end
    end
end

function Item:Remove(xPlayer, data)
    for k, v in pairs(self.CustomItems) do
        if v.type and data.type == v.type or v.name and data.name == v.name then
            if v.OnRemove then v:OnRemove(xPlayer, data) end
        end
    end
end

function Item:Use(xPlayer, item, data)
    if DWB.UsableItemsCallbacks[item] then
        for k, v in pairs(DWB.UsableItemsCallbacks[item]) do v.cb(xPlayer.source, data) end
    end

    for k, v in pairs(self.CustomItems) do
        if v.type and data.type == v.type or v.name and data.name == v.name then
            if v.OnUse then
                v:OnUse(xPlayer, data)
            end
        end
    end
end

function Item:Change(xPlayer, data, data4)
    for k, v in pairs(self.CustomItems) do
        if v.type and data.type == v.type or v.name and data.name == v.name then
            if v.OnUseItem then
                v:OnUseItem(xPlayer, data, data4)
            end
        end
    end
end

function Item:RegisterCustom(cb)
    self.CustomRegister = cb
end

function Item:RegisterUsable(item, cb)
    if not DWB.UsableItemsCallbacks[item] then
        DWB.UsableItemsCallbacks[item] = {}
    end
    table.insert(DWB.UsableItemsCallbacks[item], {
        cb = cb
    })
    -- DWB.UsableItemsCallbacks[item] = cb
end

function Item:Register(data)
    local item = class(nil, data)
    table.insert(self.CustomItems, item)
    return item
end

function Item:GetAll()
    return DWB.Items
end

function Item:GetInventoryFormat2(itemData)
    -- -- print(json.encode(DWB.Items[itemData.name]))
    if itemData.slot and itemData.slot == 0 then itemData.slot = math.random(1, 50) end
    local item = DWB.Items[itemData.name]
    if item then
        itemData.name = string.lower(item.name)
        itemData.extra = item.extra 
        itemData.count = tonumber(itemData.count or 1)

        itemData.slot = itemData.slot or math.random(1, 50)

        itemData.data = itemData.data or {}

        itemData.weight = item.weight
        itemData.type = item.type
        itemData.label = item.label
        itemData.limit = item.limit or 1
        itemData.rare = item.rare
        itemData.canRemove = item.canRemove
        itemData.ref = item.ref

        itemData.usable = DWB.UsableItemsCallbacks[itemData.name] ~= nil
        return itemData
    else
        -- Log:Error('Wrong item', json.encode(itemData))
    end
end

function Item:GetInventoryFormat(itemData)
    -- -- print(json.encode(DWB.Items[itemData.name]))
    if itemData.name and Config.Replace[itemData.name] then
        itemData.name = Config.Replace[itemData.name]
    end

    local item = DWB.Items[string.lower(itemData.name)]

    if itemData.slot and itemData.slot == 0 then itemData.slot = math.random(1, 50) end
    if item then



        return {
            extra = item.extra,
            name = string.lower(item.name),
            count = tonumber(itemData.count or 1),
            slot = itemData.slot or math.random(1, 50),
            data = itemData.data or {},

            weight = item.weight,
            type = item.type,
            label = item.label,
            limit = item.limit or 1,
            rare = item.rare,
            canRemove = item.canRemove,
            ref = item.ref,

            usable = DWB.UsableItemsCallbacks[itemData.name] ~= nil,
        }
    else
        -- Log:Error('Wrong item', json.encode(itemData))
        return {
            name = string.lower(itemData.name),
            count = itemData.count or 1,
            slot = itemData.slot or 1,
            label = "?" .. itemData.name,
            limit = itemData.limit or 10
        }
    end
end

function Item:GetDatabaseFormat(item)
    return {
        name = string.lower(item.name),
        count = item.count,
        data = item.data,
        slot = item.slot
    }
end

function Item:GetInventoryDatabaseFormat(inv)
    local inventory = {}
    for k, v in pairs(inv) do
        table.insert(inventory, {
            count = v.count,
            name = string.lower(v.name),
            data = v.data,
            slot = v.slot
        })
    end
    return inventory
end
