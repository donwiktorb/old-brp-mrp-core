Database = class()
Database.Async = {}
Database.Sync = {}
Database.cached = {}

if not Config.Database.UseCache then
    function Database.Sync:Execute(q, p)
        local res = 0
        local finishedQuery = false

        exports[GetCurrentResourceName()]:mysql_execute(q, p, function (result)
            res = result
            finishedQuery = true
        end)

        repeat
            Citizen.Wait(0)
        until finishedQuery == true
        return res
    end

    function Database.Sync:fetch(q, p)
        local res = {}
        local finishedQuery = false

        exports[GetCurrentResourceName()]:mysql_fetch(q, p, function (result)
            res = result
            finishedQuery = true
        end)

        repeat
            Citizen.Wait(0)
        until finishedQuery == true

        return res
    end

    function Database.Sync:fetchAll(q, p)
        local res = {}
        local finishedQuery = false

        exports[GetCurrentResourceName()]:mysql_fetch_all(q, p, function (result)
            res = result
            finishedQuery = true
        end)

        repeat
            Citizen.Wait(0)
        until finishedQuery == true

        return res
    end

    function Database.Sync:fetchScalar(q, p)
        local res = {}
        local finishedQuery = false

        exports[GetCurrentResourceName()]:mysql_fetch_scalar(q, p, function (result)
            res = result
            finishedQuery = true
        end)

        repeat
            Citizen.Wait(0)
        until finishedQuery == true
        return res
    end

    function Database.Sync:Insert(q, p)
        local res = 0
        local finishedQuery = false

        exports[GetCurrentResourceName()]:mysql_insert(q, p, function (result)
            res = result
            finishedQuery = true
        end)

        repeat
            Citizen.Wait(0)
        until finishedQuery == true
        return res
    end

    function Database.Sync:Transaction(q, p)
        local res = 0
        local finishedQuery = false

        exports[GetCurrentResourceName()]:mysql_transaction(q, p, function (result)
            res = result
            finishedQuery = true
        end)

        repeat
            Citizen.Wait(0)
        until finishedQuery == true
        return res
    end

    function Database.Async:fetch(q, p, func)
        exports[GetCurrentResourceName()]:mysql_fetch(q, p, func)
    end

    function Database.Async:fetchAll(q, p, func)
        exports[GetCurrentResourceName()]:mysql_fetch_all(q, p, func)
    end

    function Database.Async:fetchScalar(q, p, func)
        exports[GetCurrentResourceName()]:mysql_fetch_scalar(q, p, func)
    end

    function Database.Async:Insert(q, p, func)
        exports[GetCurrentResourceName()]:mysql_insert(q, p, func)
    end

    function Database.Async:Execute(q, p, func)
        exports[GetCurrentResourceName()]:mysql_execute(q, p, func)
    end

    function Database.Async:Transaction(q, p, func)
        return exports[GetCurrentResourceName()]:mysql_transaction(q, p, func)
    end

    function Database:isReady()
        return exports[GetCurrentResourceName()]:is_ready()
    end

    function Database:onReady(cb)
        Thread:Create(function ()
            while GetResourceState(GetCurrentResourceName()) ~= "started" do
                Citizen.Wait(0)
            end

            while not exports[GetCurrentResourceName()]:is_ready() do
                Citizen.Wait(0)
            end

            return Handling:Call(cb, self)
        end)
    end
else
    function Database.Sync:Execute(q, p)
        local res = 0
        return res
    end

    function Database.Sync:fetch(q, p)
        local res = {}

        return res
    end

    function Database.Sync:fetchAll(q, p)
        local res = {}
        local finishedQuery = false
        return res
    end

    function Database.Sync:fetchScalar(q, p)
        local res = ""
        local finishedQuery = false
        return res
    end

    function Database.Sync:Insert(q, p)
        local res = 0
        return res
    end

    function Database.Async:fetch(q, p, func)
        func({})
    end

    function Database.Async:fetchAll(q, p, func)
        -- exports[GetCurrentResourceName()]:mysql_fetch_all(q, p, func)
        func({})
    end

    function Database.Async:fetchScalar(q, p, func)
        -- exports[GetCurrentResourceName()]:mysql_fetch_scalar(q, p, func)
        local res = self.cached[q] or {}
        func(res)
    end

    function Database.Async:Insert(q, p, func)
        -- exports[GetCurrentResourceName()]:mysql_insert(q, p, func)
        func(0)
    end

    function Database.Async:Execute(q, p, func)
        -- exports[GetCurrentResourceName()]:mysql_execute(q, p, func)
        func({})
    end

    function Database:isReady()
        return true
    end

    --function Database:onReady(cb)
    --    Thread:Create(function ()
    --        while GetResourceState(GetCurrentResourceName()) ~= 'started' do
    --            Citizen.Wait(0)
    --        end
    --
    --        return Handling:Call(cb, self)
    --    end)
    --end
end

Mysql = Database
