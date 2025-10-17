function verifyNames(firstname)
  local firstname = firstname:lower():gsub("^%l", string.upper):gsub("%W+", ""):gsub("%d", "")

  return firstname
end

function User:CreateChar(extra, cb, cb2)
  local elems = {
    {
      type = "input",
      name = "firstname",
      label = "Imię",
      required = true,
      formatName = true,
    },
    {
      type = "input",
      name = "lastname",
      label = "Nazwisko",
      required = true,
      formatName = true,
    },

    {
      type = "date",
      name = "date",
      label = "Data urodzenia",
      required = true,
    },

    {
      type = "number",
      name = "height",
      label = "Wysokość",
      required = true,
    },
    {
      required = true,
      type = "select",
      name = "sex",
      label = "Płeć",
      -- defaultValue = 0,
      value = {
        label = "Mężczyzna",
        value = "m",
      },
      max = 2.0,
      options = {
        {
          label = "Mężczyzna",
          value = "m",
        },
        {
          label = "Kobieta",
          value = "f",
        },
      },
    },
  }

  for k, v in pairs(extra) do
    table.insert(elems, v)
  end

  UI:Open("MenuSide", {
    show = true,
    name = "new-char",
    title = "Tworzenie postaci",
    align = "middle",
    side = "right",
    main = 0,
    elements = elems,
    pages = nil,
    currentPage = nil,
  }, function(data, menu)
    local newData = {}

    for k, v in pairs(data.menu.elements) do
      if not v.value then
        return
      end
      newData[v.name] = v.formatName and verifyNames(v.value) or v.value
    end

    menu.close()

    cb(newData)
  end, function(data, menu)
    menu.close()
    cb2()
  end)
end

function User:CharSelector(chars, limit, cbNew, cbSelected, cbClose, charType)
  if type(cbClose) == "string" then
    charType = cbClose
    cbClose = nil
  end
  local elements = {}

  local actualChars = 0
  for k, v in pairs(chars) do
    if (not charType and not v.type) or (charType == v.type) then
      actualChars = actualChars + 1
      table.insert(elements, {
        label = string.format("%s %s %s", v.id, v.firstname, v.lastname),
        value = v.id,
      })
    end
  end
  if actualChars < limit then
    table.insert(elements, {
      label = "Nowa postać",
      value = "new",
    })
  end
  UI:Open("Menu", {
    show = true,
    name = "anims-cat",
    align = "right",
    title = "Wybór postaci",
    elements = elements,
    side = "right",
    main = 0,
  }, function(data, menu)
    menu.close()
    if data.current.value == "new" then
      cbNew(data)
    else
      cbSelected(data)
    end
  end, function(data, menu)
    if cbClose then
      menu.close()
      cbClose(data)
    end
  end)
end
