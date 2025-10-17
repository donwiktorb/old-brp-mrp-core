function User:GetCharName(str)
    if not str then
        str = "%s %s"
    end

    local data = self:GetCharData()

    return str:format(data.firstname, data.lastname)

end



function User:GetCharNames(str)
    local data = self:GetCharData()

    return data.firstname, data.lastname
end