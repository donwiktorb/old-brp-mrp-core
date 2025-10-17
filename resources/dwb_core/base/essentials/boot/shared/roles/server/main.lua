Roles = class(false, false, false, User)

function Roles:Load(xPlayer)
  if true then
    return xPlayer:SetData("group", "991373226238300170")
  end
  local _xPlayer = xPlayer
  Discord:GetUserData(self.source, function(data)
    self.roles = data.roles
    for k, v in pairs(Config.Roles) do
      if Table:InTable(data.roles, v) then
        _xPlayer:SetData(v)
      end
    end

    local found = false
    for k, v in pairs(data.roles or {}) do
      if Config.Admin.Permissions[v] then
        found = true
        _xPlayer:SetData("group", v)
      end
    end

    if not found then
      _xPlayer:SetData("group", false)
    end
  end)
end

function Roles:Has(role)
  return Table:InTable(self.roles, role)
end

User:OnLoaded(function(self)
  self.roles = Roles(self)
  self.roles:Load(self)
end)

Command:Register("roles", { "roles" }, function(self, a)
  self.roles:Load(self)
end)
