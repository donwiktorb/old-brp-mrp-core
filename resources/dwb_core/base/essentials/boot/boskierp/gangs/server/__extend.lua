Group = class()
Group.groups = {}
Group.invites = {}

function Group:GetPlayerGroup(player)
    for k,v in pairs(self.groups) do
        for key,value in pairs(v.players) do
            if value == player then
                return k, key
            end
        end
    end
end

function Group:Create(owner, name)
    if not self.groups[name] and not self:GetPlayerGroup(owner) then
        self.groups[name] = {
            owner = owner,
            players = {
                owner
            },
            name = name
        }
    end
end

function Group:Join(src, group)
    if self.invites[src] == group then
        table.insert(self.groups[group].players, src)
        self.invites[src] = nil
    end
end

function Group:Add(src, source)
    local group = self:GetPlayerGroup(src)
    self.invites[source] = group.name
end

function Group:Remove(src, source)
    local group, playerId = self:GetPlayerGroup(source)
    table.remove(group.players, playerId)
end

function Group:Leave(src, source)
    local group, playerId = self:GetPlayerGroup(src)
    if group then
        if group.owner == src then
            for k,v in pairs(group.players) do
                self:Leave(v)
            end
            self.groups[group.name] = nil
        else
            table.remove(group.players, playerId)
        end
    end
end
