Scaleform = class()
Scaleform.Forms = {}
function Scaleform:Request(name, cb)
    local scaleform = RequestScaleformMovie(name)
    local timeout = 10
    while not HasScaleformMovieLoaded(scaleform) and timeout > 0 do
        Citizen.Wait(1000)
        timeout = timeout - 1
        print("scale wait")
    end

    if cb then
        cb()
    else
        return scaleform
    end
end

function Scaleform:Bool(sc, name, value)
    BeginScaleformMovieMethod(sc, name)
    ScaleformMovieMethodAddParamBool(value)
    EndScaleformMovieMethod()
end

function Scaleform:Int(sc, name, value)
    BeginScaleformMovieMethod(sc, name)
    ScaleformMovieMethodAddParamInt(value)
    EndScaleformMovieMethod()
end

function Scaleform:Float(sc, name, value)
    BeginScaleformMovieMethod(sc, name)
    ScaleformMovieMethodAddParamFloat(value)
    EndScaleformMovieMethod()
end

function Scaleform:String(sc, name, value)
    BeginScaleformMovieMethod(sc, name)
    ScaleformMovieMethodAddParamTextureNameString(value)
    EndScaleformMovieMethod()
end

function Scaleform:GetAll()
    return Scaleform.Forms   
end

function Scaleform:Remove(name)
    for k,v in pairs(Scaleform.Forms) do
        if v.name == name then
            SetScaleformMovieAsNoLongerNeeded(v.scaleform)
            Scaleform['Forms'][k]=nil           
        end
    end
end

function Scaleform:Add(name, scaleform, fullscreen)
    table.insert(Scaleform.Forms, {
        name = name,
        scaleform = scaleform,
        fullscreen = true
    })
end