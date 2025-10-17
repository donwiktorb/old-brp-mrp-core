
-- -- local dir = 'resources/[scripts]/[core]/'..GetCurrentResourceName()..'/base/essentials/boot/'
-- -- local cScripts = {}

-- -- function error_handler(err, res, file, ...)
-- --     Log:Error("Error loading resource", res, 'in file', file, err, ...)
-- -- end

-- -- function random_string(length)
-- --   local chars = {}
-- --   for i = 1, length do
-- --     -- Generate a random uppercase or lowercase letter
-- --     local char_code = math.random(65, 90) -- Uppercase letters
-- --     if math.random() < 0.5 then -- 50% chance of lowercase letter
-- --       char_code = char_code + 32 -- Convert to lowercase letter
-- --     end
-- --     -- Convert the character code to a string and add it to the table
-- --     table.insert(chars, string.char(char_code))
-- --   end
-- --   -- Concatenate the table of characters into a string and return it
-- --   return table.concat(chars)
-- -- end
-- -- local machinge = 'windows'

-- -- if machinge == 'windows' then
-- -- function loadScriptsFromDir(dir, fixedDir)
-- --     for file in io.popen("dir \""..dir.."\" /b"):lines() do
-- --         local path = dir .. "\\" .. file
-- --         local mode = io.open(path, "r")
-- --         local fixedDir = fixedDir or ""
-- --         if mode then
-- --             mode:close()
-- --             if string.sub(file, -4) == ".lua" and string.find(fixedDir, 'server') ~= nil then
-- --                 local code = LoadResourceFile(GetCurrentResourceName(), 'base/essentials/boot'..fixedDir..'/'..file)

-- --                 local sName = string.sub(fixedDir,2)
-- --                 local charPos = string.find(sName, "/")
-- --                 sName = string.sub(sName, 1, charPos-1)
-- --                 code = string.gsub(code, "  ", " ")
-- --                 code = string.gsub(code, "\n", "")
-- --                 code = string.gsub(code, "\n+", " ")

-- --                 local initMe = string.format("local currentResName = '%s' ", sName)

-- --                 code = initMe..code

-- --                 local loadedCode = load(code, string.format('%s/%s', fixedDir, file))

-- --                 local success, result = xpcall(loadedCode, function(error)
-- --                     error_handler(error, fixedDir, file, debug.getupvalue(loadedCode, 2))
-- --                 end)
-- --             end
-- --         else
-- --             loadScriptsFromDir(path, fixedDir.."/"..file)
-- --         end
-- --     end
-- -- end

-- -- -- loadScriptsFromDir(dir)

-- -- function encodeLua(source)
-- --     local encoded = source:gsub(".", function(c)
-- --         return string.format("\\x%02X", string.byte(c))
-- --     end)
-- --     return encoded
-- -- end

-- -- function loadClientScriptsFromDir(dir, fixedDir, firstDir)
-- --     for file in io.popen("dir \""..dir.."\" /b"):lines() do
-- --         local path = dir .. "\\" .. file
-- --         local mode = io.open(path, "r")
-- --         local fixedDir = fixedDir or ""
-- --         if mode then
-- --             mode:close()
-- --             if string.sub(file, -4) == ".lua" and string.find(fixedDir, 'client') ~= nil then
-- --                 local code = LoadResourceFile(GetCurrentResourceName(), 'base/essentials/boot'..fixedDir..'/'..file)

-- --                 for local_var in code:gmatch("local function%s+([%w_]+)%s*()") do
-- --                     local new_string = string.gsub(code , "%f[%a]"..local_var.."%f[%A]", random_string(8))
-- --                     code = new_string
-- --                 end
                
-- --                 local sName = string.sub(fixedDir,2)
-- --                 local charPos = string.find(sName, "/")
-- --                 sName = string.sub(sName, 1, charPos-1)

-- --                 -- code = string.gsub(code, "\r?\n", " ")
-- --                 code = string.gsub(code, "  ", " ")
-- --                 -- code = string.gsub(code, "\n", "")
-- --                 -- code = string.gsub(code, "\n+", " ")
-- --                 code = "local currentResName = "..sName.." "..code
-- --                 code = encodeLua(code)
                

-- --                 table.insert(cScripts, {
-- --                     name = file,
-- --                     dir = fixedDir,
-- --                     code = code
-- --                 })

-- --             end
-- --         else
-- --             loadClientScriptsFromDir(path, fixedDir.."/"..file, firstDir)
-- --         end
-- --     end
-- -- end

