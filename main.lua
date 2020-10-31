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
  --PROPS.recent_visit = os_date
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

function _G.saveAll()
  local table = loadsave.loadTable("settings.json")
  os_date = os.date("*t")
  if os_date.yday-PROPS.recent_visit.yday > 7 then
    for i =1, 7 do
      ACHIEVES.week_progres[i] = {all_score=0,all_right_answer=0,all_mistake_answer=0}
    end
  end
  PROPS.recent_visit = os_date
  table.settings = PROPS
  table.game_achieve = {
    all_score = ACHIEVES.all_score,
    all_right_answer = ACHIEVES.all_right_answer,
    all_mistake_answer = ACHIEVES.all_mistake_answer,
    all_time = ACHIEVES.all_time,
    middle_time = ACHIEVES.middle_time,
    count_game = ACHIEVES.count_game,
    achieve_name = ACHIEVES.achieve_name,
    week_progres = ACHIEVES.week_progres,
  }
  loadsave.saveTable(table, "settings.json")
end

function _G.musicControl(t)
  local t = t or {}
  local music = t.music or PROPS.music
  local sound = t.sound or PROPS.sounds
  local volume = t.volume or 0.3
  local B = {}

  function B:init()
    _G.music = {}
    _G.music.backgroundMusic = audio.loadStream("audio/One Step Closer.mp3")
    _G.music.mistake = audio.loadSound("audio/error-sound.mp3")
    _G.music.gameOver = audio.loadSound("audio/game-over.mp3")
    _G.music.victory = audio.loadSound("audio/jingle-achievement-00.mp3")
    _G.music.right = audio.loadSound("audio/level-up-01.mp3")
    return B
  end
  audio.setVolume(volume)
  audio.setVolume( 1, {channel=2})
  function B:play()
    local backgroundMusicChannel
    if PROPS.music == true then
      backgroundMusicChannel = audio.play(_G.music.backgroundMusic, {loops=-1, channel = 1})
      audio.resume(backgroundMusicChannel)
    else
      audio.pause(backgroundMusicChannel)
    end
 end
 function B:sound(s)
   if PROPS.sounds then
     audio.play(_G.music[s],{channel = 2})
   end
 end
  return B
end
_G.musicControl():init():play()




local function onSystemEvent( event )
    local eventType = event.type
    if (eventType == "applicationExit") then
      _G.saveAll()
    end
end
Runtime:addEventListener("system", onSystemEvent)

local background = display.setDefault("background", unpack(PROPS.color.background))
composer.gotoScene("scene.menu", PROPS.animation.scene)
