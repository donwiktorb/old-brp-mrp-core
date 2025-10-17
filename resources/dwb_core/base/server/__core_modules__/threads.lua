Thread = class()

Thread.threads = {}

function Thread:Create(name, cb)
	if not cb then
		cb = name
		name = math.random(1, 9999)
	end
	Citizen.CreateThread(function(id)
		self.threads[name] = id
		xpcall(cb, function(...)
			Log:Info("Error", ..., name)
		end)
	end)
end

function Thread:Remove(name)
	TerminateThread(self.threads[name])

	self.threads[name] = nil
end

