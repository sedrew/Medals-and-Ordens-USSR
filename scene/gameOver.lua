local composer = require("composer")
local widget = require("widget")
local loadsave = require( "lib.loadsave" )
local facts	= require("resource.facts")[PROPS.lang]
local scene = composer.newScene()

function scene:create(event)
  local sceneGroup = self.view

  local text_gameOver = composer.getVariable("textGameOver") or "time_out"
  display.newRect(sceneGroup, centerX , centerY, fullw, fullh):setFillColor(37/255, 39/255, 46/255, 0.7)
  local plant = display.newRoundedRect(sceneGroup, centerX, centerY, fullw-80, fullh-180, 15)
        plant:setFillColor(unpack(PROPS.color.cart))


  local textTab = {"Время вышло\n", "Звезды закончились\n", "Очки", "Ловкость ", "Правельных ответов"}

  local butt = display.newRoundedRect(sceneGroup, centerX , plant.y-plant.width+175, plant.width-100, 130, 20)

  if text_gameOver == "victory" then
    butt:setFillColor(unpack(PROPS.color.right))
  elseif text_gameOver == "pause" then
    butt:setFillColor(unpack(PROPS.color.achieve))
  else
    butt:setFillColor(unpack(PROPS.color.mistake))
  end

  local text = display.newText({
    parent = sceneGroup,
    text =  i18n(text_gameOver),
    width = butt.width,
    align = "center",
    x = display.contentCenterX, y = plant.y-plant.width+175,
    font = PROPS.font,
    fontSize = (butt.width-100)/math.floor(utf8.len(i18n(text_gameOver)))+25,
  })
  text:setTextColor(1)

  transition.cancel("tagPauseLineTime")

  local settings = require("lib.loadsave")
  local table_achieve = settings.loadTable("settings.json")

  ACHIEVES.all_score = table_achieve.game_achieve.all_score + composer.getVariable("score") --посмтри на main.lua

  table_achieve.game_achieve = {
    all_score = ACHIEVES.all_score,
    all_right_answer = ACHIEVES.all_right_answer,
    all_mistake_answer = ACHIEVES.all_mistake_answer,
    all_time = ACHIEVES.all_time,
    middle_time = ACHIEVES.middle_time,
    count_game = ACHIEVES.count_game,
    achieve_name = {},
    week_progres = {},
    recent_visit = {},
  }
  settings.saveTable(table_achieve, "settings.json")

  local all_text_score = display.newText({
    parent = sceneGroup,
    text =  table_achieve.game_achieve.all_score,
    width = 490,
    align = "center",
    x = display.contentCenterX, y = text.y+260,
    font = PROPS.font,
    fontSize = 200,
  })
  all_text_score:setFillColor(unpack(PROPS.color.achieve))

  local text_score = display.newText({
    parent = sceneGroup,
    text =  "+"..composer.getVariable("score"),
    width = 490,
    align = "left",
    x = all_text_score.x+250, y = text.y+150,
    font = PROPS.font,
    fontSize = 75,
  })
  text_score:setFillColor(unpack(PROPS.color.achieve))


  local ar1 = math.random(1, #facts)
  local ar2 = math.random(2, math.random(2, #facts[ar1]))

  local text_ask = display.newText({
	  parent = sceneGroup,
	  text =  'А вы знали что:' ,
	  width = 490,
	  align = "center",
	  x = display.contentCenterX, y = plant.y,
	  font = PROPS.font,
	  fontSize = 45,
  })
  text_ask:setTextColor(1)

  local fact = display.newText({
    parent = sceneGroup,
    text =  facts[ar1][1] .. '\n' .. facts[ar1][ar2] ,
    width = plant.width-30,
    align = "center",
    x = display.contentCenterX, y = text_ask.y+165,--КОСТЫЛь
    font = PROPS.font,
    fontSize = 600/string.len(facts[ar1][ar2])+35,
  })
  fact:setTextColor(1)

  local old_scene_name = composer.getVariable("old_scene_name")
  function closer(event)
    if (event == 'restart') then
	    composer.removeHidden( false )
	    composer.hideOverlay("fade", 400)
	    composer.removeScene(old_scene_name)-- composer.getVariable( "name" )
	    composer.gotoScene(old_scene_name, PROPS.animation.scene )
    elseif (event == 'close') then
	    composer.hideOverlay("fade", 400) -- закрываем сцену
	    composer.gotoScene("scene.menu",  PROPS.animation.scene)
	    composer.removeScene(old_scene_name)
    end
  end


  local button_props = {radius = 10, width = 200, height = 100}
  local okButton = widget.newButton{
    shape = 'roundedRect',
    cornerRadius = button_props.radius,
    width = button_props.width, height = button_props.height,
    x = (plant.x-plant.width/2)+button_props.width/2,
    y = (plant.y+plant.height/2)-button_props.height/2,
    fillColor = { default={0.645,	0.743, 0.837}, over={unpack(PROPS.color.right)} },
    labelColor = { default={ 1 }, over={ 1 } },
    fontSize = 32,
    label = i18n("back"),
    onRelease  = function(event) closer('close') end
   }
	sceneGroup:insert(okButton)

  local restartButton = widget.newButton{
    shape = 'roundedRect',
    cornerRadius = button_props.radius,
    width = button_props.width, height = button_props.height,
    x = (plant.x+plant.width/2)-button_props.width/2,
    y = (plant.y+plant.height/2)-button_props.height/2,
    --left = plant.y+button_props.width, top = (plant.x+plant.height)-(button_props.height),
    fillColor = { default={0.645,	0.743, 0.837}, over= {unpack(PROPS.color.right)}},
    labelColor = { default={ 1 }, over={ 1 } },
    fontSize = 32,
    label =  i18n("restart"),
    onRelease = function(event)	closer('restart') end
  }
	sceneGroup:insert(restartButton)


end

scene:addEventListener("create", scene)
return scene
