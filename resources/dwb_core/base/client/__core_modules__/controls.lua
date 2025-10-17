--- Controls Module
---Provides functionality for managing input controls.
---@module Controls

--- Controls class for managing input states.
---@type Controls
Controls = class()

Controls.keys = {
  ["V"] = 0,
  ["1"] = 157,
  ["F1"] = 288,
  ["2"] = 158,
  ["F2"] = 289,
  ["3"] = 160,
  ["F3"] = 170,
  ["4"] = 164,
  ["N4"] = 108,
  ["5"] = 165,
  ["F5"] = 166,
  ["N5"] = 60,
  ["6"] = 159,
  ["F6"] = 167,
  ["N6"] = 107,
  ["7"] = 161,
  ["F7"] = 168,
  ["N7"] = 117,
  ["8"] = 162,
  ["F8"] = 169,
  ["N8"] = 61,
  ["S"] = 8,
  ["9"] = 163,
  ["D"] = 9,
  ["F9"] = 56,
  ["N9"] = 118,
  ["F10"] = 57,
  ["PAGEUP"] = 10,
  ["PAGEDOWN"] = 11,
  ["ENTER"] = 18,
  ["LEFTALT"] = 19,
  ["Z"] = 20,
  ["LEFTSHIFT"] = 21,
  ["SPACE"] = 22,
  ["F"] = 23,
  ["C"] = 26,
  ["TOP"] = 27,
  ["B"] = 29,
  ["W"] = 32,
  ["A"] = 34,
  ["LEFTCTRL"] = 36,
  ["TAB"] = 37,
  ["E"] = 38,
  ["["] = 39,
  ["]"] = 40,
  ["Q"] = 44,
  ["R"] = 45,
  ["G"] = 47,
  ["RIGHTCTRL"] = 70,
  ["X"] = 73,
  ["H"] = 74,
  ["."] = 81,
  [","] = 82,
  ["="] = 83,
  ["-"] = 84,
  ["N+"] = 96,
  ["N-"] = 97,
  ["CAPS"] = 137,
  ["DOWN"] = 173,
  ["LEFT"] = 174,
  ["RIGHT"] = 175,
  ["BACKSPACE"] = 177,
  ["DELETE"] = 178,
  ["L"] = 182,
  ["P"] = 199,
  ["NENTER"] = 201,
  ["HOME"] = 213,
  ["~"] = 243,
  ["M"] = 244,
  ["T"] = 245,
  ["Y"] = 246,
  ["N"] = 249,
  ["U"] = 303,
  ["K"] = 311,
  ["ESC"] = 322,
}

Controls.disabledAll = false
Controls.disabled = {}
Controls.enabled = {}

--- Remove disabled controls
function Controls:RemoveDisable()
  Controls.disabled = {}
end

--- Disable all controls
---@param state boolean
function Controls:DisableAll(state)
  Controls.disabledAll = state
  if Controls.disabled then
    Controls.enabled = {}
  end
end

--- Get controls state
function Controls:GetDisabledAll()
  return Controls.disabledAll
end

--- Get disabled state
function Controls:GetDisabled()
  return Controls.disabled
end

--- Get enabled state
function Controls:GetEnabled()
  return Controls.enabled
end

--- Enable controls
function Controls:Enable(...)
  local keys = { ... }
  for k, key in pairs(keys) do
    if tonumber(key) then
      table.insert(Controls.enabled, key)
    else
      if Controls.keys[key] then
        table.insert(Controls.enabled, self.keys[key])
      end
    end
  end
end

--- Disable controls
function Controls:Disable(...)
  local keys = { ... }
  for k, key in pairs(keys) do
    if tonumber(key) then
      table.insert(Controls.disabled, key)
    else
      if Controls.keys[key] then
        table.insert(Controls.disabled, self.keys[key])
      end
    end
  end
end
