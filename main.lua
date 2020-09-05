local composer = require( "composer" )
local background = display.setDefault("background", 0/255, 143/255, 126/255 )
------------------------------------------
--GLOBAL VARIABLE
------------------------------------------
centerX    = display.contentCenterX
centerY    = display.contentCenterY
fullw      = display.actualContentWidth
fullh      = display.actualContentHeight
left       = centerX - fullw/2
right      = left + fullw
top        = centerY - fullh/2
bottom     = top + fullh
------------------------------------------
local options = {
    effect = "fade",
    time = 500,
    params = {
        someKey = "someValue",
        someOtherKey = 10
    }
}

local loadsave  = require("scr.loadsave")
local properties = loadsave.loadTable( "settings.json" )

if properties ~= nil then
  print("logging")
  print(unpack(setting),"SSSS")
else
  local table = {
    settings = {
     color_theme = 0,
     font = 0,
     music = true,
     sounds = true,
     language = "Ru_ru"
    },
    game_achieve = {
      all_count = 0,
      all_time = 0,
      achieve_name = {}
    }
  }
  loadsave.saveTable(table, "settings.json")

end



composer.gotoScene( "scene.menu", options )
