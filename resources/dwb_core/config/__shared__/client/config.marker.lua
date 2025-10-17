--- Config
-- template
-- @module Config.Default.Zone

--- Marker Settings
-- Settings for a marker, including its appearance and behavior.
-- @table marker
-- @field type int Marker type (e.g., 27).
-- @field direction vector3 Direction of the marker.
-- @field rotation vector3 Rotation of the marker.
-- @field scale vector3 Scale of the marker.
-- @field color table Marker color settings (RGBA).
-- @field color.r int Red component (0-255).
-- @field color.g int Green component (0-255).
-- @field color.b int Blue component (0-255).
-- @field color.a int Alpha component (0-255).
-- @field animate bool Whether the marker animates.
-- @field faceCam bool Whether the marker faces the camera.

--- Default Zone Configuration
-- The default template for a zone.
-- @table Config.Default.Zone
-- @field marker marker Marker settings including type, scale, and color.
-- @field messages table<string, string> Zone messages like 'onEnter' and 'onExit'.
-- @field data table Custom data for the zone.
-- @field settings table Configuration settings for the zone.
-- @field functions table Custom functions for the zone.
-- @field coords table<integer, table> Coordinates for zone locations.
Config.Default.Zone = { -- table Config.Default.Zone
  marker = {
    type = 27, -- int marker type
    direction = vector3(0, 0, 0), -- vec3 direction
    rotation = vector3(0, 0, 0), -- vec3 rotation
    scale = vector3(1, 1, 1), -- vec3 scale
    color = { -- table color
      r = 200, -- int red
      g = 200, -- int green
      b = 200, -- int blue
      a = 200, -- int alpha
    },
    animate = false, -- bool animate
    faceCam = false, -- bool faceCam
  },
  messages = { -- table messages
    -- onClose = 'In close distance wtih marker',
    -- onEnter = 'In marker',
    -- onExit = 'Out of marker'
  },
  data = {},
  settings = {
    drawMarker = true,
  },
  functions = {},
  coords = {
    {
      -- key = 'default',
      pos = vector3(0, 0, 0),
    },
  },
}

Config.Markers = {}

Config.Markers.onCreateCbs = {
  ["teleport"] = function(data, v)
    User:Teleport(data)
  end,
}

Config.Markers.onEnterCbs = {
  ["trackEnter"] = function(cbData, zoneData, posData) end,
}

Config.Markers.onExitCbs = {
  ["teleportback"] = function(cbData, zoneData, posData)
    User:Teleport({ coords = posData.pos, heading = posData.heading or 434.4 })
  end,
}

Config.Markers.onRemoveCbs = {}

Config.Markers.CreateCbs = {
  ["owned-property"] = function(data, v)
    for k4, v4 in pairs(v and v.coords or {}) do
      if
        v4.data
        and v4.data.owner
        and DWB.PlayerData.char
        and v4.data.owner == DWB.PlayerData.char.id
      then
        v4.blip = v.ownedSingleBlip
      end
    end
    return true
  end,
  ["has-job"] = function(data)
    return User:HasJob(data)
  end,

  ["has-char-data"] = function(data)
    return DWB.PlayerData.char and DWB.PlayerData.char.data[data]
  end,
  ["!has-job"] = function(data)
    return not User:HasJob(data)
  end,
}

Config.Markers.Checks = {
  ["has-trailer"] = function()
    return IsVehicleAttachedToTrailer(DWB.PlayerData.Vehicle)
  end,
  ["remove-trailer"] = function()
    local retval, trailer = GetVehicleTrailerVehicle(DWB.PlayerData.Vehicle)
    if not retval then
      return false
    end

    DeleteEntity(trailer)
    return true
  end,
}

Config.Markers.Debug = {
  AllBlips = false,
  Names = false,
}
