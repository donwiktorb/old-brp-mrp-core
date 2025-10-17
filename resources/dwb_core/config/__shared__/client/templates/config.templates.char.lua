Config.UI.Templates["CharSelector"] = {
  template = {
    name = "char_selector",
    title = TR("select_char"),
    align = "flex justify-end items-end",

    style = {
      box = "h-[90%] w-1/4 max-h-full max-w-full top-1/2 -translate-y-1/2 right-5",
      elements = "flex flex-col gap-2",
    },

    settings = { requiredAll = true },
    elements = {},
  },
}

Config.UI.Templates["CharCreator"] = {
  template = {
    name = "char_creator",
    title = TR("create_char"),
    align = "flex justify-end items-end",

    style = {
      box = "h-[90%] w-1/4 max-h-full max-w-full top-1/2 -translate-y-1/2 right-5",
      elements = "flex flex-col gap-2",
    },

    settings = { requiredAll = true, saveButtons = true },
    elements = {
      {
        name = "firstname",
        label = TR("enter_firstname"),
        type = "text",
        min = 4,
        max = 34,
      },
      {
        name = "lastname",
        label = TR("enter_lastname"),
        type = "text",
        min = 4,
        max = 34,
      },
      {
        name = "date",
        label = TR("enter_dob"),
        type = "date",
      },
      { name = "height", type = "number", label = TR("enter_height"), min = 140, max = 199 },
      { name = "sex", type = "radio", label = TR("male"), value = "m", checked = true },
      { name = "sex", type = "radio", label = TR("female"), value = "f" },
    },
  },
}
