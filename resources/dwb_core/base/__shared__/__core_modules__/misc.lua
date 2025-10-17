function switch(value, cb)
	function case(name, fn)
		if name == value then
			return fn()
		end

		if not fn then
			return name()
		end
	end

	cb(case)
end

-- local state = 2

-- local function increaseState()
--     state = state << 1
-- end

-- local function decreaseState()
--     state = state >> 1
-- end

-- print(state)

-- increaseState()

-- increaseState()

-- print(state)

