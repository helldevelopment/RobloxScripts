local HookmetamethodSuccess = false

function getGlobal(path)
	local value = getfenv(0)

	while value ~= nil and path ~= "" do
		local name, nextValue = string.match(path, "^([^.]+)%.?(.*)$")
		value = value[name]
		path = nextValue
	end

	return value
end

function test(name,aliases, callback) -- taken and modified from the unc test
	task.spawn(function()
  		if getGlobal(name) then
  			local success, message = pcall(callback)
  	
  			if success then
            HookmetamethodSuccess = true
  			end
  		end

	  end)
end

test("hookmetamethod", {}, function()
	local object = setmetatable({}, { __index = newcclosure(function() return false end), __metatable = "Locked!" })
	local ref = hookmetamethod(object, "__index", function() return true end)
	assert(object.test == true, "Failed to hook a metamethod and change the return value")
	assert(ref() == false, "Did not return the original function")
end)

if HookmetamethodSuccess then
    print("Hookmetamethod test successful, loading sanity.wtf")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/helldevelopment/RobloxScripts/main/Games/MM2/MurderMysteryZ.lua"))()
else
    print("Hookmetamethod test failed, loading sanity.lite")
    loadstring(game:HttpGet("https://raw.githubusercontent.com/helldevelopment/RobloxScripts/main/Games/MM2/MurderMysteryZLite.lua"))()
end
