Timer = class()
Timer.timers = {}
Timer.oneCb = nil
Timer.oneTimeout = nil

function Timer:CreateOne(cb, exitCb, timeout)
    Timer.oneCb = cb
    if timeout then
        Timer.oneTimeout = timeout * 1000
    end
 
    while Timer.oneTimeout > 0 do
        Wait(0)
        local res = Timer.oneCb()
        Timer.oneTimeout = self.oneTimeout - 1
        if res then
            Timer.oneTimeout = 0
        end
    end

    Timer.oneTiemout = nil
    Timer.oneCb = nil

    if exitCb then exitCb() end
end

function Timer:Create(cb, exitCb, timeout)
    local timeout = timeout * 1000
 
    while timeout > 0 do
        Wait(0)
        local res = cb()
        timeout = timeout - 1
        if res then
            timeout = 0
        end
    end

    if exitCb then exitCb() end

end

function Timer:Set(func, time, ...)
    table.insert(Timer.timers, {
        fn = func,
        args = {...},
        time = time
    })
    local id = #Timer.timers

    function cb()
        local id = id
        local timer = Timer.timers[id]
        timer.fn(table.unpack(timer.args))
        SetTimeout(timer.time, timer.cb)
    end

    Timer.timers[id].cb = cb 
    SetTimeout(Timer.timers[id].time, self.timers[id].cb, id)
end