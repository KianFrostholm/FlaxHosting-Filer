Callback = {}
Callback.ServerCallbacks = {}
Callback.CurrentRequestId = 0

TriggerServerCallback = function(name, cb, ...)
	Callback.ServerCallbacks[Callback.CurrentRequestId] = cb

	TriggerServerEvent(GetCurrentResourceName() .. ':triggerServerCallback', name, Callback.CurrentRequestId, ...)

	if Callback.CurrentRequestId < 65535 then
		Callback.CurrentRequestId = Callback.CurrentRequestId + 1
	else
		Callback.CurrentRequestId = 0
	end
end

RegisterNetEvent(GetCurrentResourceName() .. ':serverCallback')
AddEventHandler(GetCurrentResourceName() .. ':serverCallback', function(requestId, ...)
	Callback.ServerCallbacks[requestId](...)
	Callback.ServerCallbacks[requestId] = nil
end)	