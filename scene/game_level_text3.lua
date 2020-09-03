
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
	
	local def = modules:random(4,30).notRepeat()
	print(def.returnOneNumber(), " S ", unpack(def.randomList) )
	
	local pop = modules:createRects({
	  countX=2,countY=2,
	  h=300,w=300,
	  x=200,y=600,
	  indentX = 2, indentY = 2 
	})
	
	pop:image(def.randomList)
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
