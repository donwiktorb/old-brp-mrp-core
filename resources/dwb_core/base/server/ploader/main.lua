PluginLoader = class({
  dir = "resources/" .. GetCurrentResourceName() .. "/base/essentials/boot/",
  relativeDir = "base/essentials/boot%s/%s",
  clientScripts = {},
  configs = {
    ["windows"] = {
      char = "\\",
      command = 'dir "%s" /b /O',
      format = "%s\\%s",
    },
    ["linux"] = {
      char = "/",
      command = "LC_ALL=C ls -1 %s",
      format = "%s/%s",
    },
  },
  config = {},

  clientLoaded = false,
})

if not Config.Scripts.LoadScripts then
  return
end

function PluginLoader:HandleError(err, res, file, ...)
  Log:Error("Error loading resource", res, "in file", file, err, ...)
end

function PluginLoader:Encode(source)
  local encoded = source:gsub(".", function(c)
    return string.format("\\x%02X", string.byte(c))
  end)
  return encoded
end

function PluginLoader:InitConfig()
  local handle = io.popen("uname")
  local res = handle:read("*a")
  handle:close()

  if string.find(res, "Linux") then
    self.config = self.configs["linux"]
  else
    self.config = self.configs["windows"]
  end
end

function PluginLoader:LoadServerScripts(dir, fixedDir)
  for file in io.popen(string.format(self.config.command, dir or self.dir)):lines() do
    local path = string.format(self.config.format, dir or self.dir, file)
    local mode = io.open(path, "r")
    local fixedDir = fixedDir or ""
    if mode then
      mode:close()
      if string.sub(file, -4) == ".lua" and string.find(fixedDir, "server") ~= nil then
        local code = LoadResourceFile(
          GetCurrentResourceName(),
          string.format(self.relativeDir, fixedDir, file)
        )

        local sName = string.sub(fixedDir, 2)
        local charPos = string.find(sName, "/")
        sName = string.sub(sName, 1, charPos - 1)

        --code = string.gsub(code, "  ", " ")
        --code = string.gsub(code, "\n", " ")
        --code = string.gsub(code, "\n+", " ")

        local initMe = string.format("local currentResName = '%s' ", sName)

        code = initMe .. code

        local loadedCode = load(code, string.format("%s/%s", fixedDir, file))

        local success, result = xpcall(loadedCode, function(error)
          print(error)
          self:HandleError(error, fixedDir, file, debug.getupvalue(loadedCode, 2))
        end)
      else
        self:LoadServerScripts(path, fixedDir .. "/" .. file)
      end
    else
      self:LoadServerScripts(path, fixedDir .. "/" .. file)
    end
  end
end

function PluginLoader:LoadClientScripts(dir, fixedDir)
  for file in io.popen(string.format(self.config.command, dir or self.dir)):lines() do
    local path = string.format(self.config.format, dir or self.dir, file)
    local mode = io.open(path, "r")
    local fixedDir = fixedDir or ""
    if mode then
      mode:close()
      if string.sub(file, -4) == ".lua" and string.find(fixedDir, "client") ~= nil then
        local code = LoadResourceFile(
          GetCurrentResourceName(),
          string.format(self.relativeDir, fixedDir, file)
        )

        for local_var in code:gmatch("local function%s+([%w_]+)%s*()") do
          local new_string =
            string.gsub(code, "%f[%a]" .. local_var .. "%f[%A]", Math:RandomString(8))
          code = new_string
        end

        local sName = string.sub(fixedDir, 2)
        local charPos = string.find(sName, "/")
        sName = string.sub(sName, 1, charPos - 1)
        code = string.gsub(code, "  ", " ")
        -- code = string.gsub(code, "\n", "")
        -- code = string.gsub(code, "\n+", " ")
        code = "local currentResName = " .. sName .. " " .. code
        code = self:Encode(code)
        local initMe = string.format("local currentResName = '%s' ", sName)
        code = initMe .. code

        local type = string.sub(dir, #(self.dir .. "//"))

        local i, j = string.find(type, self.config.char)
        type = type.sub(type, 0, j - 1)

        table.insert(self.clientScripts, {
          name = file,
          dir = fixedDir,
          code = code,

          type = type,
        })
      else
        self:LoadClientScripts(path, fixedDir .. "/" .. file)
      end
    else
      self:LoadClientScripts(path, fixedDir .. "/" .. file)
    end
  end

  self.clientLoaded = true
end

function PluginLoader:SendClientScripts(xPlayer)
  while not self.clientLoaded do
    Wait(0)
  end

  Event:TriggerNet("dwb:scripts:load", xPlayer.source, self.clientScripts)
end

function PluginLoader:Init()
  self:InitConfig()
  self:LoadServerScripts()
  self:LoadClientScripts()
  Log:Info("Plugins loaded")
end

Thread:Create(function()
  PluginLoader:Init()
end)

User:OnLoaded(function(self)
  PluginLoader:SendClientScripts(self)
end)
