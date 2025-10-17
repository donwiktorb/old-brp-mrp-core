


-- -- function User:CreateChar(charData, cb)
-- --     Player(self.source).state.data = {
-- --         char = charData
-- --     }
-- --     return Mysql.Async:Execute('INSERT INTO characters SET ?', {

-- --         data = json.encode(charData),
        
-- --         jobs = json.encode({{
-- --             job = 'military',
-- --             grade = 1
-- --         }}),

-- --         position = json.encode({})
-- --     }, function(rowsChanged2)
-- --         local charId = rowsChanged2.insertId
-- --         charData.id = charId
-- --         table.insert(self.data.chars, charData)
-- --         -- -- self:Set('charId', charId)
-- --         self:Set({
-- --             charId = charId,
-- --             inventory = {},
-- --             jobs = json.encode({{
-- --                 job = 'military',
-- --                 grade = 1
-- --             }}),
-- --             position = {} 
-- --         })
-- --         self:SetChar(charData)
-- --         self:Save()

-- --         Event:Trigger('dwb:player:changed', self.source, charId)
-- --         return cb(self)
-- --     end)
-- -- end

-- -- function User:LoadChar(id, cb)


-- --     local source = self.source
    
-- --     Mysql.Async:fetchAll('SELECT data, skin, jobs, inventory, position FROM characters WHERE id = ?', {
-- --         id
-- --     }, function(result)
-- --         local data = {}
-- --         local result = result[1]
-- --         -- -- local accounts = json.decode(result.accounts)
-- --         local jobsJSON = json.decode(result.jobs)
-- --         local newData = json.decode(result.data)

-- --         -- -- for i=1, #Config.Accounts, 1 do
-- --         -- --     local account = accounts[Config.Accounts[i]] or 0
-- --         -- --     table.insert(data.accounts, {
-- --         -- --         name = Config.Accounts[i],
-- --         -- --         money = account,
-- --         -- --         label = Config.AccountLabels[Config.Accounts[i]]
-- --         -- --     })

            
-- --         -- -- end

-- --         data.char = json.decode(result.data)

-- --         data.skin = json.decode(result.skin) or {}

-- --         local pos = json.decode(result.position) or {x = 0, y = 0, z = 0}
-- --         if pos and pos.x then
-- --             data.position = vector3(pos.x, pos.y, pos.z)
-- --         end
-- --         data.jobs = {} 
-- --         print(json.encode(jobsJSON))
-- --         for k,v in pairs(jobsJSON or {}) do
-- --             local jobObj, gradeObj = Job:GetJobFromNameGrade(v.job, tonumber(v.grade))
-- --             print(jobObj, gradeObj, json.encode(gradeObj), v.job)
-- --             -- local job = {
-- --             --     name = v.job,
-- --             --     label = jobObj.label,
-- --             --     grade = tonumber(v.grade),
-- --             --     grade_name = gradeObj.name,
-- --             --     grade_label = gradeObj.label,
-- --             --     isBoss = gradeObj.isBoss,
-- --             --     grade_salary = gradeObj.salary
-- --             -- }
-- --             -- data.jobs[v.job] = job
-- --             data.jobs[v.job] = gradeObj
-- --             print(json.encode(job), v.job)
-- --         end

-- --         if result.loadout then
-- --             data.loadout = json.decode(result.loadout) or {}
-- --         end

-- --         local newInventory = json.decode(result.inventory) or {}

-- --         data.inventory = {}

-- --         for k,v in pairs(newInventory) do
-- --             if v.type == 'weapon' or (v.count and v.count > 0) then
-- --                 local item = DWB.Items[v.name]
-- --                 if item then
-- --                     table.insert(data.inventory, {
-- --                         name = v.name,
-- --                         count = tonumber(v.count),
-- --                         slot = v.slot or 0,
-- --                         weight = item.weight,
-- --                         data = v.data,
-- --                         type = item.type,
-- --                         label = item.label,
-- --                         limit = item.limit,
-- --                         usable = DWB.UsableItemsCallbacks[v.name] ~= nil,
-- --                         rare = item.rare,
-- --                         canRemove = item.canRemove,
-- --                         ref = item.ref
-- --                     })
-- --                 else
-- --                     print('Wrong item '..v.name)
-- --                 end
-- --             end
-- --         end

-- --         -- -- table.sort(data.inventory, function(a,b)

-- --         -- --     return a.slot < b.slot
-- --         -- -- end)
-- --         Player(self.source).state.data = data
-- --         data.skin.sex = data.char.sex
-- --         self:Set({
-- --             charId = id,
-- --             skin = data.skin,
-- --             jobs = data.jobs,
-- --             position = data.position,
-- --             inventory = data.inventory
-- --         })

-- --         self:SyncJobs()
        
-- --         Event:TriggerNet('dwb:skin:load', self.source, data.skin)

-- --         data.skin = nil
-- --         data.jobs = nil
-- --         data.inventory = nil
-- --         data.position = nil
        

-- --         self:SetChar(data.char)

-- --         Event:Trigger('dwb:player:changed', self.source, self.charId)
-- --         Log:Info('x d', json.encode(data.char), id, cb, self.source, self.charId, json.encode(self.char))
-- --         return cb(self)
-- --     end)
-- -- end

