
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

   -- local por = "CHEBURUSHKA"
   -- print(por)


  local myGroup = display.newGroup()

  local ic = display.newImage(myGroup, "scene/menu/ic.png")
      ic.x = 140 ic.y = 970 ic:scale(0.6, 0.6)


  local GroupText = display.newText({
  parent = GroupText,
	text = "Медали и Ордена",
	x = display.contentCenterX, y = 120,
	font = "font/Blogger_Sans-Bold.otf",
	fontSize = 85,
})
  ---
  local fSize = 80
  local PlayGame =  display.newText({
  parent = myGroup,
  text = "Играть",
  x = display.contentCenterX-20, y = 800,
  font = "font/Blogger_Sans-Bold.otf",
  fontSize = fSize,
})
------------------
-- local loadsave = require( "scene.loadsave" )
-- local setting = loadsave.loadTable( "settings.json" )
-- local setting = {
--   PlayGame = 0,
--   score = 0,
--   minus = 0,
--   lovk = 0,
-- }
-- loadsave.saveTable( setting, "settings.json" )
-----------------

function GroupText:insertText(text, fontname, size, x, y)
    local offset = size/10
    local label = display.newText(text, x, y, "Blogger_Sans-Bold.otf", size)
    local shadow = display.newText(text, x+offset, y+offset, "Blogger_Sans-Bold.otf", size)
    label:setTextColor(255, 255, 255)
    shadow:setTextColor(0, 0, 0, 128)
    self:insert(shadow)
    self:insert(label)
end


  ---

     function PlayGame:touch(event)
      if ( event.phase == "began" ) then
          transition.to(PlayGame, {time = 250, size = 75, transition=easing.continuousLoop,
          onComplete = function()
          composer.gotoScene("scene.level", {delay = 400, time = 1000, effect="crossFade"})
          composer.removeScene("scene.menu")
          display.remove( PlayGame )
          PlayGame = nil
        end
       })
      end
      return true
    end
    PlayGame:addEventListener( "touch", PlayGame )


    local GroupText3 = display.newText({
      parent = GroupText3,
      text = "Справочник",
      x = display.contentCenterX+70, y = 1015,
      font = "font/Blogger_Sans-Bold.otf",
      fontSize = fSize,
    })
    sceneGroup:insert(GroupText3)


    function GroupText3:touch(event)
    if ( event.phase == "began" ) then
      elseif ( event.phase == "ended" ) then
        composer.gotoScene("scene.handbook", {time = 800, effect="slideUp", onComplete = composer.removeScene("scene.menu")})
        composer.removeScene("scene.menu")
      end
    return true
  end
  GroupText3:addEventListener( "touch", GroupText3 )

  local diary = display.newText({
    parent = diary,
    text = "Дневник",
    x = display.contentCenterX+10, y = 910,
    font = "font/Blogger_Sans-Bold.otf",
    fontSize = fSize,
  })
    sceneGroup:insert(diary)

    function diary:touch(event)
      if ( event.phase == "ended" ) then
        composer.gotoScene("scene.diary", {time = 800, effect="slideUp", onComplete = composer.removeScene("scene.menu")})
        -- composer.removeScene("scene.menu")
        -- display.remove( diary )
        -- diary = nil
      end
    return true
  end
  diary:addEventListener( "touch", diary)


    local case = display.newText({
      parent = sceneGroup,
      text = "Личное дело",
      x = display.contentCenterX+80, y = 1125,
      font = "font/Blogger_Sans-Bold.otf",
      fontSize = fSize,
    })
      sceneGroup:insert(case)

    --   local utf8 = require( "plugin.utf8" )
    --   print(utf8.match("Медаль «За победу над Германией в Великой Отечественной войне 1941-1945 гг.»",
    -- "%S+"))
--
-- level = {one = "text_3", two = "medal_4", free = "kolodki_4"}
--
-- composer.setVariable( "level", level.two)

local loadsave  = require("scene.loadsave")
      function case:touch(event)
       if ( event.phase == "began" ) then
           transition.to(case, {time = 250, size = 75, transition=easing.continuousLoop,
           onComplete = function()
           composer.gotoScene("scene.affair", {delay = 400, time = 1000, effect="crossFade"})
           composer.removeScene("scene.menu")
              end
            })
          --  local setting = {
          --    PlayGame = 0,
       		-- 	score = 0,
       		-- 	minus = 0,
       		-- 	lovk = 0,
     			-- }
     			-- loadsave.saveTable( setting, "settings.json" )
       end
       return true
     end
     case:addEventListener( "touch", case )
--
    local logo = display.newImage("scene/menu/logo.jpg")
    logo:scale( 0.7, 0.7 )
    logo.x = display.contentCenterX
    logo.y = 480


sceneGroup:insert(myGroup)
sceneGroup:insert(GroupText)
sceneGroup:insert(PlayGame)
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


-- destroy()
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
