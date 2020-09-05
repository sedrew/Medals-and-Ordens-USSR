local composer = require( "composer" )

local scene = composer.newScene()

function scene:create( event )

    local sceneGroup = self.view

end

function scene:show( event )

    local sceneGroup = self.view
    local phase = event.phase

    if ( phase == "will" ) then
      local GroupText1 = display.newText({
        parent = sceneGroup,
        text = "Домой",
        x = display.contentCenterX, y = 80,
        font = PROPS.font,
        fontSize = 90,
      })
      --
      function GroupText1:touch()
        composer.gotoScene("scene.menu", PROPS.animation.scene)
        composer.removeScene("scene.level")
       return true
      end
      GroupText1:addEventListener( "touch", GroupText1 )

-- local myRoundedRect = display.newRoundedRect(sceneGroup, display.contentCenterX, 560, display.actualContentWidth, 1000, 0)
--       myRoundedRect:setFillColor(190/255,215/255,239/255)

      local but = display.newGroup()
      sceneGroup:insert(but)
      local im = {}

      function img()
        x = centerX
        y = 200
        for i = 1, 4 do
          y = y + 200
          im[i] = display.newImage(but, "scene/menu/im" .. i-1 .. ".png", x, y)
          im[i]:scale(0.7, 0.7)
          im[i].tag = i
        end
      end
      img()

      local levels = {"scene", "scene" ,"scene","scene"}

      local level = {"text_3", "text_3", "medal_4", "kolodki_4"}

      _G.variant = "text_3"
      _G.marafon = false

      function touchIt(e)
        if(e.phase == "ended" ) then
          if (level[e.target.tag]) then
            if (level[e.target.tag] == 1) then
              _G.marafon = true
            end
            _G.variant = level[e.target.tag]
            composer.gotoScene("scene.game_level_text3", {delay = 400, time = 1000, effect="slideDown", onComplete = composer.removeScene("scene.level")})
          end
        end
      end

for i=1,4 do
   im[i]:addEventListener("touch",touchIt)
end

-- local scrollThreshold = 100
-- local resetColorOnScrolled = false
-- local snapRate = 800 -- pixels per second
--
-- local scrollW = fullw
-- local scrollH = fullh
-- local buttonW = math.floor(fullw-60)
-- local buttonH = 1000--math.floor(fullh/2)
--
-- local function isInBounds( obj, obj2 )
--    if(not obj2) then return false end
--    local bounds = obj2.contentBounds
--    if( obj.x > bounds.xMax ) then return false end
--    if( obj.x < bounds.xMin ) then return false end
--    if( obj.y > bounds.yMax ) then return false end
--    if( obj.y < bounds.yMin ) then return false end
--    return true
-- end
--
-- local buttons = {}
--
-- local function listener( event )
--
--    if( event.phase == "began" ) then
--       event.target.scrolled = false
--       for i = 1, #buttons do
--          if( isInBounds( event, buttons[i] ) ) then
--             buttons[i]:setFillColor(0.5, 0.8, 0.5,0)
--          else
--             buttons[i]:setFillColor(0.8, 0.5, 0.5,0)
--          end
--       end
--    elseif(event.phase == "ended" ) then
--       event.target:realign()
--       for i = 1, #buttons do
--          buttons[i]:setFillColor(0.8, 0.5, 0.5,0)
--       end
--
--       -- Is it a click?
--       if( not event.target.scrolled ) then
--          local button
--          for i = 1, #buttons do
--             if( isInBounds( event, buttons[i] ) ) then
--                button = buttons[i]
--             end
--          end
--          if( button ) then
--             button:clickAction()
--             button:setFillColor(0.5,1,0,0)
--             --timer.performWithDelay( 333, function() button:setFillColor(0.8,0.5,0.5) end )
--          end
--       end
--
--    elseif(event.phase == "moved" ) then
--
--       -- Update to 'scrolled' if drag passes threshold
--       local lastState = event.target.scrolled
--       event.target.scrolled = event.target.scrolled or (math.abs(event.x-event.xStart) >= scrollThreshold )
--
--       -- If state changed, recolor all buttons to 'off'
--       if( resetColorOnScrolled and lastState ~= event.target.scrolled ) then
--          for i = 1, #buttons do
--             buttons[i]:setFillColor(0.8, 0.5, 0.5, 0)
--          end
--       end
--    end
-- end
--
--
-- local widget = require "widget"
--
-- local options =
-- {
--
--    x = centerX,
--    width = fullw,
--    height = fullh,
--    backgroundColor = {0.8, 0.8, 0.8, 0},
--    hideScrollBar = true,
--    listener = listener,
--    top = 70,
--    --         topPadding = 1200,
--    --         bottomPadding = 1200,
--     --       horizontalScrollDisabled  = true,
--    verticalScrollDisabled = true,
--    --         listener = scrollListener,
--    --         backgroundColor = { 0.8, 0.8, 0.8, 0 }
-- }
--
-- local menu = widget.newScrollView( options )
--
-- -- This function make sure the buttons align nicely to the top edge
-- function menu.realign(self)
--    local minX = -self:getView().contentWidth + 5 * buttonW
--    local x,y = self:getContentPosition()
--
--    if( x <= minX ) then
--       print( "Skipping", minX, x )
--    elseif( x >= 0 ) then
--       print("Skipping2", minX, x)
--    else
--
--       local dy = x
--       local count = 0
--       --local toX
--       while(dy < 0) do
--          count = count + 1
--          dy = dy + buttonW
--       end
--
--       if( dy > buttonW/2 ) then
--          toX = x + (buttonW-dy)
--          print(buttonW/3)
--       else
--          toX = x + (buttonW-dy) - buttonW
--       end
--
--       local distance = math.abs(x-toX)
--
--       print("Realign it" , x, minX, count, toX, distance)
--       self:scrollToPosition( {x = toX, time = 1000 * distance/snapRate})
--    end
-- end
--
-- local mas = {}
--
-- for i = 1, 3 do
--    local button = display.newRect((i-0.45) * buttonW, buttonH/2, buttonW-2, buttonH-2 )
--    menu:insert(button)
--    button:setFillColor(0.8, 0.5, 0.5,0)
--    button:setStrokeColor(0,0,0,0)
--    button.strokeWidth = 2
--    buttons[#buttons+1] = button
--    button.label = display.newText( i, button.x, button.y, native.systemFont, 20 )
--    button.label:setFillColor(0)
--    menu:insert(button.label)
--
--    button.id = i
--
--
--    function button.clickAction( self )
--       composer.gotoScene(levels[self.id], {delay = 400, time = 1000, effect="slideDown", onComplete = composer.removeScene("scene.level")})
--       local setting = {
-- 				difficulty = "easy",
-- 			--	touchPlay = touchPlay+1,
-- 				highestLevel = 7,
-- 				score = score,
-- 				minus = minus,
-- 				lovkost
-- 			}
-- 			loadsave.saveTable( setting, "settings.json" )
--       --rint("Clicked button ", self.id )
--       -- Do click work here
--    end
-- end
-- sceneGroup:insert(menu)
--
--
--
--
-- local np = 1
-- local mas = {}
-- local p = 1
-- local box = display.newGroup()
--     for i = 1, 3 do
--       mas[i] = display.newImage(box, "img/" .. p+i .. ".jpg", (display.contentCenterX-650)+i*650, 500)
--       mas[i]:scale(0.48,0.48)
--     end
-- menu:insert(box)


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
