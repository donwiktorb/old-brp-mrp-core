
client, server = not IsDuplicityVersion(), not client

local function Module()
    local self = {}

    self.cached = {}

    self.types = {
        ['client'] = client,
        ['server'] = server,
        ['shared'] = true
    }

    function self:LoadFile(rsc, pth)
        local code = LoadResourceFile(rsc, pth)
        if code then
            local cb, e = load(code, rsc..' '..pth, 't')
            if cb then
                local status, res = xpcall(cb, function(err)
                    print(string.format("Error loading code resource %s path %s error %s", rsc, pth, err))
                end)
                if status then
                    self.cached[rsc.."/"..pth] = res
                    return res
                else
                    print(string.format("Error calling code %s path %s status %s result %s", rsc, pth, status, res))
                end
            else
                print(string.format("Error loading chunk resource %s path %s error %s", rsc, pth, e))
            end
        else
            print(string.format("Error loading file resource %s path %s", rsc, pth))
        end
    end
    
    function self:LoadModule(type, rsc, pth)
        if not self.cached[type.."//"..rsc.."/"..pth] then
            if self.types[type] then
                local pth = pth
                if string.find(pth, '.lua', 1, true) == nil then
                    pth = pth .. '.lua'
                end
                return self:LoadFile(rsc, pth)
            elseif self.types[type] == nil then
                print(string.format("Error type %s not found in resource %s path %s", type, rsc, pth))
            end
        else
            return self.cached[type.."//"..rsc.."/"..pth]
        end
    end

    return self
end

local M = Module()

function use(type, rsc, pth)
    Log:Error("USING OLD USE", type, rsc, pth, "d")
    return M:LoadModule(type, rsc, pth)
end