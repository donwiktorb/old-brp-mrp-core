Temp = {}
CachedData = json.decode(LoadResourceFile(GetCurrentResourceName(), "base/data/data.json")) or {}

-- Weapon = use('shared', GetCurrentResourceName(), 'base/shared/__core_modules__/weapon')
-- Async = use('shared', GetCurrentResourceName(), 'base/shared/__core_modules__/async')
-- Math = use('shared', GetCurrentResourceName(), 'base/shared/__core_modules__/math')
-- Class = use('shared', GetCurrentResourceName(), 'base/shared/__core_modules__/class')
-- Log = use('shared', GetCurrentResourceName(), 'base/shared/__core_modules__/log')
-- Cache = use('shared', GetCurrentResourceName(), 'base/shared/__core_modules__/cache')
-- Handling = use('shared', GetCurrentResourceName(), 'base/shared/__core_modules__/handling')
-- Table = use('shared', GetCurrentResourceName(), 'base/shared/__core_modules__/table')
-- Timer = use('shared', GetCurrentResourceName(), 'base/shared/__core_modules__/timer')
-- Env = use('shared', GetCurrentResourceName(), 'base/shared/__core_modules__/env')

collectgarbage("generational")
