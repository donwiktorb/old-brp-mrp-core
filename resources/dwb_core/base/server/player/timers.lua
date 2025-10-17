function SavePlayers(all, cb2, cb4)
    Core:SavePlayers(all, cb2, cb4)
end

Timer:Set(SavePlayers, 10*60*1000, false)

function SyncPlayers()
    Core:SyncPlayers()
end

Timer:Set(SyncPlayers, 60000)