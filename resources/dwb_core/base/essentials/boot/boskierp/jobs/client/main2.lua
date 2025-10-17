


Event:Register('dwb:jobs:menu', function(jobs, pJobs)
   UI:Open('Menu', {
        name = 'jobs',
        title = 'Centrum Roboty',
        elements = {
            {
                label = "Zatrudnij się",
                value = 'employ'
            },
            {

                label = "Zwolnij się",
                value = 'fire'
            }
        }
    }, function(data, menu)
        if data.current.value == 'employ' then
            local jobs2 = {}
            for k,v in pairs(jobs) do
                if v.whitelisted == 0 then
                    table.insert(jobs2, {
                        label = v.label,
                        value = v.name                        
                    })
                end
            end
            UI:Open('Menu', {
                name = 'jobs2',
                title = 'Joby',
                elements = jobs2
            }, function(data, menu2)
                menu2.close()
                Event:TriggerNet('dwb:jobs:chosen', data.current.value)
            end)
        else
            local jobs2 = {}
            for k,v in pairs(pJobs) do
                table.insert(jobs2, {
                    label = string.format("%s %s", v.label, v.grade_label),
                    value = v.name
                })
            end
            
            UI:Open('Menu', {
                name = 'jobs4',
                title = 'Centrum Roboty',
                elements = jobs2
            }, function(data, menu2)
                menu2.close()
                Event:TriggerNet('dwb:jobs:leave', data.current.value)
            end)
        end
    end)
end, true)