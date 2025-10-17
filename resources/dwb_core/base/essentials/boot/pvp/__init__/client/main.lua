Key:onJustPressed("J", "F7", function()
  local elements = {}
  UI:Open("Menu", {
    show = true,
    name = "pvp-menu",
    align = "right",
    title = "Wybór trybu",
    elements = elements,
    side = "right",
    main = 0,
  })
end)
