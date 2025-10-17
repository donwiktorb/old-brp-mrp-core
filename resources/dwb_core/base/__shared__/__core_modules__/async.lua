Async = class()
Async.Cached = {}

function Async:Await(fn, ...)
    local cb = fn(...)
    while not cb do
        Wait(0)
    end
    return table.unpack(cb)
end

function Async:Promise(fn)
    local function resolve(...)
        return {...}
    end

    local function reject(...)
        return {...}
    end

    return fn(resolve, reject)
end

function Async:next(fn, ...)
    return fn(...)
end

function Async:catch(fn, ...)
    return fn(...)
end

function Async:NewPromise(fn)
    local args = table.pack(func())
    local res = args[1]
    table.remove(args, 1)
    local obj = {}
    obj.catches = {}
    obj.nexts = {}

    function obj:next(fn)
        table.insert(self.nexts, {
            fn = fn
        })
        return obj
    end

    function obj:catch(fn)
        table.insert(self.catches, {
            fn = fn
        })

        return obj
    end

    function obj:run()
        local args2
        for k,v in pairs(self.nexts) do
            args2 = table.pack(Async:catch(v.fn, table.unpack(args2 or args)))
            if args2[1] == false then
                local catch = self.catches[k+1]
                if catch then
                    table.remove(args2, 1)
                    local args4 = table.pack(Async:catch(catch.fn, table.unpack(args2)))
                    return table.unpack(args4)
                else
                    local current = k
                    repeat 
                        catch = self.catches[current]
                        if current <= 0 then
                            return
                        end
                        current=  current - 1
                        Wait(0)
                    until catch

                    
                    table.remove(args2, 1)
                    local args4 = table.pack(Async:catch(catch.fn, table.unpack(args2)))
                    return table.unpack(args4)
                    
                end
            end

            return table.unpack(args2)
        end

    end

    return obj
end

function Async:parallel(tasks, cb)

	if #tasks == 0 then
		cb({})
		return
	end

	local remaining = #tasks
	local results   = {}
    
	for i=1, #tasks, 1 do
		
		Thread:Create(function()
			
			tasks[i](function(result)
				
				table.insert(results, result)
				
				remaining = remaining - 1;

				if remaining == 0 then
					cb(results)
				end

			end)

		end)

	end

end

function Async:parallelLimit(tasks, limit, cb)
	if #tasks == 0 then
		cb({})
		return
	end

	local remaining = #tasks
	local running   = 0
	local queue     = {}
	local results   = {}

	for i=1, #tasks, 1 do
		table.insert(queue, tasks[i])
	end

	local function processQueue()

		if #queue == 0 then
			return
		end

	while running < limit and #queue > 0 do
			
			local task = table.remove(queue, 1)
			
			running = running + 1

			task(function(result)
				
				table.insert(results, result)
				
				remaining = remaining - 1;
				running   = running - 1

				if remaining == 0 then
					cb(results)
				end

			end)

		end

		Thread:Create(processQueue)

	end

	processQueue()

end

function Async:series(tasks, cb)
	Async:parallelLimit(tasks, 1, cb)
