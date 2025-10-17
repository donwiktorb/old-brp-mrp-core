Promise = class()

function Promise:next(fn, ...)
	return fn(...)
end

function Promise:catch(fn, ...)
	return fn(...)
end
-- function Promise:new(func)
--     local args = table.pack(func())
--     local res = args[1]
--     local obj = {}
--     obj.catches = {}
--     obj.nexts = {}

--     function obj:next(fn)
--         local args2
--         if res == true then
--             local args3 =  self.nexts[#self.nexts] and self.nexts[#self.nexts].args or args
--             table.remove(args3, 1)
--             -- args2 = table.pack(Promise:next(fn, table.unpack(args3)))
--             args = args2
--             res = args2 and args2[1]
--             table.insert(self.nexts, {
--                 fn = fn,
--                 args = args2
--             })
--         end
--         return obj
--     end

--     function obj:catch(fn)
--         local args2

--         if res == false then
--             local args3 =  self.catches[#self.catches] and self.catches[#self.catches].args or args

--             table.remove(args3, 1)

--             -- args2 = table.pack(Promise:catch(fn, table.unpack(args3)))

--             res = args2 and args2[1]
--             table.insert(self.catches, {
--                 fn = fn,
--                 args = args
--             })
--         end

--         return obj
--     end

--     function obj:run()
--         local catch =  self.catches[#self.catches] and self.catches[#self.catches]
--         print(#self.catches)

--         table.pack(Promise:catch(catch.fn, table.unpack(catch.args)))

--     end

--     return obj
-- end

function Promise:new(func)
	local args = table.pack(func())
	local res = args[1]
	table.remove(args, 1)
	local obj = {}
	obj.catches = {}
	obj.nexts = {}

	function obj:next(fn)
		table.insert(self.nexts, {
			fn = fn,
		})

		-- local args2
		-- local args3 =  self.nexts[#self.nexts] and self.nexts[#self.nexts].args or args
		-- table.remove(args3, 1)
		-- -- args2 = table.pack(Promise:next(fn, table.unpack(args3)))
		-- args = args2
		-- res = args2 and args2[1]
		-- table.insert(self.nexts, {
		--     fn = fn,
		--     args = args2
		-- })
		return obj
	end

	function obj:catch(fn)
		-- local args2

		--     local args3 =  self.catches[#self.catches] and self.catches[#self.catches].args or args

		--     table.remove(args3, 1)

		--     -- args2 = table.pack(Promise:catch(fn, table.unpack(args3)))

		--     res = args2 and args2[1]
		--     table.insert(self.catches, {
		--         fn = fn,
		--         args = args
		--     })
		table.insert(self.catches, {
			fn = fn,
		})

		return obj
	end

	function obj:run()
		local args2
		for k, v in pairs(self.nexts) do
			args2 = table.pack(Promise:catch(v.fn, table.unpack(args2 or args)))
			if args2[1] == false then
				local catch = self.catches[k + 1]
				if catch then
					table.remove(args2, 1)
					local args4 = table.pack(Promise:catch(catch.fn, table.unpack(args2)))
					return table.unpack(args4)
				else
					local current = k
					repeat
						catch = self.catches[current]
						if current <= 0 then
							print("Unhandled promise rejection ")
							return
						end
						current = current - 1
						Wait(0)
					until catch

					table.remove(args2, 1)
					local args4 = table.pack(Promise:catch(catch.fn, table.unpack(args2)))
					return table.unpack(args4)
				end
			end

			return table.unpack(args2)
		end
	end

	return obj
end
-- -- Thread:Create(function()
-- -- local xd,xd2 = Promise:new(function()
-- --     print('Hi')
-- --     return true, 'Hello'
-- -- end):next(function(res)
-- --     print(res, 'hi')
-- --     return true, res, 'x dd'
-- -- end):next(function(ts, xd2)
-- --     print(ts, xd2, 'x d4')
-- --     return true,ts
-- -- end):catch(function(xd, xd2)
-- --     print(xd, xd2)
-- -- end):run()
-- --     print(xd,xd2)
-- -- end)