-- -- function User:UnloadChar()
-- --     local source = self.source
-- --     local data = {}
-- --     Player(self.source).state.data = nil
-- --     self.charId = nil
-- --     self:Set({
-- --         charId = nil,
-- --         skin = data.skin,
-- --         jobs = data.jobs,
-- --         position = data.position,
-- --         inventory = data.inventory,
-- --         char = {}
-- --     })
    
-- --     Event:TriggerNet('dwb:skin:load', self.source, {sex = 'm'})

-- --     self:SetChar({})

-- --     Event:Trigger('dwb:player:unloaded', self.source, self.charId)
-- -- end


-- -- function InitPlayerLoad(source)
-- --     local _source = source

-- -- 	local identifier = GetPlayerIdentifier(_source, 0)

-- --     local identifiers = {}

-- --     for k,v in pairs(GetPlayerIdentifiers(_source)) do
-- --         if string.sub(v, 1, string.len("ip:")) ~= 'ip:' then
-- --             for i, nv in string.gmatch(v, "(%w+):(%w+)") do
-- --                 identifiers[i] = v
-- --             end
-- --         end
-- --     end

-- -- 	if not identifier or string.sub(identifier, 1, string.len("steam:")) ~= "steam:" then
-- -- 		DropPlayer(_source, "\n[dwb]: Nie masz włączonego steama lub wystąpił z nim jakiś błąd.")
-- -- 	else

-- --         local cacheData = Cache:Get(identifier)

-- --         if cacheData then
-- -- 			LoadPlayer(_source, cacheData, false, cacheData.id)
-- --             Cache:Remove(identifier)
-- --             return
-- --         end

-- -- 	    local license = GetPlayerIdentifier(_source, 1)
-- -- 		Mysql.Async:fetchAll('SELECT data FROM users WHERE identifier = ?', {
-- -- 			identifier
-- -- 		}, function(result)
-- -- 			if result and result[1] then
-- -- 				LoadPlayer(_source, json.decode(result[1].data), false, result[1].id)
-- -- 			else
-- -- 				Mysql.Async:Execute('INSERT INTO users SET ?', {
-- --                     identifier = identifier,
-- --                     name = GetPlayerName(_source),
-- --                     identifiers = json.encode(identifiers),
-- --                     data = json.encode({group = 'user'})
-- -- 				}, function(rowsChanged)
-- --                     Mysql.Async:Execute('INSERT INTO characters SET ?', {
-- --                         id = rowsChanged.insertId,
-- --                         data = json.encode(
-- --                             {
-- --                                 firstname = '',
-- --                                 lastname = '',
-- --                                 dateofbirth = '',
-- --                                 phone_number = 0,
-- --                                 sex = 'm'
-- --                             }
-- --                         ),
                        
-- --                         jobs = json.encode({{
-- --                             job = 'unemployed',
-- --                             grade = 1
-- --                         }}),
-- --                         position = json.encode(Config.Default.position)
-- --                     }, function(rowsChanged2)
-- --                         LoadPlayer(_source, {char = rowsChanged2.insertId, chars = {}}, true, rowsChanged.insertId)
-- --                     end)
-- -- 				end)
-- -- 			end
-- -- 		end)
-- -- 	end
-- -- end


-- -- function LoadPlayer(source, userData, firstTime, id)
-- --     local _source = source
-- --     local tasks   = {}
-- --     local identifier = GetPlayerIdentifier(_source, 0)
-- --     local name = GetPlayerName(_source)
    
-- --     if identifier == nil or string.sub(identifier, 1, string.len("steam:")) ~= "steam:" then
-- --         DropPlayer(_source, "[dwb]: Nie wykryto steama.")
-- --     end