-- -- loadClientScriptsFromDir(dir)

-- -- else

-- -- function loadScriptsFromDir(dir, fixedDir)
-- --     for file in io.popen("ls -1 "..dir):lines() do
-- --         print(file, dir, fixedDir)
-- --     -- for file in io.popen("dir \""..dir.."\" /b"):lines() do
-- --         local path = dir .. "/" .. file
-- --         local mode = io.open(path, "r")
-- --         local fixedDir = fixedDir or ""
-- --         if mode then
-- --             mode:close()
-- --             if string.sub(file, -4) == ".lua" and string.find(fixedDir, 'server') ~= nil then
-- --                 local code = LoadResourceFile(GetCurrentResourceName(), 'base/essentials/boot'..fixedDir..'/'..file)

-- --                 local sName = string.sub(fixedDir,2)
-- --                 local charPos = string.find(sName, "/")
-- --                 sName = string.sub(sName, 1, charPos-1)
-- --                 code = string.gsub(code, "  ", " ")
-- --                 code = string.gsub(code, "\n", "")
-- --                 code = string.gsub(code, "\n+", " ")

-- --                 local initMe = string.format("local currentResName = '%s' ", sName)

-- --                 code = initMe..code

-- --                 local loadedCode = load(code, string.format('%s/%s', fixedDir, file))

-- --                 local success, result = xpcall(loadedCode, function(error)
-- --                     error_handler(error, fixedDir, file)
-- --                 end)
-- --             elseif string.sub(file, -4) ~= ".lua" and string.find(fixedDir, 'server') == nil then
-- --                 loadScriptsFromDir(path, fixedDir.."/"..file)
-- --             end
-- --         else
-- --             loadScriptsFromDir(path, fixedDir.."/"..file)
-- --         end
-- --     end
-- -- end

-- -- loadScriptsFromDir(dir)

-- -- function encodeLua(source)
-- --     local encoded = source:gsub(".", function(c)
-- --         return string.format("\\x%02X", string.byte(c))
-- --     end)
-- --     return encoded
-- -- end

-- -- function loadClientScriptsFromDir(dir, fixedDir, firstDir)
-- --     for file in io.popen("ls -1 "..dir):lines() do
-- --     -- -- for file in io.popen("dir \""..dir.."\" /b"):lines() do
-- --         local path = dir .. "/" .. file
-- --         local mode = io.open(path, "r")
-- --         local fixedDir = fixedDir or ""
-- --         if mode then
-- --             mode:close()
-- --             if string.sub(file, -4) == ".lua" and string.find(fixedDir, 'client') ~= nil then
-- --                 local code = LoadResourceFile(GetCurrentResourceName(), 'base/essentials/boot'..fixedDir..'/'..file)

-- --                 for local_var in code:gmatch("local function%s+([%w_]+)%s*()") do
-- --                     local new_string = string.gsub(code , "%f[%a]"..local_var.."%f[%A]", random_string(8))
-- --                     code = new_string
-- --                 end
                
-- --                 local sName = string.sub(fixedDir,2)
-- --                 local charPos = string.find(sName, "/")
-- --                 sName = string.sub(sName, 1, charPos-1)

-- --                 -- code = string.gsub(code, "\r?\n", " ")
-- --                 code = string.gsub(code, "  ", " ")
-- --                 code = string.gsub(code, "\n", "")
-- --                 code = string.gsub(code, "\n+", " ")
-- --                 code = "local currentResName = "..sName.." "..code
-- --                 code = encodeLua(code)
                

-- --                 table.insert(cScripts, {
-- --                     name = file,
-- --                     dir = fixedDir,
-- --                     code = code
-- --                 })
-- --             elseif string.sub(file, -4) ~= ".lua" and string.find(fixedDir, 'client') == nil then
-- --                 loadClientScriptsFromDir(path, fixedDir.."/"..file)
-- --             end
-- --         else
-- --             loadClientScriptsFromDir(path, fixedDir.."/"..file, firstDir)
-- --         end
-- --     end
-- -- end

-- -- loadClientScriptsFromDir(dir)
-- -- end

-- -- User:OnLoaded(function(self)
-- --     Event:TriggerNet('dwb:scripts:load', self.source, cScripts)
-- -- end)
-- -- Event:Register('dwb:player:joined', function()
-- -- end, true)

-- -- Event:Register('dwb:player:joined', function()

-- --     Event:TriggerNet('dwb:xd', source)
-- -- end, true)