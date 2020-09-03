
local composer = require( "composer" )

local scene = composer.newScene()

-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------


composer.removeScene("scene.menu")

-- -----------------------------------------------------------------------------------
-- Scene event functions
-- -----------------------------------------------------------------------------------

-- create()
function scene:create( event )

  -- Code here runs when the scene is first created but has not yet appeared on screen
end
-- show()
function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
	
	local modules = require("maket")
	local nazv    = require("words")
	
	local random_numbers = modules:random(4,30).notRepeat()
	
	local pop = modules:createRects({
	  countX=2,countY=2,
	  h=300,w=300,
	  x=200,y=700,
	  indentX = 9, indentY = 9,
      numbersList = random_numbers.randomList
	})
	local colorGreen = {145/255,209/255,79/255}
    local colorRed = {255,101/255,101/255}
	
	pop:image(random_numbers.randomList)
	
	local number_name = random_numbers.returnOneNumber()
	local name_medal = pop:oneText(nazv,number_name)
	print(number_name, " S ", unpack(random_numbers.randomList) )
	
	function touchIt(e)
      if(e.phase == "ended" ) then
	  print(random_numbers.randomList[e.target.tag])
        if (random_numbers.randomList[e.target.tag] == number_name) then
          --great.start()
        --sceneGroup:remove(0)
        -- score = score + 1
        -- timeGame.setScore(score)
        -- great.tumb = false
        -- gt = gt + full
        -- random(full,gt)
        -- transition.cancel("transTag")
        -- timeGame.timeStripe(sceneGroup,composer,9)
        -- great:remove()
	
        pop.box[e.target.tag]:setFillColor(unpack(colorGreen))

      elseif (e.target.tap == true) then
       -- timeGame.starColor()
        pop.box[e.target.tag]:setFillColor(unpack(colorRed))
    -- --   minus = minus + 1
       -- e.target.tap = false
	   end
     end
  end

  for i=1, #pop.box do
    pop.box[i]:addEventListener("touch",touchIt)
  end
	--name_medal.medText.text = "DDDDD"
	
	--great.react(tabl,sceneGroup)

-- sceneGroup:insert(stars)
-- sceneGroup:insert(textMedal)
-- sceneGroup:insert(med1)
-- sceneGroup:insert(toMenu)

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
