local composer = require( "composer" )

local scene = composer.newScene()
_G.game_mode = "medal_4"


function scene:create( event )

    local sceneGroup = self.view

end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then

      display.newRoundedRect(sceneGroup, display.contentCenterX, 50, display.actualContentWidth, 100, 10):setFillColor(unpack(PROPS.color.up_bar));
      local GroupText1 = display.newText({
        parent = sceneGroup,
        text = i18n('home'),
        x = display.contentCenterX, y = 40,
        font = PROPS.font,
        fontSize = 75,
      })
      function GroupText1:touch()
        composer.gotoScene("scene.menu", PROPS.animation.scene)
        composer.removeScene("scene.level")
       return true
      end
      GroupText1:addEventListener( "touch", GroupText1 )

-- local myRoundedRect = display.newRoundedRect(sceneGroup, display.contentCenterX, 560, display.actualContentWidth, 1000, 0)
--       myRoundedRect:setFillColor(190/255,215/255,239/255)


      local levels = {"scene", "scene" ,"scene","scene"}

      local level = {"text_3", "text_3", "medal_4", "kolodki_4"}

      _G.variant = "text_3"
      _G.marafon = false


local button = {}
function button:play(t)
  self.vr = t.vr or 0
  self.x, self.y = t.x or 0, t.y or 0
  self.gotoScene = t.gotoScene or "scene.menu"
  self.options_dealy = t.options_dealy or {delay = 400, time = 1000, effect="slideDown"}
  self.sceneGroup = t.sceneGroup or sceneGroup
  self.text = t.name or "error"
  self.shift_textX = t.shift_textX or 0
  self.align = t.align or "center"

  self.widget = display.newImage(sceneGroup, "img/menu/ib" .. self.vr .. ".png", self.x, self.y)
  self.title = display.newText({
    width = 800,
    align = self.align,
    parent = sceneGroup,
    text = i18n(self.text),
    x = self.widget.x+self.shift_textX, y = self.widget.y-10,
    font = PROPS.font,
    fontSize = 90,
  })

  self.score_for_open = t.open or 0
  self.all_score = t.all_score or -4
  local bools = true

  if  self.all_score < self.score_for_open then
    bools = false
    display.newRoundedRect(sceneGroup, self.widget.x, self.widget.y, 680, 170, 30):setFillColor(unpack(PROPS.color.grey),0.95)
    local locked = display.newImage(sceneGroup, "img/UI/2x/locked.png", self.x-200, self.y)
    local PlayGame =  display.newText({
      parent = sceneGroup,
      text = self.all_score.."/"..self.score_for_open,
      x =  self.x+50, y = self.y,
      font = PROPS.font,
      fontSize = 80,
    })
  else
    bools = true
  end

  function self.widget:touch(e)
      print(bools)
    if (bools == true) then
      print(bools)
      if(e.phase == "ended" ) then
        _G.game_mode = t.game_mode
        composer.gotoScene("scene.three_games", self.options_dealy)
        composer.removeScene("scene.level")
      end
    end
  end
    self.widget:addEventListener("touch",self.widget)
 return self
end

local button_group = display.newGroup()
sceneGroup:insert(button_group)

local one_button = button:play({
  sceneGroup = button_group,
  x = centerX, y = 400,
  gotoScene = "scene.three_games",
  options_delay = PROPS.animation.scene,
  vr = 0,
  game_mode = "text_3",
  open = -1,
  all_score = ACHIEVES.all_score,
  name = "marathon",
})
one_button.widget:scale(0.7, 0.7)

local two_button = button:play({
  sceneGroup = button_group,
  x = centerX, y = 600,
  gotoScene = "scene.three_games",
  options_delay = PROPS.animation.scene,
  vr = 1,
  game_mode = "text_3",
  open = 100,
  all_score = ACHIEVES.all_score,
  name = "title",
  shift_textX = 50,
})
two_button.widget:scale(0.7, 0.7)

local three_button = button:play({
  sceneGroup = button_group,
  x = centerX, y = 800,
  gotoScene = "scene.three_games",
  options_delay = PROPS.animation.scene,
  vr = 2,
  game_mode = "medal_4",
  open = 200,
  all_score = ACHIEVES.all_score,
  name = "medals",
  shift_textX = 50,
})
three_button.widget:scale(0.7, 0.7)

local four_button = button:play({
  sceneGroup = button_group,
  x = centerX, y = 1000,
  gotoScene = "scene.three_games",
  options_delay = PROPS.animation.scene,
  vr = 3,
  game_mode = "kolodki_4",
  open = 300,
  all_score = ACHIEVES.all_score,
  name = "ribbon",
  shift_textX = 50,
})
four_button.widget:scale(0.7, 0.7)

    end
end

-------------


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
