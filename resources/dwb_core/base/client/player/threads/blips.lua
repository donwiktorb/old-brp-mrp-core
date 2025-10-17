local Display = 1

function UpdateDisplay()
    if PushScaleformMovieFunctionN("DISPLAY_DATA_SLOT") then
        PushScaleformMovieFunctionParameterInt(Display)
        PopScaleformMovieFunctionVoid()
    end
end

function SetColumnState(column, state)
    if PushScaleformMovieFunctionN("SHOW_COLUMN") then
        PushScaleformMovieFunctionParameterInt(column)
        PushScaleformMovieFunctionParameterBool(state)
        PopScaleformMovieFunctionVoid()
    end
end

function ShowDisplay(show)
    SetColumnState(Display, show)
end

function func_36(fParam0)
    BeginTextCommandScaleformString(fParam0)
    EndTextCommandScaleformString()
end

function SetIcon(index, title, text, icon, iconColor, completed)
    if PushScaleformMovieFunctionN("SET_DATA_SLOT") then
        PushScaleformMovieFunctionParameterInt(Display)
        PushScaleformMovieFunctionParameterInt(index)
        PushScaleformMovieFunctionParameterInt(65)
        PushScaleformMovieFunctionParameterInt(3)
        PushScaleformMovieFunctionParameterInt(2)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(1)
        func_36(title)
        func_36(text)
        PushScaleformMovieFunctionParameterInt(icon)
        PushScaleformMovieFunctionParameterInt(iconColor)
        PushScaleformMovieFunctionParameterBool(completed)
        PopScaleformMovieFunctionVoid()
    end
end

function SetText(index, title, text, textType)
    if PushScaleformMovieFunctionN("SET_DATA_SLOT") then
        PushScaleformMovieFunctionParameterInt(Display)
        PushScaleformMovieFunctionParameterInt(index)
        PushScaleformMovieFunctionParameterInt(65)
        PushScaleformMovieFunctionParameterInt(3)
        PushScaleformMovieFunctionParameterInt(textType or 0)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(0)
        func_36(title)
        func_36(text)
        PopScaleformMovieFunctionVoid()
    end
end

local _labels = 0
local _entries = 0
function ClearDisplay()
    if PushScaleformMovieFunctionN("SET_DATA_SLOT_EMPTY") then
        PushScaleformMovieFunctionParameterInt(Display)
    end
    PopScaleformMovieFunctionVoid()
    _labels = 0
    _entries = 0
end

function _label(text)
    local lbl = "LBL" .. _labels
    AddTextEntry(lbl, text)
    _labels = _labels + 1
    return lbl
end

function SetTitle(title, rockstarVerified, rp, money, dict, tex)
    if PushScaleformMovieFunctionN("SET_COLUMN_TITLE") then
        PushScaleformMovieFunctionParameterInt(Display)
        func_36("")
        func_36(_label(title))
        PushScaleformMovieFunctionParameterInt(rockstarVerified)
        PushScaleformMovieFunctionParameterString(dict)
        PushScaleformMovieFunctionParameterString(tex)
        PushScaleformMovieFunctionParameterInt(0)
        PushScaleformMovieFunctionParameterInt(0)
        if rp == "" then
            PushScaleformMovieFunctionParameterBool(0)
        else
            func_36(_label(rp))
        end
        if money == "" then
            PushScaleformMovieFunctionParameterBool(0)
        else
            func_36(_label(money))
        end
    end
    PopScaleformMovieFunctionVoid()
end

function AddText(title, desc, style)
    SetText(_entries, _label(title), _label(desc), style or 1)
    _entries = _entries + 1
end

function AddIcon(title, desc, icon, color, checked)
    SetIcon(_entries, _label(title), _label(desc), icon, color, checked)
    _entries = _entries + 1
end

-- -- Thread:Create(function()
-- --     local current_blip = nil
-- --     SetPauseMenuActive(false)
-- --     ReleaseControlOfFrontend()
-- --     while true do
-- --         local sleep = 0
-- --         if IsFrontendReadyForControl() then
-- --             local blip = DisableBlipNameForVar()
-- --             if IsHoveringOverMissionCreatorBlip() then
-- --                 if DoesBlipExist(blip) then
-- --                     if current_blip ~= blip then
-- --                         current_blip = blip
-- --                         if DWB.Blips[blip] then
-- --                             local data = DWB.Blips[blip]
-- --                             TakeControlOfFrontend()
-- --                             ClearDisplay()
-- --                             SetTitle(data.title, data.rockstarVerified or "", data.rp or "", data.money or "", data.dict or "", data.tex or "")

-- --                             for k,v in pairs(data.info) do
-- --                                 if v.type == 'icon' then
-- --                                     AddIcon(v.title, v.desc, v.icon, v.color, v.checked)
-- --                                 else
-- --                                     AddText(v.title, v.desc, v.style)
-- --                                 end
-- --                             end

-- --                             ShowDisplay(true)
-- --                             UpdateDisplay()
-- --                             ReleaseControlOfFrontend()
-- --                         else
-- --                             ShowDisplay(false)
-- --                         end
-- --                     end
-- --                 end
-- --             else
-- --                 if current_blip then
-- --                     current_blip = nil
-- --                     ShowDisplay(false)
-- --                 end
-- --             end
-- --         else
-- --             sleep = 500
-- --         end
-- --         Wait(sleep)
-- --     end
-- -- end)