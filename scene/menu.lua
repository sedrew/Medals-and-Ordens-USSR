
local composer = require( "composer" )

local scene = composer.newScene()


function scene:create( event )

 local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
end
-- show()
function scene:show( event )

 local sceneGroup = self.view
 local phase = event.phase

 if ( phase == "will" ) then
  local myGroup = display.newGroup()
  local ic = display.newImage(myGroup, "img/menu/ic.png")
      ic.x = 140 ic.y = 970 ic:scale(0.6, 0.6)

  local GroupText = display.newText({
    parent = sceneGroup,
	  text = i18n('name_game'),
	  x = display.contentCenterX, y = 120,
	  font = PROPS.font,
	  fontSize = 85,
  })

  local fSize = 80
  local PlayGame =  display.newText({
    parent = sceneGroup,
    text = i18n('play'),
    x = display.contentCenterX-20, y = 800,
    font = PROPS.font,
    fontSize = fSize,
  })

  function PlayGame:touch(event)
    if ( event.phase == "began" ) then
      transition.to(PlayGame, {time = 50, size = 75,
        onComplete = function()
          composer.removeScene("scene.menu")
          composer.gotoScene("scene.menuSetting", PROPS.animation.scene)
        end})
    end
      return true
  end
  PlayGame:addEventListener( "touch", PlayGame )

  local GroupText3 = display.newText({
    parent = GroupText3,
    text = "Справочник",
    x = display.contentCenterX+70, y = 1015,
    font = PROPS.font,
    fontSize = fSize,
  })
  sceneGroup:insert(GroupText3)

  function GroupText3:touch(event)
    if ( event.phase == "began" ) then
      elseif ( event.phase == "ended" ) then
        composer.gotoScene("scene.handbook", {time = 800, effect="slideUp"})
        composer.removeScene("scene.menu")
      end
    return true
  end
  GroupText3:addEventListener( "touch", GroupText3 )

  local diary = display.newText({
    parent = diary,
    text = "Дневник",
    x = display.contentCenterX+10, y = 910,
    font = PROPS.font,
    fontSize = fSize,
  })
  sceneGroup:insert(diary)

  function diary:touch(event)
    if ( event.phase == "ended" ) then
      composer.gotoScene("scene.diary", {time = 800, effect="slideUp"})
      composer.removeScene("scene.menu")
      end
    return true
  end
  diary:addEventListener( "touch", diary)

  local case = display.newText({
    parent = sceneGroup,
    text = "Личное дело",
    x = display.contentCenterX+80, y = 1125,
    font = PROPS.font,
    fontSize = fSize,
  })
  sceneGroup:insert(case)

  --local loadsave  = require("lib.loadsave")
  function case:touch(event)
    if ( event.phase == "began" ) then
      transition.to(case, {time = 250, size = 75, transition=easing.continuousLoop})
      composer.gotoScene("scene.affair", PROPS.animation.scene)
      composer.removeScene("scene.menu")
    end
   return true
  end
  case:addEventListener( "touch", case )

  local logo = display.newImage("img/menu/logo.jpg")
  logo:scale( 0.7, 0.7 )
  logo.x = display.contentCenterX
  logo.y = 480

  sceneGroup:insert(myGroup)
  sceneGroup:insert(GroupText)
  myGroup:insert(logo)
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

function scene:destroy( event )
 --display.remove( sceneGroup )
 --sceneGroup = nil
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

return scene
