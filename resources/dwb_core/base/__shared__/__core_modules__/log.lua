local _print = print
Log = class()
Log.Errors = ""

function Log:Info(msg, ...)
  local type = not client and "Server" or "Client"
  local dbg = debug.getinfo(2)
  local line = dbg.currentline
  local source = dbg.source
  _print(
    "^6[dwb] -> ("
      .. tostring(type)
      .. ":INFO) -> ^5["
      .. tostring(source)
      .. ":"
      .. line
      .. "] -> ^6"
      .. tostring(msg)
      .. "^2",
    ...
  )
end

function Log:Debug(msg, ...)
  local type = not client and "Server" or "Client"
  local dbg = debug.getinfo(2, "Sl")
  local line = dbg.currentline
  local source = dbg.source
  _print(
    "^2[dwb] -> (" .. type .. ":DEBUG) -> ^5[" .. source .. ":" .. line .. "] -> ^8" .. msg .. "^2",
    ...
  )
end

function Log:Print(msg, ...)
  local type = not client and "Server" or "Client"

  local dbg = debug.getinfo(3, "Sl")
  local line = dbg.currentline
  local source = dbg.source
  _print("^4[dwb] -> (" .. type .. ":WARN) -> [" .. source .. ":" .. line .. "] -> " .. msg, ...)
end

function Log:Warn(msg, ...)
  local type = not client and "Server" or "Client"

  local dbg = debug.getinfo(2, "Sl")
  local line = dbg.currentline
  local source = dbg.source
  _print("^4[dwb] -> (" .. type .. ":WARN) -> [" .. source .. ":" .. line .. "] -> " .. msg, ...)
end

function Log:Error(msg, ...)
  local type = not client and "Server" or "Client"

  -- if not self.errorLevel then
  --     self.errorLevel = 1
  -- end

  local dbg = debug.getinfo(2, "Sl")

  -- if not dbg or self.errorLevel > 5 then
  --     self.errorLevel = nil
  --     return
  -- end

  local line = dbg.currentline
  local source = dbg.source
  _print(
    "^4[dwb] -> (" .. type .. ":ERROR) -> [" .. source .. ":" .. line .. "] -> " .. msg,
    "^0",
    ...
  )

  if IsDuplicityVersion() then
    local args = { ... }
    local msg5 = "[dwb] -> (" .. type .. ":ERROR) -> [" .. source .. ":" .. line .. "] -> " .. msg
    for k, v in pairs(args) do
      msg5 = msg5 .. " " .. v
    end

    self.Errors = self.Errors .. "\n" .. msg5

    SaveResourceFile(GetCurrentResourceName(), "error_log" .. ".txt", self.Errors, -1)
    -- else
    --     local msg = '[dwb] -> ('..type..':ERROR) -> ['..source..':'..line..'] -> '..msg..string.format('%s', ...)
    --     self.Errors = self.Errors..'\n'..msg
  end

  -- self.errorLevel = self.errorLevel + 1

  -- Log:Error(msg, ...)
end

print = function(...)
  Log:Print("prin", ...)
end
