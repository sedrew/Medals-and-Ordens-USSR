local composer = require( "composer" )

local modules = require("maket")
local nazv    = require("resource.words")

local scene = composer.newScene()

composer.removeScene("scene.menu")

local random_numbers
local number_name
local pop
local images
local name_medal

local colorGreen = {145/255,209/255,79/255}
local colorRed = {255,101/255,101/255}

local time_start
-- create()
function scene:create( event )
  local sceneGroup = self.view
  local kod = {1,3,4,6,7,8,9,10,12,13,14,15,16,18,19,20,21,22,23,25,26,27,28,29,31,32,33,34,35,36,38,39,40,41,42,43,44,45,46,47,49,50,52,53,54,55,56,57,58}
  random_numbers = modules:random(4,30).steps().notRepeat()
  number_name = random_numbers.returnOneNumber()

  pop = modules:createRects({
	  countX=2,countY=2,
	  h=300,w=300,
	  x=200,y=700,
	  indentX = 9, indentY = 9,
    numbersList = random_numbers.randomList
	})
  images = pop:imagesMedal(random_numbers.randomList)
  name_medal = pop:oneText(nazv,number_name)
  sceneGroup:insert(pop.mainScene)

end
-- show()
function scene:show( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    ACHIEVES.count_game = ACHIEVES.count_game + 1

    local timeGame  = require("scene.timeGame")
    local upBar_event = timeGame:upBar()

    time_start = upBar_event.timeStripe(5)
    print(upBar_event.score)
    composer.setVariable("old_scene_name", "scene.game_level_text3")
	  function upBar_event.gameOver()
      composer.setVariable("score",upBar_event.score)
	    composer.showOverlay("scene.gameOver", {time = 800, effect="crossFade", isModal = true,})
    end

	  pop.tap = true
    function touchIt(e)
      if (pop.tap == true) then
        if (e.phase == "ended")  then
          if (random_numbers.randomList[e.target.tag] == number_name) then
            ACHIEVES.all_right_answer = ACHIEVES.all_right_answer + 1
            pop.tap = false
            pop:remove(images,
              function()
                images = pop:imagesMedal(random_numbers.randomList)
                pop:resetColor(pop.box)
                pop.tap = true
                time_start.startTime()
              end)

            transition.cancel("tagPauseLineTime")
            upBar_event.score = upBar_event.score + 1

            pop.box[e.target.tag]:setFillColor(unpack(colorGreen))
            random_numbers = modules:random(4,30).notRepeat()
            number_name = random_numbers.returnOneNumber()
            name_medal.text = nazv[number_name]
          elseif (e.target.tap == true) then
            ACHIEVES.all_mistake_answer = ACHIEVES.all_mistake_answer + 1
            upBar_event.mistake = upBar_event.mistake + 1
            pop.box[e.target.tag]:setFillColor(unpack(colorRed))
            e.target.tap = false
          end
          upBar_event.update()
        end
      end
    end

    for i=1, #pop.box do
      pop.box[i]:addEventListener("touch",touchIt)
    end

    sceneGroup:insert(pop.mainScene)
    sceneGroup:insert(upBar_event.sceneGroup)
  elseif ( phase == "did" ) then
    time_start.startTime()
  end
end


-- hide()
function scene:hide( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
    end
end

-- destroy()
function scene:destroy( event )
  local ran = 1
  local pl = {}
  local bg = {}

    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
end

-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
return scene
