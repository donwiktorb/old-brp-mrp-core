resource_type("gametype")({ name = "Roleplay" })

fx_version("cerulean")
game("gta5")
description("dwb")
author("dwb")
version("4.0.0")

lua54("yes")

loadscreen_cursor("yes")
loadscreen_manual_shutdown("yes")

ui_page("base/static/ui/boskierp/index.html")
loadscreen("base/static/ui/boskierp/index.html")

files({
  "base/data/shared/**/**/*.json",
  "base/static/ui/boskierp/index.html",
  "base/static/ui/boskierp/sounds/*.ogg",
  "base/static/ui/boskierp/img/**/*.png",
  "base/static/ui/boskierp/static/css/*.css",
  "base/static/ui/boskierp/static/css/*.css.map",
  "base/static/ui/boskierp/static/js/*.js",
  "base/static/ui/boskierp/static/js/*.js.map",
  "base/static/ui/boskierp/fonts/*.ttf",
})

shared_scripts({
  "translate.lua",
  "locales/*.lua",
  "config/**/__shared/**.lua",
  "base/__shared__/**/*.lua",
  "base/essentials/boot/**/shared/*.*",
  -- 'base/data/**/*.json',
})

client_scripts({
  "config/**/client/**/*.lua",
  "base/essentials/post/**/client/*.*",
  "base/client/**.lua",
  -- -- -- -- 'base/essentials/boot/**/client/*.*', --
})

exports({
  "use",
})

server_scripts({
  "config/**/server/**.lua",
  "base/essentials/post/**/server/*.*",
  "base/server/**.lua",

  -- -- -- -- 'base/essentials/boot/**/server/*.*', --
})

server_exports({
  "use",
})
