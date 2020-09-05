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

local loadsave  = require("lib.loadsave")
local props = loadsave.loadTable( "settings.json" )

PROP   = {}
ACHIEVE = {}

if props ~= nil then
  --print("logging")
  --print(unpack(setting),"SSSS")
  PROPS= props.settings
  ACHIEVES  = props.game_achieve
else
  local tabl = {
    settings = {
     color_theme = 0,
     font = 0,
     music = true,
     sounds = true,
     lang = "ru"
    },
    game_achieve = {
      all_count = 0,
      all_time = 0,
      achieve_name = {}
    }
  }
  PROPS = tabl.settings
  ACHIEVES  = tabl.game_achieve
  loadsave.saveTable(tabl, "settings.json")
end

i18n = require('lib.i18n.init')
i18n.load(require('lib.i18n.languages'))
--i18n.loadFile(system.pathForFile(system.ResourceDirectory) ..'/lib/i18n/ru.lua') -- load French language file
i18n.setLocale(PROPS.lang)

print("sdsdsds %{age}", 3)
print(i18n('good_bye')) -- Good-bye!


composer.gotoScene( "scene.menu", options )
