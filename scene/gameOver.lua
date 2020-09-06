local composer = require("composer")
local widget = require("widget")
local loadsave = require( "lib.loadsave" )
local facts	= require("resource.facts")[PROPS.lang]
local scene = composer.newScene()

function scene:create(event)
  local sceneGroup = self.view

  display.newRect(sceneGroup, centerX , centerY, fullw, fullh):setFillColor(37/255, 39/255, 46/255, 0.7)
  local plant = display.newRoundedRect(sceneGroup, centerX, centerY, fullw-80, fullh-180, 15)
        plant:setFillColor(244/255,229/255,209/255)

  local textTab = {"Время вышло\n", "Звезды закончились\n", "Очки", "Ловкость ", "Правельных ответов"}

  local text = display.newText({
    parent = sceneGroup,
    text =  textTab[1],
    width = 490,
    align = "center",
    x = display.contentCenterX, y = plant.y-plant.width+175,
    font = PROPS.font,
    fontSize = 75,
  })
  text:setTextColor(255/255,129/255,129/255)

  transition.cancel("tagPauseLineTime")

  local settings = require("lib.loadsave")
  local table_achieve = settings.loadTable("settings.json")

  table_achieve.game_achieve = {
    all_score = ACHIEVES.all_score + composer.getVariable("score"),
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
  -- local lov = 0
  -- for i = 1, #lovkost do
    -- lov = math.ceil(lov + lovkost[i])
		-- --print(lovkost[i])
   -- end

  -- display.newRoundedRect(sceneGroup, display.contentCenterX, plant.y-320, 350, 55, 15):setFillColor(118/255,113/255,112/255)
  -- local plane = display.newRoundedRect(sceneGroup, display.contentCenterX-175, plant.y-320, (350/100)*(lov/#lovkost), 55, 15)
    -- plane:setFillColor(0.272+(38/(lov/#lovkost+10)), (0.815/100)*(lov/#lovkost+30), 80/255) --red 0.572 .428
    -- plane.anchorX = 0

  -- local text2 = display.newText({
	-- parent = sceneGroup,
	-- text =  textTab[4] .. math.ceil(lov/#lovkost) .. '%', --.."%\n" .. textTab[5] .." ".. math.floor((score/minus)*100) .. "%"
	-- width = 490,
	-- align = "center",
	-- x = display.contentCenterX, y = plant.y-320,
	-- font = "font/Blogger_Sans-Bold.otf",
	-- fontSize = 45,
  -- })
  -- text2:setTextColor(1,1,1)
  local text_score = display.newText({
    parent = sceneGroup,
    text =  composer.getVariable("score"),
    width = 490,
    align = "center",
    x = display.contentCenterX, y = text.y+150,
    font = PROPS.font,
    fontSize = 75,
  })

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
  text_ask:setTextColor(118/255,113/255,112/255)

  local fact = display.newText({
    parent = sceneGroup,
    text =  facts[ar1][1] .. '\n' .. facts[ar1][ar2] ,
    width = plant.width-30,
    align = "left",
    x = display.contentCenterX, y = text_ask.y+165,--КОСТЫЛь
    font = PROPS.font,
    fontSize = 600/string.len(facts[ar1][ar2])+35,
  })
  fact:setTextColor(118/255,113/255,112/255)
  --local setting = loadsave.loadTable( "settings.json" )

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
	  --	composer.removeScene(composer.getVariable( "name" ))
    end
  end


  local button_props = {radius = 10, width = 200, height = 100}
  local okButton = widget.newButton{
    shape = 'roundedRect',
    cornerRadius = button_props.radius,
    width = button_props.width, height = button_props.height,
    x = (plant.x-plant.width/2)+button_props.width/2,
    y = (plant.y+plant.height/2)-button_props.height/2,
    fillColor = { default={ 0.2 }, over={ 0, 149/255, 59/255 } },
    labelColor = { default={ 1 }, over={ 1 } },
    fontSize = 32,
    label = "Back",
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
    fillColor = { default={ 0.2 }, over={ 0, 149/255, 59/255 } },
    labelColor = { default={ 1 }, over={ 1 } },
    fontSize = 32,
    label = "Restart",
    onRelease = function(event)	closer('restart') end
  }
	sceneGroup:insert(restartButton)


end

scene:addEventListener("create", scene)
return scene
