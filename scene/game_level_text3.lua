
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
  
  random_numbers = modules:random(4,30).notRepeat()
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
	
	--local random_numbers = modules:random(4,30).notRepeat()
	print(number_name, " S ", unpack(random_numbers.randomList) )
	
	local GroupText1 = display.newText({
        parent = sceneGroup,
        text = "Домой",
        x = display.contentCenterX, y = 80,
        font = "font/Blogger_Sans-Bold.otf",
        fontSize = 90,
      })
      --
      function GroupText1:touch()
        composer.gotoScene("scene.menu", {time = 800, effect="crossFade"})
        composer.removeScene("scene.scene.game_level_text3")
		--sceneGroup:removeSelf()
      return true
    end
    GroupText1:addEventListener( "touch", GroupText1 )
	
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
        -- timeGame.setScore(score)
        -- transition.cancel("transTag")
        -- timeGame.timeStripe(sceneGroup,composer,9)
	
        pop.box[e.target.tag]:setFillColor(unpack(colorGreen))
		random_numbers = modules:random(4,30).notRepeat()
		number_name = random_numbers.returnOneNumber()
	    name_medal.text = nazv[number_name]
		--images = pop:image(random_numbers.randomList)
		--name_medal:removeSelf()
		
      elseif (e.target.tap == true) then
       -- timeGame.starColor()
        pop.box[e.target.tag]:setFillColor(unpack(colorRed))
    -- --   minus = minus + 1
       -- e.target.tap = false
	   end
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
