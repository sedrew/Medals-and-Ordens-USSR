
local composer = require( "composer" )

local modules = require("maket")
local nazv    = require("words")

local scene = composer.newScene()

composer.removeScene("scene.menu")

local random_numbers
local number_name
local pop 
local images
local name_medal

local colorGreen = {145/255,209/255,79/255}
local colorRed = {255,101/255,101/255}

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
  print("D______")
end
-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
	
	-- print(number_name, " S ", unpack(random_numbers.randomList) )
	-- local GroupText1 = display.newText({
        -- parent = sceneGroup,
        -- text = "Домой",
        -- x = display.contentCenterX, y = 80,
        -- font = "font/Blogger_Sans-Bold.otf",
        -- fontSize = 90,
      -- })
      -- --
      -- function GroupText1:touch()
        -- composer.gotoScene("scene.menu", {time = 800, effect="crossFade"})
        -- composer.removeScene("scene.scene.game_level_text3")
		-- --sceneGroup:removeSelf()
      -- return true
    -- end
    -- GroupText1:addEventListener( "touch", GroupText1 )
	
	local timeGame  = require("scene.timeGame")
	local upBar_event = timeGame:upBar()
    --timeGame.timeStripe(sceneGroup,composer,15)
	upBar_event.timeStripe()
	
	function upBar_event.gameOver() 
	  composer.showOverlay("scene.gameOver", {time = 800, effect="crossFade", isModal = true,})
      transition.pause( "transTag" )
	end
	--print("SDCCCCCC", bottom)
	
	
	pop.tap = true
	function touchIt(e)
	 if (pop.tap == true) then 
      if (e.phase == "ended")  then
	  print(random_numbers.randomList[e.target.tag])
        if (random_numbers.randomList[e.target.tag] == number_name) then
         --images:removeSelf(images)
		 pop.tap = false
		 pop:remove(images, 
		   function()
		     images = pop:imagesMedal(random_numbers.randomList) 
			 pop:resetColor(pop.box)
	         pop.tap = true
		   end)
        -- score = score + 1
        -- transition.cancel("transTag")
        upBar_event.score = upBar_event.score + 1 
	
        pop.box[e.target.tag]:setFillColor(unpack(colorGreen))
		random_numbers = modules:random(4,30).notRepeat()
		number_name = random_numbers.returnOneNumber()
	    name_medal.text = nazv[number_name]
		--images = pop:image(random_numbers.randomList)
		
      elseif (e.target.tap == true) then
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

elseif ( phase == "did" ) then

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
