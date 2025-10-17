Skills = class()

function Skills:Update(name, value)
    Event:TriggerNet('dwb:skills:update', name, value)
end

function Skills:OpenClick(cbhit, cbnothit, cb)
    UI:Open('Skills', {
        name= 'skills',
        docType= 'fastClick',
        show=true,
        tries = 4,
        middleRot = math.random(-180, 180),
        offset = math.random(0,10),
        defaultTries = math.random(1,5),
        defaultTimer = math.random(1,40),
        timer = 250
    }, function(data,menu)
        if data.current.type == 'hit' then
            cbhit(data, menu)
        else
            cbnothit(data,menu)
        end
    end, function(data,menu)
        cb(data,menu)
    end)
end

function Skills:OpenBar(name, msg, time, cb)
    UI:Open('Bar', {
        name = name,
        time = time,
        show = true,
        task = msg
    }, function(data,menu)
        cb(data, menu)
        menu.close()
    end)
end