-- --     local identifiers = {}

-- --     for k,v in pairs(GetPlayerIdentifiers(_source)) do
-- --         if string.sub(v, 1, string.len("ip:")) ~= 'ip:' then
-- --             table.insert(identifiers, v)
-- --             -- -- -- for i, nv in string.gmatch(v, "(%w+):(%w+)") do
-- --             -- -- --     table.insert()
-- --             -- -- --     identifiers[i] = v
-- --             -- -- -- end
-- --         end
-- --     end

-- --     local data = {
-- --         data = userData,
-- --         info = {
-- --             -- charId = tonumber(userData.char),
-- --             id = tonumber(id),
-- --             identifier = identifier,
-- --             name = name,
-- --             source = _source,
-- --             ped = GetPlayerPed(_source)
-- --         },
-- --         char = {
-- --             firstname = '',
-- --             lastname = '',
-- --             phone = 0,
-- --             dateofbirth = ''
-- --         },
-- --         position = Config.Default.position,
-- --         jobs = {},
-- --         loadout = {},
-- --         inventory = {},
-- --         accounts = {},
-- --         avatar = ""
-- --     }

-- --     while not MysqlLoaded do
-- --         Citizen.Wait(0)
-- --     end

-- --     table.insert(tasks, function(cb)
-- --         Mysql.Async:Execute('UPDATE users SET name = ? WHERE identifier = ?', {
-- --             identifier,
-- --             name
-- --         }, function(rowsChanged)
-- --             cb()
-- --         end)
-- --     end)

-- --     table.insert(tasks, function(cb)
-- --         Mysql.Async:Execute('UPDATE users SET identifiers = ? WHERE identifier = ?', {
-- --             identifier,
-- --             json.encode(identifiers)
-- --         }, function(rowsChanged)
-- --             cb()
-- --         end)
-- --     end)

-- --     -- table.insert(tasks, function(cb)

-- --     --     if not data.info.charId then
-- --     --         return cb()
-- --     --     end
-- --     --     Mysql.Async:fetchAll('SELECT data, skin, jobs, inventory, position FROM characters WHERE id = ?', {
-- --     --         data.info.charId
-- --     --     }, function(result)
-- --     --         local result = result[1]
-- --     --         -- -- local accounts = json.decode(result.accounts)
-- --     --         local jobsJSON = json.decode(result.jobs)
-- --     --         local newData = json.decode(result.data)

-- --     --         -- -- for i=1, #Config.Accounts, 1 do
-- --     --         -- --     local account = accounts[Config.Accounts[i]] or 0
-- --     --         -- --     table.insert(data.accounts, {
-- --     --         -- --         name = Config.Accounts[i],
-- --     --         -- --         money = account,
-- --     --         -- --         label = Config.AccountLabels[Config.Accounts[i]]
-- --     --         -- --     })

                
-- --     --         -- -- end


-- --     --         data.char = json.decode(result.data)
-- --     --         data.skin = json.decode(result.skin)

-- --     --         if not userData.pos then
-- --     --             local pos = json.decode(result.position)
-- --     --             if pos and pos.x then
-- --     --                 data.position = vector3(pos.x, pos.y, pos.z)
-- --     --             end
-- --     --         else
-- --     --             data.position = userData.pos.coords
-- --     --         end
            
-- --     --         for k,v in pairs(jobsJSON) do
-- --     --             local jobObj, gradeObj = Job:GetJobFromNameGrade(v.job, tonumber(v.grade))

-- --     --             local job = {
-- --     --                 name = v.job,
-- --     --                 label = jobObj.label,
-- --     --                 grade = tonumber(v.grade),
-- --     --                 grade_name = gradeObj.name,
-- --     --                 grade_label = gradeObj.label,
-- --     --                 isBoss = gradeObj.isBoss,
-- --     --                 grade_salary = gradeObj.salary
-- --     --             }

-- --     --             data.jobs[v.job] = job

-- --     --         end

-- --     --         if result.loadout then
-- --     --             data.loadout = json.decode(result.loadout)
-- --     --         end

-- --     --         local newInventory = json.decode(result.inventory)

-- --     --         for k,v in pairs(newInventory) do
-- --     --             if v.type == 'weapon' or (v.count and v.count > 0) then
-- --     --                 local item = DWB.Items[v.name]
-- --     --                 if item then
-- --     --                     table.insert(data.inventory, {
-- --     --                         name = v.name,
-- --     --                         count = tonumber(v.count),
-- --     --                         slot = v.slot or 0,
-- --     --                         weight = item.weight,
-- --     --                         data = v.data,
-- --     --                         type = item.type,
-- --     --                         label = item.label,
-- --     --                         limit = item.limit,
-- --     --                         usable = DWB.UsableItemsCallbacks[v.name] ~= nil,
-- --     --                         rare = item.rare,
-- --     --                         canRemove = item.canRemove,
-- --     --                         ref = item.ref
-- --     --                     })
-- --     --                 else
-- --     --                     print('Wrong item '..v.name)
-- --     --                 end
-- --     --             end
-- --     --         end

-- --     --         table.sort(data.inventory, function(a,b)
-- --     --             return a.slot < b.slot
-- --     --         end)


-- --     --         cb()
-- --     --     end)
-- --     -- end)

