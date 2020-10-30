local composer = require( "composer" )
------------------------------------------
--GLOBAL VARIABLE
------------------------------------------
centerX    = display.contentCenterX -- привести к глобальной таблице G
centerY    = display.contentCenterY
fullw      = display.actualContentWidth
fullh      = display.actualContentHeight
left       = centerX - fullw/2
right      = left + fullw
top        = centerY - fullh/2
bottom     = top + fullh
------------------------------------------
utf8 = require("lib.utf8")
-- local str = "Медаль\n «Партизану Отечественной войны»\n I степени"
-- local sd = utf8.gsub(str,'\n.-'," ")
--print(sd) --system.getPreference("locale", "language")
--utf8.gsub("Медаль «Партизану Отечественной войны» I степени", "(%w+)%s*(%w+)", "%2 %1"))
local loadsave  = require("lib.loadsave")
local props = loadsave.loadTable("settings.json")
local os_date = os.date( "*t" )

PROPS   = {}
ACHIEVES = {}

if props ~= nil then
  PROPS = props.settings
  ACHIEVES  = props.game_achieve
  PROPS.recent_visit = os_date
else
  local tabl = {
    settings = {
     color = {
       background = {0,	0.560, 0.494},
       up_bar = {0, 0.509, 0.454},
       achieve = {1, 0.949,	0.419},
       text = {0,0,0},
       cart = {0.745,	0.843, 0.937},
       right = {0.568, 0.819, 0.309},
       mistake = {1, 0.396, 0.396},
       white = {0,0,0},
       grey = {0.5,0.5,0.5},
     },
     font = "font/Blogger_Sans-Medium.otf",
     font_size = 80,
     music = true,
     sounds = true,
     lang = "ru",
     recent_visit = os_date,
     animation = {
       scene = {delay = 100, time = 300, effect="crossFade"},
       object = {time = 400, delay = 700, alpha = 0},
     }
    },
    game_achieve = {
      all_score = 0,
      all_right_answer = 0,
      all_mistake_answer = 0,
      all_time = 0,
      middle_time = 0,
      count_game = 0,
      achieve_name = {},
      week_progres = {{all_score=0,all_right_answer=0,all_mistake_answer=0},
                      {all_score=0,all_right_answer=0,all_mistake_answer=0},
                      {all_score=0,all_right_answer=0,all_mistake_answer=0},
                      {all_score=0,all_right_answer=0,all_mistake_answer=0},
                      {all_score=0,all_right_answer=0,all_mistake_answer=0},
                      {all_score=0,all_right_answer=0,all_mistake_answer=0},
                      {all_score=0,all_right_answer=0,all_mistake_answer=0}},
      all_time_progres = {},
    }
  }
  PROPS = tabl.settings
  ACHIEVES  = tabl.game_achieve
  loadsave.saveTable(tabl, "settings.json")
end

--i18n.loadFile(system.pathForFile(system.ResourceDirectory) ..'/lib/i18n/ru.lua') -- load French language file
-- print("sdsdsds %{age}", 3)
-- print(i18n('good_bye'))
--print(PROPS.lang)
function _G.saveAll()
  print("SSSADAD")
end

local function onSystemEvent( event )
    local eventType = event.type
    if (eventType == "applicationExit") then
      local table_save = {settings = PROPS,game_achieve = ACHIEVES}
      loadsave.saveTable(table_save, "settings.json")
    end
end
Runtime:addEventListener( "system", onSystemEvent )

local background = display.setDefault("background", unpack(PROPS.color.background))
composer.gotoScene("scene.menu", PROPS.animation.scene)
