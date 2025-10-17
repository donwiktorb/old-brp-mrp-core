Env = class()

function Env:getfenv(fn)
    local i = 1
    while true do
        Wait(0)
        local name, val = debug.getupvalue(fn, i)
        if name == "_ENV" then
            return val, i
        elseif not name then
            break
        end
        i = i + 1
    end
end

function Env:setfenv(fn, env)
    local i = 1
    while true do
        Wait(0)
        local name = debug.getupvalue(fn, i)
        if name == "_ENV" then
            debug.upvaluejoin(fn, i, (function()
                return env
            end), 1)
            break
        elseif not name then
            break
        end

        i = i + 1
    end

    return fn
end