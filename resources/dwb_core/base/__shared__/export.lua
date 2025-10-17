function import(type, rsc, pth)
    return exports[GetCurrentResourceName()]:use(type, rsc, pth)
end
