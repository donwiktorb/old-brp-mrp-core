--- Animation Class
-- Handles animations for ped objects in FiveM.
-- @classmod Animation
-- @author YourName
-- @license MIT
-- @release 1.0.0
Animation = class()

Animation.canPlay = true

--- Setter for whether animations can be played
--@param state boolean
function Animation:SetCanPlay(state)
  self.canPlay = state
end

--- Play advanced animation
---@param ped integer
---@param lib string
---@param anim string
---@param coords table
---@param rot table
---@param entSpeed number
---@param exSpeed number
---@param duration integer
---@param flag bitlib
---@param time integer
function Animation:PlayAdvanced(
  ped,
  lib,
  anim,
  coords,
  rot,
  entSpeed,
  exSpeed,
  duration,
  flag,
  time
)
  if self.canPlay then
    Stream:RequestAnimDict(lib, function()
      TaskPlayAnimAdvanced(
        ped,
        lib,
        anim,
        coords,
        rot,
        entSpeed,
        exSpeed,
        duration,
        flag,
        time,
        0,
        0
      )
    end)
  end
end
--- Example Usage
-- To play an advanced animation:
-- ```lua
-- Animation:PlayAdvanced(ped, "amb@world_human_hang_out_street", "idle_a", coords, rot, 1.0, 1.0, 3000, 0, 0)
-- ```
--- Play animation

---@param ped integer
---@param lib string
---@param anim string
---@param blendIn number
---@param blendOut number
---@param duration number
---@param flag bitlib
---@param playRate number
---@param lockX boolean
---@param lockY boolean
---@param lockZ boolean
function Animation:Play(
  ped,
  lib,
  anim,
  blendIn,
  blendOut,
  duration,
  flag,
  playRate,
  lockX,
  lockY,
  lockZ
)
  if self.canPlay then
    Stream:RequestAnimDict(lib, function()
      TaskPlayAnim(ped, lib, anim, blendIn, blendOut, duration, flag, playRate, lockX, lockY, lockZ)
    end)
  end
end

--- Play anim clipset
---@param ped integer
---@param anim string
---@param speed number
function Animation:PlayClipset(ped, anim, speed)
  if self.canPlay then
    Stream:RequestAnimSet(anim, function()
      SetPedMovementClipset(ped, anim, speed)
    end)
  end
end

--- Play weapon clipset
---@param ped integer
---@param anim string
---@param speed number
function Animation:PlayClipsetWeapon(ped, anim, speed)
  if self.canPlay then
    Stream:RequestAnimSet(anim, function()
      SetPedWeaponMovementClipset(ped, anim, speed)
    end)
  end
end

--- Clear Tasks
---@param ped integer
function Animation:ClearTasks(ped)
  if self.canPlay then
    ClearPedTasks(ped)
  end
end

--- Reset Movement
---@param ped integer
function Animation:ResetMovement(ped)
  if self.canPlay then
    ResetPedMovementClipset(ped, 0)
  end
end

--- Forced Animation Methods
-- Static methods for forced animations.
-- @section Forced

Animation.forced = {}

--- func desc
---@param ped integer
---@param lib string
---@param anim string
---@param coords table
---@param rot table
---@param entSpeed integer
---@param exSpeed integer
---@param duration integer
---@param flag bitlib
---@param time integer
function Animation.forced:PlayAdvanced(
  ped,
  lib,
  anim,
  coords,
  rot,
  entSpeed,
  exSpeed,
  duration,
  flag,
  time
)
  Stream:RequestAnimDict(lib, function()
    TaskPlayAnimAdvanced(ped, lib, anim, coords, rot, entSpeed, exSpeed, duration, flag, time, 0, 0)
  end)
end

--- Play (forced)
---@param ped integer
---@param lib string
---@param anim string
---@param blendIn number
---@param blendOut number
---@param duration integer
---@param flag bitlib
---@param playRate number
---@param lockX boolean
---@param lockY boolean
---@param lockZ boolean
function Animation.forced:Play(
  ped,
  lib,
  anim,
  blendIn,
  blendOut,
  duration,
  flag,
  playRate,
  lockX,
  lockY,
  lockZ
)
  Stream:RequestAnimDict(lib, function()
    TaskPlayAnim(ped, lib, anim, blendIn, blendOut, duration, flag, playRate, lockX, lockY, lockZ)
  end)
end

--- Play clipset (forced)
---@param ped integer
---@param anim string
---@param speed number
function Animation.forced:PlayClipset(ped, anim, speed)
  Stream:RequestAnimSet(anim, function()
    SetPedMovementClipset(ped, anim, speed)
  end)
end

--- ClearTasks (forced)
---@param ped integer
function Animation.forced:ClearTasks(ped)
  ClearPedTasks(ped)
end

--- Reset Movement
---@param ped integer
function Animation.forced:ResetMovement(ped)
  ResetPedMovementClipset(ped, 0)
end
