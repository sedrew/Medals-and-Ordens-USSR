
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



  local GroupText = display.newText({
    parent = sceneGroup,
	  text = i18n('name_game'),
	  x = display.contentCenterX, y = 120,
	  font = PROPS.font,
	  fontSize = 85,
  })

  local logo = display.newImage("img/menu/logo.png")
  logo:scale( 0.7, 0.7 )
  logo.x = display.contentCenterX
  logo.y = 480

  local butts_group = display.newGroup()
  local button_rect = display.newRoundedRect(butts_group, 0, 0, 500, 150, 30)
  button_rect:setFillColor(1,0.396,0.396)
  local fSize = 90
  local PlayGame =  display.newText({
    parent = butts_group,
    text = i18n('play'),
    x =  button_rect.x, y = button_rect.y,
    font = PROPS.font,
    fontSize = fSize,
  })

  function PlayGame:touch(event)
    if ( event.phase == "began" ) then
      transition.to(PlayGame, {time = 50, size = 75,
        onComplete = function()
          composer.removeScene("scene.menu")
          composer.gotoScene("scene.level", PROPS.animation.scene)
        end})
    end
      return true
  end
  PlayGame:addEventListener("touch", PlayGame)

  local bt = {}
  function bt:buttons(t)
    self.button_rect = display.newRoundedRect(butts_group, t.x, t.y, 150, 150, 30)
    self.scene = t.scene or "scene.affair"
    self.button_rect:setFillColor(unpack(t.color))
    self.img = display.newImage(butts_group, t.img_url, t.x, t.y)
    self.img:scale( (self.button_rect.height/100)*1, (self.button_rect.height/100)*1)


    function self.button_rect:touch(event)
      if ( event.phase == "began" ) then
            composer.removeScene("scene.menu")
            composer.gotoScene(t.scene, PROPS.animation.scene)
      end
        return true
    end
    self.button_rect:addEventListener("touch", self.button_rect )
    return self
  end

  local affair = bt:buttons({
    x = button_rect.x-button_rect.width/2+75,
    y = button_rect.y+160,
    color = {0.561,0.82,0.318},
    img_url = "img/UI/lightbulb.png",
    scene = "scene.affair",
  })
  affair.img:scale(0.1,0.1)

  local book = bt:buttons({
    x = button_rect.x,
    y = button_rect.y+160,
    color = {0.04,0.69,0.945},
    img_url = "img/UI/android-book.png",
    scene = "scene.handbook",
  })
  book.img:scale(0.1,0.1)

  local sett = bt:buttons({
    x = button_rect.x+button_rect.width/2-75,
    y = button_rect.y+160,
    color = {0.6,0.2,1},
    img_url = "img/UI/2x/gear.png",
    scene = "scene.menuSetting",
  })

  butts_group:scale(0.9,0.9)
  butts_group.x = centerX
  butts_group.y = centerY+240
  --Old disigne
    -- local myGroup = display.newGroup()
  -- local ic = display.newImage(myGroup, "img/menu/ic.png")
  --     ic.x = 140 ic.y = 970 ic:scale(0.6, 0.6)
  -- local GroupText3 = display.newText({
  --   parent = GroupText3,
  --   text = "Справочник",
  --   x = display.contentCenterX+70, y = 1015,
  --   font = PROPS.font,
  --   fontSize = fSize,
  -- })
  -- sceneGroup:insert(GroupText3)
  --
  -- function GroupText3:touch(event)
  --   if ( event.phase == "began" ) then
  --     elseif ( event.phase == "ended" ) then
  --       composer.gotoScene("scene.handbook", {time = 800, effect="slideUp"})
  --       composer.removeScene("scene.menu")
  --     end
  --   return true
  -- end
  -- GroupText3:addEventListener( "touch", GroupText3 )
  --
  -- local diary = display.newText({
  --   parent = diary,
  --   text = "Дневник",
  --   x = display.contentCenterX+10, y = 910,
  --   font = PROPS.font,
  --   fontSize = fSize,
  -- })
  -- sceneGroup:insert(diary)
  --
  -- function diary:touch(event)
  --   if ( event.phase == "ended" ) then
  --     composer.gotoScene("scene.diary", {time = 800, effect="slideUp"})
  --     composer.removeScene("scene.menu")
  --     end
  --   return true
  -- end
  -- diary:addEventListener( "touch", diary)
  --
  -- local case = display.newText({
  --   parent = sceneGroup,
  --   text = "Личное дело",
  --   x = display.contentCenterX+80, y = 1125,
  --   font = PROPS.font,
  --   fontSize = fSize,
  -- })
  -- sceneGroup:insert(case)
  --
  --
  -- function case:touch(event)
  --   if ( event.phase == "began" ) then
  --     transition.to(case, {time = 250, size = 75, transition=easing.continuousLoop})
  --     composer.gotoScene("scene.affair", PROPS.animation.scene)
  --     composer.removeScene("scene.menu")
  --   end
  --  return true
  -- end
  -- case:addEventListener( "touch", case )
  --

  --
  -- sceneGroup:insert(myGroup)
  -- myGroup:insert(logo)
  sceneGroup:insert(butts_group)
  sceneGroup:insert(logo)
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
