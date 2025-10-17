Command = class()

Command.commands = {}

--[[
    Register('car', function(source, args, raw), {'admin', 'superadmin'})
    {name, args -> {name}, help}
]]

function Command:GetAll()
    return Command.commands
end

function Command:Register(name, suggestion, cb, groups)
    if Command.commands[name] then return print('Command', name, 'already registered.') end
    RegisterCommand(name, function(source, args, raw) 
        if Config.Commands.DontCheckGroup then
            groups = nil
        end
        local xPlayer = DWB.Players[source]
        if not xPlayer then 
            return cb(xPlayer, args, raw)
        end
        if not groups then
            return cb(xPlayer, args, raw)
        else
            local perm = Config.Admin.Permissions[xPlayer.data.group]
            if perm then
                if perm.commands[name] then
                    return cb(xPlayer, args, raw)
                else
                    xPlayer:SendMessage('alert', false, 'Nie masz permisji dla komendy '..name)
                end
            end
            -- for k,v in pairs(groups) do
            --     if (xPlayer.data.group == v) then
            --         return cb(xPlayer, args, raw)
            --     end
            -- end
        end
    end)
    local help = suggestion[1]
    table.remove(suggestion, 1)
    local args = suggestion
    Command.commands[name] = {
        help = help,
        args = args,
        admin = groups
    }
    Event:TriggerNetAsync('dwb:chat:addSuggestion', -1, name, help, args)
    -- TriggerClientEvent('dwb:chat:addSuggestion', -1, name, help, args)
end
