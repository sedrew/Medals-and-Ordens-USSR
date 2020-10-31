local composer = require( "composer" )

local modules = require("maket")
local nazv    = require("resource.words")[PROPS.lang]

local scene = composer.newScene()

composer.removeScene("scene.menu")

local random_numbers
local number_name
local pop
local images
local name_medal

local time_start
local all_variant = 60
local all_cards = 4
-- create()
local kod = {1,3,4,6,7,8,9,10,12,13,14,15,16,18,19,20,21,22,23,25,26,27,28,29,31,32,33,34,35,36,38,39,40,41,42,43,44,45,46,47,49,50,52,53,54,55,56,57,58}

local pick_mode = _G.game_mode
local game_score_is_mode = 10

function scene:create( event )
  local sceneGroup = self.view

   if (pick_mode == "marathon") then

   elseif (pick_mode == "text_3") then
      all_cards = 3
     random_numbers = modules:random(all_cards,all_variant).notRepeat().step()

     pop = modules:createRects({
       countX=1,countY=3,
       h=180,w=600,
       x=centerX,y=800,
       indentX = 10, indentY = 10,
     })
     sceneGroup:insert(pop.mainScene)

     pop.other_object = display.newRoundedRect(sceneGroup, centerX, top+400, 600,  600, 12)
     pop.other_object:setFillColor(unpack(PROPS.color.cart))
   elseif (pick_mode == "medal_4") then
     game_score_is_mode = 20
     random_numbers = modules:random(all_cards,all_variant).notRepeat().step()
     pop = modules:createRects({
       countX=2,countY=2,
       h=300,w=300,
       x=200,y=700,
       indentX = 9, indentY = 9,
     })
     sceneGroup:insert(pop.mainScene)

   elseif (pick_mode == "kolodki_4") then
     game_score_is_mode = 30
     random_numbers = modules:random(all_cards)
     random_numbers.random_numbers = kod
     random_numbers.notRepeat().step()

     pop = modules:createRects({
       countX=2,countY=2,
       h=150,w=320,
       x=200,y=900,
       indentX = 9, indentY = 9,
     })
     sceneGroup:insert(pop.mainScene)

     pop.other_object = display.newRoundedRect(sceneGroup, centerX, top+450, 600,  600, 12)
     pop.other_object:setFillColor(unpack(PROPS.color.cart))
   end
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

    composer.setVariable("old_scene_name", "scene.three_games")
	  function upBar_event.gameOver(string)
      local string = string or "stars_out"
      pop.tap = false
      composer.setVariable("textGameOver", string)
      composer.setVariable("score",upBar_event.score)
	    composer.showOverlay("scene.gameOver",{isModal = true}) --{time = 800, effect="fade", isModal = true,}
    end

    function game_mode_spawn_sheet()
      random_numbers = random_numbers.notRepeat().step()
      number_name = random_numbers.returnOneNumber()
      if (pick_mode == "marathon") then

        --Дописать!!!

      elseif (pick_mode == "text_3") then
        name_medal = pop:oneImage(number_name)
        images = pop:textsMedals(nazv, random_numbers.randomList)
        pop:uniteGroup(name_medal,images)
      elseif (pick_mode == "medal_4") then
        images = pop:imagesMedal(random_numbers.randomList)
        name_medal = pop:oneText(nazv,number_name)
        pop:uniteGroup(name_medal,images)
      elseif (pick_mode == "kolodki_4") then
        name_medal = pop:oneImage(number_name)
        images = pop:imagesKolodki(random_numbers.randomList)
        pop:uniteGroup(name_medal,images)
      end
    end
    game_mode_spawn_sheet()

    local count_steps = 0
	  pop.tap = true
    function touchIt(e)
      if (pop.tap == true) then
        if (e.phase == "ended")  then
          if (random_numbers.randomList[e.target.tag] == number_name) then
            count_steps = count_steps + 1
            if (count_steps >= all_variant/all_cards) then
               print("STOOOP")
               upBar_event.gameOver("victory")
              return
            end
            ACHIEVES.all_right_answer = ACHIEVES.all_right_answer + 1
            pop:animationScores(e.target, game_score_is_mode)
            pop.tap = false
            pop:remove(pop.unite_group,
              function()
                game_mode_spawn_sheet()
                pop:resetColor(pop.box)
                pop.tap = true
                time_start.startTime()
              end)
            pop.box[e.target.tag]:setFillColor(unpack(PROPS.color.right))
            transition.cancel("tagPauseLineTime")
            upBar_event.score = upBar_event.score + game_score_is_mode
            _G.musicControl():sound("right")
          elseif (e.target.tap == true) then
            ACHIEVES.all_mistake_answer = ACHIEVES.all_mistake_answer + 1
            upBar_event.mistake = upBar_event.mistake + 1
            pop.box[e.target.tag]:setFillColor(unpack(PROPS.color.mistake))
            e.target.tap = false
            _G.musicControl():sound("mistake")
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
    elseif ( phase == "did" ) then
    end
end

-- destroy()
function scene:destroy( event )
  local ran = 1
  local pl = {}
  local bg = {}
  local sceneGroup = self.view

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
