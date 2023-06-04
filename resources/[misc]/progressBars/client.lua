function startUI(time, text) 
	lib.progressBar({
        duration = time,
        label = 'text',
        useWhileDead = false,
        canCancel = false,
        disable = {
        }
    })
end