Callback = {}
Callback.ServerCallbacks = {}

RegisterServerEvent(GetCurrentResourceName() .. ':triggerServerCallback')
AddEventHandler(GetCurrentResourceName() .. ':triggerServerCallback', function(name, requestId, ...)
	local _source = source
    TriggerServerCallback(name, requestID, _source, function(...)
		TriggerClientEvent(GetCurrentResourceName() .. ':serverCallback', _source, requestId, ...)
	end, ...)
end)

TriggerServerCallback = function(name, requestId, source, cb, ...)
    if Callback.ServerCallbacks[name] ~= nil then
        Callback.ServerCallbacks[name](source, cb, ...)
    else
        print('TriggerServerCallback => [' .. name .. '] does not exist')
    end
end

RegisterServerCallback = function(name, cb)
    Callback.ServerCallbacks[name] = cb
end