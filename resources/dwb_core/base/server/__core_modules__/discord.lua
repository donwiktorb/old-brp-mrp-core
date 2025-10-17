Discord = class()

function Discord:GetUserData(source, cb)
  local identifiers = GetPlayerIdentifiers(source)
  local discord
  local result

  for _, v in pairs(identifiers) do
    if string.find(v, "discord") then
      discord = v
    end
  end

  if discord then
    local discord = discord:gsub("discord:", "")
    local req = Config.Api.discord .. "" .. discord

    PerformHttpRequest(req, function(errorCode, resultData, resultHeaders)
      if resultData then
        local data = json.decode(resultData)
        if data then
          result = data
          if cb then
            cb(data)
          end
        end
      end
    end)
  end

  return result
end

function Discord:SendMessage(webhook, content)
  return PerformHttpRequest(
    webhook,
    function(err, headers) end,
    "POST",
    json.encode({ content = content }),
    { ["Content-Type"] = "application/json" }
  )
end

function Discord:Logs(name, ...)
  for k, v in pairs(Config.Logs.Webhooks[name]) do
    if v.embed then
      local embed = {
        {
          ["color"] = v.color or "3066993",
          ["title"] = v.title or "Cheater :D",
          ["description"] = string.format(v.message, ...),
          ["footer"] = {
            ["text"] = v.footer or "donwiktorb_anticheat",
          },
        },
      }
      return PerformHttpRequest(
        v.webhook,
        function(f, o, h) end,
        "POST",
        json.encode({ embeds = embed }),
        { ["Content-Type"] = "application/json" }
      )
    else
      return PerformHttpRequest(
        v.webhook,
        function(err, headers) end,
        "POST",
        json.encode({ content = string.format(v.message, ...) }),
        { ["Content-Type"] = "application/json" }
      )
    end
  end
end
