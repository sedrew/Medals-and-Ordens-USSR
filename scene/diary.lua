local composer = require( "composer" )

local scene = composer.newScene()
function scene:create( event )

    local sceneGroup = self.view

end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then


      score	= 10
      minus = 60


      local box = display.newGroup()
      local vp = {}
      local d = 0
      local x, y = 185-540, 290-360
      for i = 1,6 do
        x = x + (540-185)
            if ( i > d ) then
                x = 185
                d = d + 2
                y = y + 360
            end
            if (i > 4) then
            end
            vp[i] = display.newImage(box, "img/12.png", x, y)
            vp[i]:scale(0.68,0.68)
            vp[i].tag = i
          end

          function touchIt(e)
            if(e.phase == "ended" ) then
              composer.setVariable( "cards", e.target.tag )
              print(e.target.tag)
              composer.showOverlay("scene.diaryCards",{isModal = true, time = 800, effect="crossFade"})
            end
          end

          for i=1,6 do
            vp[i]:addEventListener("touch",touchIt)
          end

      sceneGroup:insert(1,box)

    -- elseif ( phase == "did" ) then
      local dir = display.newImage("img/diary.png", display.contentCenterX,display.contentCenterY )
            dir:scale(0.9*(720/display.contentHeight),0.9*(720/display.contentHeight))
            sceneGroup:insert(1,dir)

    local toMenu = display.newText({
      parent = sceneGroup,
      text = i18n('home'),
      x = display.contentCenterX, y = 30,
      font = "font/Blogger_Sans-Bold.otf",
      fontSize = 65,
    })

-------------
    function toMenu:touch(event)
      if ( event.phase == "ended" ) then
        composer.gotoScene("scene.menu", {time = 500, effect="crossFade"})
        composer.removeScene("scene.diary", {time = 500})
        display.remove( toMenu )
        toMenu = nil
      end
      return true
    end
    toMenu:addEventListener( "touch", toMenu )

    end
end

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

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