-- --     Async:parallel(tasks, function(results)
-- --         local xPlayer = User(data)

-- --         print(xPlayer)

-- --         if not xPlayer then
-- --             Log:Error('Failed to create xPlayer for player '..identifier)
-- --             DropPlayer(_source, "[dwb]: Wystąpił błąd z ładowanie twojej postaci.")
-- --         else 
            
-- --             DWB.Players[_source] = xPlayer

-- --             local clientData = {
-- --                 identifier = identifier,
-- --                 source = _source,
-- --                 group = xPlayer.data.group,
-- --                 position = xPlayer.position,
-- --                 loadout = xPlayer.loadout,
-- --                 jobs = xPlayer.jobs,
-- --                 inventory = xPlayer.inventory,
-- --                 char = xPlayer.char,
-- --                 -- charId = tonumber(xPlayer.charId),
-- --                 ped = GetPlayerPed(_source),
-- --                 avatar = xPlayer.avatar,
-- --                 newUser = xPlayer.data.newUser,
-- --                 newChar = xPlayer.data.newChar




-- --             }

-- --             Player(_source).state.data = clientData

-- --             Event:Trigger('dwb:player:loaded', _source, xPlayer)

-- --             Event:TriggerNet('dwb:player:loaded', _source, clientData)
-- --         end
    

-- --     end)
-- -- end


-- -- function SavePlayer(xPlayer, cb2)
-- -- 	local asyncTasks = {}
-- -- 	-- xPlayer.setCoords(xPlayer.getCoords())

-- --     table.insert(asyncTasks, function(cb)
    
-- --         local dataObj = {group = xPlayer.group, char = xPlayer.charId}

-- --         Mysql.Async:Execute('UPDATE users SET data = ? WHERE identifier=?', {
-- --             json.encode(xPlayer.data),
-- --             xPlayer.identifier
-- -- 		}, function(rowsChanged)
-- -- 		    cb()
-- -- 		end)
-- --     end)

-- -- 	table.insert(asyncTasks, function(cb)
-- --         if not xPlayer.charId then return cb() end
-- -- 		local newInventory = {}
-- -- 		for k,v in pairs(xPlayer.inventory or {}) do
-- -- 			table.insert(newInventory, {name = v.name, count = v.count, slot = v.slot, data = v.data or {}})
-- -- 		end

-- --         local jobObj = {}

-- --         for k,v in pairs(type(xPlayer.jobs) == 'table' and xPlayer.jobs or {}) do
-- --             table.insert(jobObj, {job = k, grade = v.grade})
-- --         end


-- -- 		Mysql.Async:Execute('UPDATE characters SET data = ?, skin = ?, jobs = ?, inventory = ?, position = ? WHERE id=?', {
-- --             json.encode(xPlayer.char),
-- --             json.encode(xPlayer.skin),
-- --             -- -- -- -- json.encode(accounts),
-- --             json.encode(jobObj),
-- --             json.encode(newInventory),
-- --             json.encode(xPlayer.position),
-- --             xPlayer.charId
-- -- 		}, function(rowsChanged)
-- -- 			cb()
-- -- 		end)
-- -- 	end)

-- -- 	Async:parallel(asyncTasks, function(results)
-- -- 		RconPrint('[SAVED] ' .. xPlayer.name .. "^7\n")

-- -- 		if cb2 ~= nil then
-- -- 			cb2(xPlayer)
-- -- 		end
-- -- 	end)
-- -- end

-- -- function User:Save(cb)
-- --     SavePlayer(self, function()
-- --         self:Saved()
-- --         cb()
-- --     end)
-- -- end