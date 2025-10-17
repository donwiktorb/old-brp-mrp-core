function User:SetSkill(name, value)
    if not self.char.data.skills then
        self.char.data.skills = {}
    end
    self.char.data.skills[name] = value
end

function User:UpdateSkill(name, value)
    if not self.char.data.skills then
        self.char.skills = {}
    end
    if not self.char.data.skills[name] then
        self.char.data.skills[name] = 0
    end
    self.char.data.skills[name] = self.char.data.skills[name] + value
    self:SetCharData('skills', self.char.data.skills)
    self:SyncChar('data')
end