end

    -- -- Database.Async:fetchAll('SELECT * FROM users', {}, function(res)
    -- --     local tasks = {}
    -- --     local users = res
    -- --     local userCount = #users
    -- --     local currentCount = 0
    -- --     local lastUserTime = os.time()

    -- --     RegisterCommand('time', function()
    -- --         local averageTimePerUser = (os.time() - lastUserTime) / currentCount
    -- --         local estimatedTime = averageTimePerUser * (userCount - currentCount)                   
    -- --         local hours = math.floor(estimatedTime / 3600)
    -- --         local minutes = math.floor((estimatedTime % 3600) / 60)
    -- --         local seconds = math.floor(estimatedTime % 60)

    -- --         local avgHours = math.floor(averageTimePerUser / 3600)
    -- --         local avgMinutes = math.floor((averageTimePerUser % 3600) / 60)
    -- --         local avgSeconds = math.floor(averageTimePerUser % 60)
    -- --         print(string.format("Estimated time for completion: %02d:%02d:%02d", hours, minutes, seconds), currentCount, "/", userCount)
    -- --         print(string.format("Average Time Per User: %02d:%02d:%02d", avgHours, avgMinutes, avgSeconds))
    -- --     end)

    -- --     for k,v in pairs(users) do
    -- --         table.insert(tasks, function(cb)
    -- --             local inventory = json.decode(v.inventory) and json.decode(v.inventory) or {}
    -- --             local loadout = json.decode(v.loadout) and json.decode(v.loadout) or {}

    -- --             for k2,v2 in pairs(loadout) do
    -- --                 v2.data = {}
    -- --                 v2.data.ammo = v2.ammo or 200
    -- --                 v2.data.components = v2.components or {}
    -- --             end

    -- --             local money = v.money or 5000000

    -- --             table.insert(inventory, {
    -- --                 name = 'cash',
    -- --                 count = money
    -- --             })
                
    -- --             local charData = {
    -- --                 data = {
    -- --                     firstname = v.firstname,
    -- --                     lastname = v.lastname,
    -- --                     dob = v.dateofbirth,
    -- --                     height = v.height
    -- --                 },
    -- --                 skin = v.skin or json.encode({}),
    -- --                 jobs = {
    -- --                     {
    -- --                         job = v.job,
    -- --                         grade = v.job_grade
    -- --                     }
    -- --                 },
    -- --                 inventory = inventory,
    -- --                 position = v.position or json.encode({})
    -- --             }
    -- --             Database.Async:Insert('INSERT INTO characters_new (id, data, skin, jobs, inventory, position) VALUES (?)', {
    -- --                 {
    -- --                     0,
    -- --                     json.encode(charData.data or {}),
    -- --                     charData.skin,
    -- --                     json.encode(charData.jobs or {}),
    -- --                     json.encode(charData.inventory or {}),
    -- --                     charData.position
    -- --                 }
    -- --             }, function(insertId)
    -- --                 local charId = insertId
    -- --                 currentCount = currentCount + 1
    -- --                 -- local averageTimePerUser = (os.time() - lastUserTime) / currentCount
    -- --                 -- local estimatedTime = averageTimePerUser * (userCount - currentCount)                   
    -- --                 -- local hours = math.floor(estimatedTime / 3600)
    -- --                 -- local minutes = math.floor((estimatedTime % 3600) / 60)
    -- --                 -- local seconds = math.floor(estimatedTime % 60)

    -- --                 -- local avgHours = math.floor(averageTimePerUser / 3600)
    -- --                 -- local avgMinutes = math.floor((averageTimePerUser % 3600) / 60)
    -- --                 -- local avgSeconds = math.floor(averageTimePerUser % 60)
    -- --                 print(currentCount, "/", userCount)
    -- --                 -- print(string.format("Estimated time for completion: %02d:%02d:%02d", hours, minutes, seconds), currentCount, "/", userCount)
    -- --                 -- print(string.format("Average Time Per User: %02d:%02d:%02d", avgHours, avgMinutes, avgSeconds))

    -- --                 lastUserTime = os.time()
    -- --                 Database.Async:Insert('INSERT INTO bank_accounts_new (id, bankId, balance) VALUES (?)', {
    -- --                     {

    -- --                         0,
    -- --                         insertId,
    -- --                         v.bank
    -- --                     }
    -- --                 })
    -- --                 local userData = {
    -- --                     name = v.name or 'NOT_FOUND',
    -- --                     identifier = v.identifier or "NOT_FOUND",
    -- --                     identifiers = {v.license},
    -- --                     data = {
    -- --                         chars = {}
    -- --                     }
    -- --                 }
    -- --                 table.insert(userData.data.chars, {
    -- --                     id = insertId,
    -- --                     firstname = charData.data.firstname,
    -- --                     lastname = charData.data.lastname
    -- --                 })
    -- --                 userData.data.char = insertId
    -- --                 Database.Async:Insert('INSERT INTO users_new (id, name, identifier, identifiers, data) VALUES (?)', {
    -- --                     {

    -- --                         0,
    -- --                         userData.name,
    -- --                         userData.identifier,
    -- --                         json.encode(userData.identifiers),
    -- --                         json.encode(userData.data),
    -- --                     }
    -- --                 }, function(userId)
    -- --                     Database.Async:fetchAll('SELECT * FROM datastore_data WHERE owner = ?', {
    -- --                         v.identifier
    -- --                     }, function(res)
    -- --                         if res then
    -- --                             local clothes = json.decode(res.dressing) and json.decode(res.dressing) or {}
    -- --                             local items = {}
    -- --                             local weapons = json.decode(res.weapons) and json.decode(res.weapons) or {}

    -- --                             for k,v in pairs(weapons or {}) do
    -- --                                 v.data = {}
    -- --                                 v.data.ammo = v.ammo or 455
    -- --                                 table.insert(items, v)
    -- --                             end

    -- --                             local moreItems = self.Sync:fetchAll('SELECT * FROM addon_inventory_items WHERE owner = ?', {v.identifier})

    -- --                             for k5,v5 in pairs(moreItems or {}) do
    -- --                                 table.insert(items, {
    -- --                                     name = v5.name,
    -- --                                     count = v5.count
    -- --                                 })
    -- --                             end

    -- --                             local blackMoney = self.Sync:fetch('SELECT * FROM addon_account_data WHERE owner = ?', {v.identifier})

    -- --                             if blackMoney then
    -- --                                 table.insert(items, {
    -- --                                     name = 'black_money',
    -- --                                     count = blackMoney.money or 50000
    -- --                                 })
    -- --                             end

    -- --                             Database.Async:Insert('INSERT INTO owned_properties_new (id, owner, owners, name, type, items, clothes) VALUES (?)', {
    -- --                                 {

    -- --                                     0,
    -- --                                     charId,
    -- --                                     json.encode({}),
    -- --                                     'HillcrestAvenue2874',
    -- --                                     'property',
    -- --                                     json.encode(items),
    -- --                                     json.encode(clothes)
    -- --                                 }
    -- --                             })
    -- --                         end
    -- --                     end)

    -- --                     Database.Async:fetchAll('SELECT * FROM owned_vehicles WHERE owner = ?', {
    -- --                         v.identifier
    -- --                     }, function(res)
    -- --                         if res then
    -- --                             for k5,v5 in pairs(res or {}) do
    -- --                                 Database.Async:Insert('INSERT INTO owned_vehicles_new (id, owner, state, vehicle) VALUES (?)', {
    -- --                                     {

    -- --                                         0,
    -- --                                         charId,
    -- --                                         1,
    -- --                                         v5.vehicle
    -- --                                     }
    -- --                                 })
    -- --                             end
    -- --                         end
    -- --                     end)
                        
    -- --                     cb()
    -- --                 end)
    -- --             end)
    -- --         end)
    -- --     end


    -- --     -- Async:parallelLimit(tasks, 1, function()
    -- --     --     print("DONE")
    -- --     -- end)

    -- --     for k,v in pairs(tasks) do
    -- --         Wait(50)
    -- --         v(function()
                
    -- --         end)
    -- --     end

    -- --     print("DONE")
    -- -- end)