


RegisterNUICallback("dwb_ui_ready", function(data, cb)
    print("UI LOADED")
    for k,v in pairs(data) do
        if json.decode(v) then
            data[k] = json.decode(v)
        end
        if tonumber(v) then
            data[k] = tonumber(v)
        end
    end
    DWB.UISettings = data or {}
    DWB.LoadedUI = true
    if DWB.UISettings == nil or json.encode(DWB.UISettings) == '[]' then
        DWB.UISettings =  Config.Server.DefaultSettings
    end
    Event:Trigger('dwb:ui:loaded')
    cb({})
end)