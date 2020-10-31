local composer = require( "composer" )

local scene = composer.newScene()
function scene:create( event )
 local sceneGroup = self.view
end

-- show()
function scene:show( event )

 local sceneGroup = self.view
 local phase = event.phase

 if ( phase == "will" ) then

   i18n = require('lib.i18n.init')
   i18n.load(require('resource.languages'))
   i18n.setLocale(PROPS.lang)

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
      composer.removeScene("scene.menu")
      composer.gotoScene("scene.level", PROPS.animation.scene)
      -- transition.to(PlayGame, {time = 50, size = 75,
      --   onComplete = function()
      --   end})
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
  affair.img:scale(0.15,0.15)

  local book = bt:buttons({
    x = button_rect.x,
    y = button_rect.y+160,
    color = {0.04,0.69,0.945},
    img_url = "img/UI/android-book.png",
    scene = "scene.handbook",
  })
  book.img:scale(0.12,0.12)

  local sett = bt:buttons({
    x = button_rect.x+button_rect.width/2-75,
    y = button_rect.y+160,
    color = {0.6,0.2,1},
    img_url = "img/UI/2x/gear.png",
    scene = "scene.menuSetting",
  })
  sett.img.x = sett.img.x-3 --КОСТЫЛь
  sett.img.y = sett.img.y-3 --КОСТЫЛь

  local score_text = display.newText({
    parent = sceneGroup,
    text = i18n("score")..": "..ACHIEVES.all_score,
    x =  centerX, y = centerY+140,
    font = PROPS.font,
    fontSize = 70,
    })

  butts_group:scale(0.9,0.9)
  butts_group.x = centerX
  butts_group.y = centerY+280

  sceneGroup:insert(butts_group)
  sceneGroup:insert(logo)
  end
end

---------------- hide()
function scene:hide( event )
    local sceneGroup = self.view
    local phase = event.phase
    if ( phase == "will" ) then
    elseif ( phase == "did" ) then
    end
end

function scene:destroy( event )
    local sceneGroup = self.view
end
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

return scene
