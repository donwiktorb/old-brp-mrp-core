Handling = class()

function Handling:RegisterCall(name, cb)
    Handling[name] = cb
end

function Handling:RemoveCall(name)
    Handling[name] = nil
end

function Handling:CallName(name, ...)
    Handling[name](...)
    Handling[name] = nil
end

function Handling:Call(cb, ...)
    local rsc = GetInvokingResource() or GetCurrentResourceName()

    local status, res = xpcall(cb, function(err)
        Log:Error(string.format("Error loading code resource %s path %s error \n%s", rsc, pth, err))
    end, ...)

    if status then
        return res
    else
        Log:Error(string.format("Error calling code %s path %s status %s result \n%s", rsc, pth, status, res))
    end

end