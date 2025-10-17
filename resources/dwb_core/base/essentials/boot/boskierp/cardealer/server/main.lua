local vehData = {}

-- Event:Register('dwb:save:vehicles', function(source, xPlayer,models)
--     local noVehicles = {}
--     local tasks = {}

--     for k,v in pairs(models) do
--         table.insert(tasks, function(cb)
--             Database.Async:fetchAll('SELECT * FROM owned_vehicles2 WHERE model = ?', {
--                 v.model
--             }, function(res)
--                 if #res == 1 then
--                     table.insert(noVehicles, v)
--                 end
--                 cb()
--             end)
--         end)
--     end

--     Async:parallelLimit(tasks, 10, function()
--         print("DONE")
--         local str = ''
--         for k,v in pairs(noVehicles) do
--             str = str..'\n'..v.modelName
--             print(v.model, v.modelName)
--         end

--         SaveResourceFile(GetCurrentResourceName(), 'vehicles.json', str, #str)
--     end)
-- end ,true)

Mysql:onReady(function(self)
  local migrate = false

  if migrate then
    Wait(10000)

    Database.Async:fetchAll("SELECT * FROM users", {}, function(res)
      local tasks = {}
      local tasks2 = {}
      local users = res
      local userCount = #users
      local currentCount = 0
      local lastUserTime = os.time()
      local insert = {
        bank = {},
        property = {},
        vehicles = {},
      }

      RegisterCommand("time", function()
        local averageTimePerUser = (os.time() - lastUserTime) / currentCount
        local estimatedTime = averageTimePerUser * (userCount - currentCount)
        local hours = math.floor(estimatedTime / 3600)
        local minutes = math.floor((estimatedTime % 3600) / 60)
        local seconds = math.floor(estimatedTime % 60)

        local avgHours = math.floor(averageTimePerUser / 3600)
        local avgMinutes = math.floor((averageTimePerUser % 3600) / 60)
        local avgSeconds = math.floor(averageTimePerUser % 60)
        print(
          string.format("Estimated time for completion: %02d:%02d:%02d", hours, minutes, seconds),
          currentCount,
          "/",
          userCount
        )
        print(
          string.format("Average Time Per User: %02d:%02d:%02d", avgHours, avgMinutes, avgSeconds)
        )
      end)

      for k, v in pairs(users) do
        table.insert(tasks or tasks2, function(cb)
          local inventory = json.decode(v.inventory) and json.decode(v.inventory) or {}
          local loadout = json.decode(v.loadout) and json.decode(v.loadout) or {}

          for k2, v2 in pairs(loadout) do
            v2.data = {}
            v2.data.ammo = v2.ammo or 200
            v2.data.components = v2.components or {}
          end

          local money = v.money or 5000000

          table.insert(inventory, {
            name = "cash",
            count = money,
          })

          local charData = {
            data = {
              firstname = v.firstname,
              lastname = v.lastname,
              dob = v.dateofbirth,
              height = v.height,
            },
            skin = v.skin or json.encode({}),
            jobs = {
              {
                job = v.job,
                grade = v.job_grade,
              },
            },
            inventory = inventory,
            position = v.position or json.encode({}),
          }
          Database.Async:Insert(
            "INSERT INTO characters_new (id, data, skin, jobs, inventory, position) VALUES (?)",
            {
              {
                0,
                json.encode(charData.data or {}),
                charData.skin,
                json.encode(charData.jobs or {}),
                json.encode(charData.inventory or {}),
                charData.position,
              },
            },
            function(insertId)
              local charId = insertId
              currentCount = currentCount + 1
              -- local averageTimePerUser = (os.time() - lastUserTime) / currentCount
              -- local estimatedTime = averageTimePerUser * (userCount - currentCount)
              -- local hours = math.floor(estimatedTime / 3600)
              -- local minutes = math.floor((estimatedTime % 3600) / 60)
              -- local seconds = math.floor(estimatedTime % 60)

              -- local avgHours = math.floor(averageTimePerUser / 3600)
              -- local avgMinutes = math.floor((averageTimePerUser % 3600) / 60)
              -- local avgSeconds = math.floor(averageTimePerUser % 60)
              print(currentCount, "/", userCount)
              -- print(string.format("Estimated time for completion: %02d:%02d:%02d", hours, minutes, seconds), currentCount, "/", userCount)
              -- print(string.format("Average Time Per User: %02d:%02d:%02d", avgHours, avgMinutes, avgSeconds))

              lastUserTime = os.time()
              table.insert(insert.bank, { 0, insertId, v.bank })
              -- Database.Async:Insert('INSERT INTO bank_accounts_new (id, bankId, balance) VALUES (?)', {
              --     {

              --         0,
              --         insertId,
              --         v.bank
              --     }
              -- })
              local userData = {
                name = v.name or "NOT_FOUND",
                identifier = v.identifier or "NOT_FOUND",
                identifiers = { v.license },
                data = {
                  chars = {},
                },
              }
              table.insert(userData.data.chars, {
                id = insertId,
                firstname = charData.data.firstname,
                lastname = charData.data.lastname,
              })
              userData.data.char = insertId
              Database.Async:Insert(
                "INSERT INTO users_new (id, name, identifier, identifiers, data) VALUES (?)",
                {
                  {

                    0,
                    userData.name,
                    userData.identifier,
                    json.encode(userData.identifiers),
                    json.encode(userData.data),
                  },
                },
                function(userId)
                  Database.Async:fetchAll("SELECT * FROM datastore_data WHERE owner = ?", {
                    v.identifier,
                  }, function(res)
                    if res then
                      local clothes = json.decode(res.dressing) and json.decode(res.dressing) or {}
                      local items = {}
                      local weapons = json.decode(res.weapons) and json.decode(res.weapons) or {}

                      for k, v in pairs(weapons or {}) do
                        v.data = {}
                        v.data.ammo = v.ammo or 455
                        table.insert(items, v)
                      end

                      local moreItems = self.Sync:fetchAll(
                        "SELECT * FROM addon_inventory_items WHERE owner = ?",
                        { v.identifier }
                      )

                      for k5, v5 in pairs(moreItems or {}) do
                        table.insert(items, {
                          name = v5.name,
                          count = v5.count,
                        })
                      end

                      local blackMoney = self.Sync:fetch(
                        "SELECT * FROM addon_account_data WHERE owner = ?",
                        { v.identifier }
                      )

                      if blackMoney then
                        table.insert(items, {
                          name = "black_money",
                          count = blackMoney.money or 50000,
                        })
                      end

                      table.insert(
                        insert.property,
                        {
                          0,
                          charId,
                          json.encode({}),
                          "HillcrestAvenue2874",
                          "property",
                          json.encode(items),
                          json.encode(clothes),
                        }
                      )

                      -- Database.Async:Insert('INSERT INTO owned_properties_new (id, owner, owners, name, type, items, clothes) VALUES (?)', {
                      --     {

                      --         0,
                      --         charId,
                      --         json.encode({}),
                      --         'HillcrestAvenue2874',
                      --         'property',
                      --         json.encode(items),
                      --         json.encode(clothes)
                      --     }
                      -- })
                    end
                  end)

                  Database.Async:fetchAll("SELECT * FROM owned_vehicles WHERE owner = ?", {
                    v.identifier,
                  }, function(res)
                    if res then
                      for k5, v5 in pairs(res or {}) do
                        table.insert(insert.vehicles, { 0, charId, 1, v5.vehicle })
                        -- Database.Async:Insert('INSERT INTO owned_vehicles_new (id, owner, state, vehicle) VALUES (?)', {
                        --     {

                        --         0,
                        --         charId,
                        --         1,
                        --         v5.vehicle
                        --     }
                        -- })
                      end
                    end
                  end)

                  if cb then
                    cb()
                  end
                end
              )
            end
          )
        end)
      end

      Async:parallelLimit(tasks, 1000, function()
        -- Wait(5000)
        -- Async:parallelLimit(tasks2, #tasks2, function()
        Database.Async:Insert(
          "INSERT INTO owned_vehicles_new (id, owner, state, vehicle) VALUES ?",
          {
            {
              table.unpack(insert.vehicles),
            },
          }
        )

        Database.Async:Insert(
          "INSERT INTO owned_properties_new (id, owner, owners, name, type, items, clothes) VALUES ?",
          {
            {
              table.unpack(insert.property),
            },
          }
        )

        Database.Async:Insert("INSERT INTO bank_accounts_new (id, bankId, balance) VALUES (?)", {
          {

            table.unpack(insert.bank),
          },
        })
        print("DONE")
        -- end)
      end)
      -- local cb = function() end

      -- for k,v in pairs(tasks) do
      --     Thread:Create(function()
      --         v(function()

      --     end)
      --     end)
      -- end

      print("DONE")
    end)
  end

  local data = {}
  local vehCat = self.Sync:fetchAll("SELECT * FROM vehicle_categories")
  for k, v in pairs(vehCat) do
    data[v.name] = {
      label = v.label,
      name = v.name,
      elements = {},
    }
  end

  local vehicles = self.Sync:fetchAll("SELECT * FROM vehicles ORDER BY price")
  local count = 0
  for k, v in pairs(vehicles) do
    count = count + 1
    if data[v.category] then
      if v.hidden ~= 1 then
        if v.discount then
          table.insert(data[v.category].elements, {
            label = v.name,
            value = v.model,
            discount = v.discount,
            new = v.new == 1 and true or false,
            price = v.price,
            img = v.img,
            -- category = v.category,
            -- index = index
          })
        elseif v.new then
          table.insert(data[v.category].elements, {
            label = v.name,
            value = v.model,
            discount = v.discount,
            new = v.new == 1 and true or false,
            price = v.price,
            img = v.img,
            -- category = v.category,
            -- index = index
          })
        else
          table.insert(data[v.category].elements, {
            label = v.name,
            value = v.model,
            price = v.price,
            img = v.img,
            -- category = v.category,
            -- index = index
          })
        end
      end
    else
      Log:Warn("Category", v.category, "doesnt exist")
    end
  end

  local elements = {}

  for k, v in pairs(data) do
    table.insert(elements, v)
  end

  vehData = elements

  -- Event:Trigger('dwb:cursor:add:data', 'car-dealer', 'elements', {})
end)

User:OnCustomEvent("vehicleshop", function(self, zoneData, posData)
  local source = self.source
  local bucket = GetPlayerRoutingBucket(source)
  SetPlayerRoutingBucket(source, source)
  SetRoutingBucketPopulationEnabled(source, true)
  SetRoutingBucketEntityLockdownMode(source, "inactive")
  Event:TriggerNet("dwb:cardealer:open", source, posData.data or zoneData.data, false, bucket)
end)

Event:Register("dwb:cursor:submit", function(source, xPlayer, action, entityId, data, entData)
  if action.name == "car-dealer" and data.current.value == "open" then
    local bucket = GetPlayerRoutingBucket(source)
    SetPlayerRoutingBucket(source, source)
    SetRoutingBucketPopulationEnabled(source, true)
    SetRoutingBucketEntityLockdownMode(source, "inactive")
    Event:TriggerNet("dwb:cardealer:open", source, entData, entData.elements, bucket)
  end
end, true)

Event:Register("dwb:cardealer:exit", function(source, xPlayer, bucket)
  SetPlayerRoutingBucket(source, bucket)
end, true)

Event:Register(
  "dwb:cardealer:buy",
  function(source, xPlayer, netId, properties, entData, price, bucket)
    xPlayer.inventory:RemoveItem("cash", "name", price)
    SetPlayerRoutingBucket(source, bucket)
    local entity = NetworkGetEntityFromNetworkId(netId)
    SetEntityRoutingBucket(entity, bucket)
    SetEntityCoords(entity, entData.pos)
    SetEntityHeading(entity, entData.heading)
    -- -- -- TaskEnterVehicle(GetPlayerPed(source), entity, 15000, -1, 1.0, 1, 0)
    TaskWarpPedIntoVehicle(GetPlayerPed(source), entity, -1)
    -- TaskEnterVehicle(GetPlayerPed(source) --[[ Ped ]], entity --[[ Vehicle ]], 15000 --[[ integer ]], -1 --[[ integer ]],2.0 --[[ number ]], 1 --[[ integer ]],0 --[[ Any ]])

    FreezeEntityPosition(entity, false)
    xPlayer.garage:AddVehicle({
      state = true,
      vehicle = properties,
    }, entity)
    -- Event:Trigger('dwb:garage:add:vehicle', source, entity, properties)
  end,
  true
)

User:OnLoadedChar(function(self)
  -- while #vehData <=0 do
  --     Log:Info('waiting for veh data')
  --     Wait(0)
  -- end
  Event:TriggerNet("dwb:cardealer:store", self.source, vehData)
end)

Event:RegisterCb("dwb:cardealer:enough", function(source, cb, data)
  local xPlayer = DWB.Players[source]
  local item = xPlayer.inventory:GetItem("cash", "name")
  local hasLicense = true
  if data.license then
    hasLicense = xPlayer:HasLicense(data.license)
  end
  cb(item and item.count >= tonumber(data.price), hasLicense)
end)

-- -- Event:Register('dwb:cardealer:save', function(source, xPlayer,veh)
-- --     Mysql.Async:Execute('INSERT INTO vehicles SET ?', veh, function()
-- --         print('x d')
-- --     end)
-- -- end, true)

