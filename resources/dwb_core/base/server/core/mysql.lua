MysqlLoaded = false

local function onMysqlReady()
    Core:LoadItems(function()
        Core:LoadJobs(function()
            MysqlLoaded = true
        end)
    end)
end

Mysql:onReady(onMysqlReady)