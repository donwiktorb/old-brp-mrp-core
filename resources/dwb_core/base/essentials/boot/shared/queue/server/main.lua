local waiting = {}
local connecting = {}
local points = {}
local maxPlayers = GetConvarInt("sv_maxclients", 128)
for k, v in pairs(Config.Queue.points) do
  points[v[1]] = v[2]
end

function getRandomEmojis()
  local emojis = {}
  for i = 1, 3 do
    table.insert(emojis, Config.Queue.emojis[math.random(#Config.Queue.emojis)])
  end
  return emojis
end

function AddConnecting(src)
  table.insert(connecting, {
    source = src,
  })
end

function RemoveConnecting(src)
  for k, v in pairs(connecting) do
    if v.source == src then
      table.remove(connecting, k)
    end
  end
end

function GetWaiting(source)
  for k, v in pairs(waiting) do
    if v.source == source then
      if DoesPlayerExist(v) then
        return v
      else
        table.remove(waiting, k)
        return false
      end
    end
  end
end

function AddWaiting(source, identifier)
  local userPoints = points[identifier]
  if not userPoints then
    userPoints = 0
  end
  local place = 1
  for k, v in pairs(waiting) do
    if v.points > userPoints then
      place = place + 1
    end
    if v.source == source then
      table.remove(waiting, k)
    end
  end

  table.insert(waiting, place, {
    source = source,
    identifier = identifier,
    points = userPoints,
  })
  return place, waiting[place]
end

function GetPlace(src)
  for k, v in pairs(waiting) do
    if v.source == src then
      return k
    end
  end
end

function RemoveWaiting(src)
  for k, v in pairs(waiting) do
    if v.source == src then
      table.remove(waiting, k)
    end
  end
end

function onQueueJoin(source, name, kick, def)
  local _source = source
  local identifiers = GetPlayerIdentifiers(_source)
  local identifier = identifiers[1]
  def.defer()

  Wait(0)

  --for _, v in pairs(identifiers) do
  --	if string.find(v, "steam") then
  --		identifier = v
  --		break
  --	end
  --end

  --

  --Wait(0)

  if not identifier then
    print(identifier)
    return def.done("Nie masz włączonego steama lub wystąpił jakiś błąd")
  end

  local card = json.decode(Config.Queue.Card)

  card.body[2].items[1].text = "Hej " .. name
  local timer = 5
  local connected = false

  repeat
    timer = timer - 1

    local text = string.format("Łączenie z kolejką %s", timer)

    card.body[3].text = text

    def.presentCard(json.encode(card))
    Wait(1000)
  until not DoesPlayerExist(_source) or timer <= 0

  Wait(0)

  local place, user = AddWaiting(_source, identifier)

  Wait(0)

  repeat
    place = GetPlace(_source)

    if not place then
      return def.done("Zostałeś wyrzucony z kolejki lub wystąpił błąd")
    end

    user.points = user.points + 1
    local userPoints = user.points

    if place == 1 then
      local players = #GetPlayers() + #connecting

      if players < maxPlayers then
        connected = true
        def.done()
      end
    end

    local emojis = getRandomEmojis()

    local text = string.format(
      "Jesteś %s/%s w kolejce (+ %s) (%s %s %s) \n Jeżeli emotki się zatrzymają, zrestartuj kolejkę \n Przejechałeś %s km \n Ogłoszenie: %s \n Discord: %s \n Informacja: %s",
      place,
      #waiting,
      #connecting,
      emojis[1],
      emojis[2],
      emojis[3],
      userPoints,
      Config.Queue.announcement,
      Config.Queue.discord,
      "Brak"
    )

    card.body[3].text = text

    def.presentCard(json.encode(card))
    Wait(5000)
  until not DoesPlayerExist(_source) or connected

  RemoveWaiting(_source)
end

Event:Register("dwb:player:connecting", onQueueJoin)

Event:Register("dwb:player:joining", function(source, oldsource)
  AddConnecting(source)
end)

Event:Register("dwb:player:joined", function(source, xPlayer)
  RemoveConnecting(source)
end, true)

Event:Register("dwb:player:dropped", function(source, xPlayer, reason)
  RemoveWaiting(source)
  RemoveConnecting(source)
end)
