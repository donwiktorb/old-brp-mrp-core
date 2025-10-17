
Event:Register('dwb:scratch:show', function(val)
    UI:Close('Inventory', {name='inventory'})
    UI:Open('Scratch', {
        name = 'scratch',
        show = true,
        text=val
    })
end, true)